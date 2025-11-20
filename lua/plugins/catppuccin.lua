return {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = {
		flavour = "mocha",
		transparent_background = true,
		integrations = {
			cmp = true,
			notify = true,
			fzf = true,
			harpoon = true,
			mason = true,
		},
		color_overrides = {
			mocha = {
				base = "#11111b", -- Main background (darker)
				mantle = "#0e0e17", -- Slightly darker than base
				crust = "#0a0a12", -- Darkest (for borders/splits)

				text = "#e0e0ea", -- Main text (brighter)
				subtext1 = "#c5c6d4", -- Secondary text (brighter)
				subtext0 = "#b0b1c0", -- Tertiary text (brighter)

				overlay2 = "#a5a6b5", -- Comments (brighter)
				overlay1 = "#92939f", -- (brighter)
				overlay0 = "#7d7e8a", -- (brighter)
			},
		},
	},
}
