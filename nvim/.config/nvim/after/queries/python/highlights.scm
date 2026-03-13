;; extends

(("lambda" @keyword) (#set! conceal "ﬦ "))
(("def"    @keyword) (#set! conceal "ƒ "))
(("class"  @keyword) (#set! conceal "𝑇 "))
(("in"     @keyword) (#set! conceal "∈ "))
(("or"     @keyword) (#set! conceal "∨ "))
(("and"    @keyword) (#set! conceal "∧ "))
(("not"    @keyword) (#set! conceal "¬" ))
(("not in" @keyword) (#set! conceal "∉ "))

((identifier) @function.builtin (#eq? @function.builtin "any") (#set! conceal "∃"))
((identifier) @function.builtin (#eq? @function.builtin "all") (#set! conceal "∀"))
((identifier) @function.builtin (#eq? @function.builtin "map") (#set! conceal "↦"))
((identifier) @function.builtin (#eq? @function.builtin "sum") (#set! conceal "∑"))
((identifier) @function.builtin (#eq? @function.builtin "zip") (#set! conceal "⧉"))

; ((binary_operator) @operator (#eq? @operator "/") (#set! conceal "÷"))
((none) @constant.builtin (#set! conceal "∅"))
