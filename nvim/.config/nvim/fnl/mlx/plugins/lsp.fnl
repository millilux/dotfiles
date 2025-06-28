(local M [
    {1 "neovim/nvim-lspconfig" 
        :lazy true 
        :event [ :BufReadPre :BufNewFile ]
        :dependencies ["hrsh7th/cmp-nvim-lsp"] 
        :config (fn [plugin opts]
        (fn on_attach [client bufnr]
            (local bufopts { :noremap true :silent true :buffer bufnr })
            (vim.keymap.set "n" "gd" vim.lsp.buf.definition bufopts) ; <-- breaks CTRL-O after gd in macros - seems to be fixed!
            (vim.keymap.set "n" "gD" vim.lsp.buf.definition bufopts)
            (vim.keymap.set "n" "K" vim.lsp.buf.hover bufopts)
            (vim.keymap.set "n" "gi" vim.lsp.buf.implementation bufopts)
            (vim.keymap.set "n" "gr" vim.lsp.buf.references bufopts)
            (vim.keymap.set "n" "gs" vim.lsp.buf.signature_help bufopts)
            (vim.keymap.set "n" "gt" vim.lsp.buf.type_definition bufopts)
            (vim.keymap.set "n" "<leader>r" vim.lsp.buf.rename bufopts)
            (vim.keymap.set ["n" "v"] "<leader>ca" vim.lsp.buf.code_action bufopts)
            ; (vim.keymap.set ["n" "v"] "<leader>cf" vim.lsp.buf.format bufopts) ; Use conform.nvim instead
            (vim.keymap.set "n" "<leader>ci" vim.lsp.buf.incoming_calls bufopts)
            ; (vim.keymap.set "n" "<leader>co" vim.lsp.buf.outgoing_calls bufopts)
            (vim.keymap.set "n" "<leader>wa" vim.lsp.buf.add_workspace_folder bufopts)
            (vim.keymap.set "n" "<leader>wr" vim.lsp.buf.remove_workspace_folder bufopts)
        ;     vim.keymap.set('n', '<leader>wl', function()
        ;         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        ;     end, bufopts)
            ; (vim.lsp.inlay_hint.enable true)
        )
        (local lsp (require :lspconfig))
        (local util (require :lspconfig/util))
        (local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
        ; (local capabilities [:default_capabilities])
        (fn find_elixir_ls []
            (local handle (io.popen "which elixir-ls"))
            (local output (handle:read :*a))
            (handle:close)
            (local path (string.gsub output "%s+" ""))
            (if (= path "")
                (error "elixir-ls not found"))
            path
        )
        (lsp.bashls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.ccls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :init_options {
                :compilationDatabaseDirectory "build"
                :index { :threads 0 }
                :clang { :excludeArgs ["-frounding-math"] }
            }
        })
        (lsp.clojure_lsp.setup {
            :on_attach on_attach
            :capabilities capabilities
            :root_dir (util.root_pattern "*.clj")
        })
        (lsp.cssls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.elixirls.setup {
            :cmd [(find_elixir_ls)]
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.fennel_ls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
              ; Passing settings doesn't work, but a flsproject.fnl file with the same values does
              :fennel-ls {
                :libraries {
                  :tic-80 true 
                  :love2d true 
                }
                ; :libraries (vim.api.nvim_list_runtime_paths)
                ; :extra-globals "vim hibiscus" 
              }
            }
        })
        (lsp.fsautocomplete.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.gleam.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.glsl_analyzer.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.graphql.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.hls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.html.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.jsonls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :json {
                    :schemas {
                        :kubernetes "*.json"
                        ; :json-schema-store "https://www.schemastore.org/api/json/catalog.json"
                    }
                }
            }
        })
        (lsp.ocamllsp.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        ; (lsp.ruff.setup {
        ;     :on_attach on_attach
        ;     :capabilities capabilities
        ; })
        ; (lsp.basedpyright.setup {
        ;     :on_attach on_attach
        ;     :capabilities capabilities
        ;     :settings {
        ;         :basedpyright {
        ;             :typeCheckingMode "standard"
        ;             :disableOrganizeImports false
        ;             :analysis {
        ;                 :ignore "*"
        ;             }
        ;         }
        ;     }
        ; })
        ; PyLSP has everything except workspace symbols
        (lsp.pylsp.setup {
            :cmd [ "pylsp" "-v" "--log-file" "/tmp/nvim-pylsp.log" ]
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :pylsp {
                    :plugins {
                        :ruff { :enabled true }
                        :mypy { :enabled true }
                        ; :rope_autoimport [:enabled true {:code_actions {:enabled true}}] ; Busted: https://github.com/python-lsp/python-lsp-server/issues/503
                        ; :pycodestyle { :enabled false }
                        ; :autopep8 { :enabled false }
                        ; :pylint { :enabled false }
                    }
                }
            }
        })
        ;; Pyright supports Workspace Symbol search but no code actions/linters/formatters
        ;; (lsp.pyright.setup {
        ;;     :on_attach on_attach
        ;;     :capabilities capabilities
        ;; })
        (lsp.jedi_language_server.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.lua_ls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :Lua {
                    :telemetry {:enable false}
                    :workspace {
                        :checkThirdParty "Apply"
                        :userThirdParty [ (vim.fn.expand "~/.local/share/lua-lsp-addons/") ]
                        ; Faster simpler version of below if needed
                        ; :library [
                        ;       vim.env.VIMRUNTIME
                        ; ]
                        :library (vim.api.nvim_get_runtime_file "" true) 
                    }
                }	
            }
        })
        (lsp.rust_analyzer.setup {
            :on_attach on_attach
            :capabilities capabilities
            :filetypes ["rust"]
            :root_dir (util.root_pattern "Cargo.toml")
        })
        (lsp.ts_ls.setup {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.wgsl_analyzer.setup {
            :on_attach on_attach
            :capabilities capabilities
            :filetypes ["wgsl"]
        })
        (lsp.yamlls.setup {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :yaml { :schemas { :kubernetes "*.yaml" }}
            }
        })
    )}
    {1 "python-rope/pylsp-rope"}
    {1 "nvim-treesitter/nvim-treesitter" :build ":TSUpdate" :config (fn [] 
        (local configs (require :nvim-treesitter.configs))
        (configs.setup { 
            :ensure_installed [
                "bash" "c" "cpp" "clojure" "dockerfile" "diff" "elixir" "fennel" "fish" "gleam" "glsl" "go" "graphql" "haskell" "hlsl"
                "javascript" "json" "kotlin" "lua" "make" "markdown" "markdown_inline" "ocaml" "python" "query" "regex" "rust" "sql" "swift"
                "typescript" "toml" "vim" "vimdoc" "wgsl" "yaml" "yuck"
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
                        ; "<leader>a" "@class.outer"
                    }
                    :swap_previous {
                        "<leader>A" "@parameter.inner"
                        ; "<leader>A" "@class.outer"
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
    ; {1 "nvim-treesitter/nvim-treesitter-context"}
    ; {1 "numToStr/Comment.nvim" :config true} ; Trying 0.10's built-in comments instead
    ; {1 "python-rope/ropevim"}
    {1 "tikhomirov/vim-glsl"}
    {1 "bassamsdata/namu.nvim" :opts {
            :global {}
            :namu_symbols {
              :enable true
              :options {
                :display {:format :tree_guides}}}}}
            ; :config (fn []
            ;           (vim.keymap.set "n" "<leader>ss" ":Namu symbols<cr>"
            ;             {:desc "Jump to LSP symbol"
            ;               :silent true})
            ;           (vim.keymap.set "n" "<leader>sw" ":Namu workspace<cr>"
            ;             {:desc "LSP Symbols - Workspace"
            ;               :silent true}))}}
    {1 "stevearc/aerial.nvim" :lazy true 
        :keys [["<leader>o" ":AerialToggle!<CR>"]]
        :config (fn [config opts]
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
                :guides {
                    ; When the child item has a sibling below it
                    :mid_item " ├─"
                    ; When the child item is the last in the list
                    :last_item " └─"
                    ; When there are nested child guides to the right
                    :nested_top " │ "
                    ; Raw indentation
                    :whitespace " "
                }
                :float {
                    :relative :win
                }
                :layout {
                    :min_width 20
                    ; :max_width { 120 0.2 }
                }
            }))}
])

; To debug LSP issues:
; (vim.lsp.set_log_level "debug")
; Use :LspInfo and :LspLog to see what's going on

M
