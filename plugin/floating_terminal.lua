-- Persistent floating terminal implementation
-- Add this to your init.lua or a separate config file

-- Store terminal state
local terminal_state = {
	buf = nil,
	win = nil,
	job_id = nil,
}

-- Function to create or show floating terminal
local function create_or_show_floating_terminal(cmd)
	cmd = cmd or ""

	-- Get editor dimensions
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- Calculate floating window size (70% of screen)
	local win_width = math.ceil(width * 0.70)
	local win_height = math.ceil(height * 0.70)

	-- Calculate starting position to center the window
	local row = math.ceil((height - win_height) / 3)
	local col = math.ceil((width - win_width) / 2)

	-- Window configuration
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	}

	-- Check if terminal buffer exists and is valid
	if terminal_state.buf and vim.api.nvim_buf_is_valid(terminal_state.buf) then
		-- Buffer exists, check if window is open
		if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
			-- Window is already open, just focus it
			vim.api.nvim_set_current_win(terminal_state.win)
		else
			-- Buffer exists but window is closed, reopen it
			terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, opts)
		end
	else
		-- Create new buffer and terminal
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, opts)

		-- Start terminal
		terminal_state.job_id = vim.fn.termopen(vim.o.shell, {
			on_exit = function()
				-- Reset state when terminal exits
				terminal_state.buf = nil
				terminal_state.win = nil
				terminal_state.job_id = nil
			end,
		})
	end

	-- If a command is provided, send it to the terminal
	if cmd ~= "" and terminal_state.job_id then
		vim.fn.chansend(terminal_state.job_id, cmd .. "\r")
	end

	-- Enter insert mode
	vim.cmd("startinsert")

	-- Set up keybinding to hide the terminal with Escape (don't close, just hide)
	vim.api.nvim_buf_set_keymap(
		terminal_state.buf,
		"t",
		"<Esc>",
		"<C-\\><C-n>:hide<CR>",
		{ noremap = true, silent = true }
	)
end

-- Function to toggle terminal visibility
local function toggle_floating_terminal()
	if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		-- Terminal is open, close it
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.win = nil
	else
		-- Terminal is closed, open it
		create_or_show_floating_terminal()
	end
end

-- Function to kill terminal session and start fresh
local function kill_and_restart_terminal()
	if terminal_state.job_id then
		vim.fn.jobstop(terminal_state.job_id)
	end
	if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, true)
	end
	if terminal_state.buf and vim.api.nvim_buf_is_valid(terminal_state.buf) then
		vim.api.nvim_buf_delete(terminal_state.buf, { force = true })
	end

	-- Reset state
	terminal_state = { buf = nil, win = nil, job_id = nil }

	-- Create new terminal
	create_or_show_floating_terminal()
end

-- Cargo-specific functions (now reuse same terminal)
local function cargo_run()
	create_or_show_floating_terminal("cargo run")
end

local function cargo_build()
	create_or_show_floating_terminal("cargo build")
end

local function cargo_test()
	create_or_show_floating_terminal("cargo test")
end

local function cargo_check()
	create_or_show_floating_terminal("cargo check")
end

local function go_build()
	create_or_show_floating_terminal("go build")
end

local function go_run()
	create_or_show_floating_terminal("go run")
end

-- Key mappings
vim.keymap.set("n", "<leader>rr", cargo_run, { desc = "Cargo Run" })
vim.keymap.set("n", "<leader>rb", cargo_build, { desc = "Cargo Build" })
vim.keymap.set("n", "<leader>rt", cargo_test, { desc = "Cargo Test" })
vim.keymap.set("n", "<leader>rc", cargo_check, { desc = "Cargo Check" })

-- vim.keymap.set("n", "<leader>gg", go_run, { desc = "Cargo Check" })
-- vim.keymap.set("n", "<leader>gb", go_build, { desc = "Cargo Check" })

-- Terminal management
vim.keymap.set("n", "<leader>tt", toggle_floating_terminal, { desc = "Toggle Floating Terminal" })
vim.keymap.set("n", "<leader>tk", kill_and_restart_terminal, { desc = "Kill & Restart Terminal" })

-- Alternative: Show empty terminal (same session)
vim.keymap.set("n", "<leader>ts", function()
	create_or_show_floating_terminal()
end, { desc = "Show Terminal" })
