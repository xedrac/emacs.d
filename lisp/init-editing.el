
(use-package smartparens-mode
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))

;; Fix } indent level for typing something like "while (true) {<RET>}"
(define-key global-map (kbd "RET") 'sp-newline)

;; Remember line when you revisit a file
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))
(setq delete-active-region t)

;; Save last session
(desktop-save-mode 1)

;; No text wrapping
(set-default 'truncate-lines t)

;; Disable autosaves
; (setq auto-save-default nil)

;; Set c/cpp style
(defun my-c-style-hook ()
 (c-set-offset 'substatement-open 0)
 (setq c-default-style "linux"
       c++-tab-always-indent t
       c-basic-offset 4                  ;; Default is 2
       c-indent-level 4                  ;; Default is 2
       '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)
       tab-width 4
       indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'my-c-style-hook)

(provide 'init-editing)
