vim.fn.OpenMarkdownPreview = function(url)
    vim.cmd("silent ! /Applications/Firefox.app/Contents/MacOS/firefox --new-window " .. url)
end
vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
