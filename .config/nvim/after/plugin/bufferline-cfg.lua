require('bufferline').setup(
    {
        options = {
            diagnostics = "nvim_lsp",
            mode = "tabs",
            show_buffer_close_icons = false,
            color_icons = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "NvimTreeNormal",
                    text_align = "left"
                }
            }
        }
    }
)
