require('mason').setup()
require("mason-lspconfig").setup(
  {
    ensure_installed = {
      "rust_analyzer",
      "eslint",
      "grammarly",
      "jsonls",
      "marksman",
      "tsserver",
      "yamlls",
      "denols"
    }
  }
)

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.sumneko_lua.setup {
    capabilities = capabilities,

    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
        }
    },
}

local rt = require('rust-tools')

rt.setup(
  {
    server = {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            allFeatures = true,
            overrideCommand = {
              'cargo',
              'clippy',
              '--message-format=json',
              '--all-targets',
              '--all-features'
            }
          },
          rustfmt = { extraArgs = { "+nightly" } },
          cargo = { buildScripts = { enable = true } },
          inlayHints = { lifetimeElisionHints = { enable = "always" }, reborrowHints = { enable = "always" } }
        }
      }
    }
  }
)

