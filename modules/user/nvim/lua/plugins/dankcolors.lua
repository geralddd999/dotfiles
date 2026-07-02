return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#16130e',
				base01 = '#16130e',
				base02 = '#6c6b67',
				base03 = '#6c6b67',
				base04 = '#232321',
				base05 = '#bfbdb8',
				base06 = '#bfbdb8',
				base07 = '#bfbdb8',
				base08 = '#bf4736',
				base09 = '#bf4736',
				base0A = '#8e6918',
				base0B = '#1f8c0d',
				base0C = '#948257',
				base0D = '#8e6918',
				base0E = '#c9ba94',
				base0F = '#c9ba94',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#6c6b67',
				fg = '#bfbdb8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#8e6918',
				fg = '#16130e',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6c6b67' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#948257', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#c9ba94',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#8e6918',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#8e6918',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#948257',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#1f8c0d',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#232321' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#232321' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#6c6b67',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
