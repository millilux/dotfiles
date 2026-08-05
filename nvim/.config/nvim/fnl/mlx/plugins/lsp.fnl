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
        (local lsp vim.lsp)
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
        (lsp.config "bashls" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "bashls")

        ;; C/C++. Finds compile_commands.json by walking up from the file; a
        ;; compile_flags.txt at the project root works for simple projects.
        (lsp.config "clangd" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "clangd")

        (lsp.config "clojure_lsp" {
            :on_attach on_attach
            :capabilities capabilities
            :root_dir (util.root_pattern "*.clj")
        })
        ; (lsp.enable "clojure_lsp")

        (lsp.config "cssls" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "cssls")

        (lsp.config "elixirls" {
            :cmd [(find_elixir_ls)]
            :on_attach on_attach
            :capabilities capabilities
        })
        ; (lsp.enable "elixirls") ; very busted

        (lsp.config "fennel_ls" {
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
        (lsp.enable "fennel_ls")

        (lsp.config "fsautocomplete" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "fsautocomplete")

        (lsp.config "gleam" {
            :on_attach on_attach
            :capabilities capabilities
        })
        ; (lsp.enable "gleam")


        (lsp.config "glsl_analyzer" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "glsl_analyzer")

        (lsp.config "graphql" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "graphql")

        (lsp.config "hls" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "hls")

        (lsp.config "html" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "html")

        (lsp.config "jsonls" {
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
        (lsp.enable "jsonls")

        (lsp.config "ocamllsp" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "ocamllsp")
        ; (lsp.config "ruff" {
        ;     :on_attach on_attach
        ;     :capabilities capabilities
        ; })
        ; (lsp.config "basedpyright" {
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
        ;; mise shim, not a bare `pylsp`: a stray copy earlier on $PATH would
        ;; start fine and then silently drop the plugin settings below.
        (lsp.config "pylsp" {
            :cmd [ (vim.fn.expand "~/.local/share/mise/shims/pylsp") "-v" "--log-file" "/tmp/nvim-pylsp.log" ]
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :pylsp {
                    :plugins {
                        ; :executable pins ruff to the mise one; python-lsp-ruff
                        ; otherwise prefers its own bundled copy.
                        :ruff { :enabled true :executable "ruff" }
                        :mypy { :enabled true }
                        ; :rope_autoimport [:enabled true {:code_actions {:enabled true}}] ; Busted: https://github.com/python-lsp/python-lsp-server/issues/503
                        ; :pycodestyle { :enabled false }
                        ; :autopep8 { :enabled false }
                        ; :pylint { :enabled false }
                    }
                }
            }
        })
        (lsp.enable "pylsp")
        ;; Pyright supports Workspace Symbol search but no code actions/linters/formatters
        ;; (lsp.config "pyright" {
        ;;     :on_attach on_attach
        ;;     :capabilities capabilities
        ;; })
        ; (lsp.config "jedi_language_server" {
        ;     :on_attach on_attach
        ;     :capabilities capabilities
        ; })
        (lsp.config "lua_ls" {
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
        (lsp.enable "rescriptls")
        ; (lsp.enable "lua_ls")
        (lsp.config "rust_analyzer" {
            :on_attach on_attach
            :capabilities capabilities
            ; :root_dir (util.root_pattern "Cargo.toml")
        })
        (lsp.enable "rust_analyzer")

        (lsp.config "ts_ls" {
            :on_attach on_attach
            :capabilities capabilities
        })
        (lsp.enable "ts_ls")

        (lsp.config "wgsl_analyzer" {
            :on_attach on_attach
            :capabilities capabilities
            :filetypes ["wgsl"]
        })
        (lsp.enable "wgsl_analyzer")

        (lsp.config "yamlls" {
            :on_attach on_attach
            :capabilities capabilities
            :settings {
                :yaml { :schemas { :kubernetes "*.yaml" }}
            }
        })
        (lsp.enable "yamlls")
    )}
    {1 "python-rope/pylsp-rope"}
    {1 "nvim-treesitter/nvim-treesitter"
     :branch "main"       ; requires nvim 0.11+
     :lazy false          ; main branch does not support lazy-loading
     :build ":TSUpdate"
     :config (fn []
        (local ts (require :nvim-treesitter))
        ;; Ensure parsers are installed (async; no-op if already present).
        ;; Compiled by the tree-sitter CLI (mise-managed) into stdpath('data')/site.
        (ts.install [
            "bash" "c" "cpp" "css" "clojure" "dockerfile" "diff" "elixir" "fennel" "fish" "gleam" "glsl" "go" "graphql" "groovy" "haskell" "hlsl"
            "javascript" "json" "kotlin" "lua" "make" "markdown" "markdown_inline" "ocaml" "python" "query" "qmljs" "regex" "rescript" "rust" "sql" "swift"
            "typescript" "toml" "vim" "vimdoc" "wgsl" "xml" "yaml" "yuck"
        ])
        ;; Enable Neovim-native treesitter highlighting for every filetype that
        ;; has a parser (pcall no-ops where there is none). Injections and folds
        ;; are handled natively by Neovim as well.
        (vim.api.nvim_create_autocmd :FileType
            {:callback (fn [ev] (pcall vim.treesitter.start ev.buf))}))}
    {1 "nvim-treesitter/nvim-treesitter-textobjects"
     :branch "main"
     :config (fn []
        (local tobj (require :nvim-treesitter-textobjects))
        (local ts-select (require :nvim-treesitter-textobjects.select))
        (local ts-swap (require :nvim-treesitter-textobjects.swap))
        (local ts-move (require :nvim-treesitter-textobjects.move))
        (tobj.setup {:select {:lookahead true} :move {:set_jumps true}})
        ;; select (visual / operator-pending)
        (fn sel [key obj] (vim.keymap.set [:x :o] key #(ts-select.select_textobject obj :textobjects)))
        (sel "aa" "@parameter.outer")   (sel "ia" "@parameter.inner")
        (sel "ai" "@conditional.outer") (sel "ii" "@conditional.inner")
        (sel "al" "@loop.outer")        (sel "il" "@loop.inner")
        (sel "af" "@function.outer")    (sel "if" "@function.inner")
        (sel "ac" "@class.outer")       (sel "ic" "@class.inner")
        (sel "ab" "@block.outer")       (sel "ib" "@block.inner")
        ;; swap
        (vim.keymap.set :n "<leader>a" #(ts-swap.swap_next "@parameter.inner"))
        (vim.keymap.set :n "<leader>A" #(ts-swap.swap_previous "@parameter.inner"))
        ;; move (next/prev * start/end)
        (fn mv [f key obj] (vim.keymap.set [:n :x :o] key #((. ts-move f) obj :textobjects)))
        (mv :goto_next_start "]a" "@parameter.outer")   (mv :goto_next_start "]l" "@loop.outer")
        (mv :goto_next_start "]i" "@conditional.outer") (mv :goto_next_start "]f" "@function.outer")
        (mv :goto_next_start "]b" "@block.outer")       (mv :goto_next_start "]r" "@return.outer")
        (mv :goto_next_start "]s" "@statement.outer")
        (mv :goto_next_end "]A" "@parameter.outer")   (mv :goto_next_end "]L" "@loop.outer")
        (mv :goto_next_end "]I" "@conditional.outer") (mv :goto_next_end "]F" "@function.outer")
        (mv :goto_next_end "]B" "@block.outer")       (mv :goto_next_end "]R" "@return.outer")
        (mv :goto_next_end "]S" "@statement.outer")
        (mv :goto_previous_start "[a" "@parameter.outer")   (mv :goto_previous_start "[l" "@loop.outer")
        (mv :goto_previous_start "[i" "@conditional.outer") (mv :goto_previous_start "[f" "@function.outer")
        (mv :goto_previous_start "[b" "@block.outer")       (mv :goto_previous_start "[r" "@return.outer")
        (mv :goto_previous_start "[s" "@statement.outer")
        (mv :goto_previous_end "[A" "@parameter.outer")   (mv :goto_previous_end "[L" "@loop.outer")
        (mv :goto_previous_end "[I" "@conditional.outer") (mv :goto_previous_end "[F" "@function.outer")
        (mv :goto_previous_end "[B" "@block.outer")       (mv :goto_previous_end "[R" "@return.outer")
        (mv :goto_previous_end "[S" "@statement.outer"))}
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
