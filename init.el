;; -*- lexical-binding: t; -*-

;; A big contributor to startup times is garbage collection.  We up the GC
;; threshold to temporarily prevent it from running, and then reset it later
;; using a hook.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Set the file-name-handler to nil (because regexing is cpu intensive)
;; But, keep a ref to it so we can hook it in later
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
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
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;(load (expand-file-name "~/.roswell/helper.el"))


;;; Core modules
(require 'elpaca-bootstrap)
(require 'cl-lib)
(require 'eglot)
(require 'treesit)


;;; Benchmarking tool for testing purposes
;;(use-package esup
;;    :config
;;    ;; Workaround an issue with esup and byte-compiled cl-lib
;;    ;; but this also seems to make it less useful
;;    (setq esup-depth 0)



(require 'init-core)
(require 'init-evil)
(require 'init-packages)
(require 'init-keybindings)

(provide 'init)
;;; init ends here







;;(setq treesit-language-source-alist
;;  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
;;    (c "https://github.com/tree-sitter/tree-sitter-c")
;;    ;(c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
;;    (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.20.5")
;;    (cmake "https://github.com/uyha/tree-sitter-cmake")
;;    (commonlisp "https://github.com/tree-sitter-grammars/tree-sitter-commonlisp")
;;    ;(css "https://github.com/tree-sitter/tree-sitter-css")
;;    (cuda "https://github.com/tree-sitter-grammars/tree-sitter-cuda")
;;    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
;;    (glsl "https://github.com/tree-sitter-grammars/tree-sitter-glsl")
;;    ;(go "https://github.com/tree-sitter/tree-sitter-go")
;;    (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
;;    (hlsl "https://github.com/tree-sitter-grammars/tree-sitter-hlsl")
;;    (html "https://github.com/tree-sitter/tree-sitter-html")
;;    ;(java "https://github.com/tree-sitter/tree-sitter-java")
;;    ;(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
;;    (json "https://github.com/tree-sitter/tree-sitter-json")
;;    ;(julia "https://github.com/tree-sitter/tree-sitter-julia")
;;    (lua "https://github.com/tree-sitter/tree-sitter-lua")
;;    (make "https://github.com/tree-sitter-grammars/tree-sitter-make")
;;    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
;;    ;(ocaml "https://github.com/tree-sitter/tree-sitter-ocaml")
;;    ;(php "https://github.com/tree-sitter/tree-sitter-php")
;;    (python "https://github.com/tree-sitter/tree-sitter-python")
;;    ;(regex "https://github.com/tree-sitter/tree-sitter-regex")
;;    ;(ruby "https://github.com/tree-sitter/tree-sitter-ruby")
;;    (rust "https://github.com/tree-sitter/tree-sitter-rust")
;;    ;(scala "https://github.com/tree-sitter/tree-sitter-scala")
;;    ;(swift "https://github.com/tree-sitter/tree-sitter-swift")
;;    (toml "https://github.com/tree-sitter/tree-sitter-toml")
;;    ;(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
;;    ;(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
;;    (udev "https://github.com/tree-sitter/tree-sitter-udev")
;;    (verilog "https://github.com/tree-sitter/tree-sitter-verilog")
;;    (xml "https://github.com/tree-sitter-grammars/tree-sitter-xml")
;;    (yaml "https://github.com/ikatyang/tree-sitter-yaml")
;;))

;;dolist (source treesit-language-source-alist)
;;  (unless (treesit-ready-p (car source))
;;    (treesit-install-language-grammar (car source))))
;;
;;(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
;;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
;;(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
