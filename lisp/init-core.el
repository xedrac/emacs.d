;;; Setup package.el
;(require 'package)
;(setq package-quickstart t)

;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;(when (version< emacs-version "27.0")
;  (package-initialize))

;;;  Uncomment this the first time you run emacs on a new machine
;(unless package-archive-contents
;  (package-refresh-contents))
;
;;;; Install some fundamental packages
;(defvar my-packages '(esup))
;(defun install-missing-packages ()
;  (let ((missing (seq-remove (lambda (p) (package-installed-p p)) my-packages)))
;    (when missing
;      (package-refresh-contents)
;      (dolist (p missing)
;        (package-install p)))))
;
;(install-missing-packages)

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

;; use-package is built-in emacs 29
;(eval-when-compile
;  (require 'use-package))
;;(setq use-package-always-ensure t)

;;; Benchmarking tool for testing purposes
;(require 'esup)
;; Workaround an issue with esup and byte-compiled cl-lib
;; but this also seems to make it less useful
;(setq esup-depth 0)

;;; Define SMB customization group
(defgroup smb nil "SMB Customization")

;;; Useful Defaults
(setq inhibit-startup-screen t)           ; Disable startup screen
(setq initial-scratch-message "")         ; Make *scratch* buffer blank
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(setq ring-bell-function 'ignore)         ; Disable bell sound
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(show-paren-mode 1)                       ; Show closing parens by default
(setq linum-format "%4d ")                ; Prettify line number format
(global-auto-revert-mode t)               ; Auto update buffers whose files are changed outside emacs
(add-hook 'prog-mode-hook                 ; Show line numbers in programming modes
        (if (fboundp 'display-line-numbers-mode)
            #'display-line-numbers-mode
            #'linum-mode))


;;; Offload the custom-set-variables to a separate file
;;; This keeps your init.el neater and you have the option
;;; to gitignore your custom.el if you see fit.
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
;;; Load custom file. Don't hide errors. Hide success message
(load custom-file nil t)

;;; Avoid littering the user's filesystem with backups
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '((".*" . "~/.emacs.d/saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;;; Lockfiles unfortunately cause more pain than benefit
;(setq create-lockfiles nil)

(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

;;(use-package paradox      ; Nice list-packages interface
;;  :ensure t
;;  :init
;;  (paradox-enable))

(provide 'init-core)
