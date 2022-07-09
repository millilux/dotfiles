(require :mlx.options)

(let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    :--single-branch
                    "https://github.com/folke/lazy.nvim.git"
                    lazypath]))
  (vim.opt.runtimepath:prepend lazypath))


(local lazy (require :lazy))
(lazy.setup [
    {:import "mlx.plugins"}

    ;; Themes
    {1 "folke/tokyonight.nvim"}
    {1 "marko-cerovac/material.nvim" :opts {
        :disable {
            :eob_lines true
        }
        :lualine_style :stealth
    }}
    {1 "catppuccin/nvim" :as :catppuccin}
    {1 "nyoom-engineering/oxocarbon.nvim"}
    {1 "EdenEast/nightfox.nvim"}
    
    ;; UI

    ;; "markonm/traces.vim"     ;; Highlight patterns & ranges in ex commands in commandline mode
    ;; {1 "glepnir/dashboard-nvim" :config (fn []
    ;;      (local dashboard (require :dashboard))
    ;;      (tset dashboard :custom_header {})
    ;;      (tset dashboard :custom_center [
    ;;         {
    ;;             :icon " "
    ;;             :desc "Recent                   "                   
    ;;             :action "DashboardFindHistory"
    ;;             :shortcut "SPC f h"
    ;;         }
    ;;      ])
    ;;      (tset dashboard :custom_footer {})
    ;; )}
    ;; {1 "nvim-lualine/lualine.nvim" :config { :theme "auto"}}
    ;; {1 "lukas-reineke/indent-blankline.nvim" }
    ;; {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }
    {1 "folke/noice.nvim" :dependencies ["rcarriga/nvim-notify" "MunifTanjim/nui.nvim" ]}
    ;; {1 "folke/trouble.nvim"}
    {1 "onsails/lspkind.nvim"}
    {1 "junegunn/vim-peekaboo"}  ;; Preview register contents
    ;; {1 "kevinhwang91/nvim-bqf" :ft "qf"}

    ;; Navigation
    {1 "unblevable/quick-scope"}
    {1 "ggandor/leap.nvim"}
    {1 "tpope/vim-unimpaired"}
    {1 "tpope/vim-repeat"}
    {1 "bronson/vim-visual-star-search"}

    ;; Text
    {1 "kylechui/nvim-surround" :config true}
    {1 "editorconfig/editorconfig-vim"} ;; Neovim 0.9 will have built-in editorconfig support
    ;; {1 "guns/vim-sexp"}
    ;; "wellle/targets.vim" " Not needed?

    ;; File Tree
    ;; "yamatsum/nvim-nonicons"
    ;; {1 "nvim-neo-tree/neo-tree.nvim" :dependencies [ "nvim-lua/plenary.nvim" "MunifTanjim/nui.nvim" ]}
    {1 "nvim-tree/nvim-tree.lua" :dependencies [ {1 "nvim-tree/nvim-web-devicons" :opts {
                                                    :override {:fnl {
                                                        :icon "ﬦ"
                                                        :name "Fennel"
                                                    }}
                                                    ;; :color_icons false
                                                 }}]}

    ;; Testing
    {1 "nvim-neotest/neotest"}
    {1 "nvim-neotest/neotest-python"}

    ;; Debugging
    {1 "mfussenegger/nvim-dap"}
    {1 "rcarriga/nvim-dap-ui" :config true}
    {1 "theHamsta/nvim-dap-virtual-text" :config true}
    {1 "mfussenegger/nvim-dap-python"}

    ;; WIP
    ;; {1 "anuvyklack/hydra.nvim"}
    ;; {1 "mbbill/undotree"}
])

(local leap (require :leap))
(leap.set_default_keymaps)

;; (local neotree (require :neo-tree))
;; (neotree.setup {
;;     :popup_border_style "rounded"
;;     :enable_git_status false
;;     :enable_diagnostics false
;;     :default_component_configs {
;;         :indent {
;;             :with_expanders true
;;             :expander_collapsed ""
;;             :expander_expanded ""
;;         }
;;     }
;;     :window {
;;         :mappings {
;;             "l" "open"
;;             "h" "close_node"
;;         }
;;     }
;; })

(local nvimtree (require :nvim-tree))
(nvimtree.setup {
    :hijack_cursor true
    :disable_netrw true
    ;; :git {
    ;;     :enable true
    ;;     :show_on_dirs false
    ;; }
    :actions {
        :change_dir { 
            :global true
            :enable true
        }
    }
    :view {
        ;; :side "right"
        :width 38 
        :mappings {
            :list [
                { :key "<Esc>" :action "close" }
                { :key "u" :action "dir_up" }
                { :key "." :action "cd" }
            ]
        }
        :float { 
            :enable true 
            ;; :open_win_config {
            ;;     ;; :anchor "NE"
            ;;     :row 50 
            ;;     :col 50
            ;;     :width 50
            ;; }
            :open_win_config (fn []
                (local screen_w (vim.opt.columns:get))
                (local screen_h (- (vim.opt.lines:get) (vim.opt.cmdheight:get)))
                (local window_w (* screen_w 0.5))
                (local window_h (* screen_h 0.62))
                (local window_w_int (math.floor window_w))
                (local window_h_int (math.floor window_h))
                (local center_x (/ (- screen_w window_w) 2))
                (local center_y (- (/ (- (vim.opt.lines:get) window_h) 2) (vim.opt.cmdheight:get)))
                {
                    :border "rounded"
                    :relative "editor"
                    :row center_y
                    :col center_x
                    :width window_w_int
                    :height window_h_int
                }
            )
        }
    }
    :renderer {
        :icons {
            :webdev_colors false
            :git_placement "signcolumn"
            :show {
                :file true
                ;; :folder false
                :folder_arrow true
                :git true
                :modified true
            }
            :glyphs {
                :git {
                    :unstaged "M"
                    :staged "S"
                    :unmerged ""
                    :renamed "➜"
                    :untracked "U"
                    :deleted ""
                    :ignored "◌"
                }
            }
        }
    }
})


(local neotest (require :neotest))
;; (neotest.setup)
    ;; adapters = {
    ;;     require('neotest-vim-test'),
    ;;     ;; require('neotest-python')({
    ;;     ;;   dap = { justMyCode = false },
    ;;     ;; }),
    ;;     require('neotest-plenary'),
    ;;     ;; require("neotest-vim-test")({
    ;;     ;;   ignore_file_types = { "python", "vim", "lua" },
    ;;     ;; }),
    ;; }


(local dap (require :dap))
(local dapui (require :dapui))

(fn focus_float [ element ]
    (dapui.float_element element { :enter true })
)

(vim.keymap.set "n" "<F9>" dap.continue)
(vim.keymap.set "n" "<F10>" dap.step_over)
(vim.keymap.set "n" "<F11>" dap.step_into)
(vim.keymap.set "n" "<F12>" dap.step_out)
(vim.keymap.set "n" "<Leader>x" dap.toggle_breakpoint)
(vim.keymap.set "n" "<Leader>X" (fn [] (dap.set_breakpoint (vim.fn.input "Condition: "))))
;; nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
;; (vim.keymap.set "n" "<Leader>dr" dap.repl.toggle)
(vim.keymap.set "n" "<Leader>du" dapui.toggle)
(vim.keymap.set "n" "<Leader>dc" (fn [] (focus_float "console")))
(vim.keymap.set "n" "<Leader>dr" (fn [] (focus_float "repl")))
(vim.keymap.set "n" "<Leader>dv" (fn [] (focus_float "scopes")))
(vim.keymap.set "n" "<Leader>ds" (fn [] (focus_float "stacks")))
(vim.keymap.set "n" "<Leader>de" (fn [] (focus_float "expressions")))
(vim.keymap.set "n" "<Leader>dw" (fn [] (focus_float "watches")))
;; nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

(tset dap.listeners.after.event_initialized "dapui_config" (fn [] (dapui.open)))
(tset dap.listeners.before.event_terminated "dapui_config" (fn [] (dapui.close)))
(tset dap.listeners.before.event_exited "dapui_config" (fn [] (dapui.close)))

(fn attach_python_debugger [args]
       (let [dap (require :dap)
             host (. args 1)
             port 5678]
         (global python-attach-adapter
                 {:type :server : host :port port})
         (global python-attach-config
                 {:type :python
                  :request :attach
                  :connect {:port port : host}
                  :mode :remote
                  :name "Remote Attached Debugger"
                  :cwd (vim.fn.getcwd)
                  :pathMappings [{:localRoot (vim.fn.getcwd)
                                  :remoteRoot :/usr/src/app}]})
         (local session (dap.attach host (tonumber 5) python-attach-config))
         (when (= session nil)
           (io.write "Error launching adapter"))
         (dap.repl.open)))	

(dapui.setup {
    :layouts [
        ;; {
        ;;     :elements [
        ;;         "repl"
        ;;         "console"
        ;;     ]
        ;;     :size 0.1 ;; % of total lines
        ;;     :position "bottom"
        ;; }
        {
            :elements [
            ;; Elements can be strings or table with id and size keys.
                { :id "scopes" :size 0.25 }
                "breakpoints"
                "stacks"
                "watches"
            ]
            :size 40 ;; Columns
            :position "right"
        }
    ]
    ;; :controls {
    ;;     :element "console"
    ;; }
    :render {
      :max_value_lines 3
    }
})

(local dap-python (require :dap-python))
(dap-python.setup "~/.virtualenvs/debugpy/bin/python")

(table.insert dap.configurations.python {
        :type :python
        :request :attach
        :name "Docker"
        :connect { :port 5678 :host "127.0.0.1" }
        :mode :remote
        ;; :cwd (vim.fn.getcwd)
        :pathMappings [{:localRoot (vim.fn.getcwd)
                        :remoteRoot "/athena/backend"}]})
        ;; :program "${file}"})	

(local noice (require :noice))
(noice.setup {
    :presets {
        :bottom_search true ;; use a classic bottom cmdline for search
        ;; :command_palette true ;; position the cmdline and popupmenu together
        :long_message_to_split true ;; long messages will be sent to a split
        :inc_rename false ;; enables an input dialog for inc-rename.nvim
        :lsp_doc_border false ;; add a border to hover docs and signature help
    }
    :cmdline {
        :view "cmdline"
    }
    :lsp {
        :progress { :enabled false }
    }
})

(let [config vim.diagnostic.config]
  (config {
      :virtual_text false
      :update_in_insert: true
    })
)

(require :mlx.keymaps)
(require :mlx.ui)
