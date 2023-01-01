require("nvim-tree").setup({
    open_on_setup = true,
    ignore_buffer_on_setup = true,
    view = {
        side = "right",
    },
    renderer = {
        highlight_git = true,
        group_empty = true,
        icons = {
            git_placement = "after",
        },
    },
})

-- auto-close if nvim-tree is last window
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
        end
    end
})
