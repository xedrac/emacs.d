;(setq treesit-language-source-alist
;   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
;     (c "https://github.com/tree-sitter/tree-sitter-c")
;     (cmake "https://github.com/uyha/tree-sitter-cmake")
;     (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
;     ;(csharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
;     ;(css "https://github.com/tree-sitter/tree-sitter-css")
;     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
;     ;(go "https://github.com/tree-sitter/tree-sitter-go")
;     ;(haskell "https://github.com/tree-sitter/haskell-tree-sitter")
;     (html "https://github.com/tree-sitter/tree-sitter-html")
;     ;(java "https://github.com/tree-sitter/tree-sitter-java")
;     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
;     (json "https://github.com/tree-sitter/tree-sitter-json")
;     ;(julia "https://github.com/tree-sitter/tree-sitter-julia")
;     (make "https://github.com/alemuller/tree-sitter-make")
;     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
;     ;(ocaml "https://github.com/tree-sitter/tree-sitter-ocaml")
;     (python "https://github.com/tree-sitter/tree-sitter-python")
;     ;(ruby "https://github.com/tree-sitter/tree-sitter-ruby")
;     (rust "https://github.com/tree-sitter/tree-sitter-rust")
;     ;(scala "https://github.com/tree-sitter/haskell-tree-sitter")
;     ;(swift "https://github.com/tree-sitter/tree-sitter-swift")
;     (toml "https://github.com/tree-sitter/tree-sitter-toml")
;     ;(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
;     ;(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
;     (verilog "https://github.com/tree-sitter/tree-sitter-verilog")
;     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
;
;;; Install the treesitter grammars if not already installed
;;(unless (treesit-language-available-p 'rust)
;;  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
;
;;(mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
;
;(dolist (lang treesit-language-source-alist)
;  (unless (treesit-language-available-p (car lang))
;    (treesit-install-language-grammar (car lang))))


(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
;(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
;(add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode))
;(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

(provide 'init-treesitter)

