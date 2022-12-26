require 'cmp'.register_source('emoji', require 'cmp_emoji'.new())
require('cmp').register_source('path', require('cmp_path').new())
require('cmp').register_source('buffer', require('cmp_buffer').new())
require('cmp').register_source('nvim_lsp_signature_help', require('cmp_nvim_lsp_signature_help').new())
