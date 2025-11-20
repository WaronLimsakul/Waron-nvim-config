-- LSP Error Reporter Plugin

local M = {}
local api = vim.api
local diagnostic = vim.diagnostic

-- Plugin state
local win_id = nil
local buf_id = nil
local file_list = {}

-- Close the floating window
local function close_window()
	if win_id and api.nvim_win_is_valid(win_id) then
		api.nvim_win_close(win_id, true)
	end
	win_id = nil
	buf_id = nil
	file_list = {}
end

-- Get diagnostics grouped by file
local function get_diagnostics_by_file()
	local diagnostics_by_file = {}

	-- Get all buffers
	for _, bufnr in ipairs(api.nvim_list_bufs()) do
		if api.nvim_buf_is_loaded(bufnr) then
			local diagnostics = diagnostic.get(bufnr)

			if #diagnostics > 0 then
				local filename = api.nvim_buf_get_name(bufnr)
				if filename ~= "" then
					-- Count errors and warnings
					local errors = 0
					local warnings = 0

					for _, diag in ipairs(diagnostics) do
						if diag.severity == diagnostic.severity.ERROR then
							errors = errors + 1
						elseif diag.severity == diagnostic.severity.WARN then
							warnings = warnings + 1
						end
					end

					if errors > 0 or warnings > 0 then
						table.insert(diagnostics_by_file, {
							filename = filename,
							bufnr = bufnr,
							errors = errors,
							warnings = warnings,
						})
					end
				end
			end
		end
	end

	return diagnostics_by_file
end

-- Format the display line for a file
local function format_line(item)
	local parts = {}
	local short_name = vim.fn.fnamemodify(item.filename, ":.")

	table.insert(parts, short_name)

	if item.errors > 0 then
		table.insert(parts, string.format("%d errors", item.errors))
	end

	if item.warnings > 0 then
		table.insert(parts, string.format("%d warnings", item.warnings))
	end

	return table.concat(parts, " - ")
end

-- Open file under cursor
local function open_file()
	local line = api.nvim_win_get_cursor(win_id)[1]
	local item = file_list[line]

	if item then
		close_window()
		-- Jump to the file
		api.nvim_set_current_buf(item.bufnr)
		-- Jump to first diagnostic in that file
		local diagnostics = diagnostic.get(item.bufnr)
		if #diagnostics > 0 then
			api.nvim_win_set_cursor(0, { diagnostics[1].lnum + 1, diagnostics[1].col })
		end
	end
end

-- Create and show the floating window
local function show_diagnostics_window()
	-- If window is already open, close it
	if win_id and api.nvim_win_is_valid(win_id) then
		close_window()
		return
	end

	-- Get diagnostics
	file_list = get_diagnostics_by_file()

	if #file_list == 0 then
		print("No LSP errors or warnings found")
		return
	end

	-- Create buffer
	buf_id = api.nvim_create_buf(false, true)

	-- Format lines
	local lines = {}
	for _, item in ipairs(file_list) do
		table.insert(lines, format_line(item))
	end

	api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
	api.nvim_buf_set_option(buf_id, "modifiable", false)
	api.nvim_buf_set_option(buf_id, "bufhidden", "wipe")

	-- Calculate window size and position
	local width = math.floor(vim.o.columns * 0.3)
	local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.8))

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = vim.o.columns - width,
		row = 1,
		style = "minimal",
		border = "rounded",
		title = " LSP Diagnostics ",
		title_pos = "center",
	}

	-- Create window
	win_id = api.nvim_open_win(buf_id, true, opts)

	-- Set window options
	api.nvim_win_set_option(win_id, "cursorline", true)

	-- Key mappings
	local keymaps = {
		["<CR>"] = open_file,
		["<Esc>"] = close_window,
		["q"] = close_window,
	}

	for key, func in pairs(keymaps) do
		api.nvim_buf_set_keymap(buf_id, "n", key, "", {
			noremap = true,
			silent = true,
			callback = func,
		})
	end
end

-- Setup function
function M.setup()
	-- Create user command
	api.nvim_create_user_command("LspErrorReport", show_diagnostics_window, {})

	-- Set up keybinding
	vim.keymap.set("n", "<leader>er", show_diagnostics_window, {
		noremap = true,
		silent = true,
		desc = "Show LSP errors and warnings",
	})
end

M.setup()
return M
