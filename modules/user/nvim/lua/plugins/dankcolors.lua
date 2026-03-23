return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#161312',
				base01 = '#161312',
				base02 = '#918886',
				base03 = '#918886',
				base04 = '#ebdfdd',
				base05 = '#fff9f8',
				base06 = '#fff9f8',
				base07 = '#fff9f8',
				base08 = '#ffa19f',
				base09 = '#ffa19f',
				base0A = '#f6d7d1',
				base0B = '#b7ffa5',
				base0C = '#ffeeea',
				base0D = '#f6d7d1',
				base0E = '#ffe4df',
				base0F = '#ffe4df',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#918886',
				fg = '#fff9f8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#f6d7d1',
				fg = '#161312',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#918886' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffeeea', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffe4df',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#f6d7d1',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#f6d7d1',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffeeea',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b7ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#ebdfdd' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#ebdfdd' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#918886',
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
