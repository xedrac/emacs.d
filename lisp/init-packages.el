;;
;; TODO:
;;    Consider adding lispyville, blink-search, and eglot-x packages
;;

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               ;'((c-mode c-ts-mode c++-mode c++-ts-mode) . ("ccls" "--init" "{\"compilationDatabaseDirectory\": \"build\"}"))))
               '((c-mode c-ts-mode c++-mode c++-ts-mode) . ("clangd" "--compile-commands-dir=\"build\""))))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c-ts-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c++-ts-mode-hook 'eglot-ensure)


;; Start eglot/lsp automatically when entering these programming modes
(add-hook 'rust-ts-mode-hook 'eglot-ensure) ; Installs rust-analyzer automatically I think
(add-hook 'c-mode-hook 'eglot-ensure)    ; Requires clangd to be installed already
(add-hook 'c++-ts-mode-hook 'eglot-ensure)  ; Same as ^^^
;(add-hook 'haskell-mode-hook 'eglot-ensure)

;; Convenient keybinding support for evil
(use-package general
  :ensure t)
(elpaca-wait)


;;; Different undo/redo behavior
;(use-package undo-tree
;  :ensure t
;  :init (global-undo-tree-mode))

;; Visualize the undo tree (vundo)
(use-package vundo
  :ensure t)


;; Completion ui
(use-package vertico
  :ensure t
  :bind (:map minibuffer-local-map
          ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  ;(vertico-resize t)
  (setq vertico-count 30)
  (setq vertico-scroll-margin 0)
  :init
  (vertico-mode))


;; Show recent commands/files at the top
(use-package savehist
  :init
  (savehist-mode))


;; Add context to results in the margins (file permissions, dates, help info, etc...)
(use-package marginalia
  :after (vertico)
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))


;; Project level commands (switch project roots, find files, grep, etc...)
(use-package project)


;; Provides ripgrep and file finding
(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.01
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
    consult-theme :preview-key '(:debounce 0.2 any)
    consult-ripgrep consult-git-grep consult-grep
    consult-bookmark consult-recent-file consult-xref
    consult--source-bookmark consult--source-file-register
    consult--source-recent-file consult--source-project-recent-file
    :preview-key '(:debounce 0.0 any)))


;; Allow specifying substrings instead of having to tab complete from the beginning in Vertico
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))


;; Contextual actions for vertico (delete, rename, etc...)
(use-package embark
  :ensure t
  :bind (("C-c" . embark-act)         ;; pick some comfortable binding
         ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))


;; Contextual actions for consult stuff too
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


;; Automatically enable <lang>-ts-mode for appropriate modes
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))



;;; Auto complete (works with eglot to get candidates)
;(use-package company
;  :ensure t
;  :config
;  (setq company-tooltip-align-annotations t)  ; ocd
;  (setq company-minimum-prefix-length 1)      ; reduce needed chars before company kicks in
;  (setq company-idle-delay 0)                 ; no delay for automatic popup
;  (setq company-selection-wrap-around t)
;  (with-eval-after-load 'company
;    (define-key company-active-map (kbd "C-n") 'company-select-next)
;    (define-key company-active-map (kbd "C-p") 'company-select-previous)
;    (define-key company-search-map (kbd "C-n") 'company-select-next)
;    (define-key company-search-map (kbd "C-p") 'company-select-previous)
;    (define-key company-search-map (kbd "C-t") 'company-search-toggle-filtering))
;  :bind (("C-." . company-complete))
;  :hook (prog-mode . company-mode)


(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0)           ;; 0 is not recommended
  (corfu-auto-prefix 1)          ;; 1 is not recommended
  (corfu-separator ?\s)          ;; Orderless field separator
  ;;(corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;;(corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;;(corfu-preview-current nil)    ;; Disable current candidate preview
  ;;(corfu-preselect 'prompt)      ;; Preselect the prompt
  ;;(corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;;(corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))


;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  ;; (setq completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  ;(setq text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (setq read-extended-command-predicate #'command-completion-default-include-p))


;; Indent code somewhat sanely when pasting
(use-package snap-indent
  :ensure t
  :hook (prog-mode . snap-indent-mode)
  :custom ((snap-indent-format '(untabify delete-trailing-whitespace))
           (snap-indent-on-save nil)))

;; Buffers that visit files look slightly different than other buffer types
(use-package solaire-mode
  :ensure t
  :config (solaire-global-mode +1))


;; Scheme REPL integration
(use-package geiser-guile
  :ensure t
  :config (setq geiser-guile-binary "guile3.0"))


(use-package racket-mode
  :ensure t)

(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t)

(use-package protobuf-mode
  :ensure t)

(use-package cmake-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package cargo
  :ensure t)

;;; Remove trailing whitespace on lines you've edited
;(use-package ws-butler
;  :ensure t
;  :config
;  (ws-butler-global-mode t))

;(use-package ethan-wspace
;  :ensure t
;  :config
;  (global-ethan-wspace-mode 1))

;; Format on save for rust files
;(add-hook 'rust-ts-mode-hook
;          (lambda ()
;             (add-hook 'before-save-hook 'cargo-process-fmt nil 'local))) ; local save hook for rust

;(use-package dimmer
;  :ensure t
;  :config (dimmer-mode t))

;(use-package nerd-icons-completion
;  :ensure t
;  :after marginalia
;  :config
;  (nerd-icons-completion-mode))


(provide 'init-packages)
