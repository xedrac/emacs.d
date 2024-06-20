;; -*- lexical-binding: t; -*-

;;; GC and other startup optimizations

;; A big contributor to startup times is garbage collection.  We up the GC
;; threshold to temporarily prevent it from running, and then reset it later
;; using a hook.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Keep a ref to the actual file-name-handler
(defvar default-file-name-handler-alist file-name-handler-alist)

;; Set the file-name-handler to nil (because regexing is cpu intensive)
(setq file-name-handler-alist nil)

;; Reset file-name-handler-alist after initialization
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold 16777216
          gc-cons-percentage 0.1
          file-name-handler-alist default-file-name-handler-alist)))

;; For native comp
(when (fboundp 'native-compile-async)
  (setq comp-async-jobs-number 15
        comp-deferred-compilation t
        comp-deferred-compilation-black-list '()))

;;; Add conf folder to the load path
(add-to-list 'load-path "~/.emacs.d/lisp")
;(add-to-list 'load-path "~/.emacs.d/conf")
;(add-to-list 'load-path "~/.emacs.d/conf/programming")
;(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))
;(load (expand-file-name "~/.roswell/helper.el"))

;;; Package installer setup
(require 'elpaca-bootstrap)

;;; Core modules
(require 'cl-lib)
(require 'eglot)
(require 'treesit)

(setq treesit-language-source-alist
  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
    (c "https://github.com/tree-sitter/tree-sitter-c")
    ;(c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.20.5")
    (cmake "https://github.com/uyha/tree-sitter-cmake")
    (commonlisp "https://github.com/tree-sitter-grammars/tree-sitter-commonlisp")
    ;(css "https://github.com/tree-sitter/tree-sitter-css")
    (cuda "https://github.com/tree-sitter-grammars/tree-sitter-cuda")
    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    (glsl "https://github.com/tree-sitter-grammars/tree-sitter-glsl")
    ;(go "https://github.com/tree-sitter/tree-sitter-go")
    (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
    (hlsl "https://github.com/tree-sitter-grammars/tree-sitter-hlsl")
    (html "https://github.com/tree-sitter/tree-sitter-html")
    ;(java "https://github.com/tree-sitter/tree-sitter-java")
    ;(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
    (json "https://github.com/tree-sitter/tree-sitter-json")
    ;(julia "https://github.com/tree-sitter/tree-sitter-julia")
    (lua "https://github.com/tree-sitter/tree-sitter-lua")
    (make "https://github.com/tree-sitter-grammars/tree-sitter-make")
    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
    ;(ocaml "https://github.com/tree-sitter/tree-sitter-ocaml")
    ;(php "https://github.com/tree-sitter/tree-sitter-php")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    ;(regex "https://github.com/tree-sitter/tree-sitter-regex")
    ;(ruby "https://github.com/tree-sitter/tree-sitter-ruby")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    ;(scala "https://github.com/tree-sitter/tree-sitter-scala")
    ;(swift "https://github.com/tree-sitter/tree-sitter-swift")
    (toml "https://github.com/tree-sitter/tree-sitter-toml")
    ;(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
    ;(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
    (udev "https://github.com/tree-sitter/tree-sitter-udev")
    (verilog "https://github.com/tree-sitter/tree-sitter-verilog")
    (xml "https://github.com/tree-sitter-grammars/tree-sitter-xml")
    (yaml "https://github.com/ikatyang/tree-sitter-yaml")
))

(require 'init-core)
(require 'init-ui)
(require 'init-editing)

;;; Helper modules
(require 'init-packages)
;(require 'init-company)
;(require 'init-flycheck)
;(require 'init-lsp)
(require 'init-navigation)
(require 'init-keybindings)

(provide 'init)
;;; init ends here
