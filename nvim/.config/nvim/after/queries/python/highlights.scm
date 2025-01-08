;; extends

(("lambda" @keyword) (#set! conceal "ﬦ "))
(("def"    @keyword) (#set! conceal " "))
;(("in"     @keyword) (#set! conceal "∈ "))
;(("or"     @keyword) (#set! conceal "∨ "))
;(("and"    @keyword) (#set! conceal "∧ "))
;(("not"    @keyword) (#set! conceal "¬" ))
;(("not in" @keyword) (#set! conceal "∉ "))

; ((function_call name: (identifier) @function (#eq? @function "sum"))  (#set! conceal "∑ "))
; (("all"    @keyword) (#set! conceal "∀"))
; (("any"    @keyword) (#set! conceal "∃"))
; (("/"    @keyword) (#set! conceal "÷"))
; (("None"  @keyword) (#set! conceal "∅"))
