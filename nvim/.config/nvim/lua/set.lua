vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.undofile = true
vim.opt.exrc = true

vim.opt.cmdheight = 0
vim.o.updatetime = 50

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cpp',
    callback = function() vim.bo.commentstring = '// %s' end
})
