require('rose-pine').setup({
    disable_background = true
})

function CustomColorScheme(color) 
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

CustomColorScheme()
