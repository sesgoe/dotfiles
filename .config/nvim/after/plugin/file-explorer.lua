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

