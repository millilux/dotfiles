(import-macros {: color! : g! : augroup!} :hibiscus.vim)

(color! :oxocarbon)

(local signs {:Error " " :Warn " " :Info " " :Hint " "})

(each [type icon (pairs signs)]
  (local hl (.. :DiagnosticSign type))
  (vim.fn.sign_define hl {:text icon :texthl hl :numhl ""}))

(let [config vim.diagnostic.config]
  (config {:virtual_text false "update_in_insert:" true}))

;; (g! material_style "deep ocean")
;;
;; (local material (require :material))
;; (local colors (require :material/colors))
;; (material.setup {
;;     :pop_menu "light"
;;     :contrast_windows {}
;;     :disable {
;;         :term_colors true
;;     }
;;     :custom_highlights {
;;         :NvimTreeIndentMarker { :fg colors.selection }
;;         :NvimTreeNormal { :bg colors.contrast }
;;         :NvimTreeFolderIcon { :fg colors.fg }
;;         :NvimTreeFolderName { :fg colors.blue }
;;         :NvimTreeOpenedFolderName { :fg colors.blue }
;;         :NvimTreeGitDirty { :fg colors.yellow }
;;         :NvimTreeGitStaged { :fg colors.green }
;;         :NvimTreeGitMerge { :fg colors.red }
;;         :NvimTreeGitRenamed { :fg colors.orange }
;;         :NvimTreeGitNew { :fg colors.pink }
;;         :NvimTreeGitDeleted { :fg colors.red }
;;     }
;; })

(vim.cmd "highlight WinSeparator ctermfg=None ctermbg=None guibg=None guifg=None")
(vim.cmd "highlight StatusLineNC ctermbg=None guibg=None")

(vim.cmd "highlight Normal ctermbg=None guibg=None")
(vim.cmd "highlight NormalNC ctermbg=None guibg=None")
(vim.cmd "highlight SignColumn ctermbg=None guibg=None")
(vim.cmd "highlight FoldColumn ctermbg=None guibg=None")
(vim.cmd "highlight LineNr ctermbg=None guibg=None")
; (vim.cmd "highlight NonText ctermbg=None guibg=None")

; Remove fold background highlighting
(vim.api.nvim_set_hl 0 :Folded {:bg :None :fg :#393939})

; Force the Flash Label highlight to match Hop's default
; (vim.api.nvim_set_hl 0 :FlashLabel {:bg :None :fg :#FF007C :bold true})
; (vim.api.nvim_set_hl 0 :FlashLabel {:bg :#FF007C :fg :#FFFFFF :bold true})
(vim.api.nvim_set_hl 0 :FlashLabel {:bg :None :fg :#00dfff :bold true})
; (vim.api.nvim_set_hl 0 :FlashMatch {:bg :None :fg :#2B8DB3})
; (vim.api.nvim_set_hl 0 :FlashCurrent {:bg :None :fg :#FF007C})

(augroup! :dap-ui-statusline [[FileType] [dapui*] ":set statusline=\\ "])

; (augroup! :active-cursorline [[VimEnter] * ":setlocal cursorline"]
;           [[WinEnter] * ":setlocal cursorline"]
;           [[BufWinEnter] * ":setlocal cursorline"]
;           [[WinLeave] * ":setlocal nocursorline"])

(vim.fn.sign_define :DapBreakpoint
                    {:text "→" :texthl :Special :linehl "" :numhl ""})
(vim.fn.sign_define :DapStopped {:text "→"
                                 :texthl :Error
                                 :linehl ""
                                 :numhl ""})

