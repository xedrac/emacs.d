
;(use-package smartparens-mode
;  :ensure smartparens  ;; install the package
;  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
;  :config
;  ;; load default config
;  (require 'smartparens-config)

;; Fix } indent level for typing something like "while (true) {<RET>}"
;(define-key global-map (kbd "RET") 'sp-newline)

;; Better paren management for lisp editing
;(use-package parinfer-rust-mode
;  :ensure t
;  :hook (emacs-lisp-mode scheme-mode racket-mode clojure-mode lisp-mode)
;  :init
;  (setq parinfer-rust-auto-download t)

;; (use-package lispy
;; ;;   :ensure t
;; ;;   :hook ((emacs-lisp-mode scheme-mode racket-mode clojure-mode lisp-mode) . (lambda () (lispy-mode 1)))
;; ;;   :config
;; ;;   (setq lispy-safe-delete t
;; ;;         lispy-safe-copy t
;; ;;         lispy-safe-paste t
;; ;;         lispy-safe-actions-no-pull-delimiters-into-comments t))
;
;; (use-package lispyville
;; ;;   :ensure t
;; ;;   :after lispy
;; ;;   :hook (lispy-mode . lispyville-mode))


;; Remember line when you revisit a file
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))
(setq delete-active-region t)

(setq require-final-newline t)       ; add newline to end of file if necessary
(setq show-trailing-whitespace t)    ; show trailing whitespace

;; Delete trailing whitespace on save in programming modes
(add-hook 'prog-mode-hook
          (lambda () (add-hook 'before-save-hook
                               (lambda () (delete-trailing-whitespace)
                               nil 'local))))

;; Save last session
(desktop-save-mode 1)

;; No text wrapping
(set-default 'truncate-lines t)

;; Disable autosaves
; (setq auto-save-default nil)

;;; Set c/cpp style
;(defun my-c-style-hook ()
; (c-set-offset 'substatement-open 0)
; (setq ;c-default-style "linux"
;       c++-tab-always-indent t
;       c-basic-offset 4                  ;; Default is 2
;       c-indent-level 4                  ;; Default is 2
;       tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)
;       tab-width 4
;       indent-tabs-mode nil))
;
;(add-hook 'c-mode-common-hook 'my-c-style-hook)
(setq c-default-style "k&r")
(setq c-ts-mode-indent-offset 4)

(provide 'init-editing)
