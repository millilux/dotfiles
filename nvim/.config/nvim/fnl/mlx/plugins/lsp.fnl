(local M [
    {1 "neovim/nvim-lspconfig" :dependencies ["hrsh7th/cmp-nvim-lsp"] :config (fn [plugin opts]
        (fn on_attach [client bufnr]
            ; (local lsp-format-modifications (require :lsp-format-modifications))
            ; (lsp-format-modifications.attach client bufnr { :format_on_save false }); <-- stopping things working
            (local bufopts { :noremap true :silent true :buffer bufnr })
            (vim.keymap.set "n" "gd" vim.lsp.buf.definition bufopts)
            (vim.keymap.set "n" "gD" vim.lsp.buf.definition bufopts)
            (vim.keymap.set "n" "K" vim.lsp.buf.hover bufopts)
            (vim.keymap.set "n" "gi" vim.lsp.buf.implementation bufopts)
            (vim.keymap.set "n" "gr" vim.lsp.buf.references bufopts)
            (vim.keymap.set "n" "gs" vim.lsp.buf.signature_help bufopts)
            (vim.keymap.set "n" "gt" vim.lsp.buf.type_definition bufopts)
            (vim.keymap.set "n" "<leader>r" vim.lsp.buf.rename bufopts)
            (vim.keymap.set ["n" "v"] "<leader>ca" vim.lsp.buf.code_action bufopts)
            (vim.keymap.set ["n" "v"] "<leader>cf" vim.lsp.buf.format bufopts)
            (vim.keymap.set "n" "<leader>ci" vim.lsp.buf.incoming_calls bufopts)
            ; (vim.keymap.set "n" "<leader>co" vim.lsp.buf.outgoing_calls bufopts)
            (vim.keymap.set "n" "<leader>wa" vim.lsp.buf.add_workspace_folder bufopts)
            (vim.keymap.set "n" "<leader>wr" vim.lsp.buf.remove_workspace_folder bufopts)
        ;     vim.keymap.set('n', '<leader>wl', function()
        ;         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        ;     end, bufopts)
        )
        (local lsp (require :lspconfig))
        (local util (require "lspconfig/util"))
        (local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
        (lsp.bashls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.ccls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.clojure_lsp.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        ; (lsp.elixirls.setup {
        ;     :on_attach on_attach
        ;     :capabilities capabilities
        ; })
        (lsp.fsautocomplete.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.hls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        ; PyLSP has everything except workspace symbols
        (lsp.pylsp.setup {
            :cmd [ "pylsp" "-v" "--log-file" "/tmp/nvim-pylsp.log" ]
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :pylsp {
                    :plugins {
                        :black { :enabled true }
                        :flake8 { :enabled true }
                        :mypy { :enable true }
                        :pycodestyle { :enabled false }
                        :autopep8 { :enabled false }
                        :pylint { :enabled false }
                    }
                }
            }
        })
        ;; Pyright supports Workspace Symbol search but no code actions/linters/formatters
        ;; (lsp.pyright.setup {
        ;;     :on_attach on_attach
        ;;     :capabilities capabilities
        ;; })
        ; (lsp.jedi_language_server.setup {
        ;     :on_attach on_attach
        ;     :capabilities capabilities
        ; })
        (lsp.lua_ls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :Lua {
                    :diagnostics {:globals [:vim :love]}
                    :workspace {:library (vim.api.nvim_get_runtime_file "" true) :checkThirdParty false}
                    :telemetry {:enable false}
                }	
            }
        })
        (lsp.rust_analyzer.setup {
            :on_attach on_attach
            :capabilities capabilities
            :filetypes ["rust"]
            :root_dir (util.root_pattern "Cargo.toml")
        })
        (lsp.tsserver.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.yamlls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :yaml { :schemas { :kubernetes "*.yaml" }}
            }
        })
    )}
    {1 "joechrisellis/lsp-format-modifications.nvim"}
    {1 "python-rope/pylsp-rope"}
    {1 "nvim-treesitter/nvim-treesitter" :build ":TSUpdate" :config (fn [opts] 
        (local configs (require :nvim-treesitter.configs))
        (configs.setup { 
            :ensure_installed [
                "bash" "c" "cpp" "clojure" "dockerfile" "elixir" "fennel" "fish" "glsl" "graphql" "haskell" "hlsl"
                "javascript" "json" "kotlin" "lua" "make" "markdown" "python" "regex" "rust" "swift" "typescript" "vim"
                "wgsl" "yaml"
            ]
            :highlight { 
                :enable true 
                :additional_vim_regex_highlighting false 
            }
            :textobjects {
                :select {
                    :enable true
                    :lookahead true
                    :keymaps {
                        "aa" "@parameter.outer"
                        "ia" "@parameter.inner"
                        "ai" "@conditional.outer"
                        "ii" "@conditional.inner"
                        "al" "@loop.outer"
                        "il" "@loop.inner"
                        "af" "@function.outer"
                        "if" "@function.inner"
                        "ac" "@class.outer"
                        "ic" "@class.inner"
                        "ab" "@block.outer"
                        "ib" "@block.inner"
                    }
                    ;; You can choose the select mode (default is charwise 'v')
                    ;; selection_modes = {
                    ;;     ['@parameter.outer'] = 'v' -- charwise
                    ;;     ['@function.outer'] = 'V' -- linewise
                    ;;     ['@class.outer'] = '<c-v>' -- blockwise
                    ;; }
                }
                :swap {
                    :enable true
                    :swap_next {
                        "<leader>a" "@parameter.inner"
                    }
                    :swap_previous {
                        "<leader>A" "@parameter.inner"
                    }
                }
                :move { 
                    :enable true 
                    :set_jumps true
                    :goto_next_start {
                        "]a" "@parameter.outer"
                        "]l" "@loop.outer"
                        "]i" "@conditional.outer"
                        "]f" "@function.outer"
                        "]b" "@block.outer"
                        "]r" "@return.outer"
                        "]s" "@statement.outer"
                    }
                    :goto_next_end {
                        "]A" "@parameter.outer"
                        "]L" "@loop.outer"
                        "]I" "@conditional.outer"
                        "]F" "@function.outer"
                        "]B" "@block.outer"
                        "]R" "@return.outer"
                        "]S" "@statement.outer"
                    }
                    :goto_previous_start {
                        "[a" "@parameter.outer"
                        "[l" "@loop.outer"
                        "[i" "@conditional.outer"
                        "[f" "@function.outer"
                        "[b" "@block.outer"
                        "[r" "@return.outer"
                        "[s" "@statement.outer"
                    }
                    :goto_previous_end {
                        "[A" "@parameter.outer"
                        "[L" "@loop.outer"
                        "[I" "@conditional.outer"
                        "[F" "@function.outer"
                        "[B" "@block.outer"
                        "[R" "@return.outer"
                        "[S" "@statement.outer"
                    }
                }
            }
        })
    )}
    {1 "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"}
    {1 "nvim-treesitter/nvim-treesitter-context"}
    {1 "numToStr/Comment.nvim" :config true} 
    {1 "python-rope/ropevim"}
    {1 "stevearc/aerial.nvim" :config (fn [config opts]
        (fn on_attach [bufnr]
            (local bufopts { :buffer bufnr})
            (vim.keymap.set "n" "{" "<cmd>AerialPrev<CR>" bufopts)
            (vim.keymap.set "n" "}" "<cmd>AerialNext<CR>" bufopts)
            (vim.keymap.set "n" "<leader>s" "<cmd>AerialNavToggle<CR>" bufopts)
        )
        (local aerial (require :aerial))
        (aerial.setup {
            :on_attach on_attach
            :show_guides true
            :layout {
                :max_width { 80 0.2 }
            }
        }))}
])

;; To debug LSP issues:
;; vim.lsp.set_log_level("debug")
;; Use :LspInfo and :LspLog to see what's going on

M
