;; lisp setup
;;
;; MANUAL INSTALLATION STEP REQUIRED:
;;
;; Install SBCL
;;    $> sudo dnf install sbcl
;;
;; Download quicklisp
;;    $> mkdir -p ~/quicklisp && cd ~/quicklisp
;;    $> curl -O https://beta.quicklisp.org/quicklisp.lisp
;;    $> sbcl --load ~/quicklisp/quicklisp.lisp
;;
;;    inside of repl:
;;        (quicklisp-quickstart:install)
;;        (ql:add-to-init-file)
;;        (ql:quickload "quicklisp-slime-helper")


;;(use-package paredit
;;  :ensure t)
(use-package smartparens
  :ensure t
  :hook ((lisp-mode . smartparens-strict-mode)
         (lisp-interaction-mode . smartparens-strict-mode)
         (emacs-lisp-mode . smartparens-strict-mode)
         (scheme-mode . smartparens-strict-mode)
         (racket-mode . smartparens-strict-mode)
         (sly-repl-mode . smartparens-strict-mode)))

(use-package sly-asdf
  :ensure t
  :after sly)

(use-package sly-quicklisp
  :ensure t
  :after sly)

(use-package sly-macrostep
  :ensure t
  :after sly)

(use-package sly
  :ensure t
  ;:after paredit
  :after smartparens
  ;; :hook ((lisp-mode . paredit-mode)
  ;;        (lisp-interaction-mode . paredit-mode)
  ;;        (emacs-lisp-mode . paredit-mode)
  ;;        (scheme-mode . paredit-mode)
  ;;        (sly-repl-mode . paredit-mode)
  ;;        (enable-paredit-mode . paredit-mode))
  :init
  (setq sly-command-switch-to-existing-lisp 'always)
  :config
  ;(load (expand-file-name "~/.roswell/helper.el"))  ;; Need to do "ros install sly" first
  ;(setq inferior-lisp-program "ros dynamic-space-size=3gb -Q -- run")  ; use roswell to run lisp (it's like stack for haskell)
  ;(setq inferior-lisp-program (executable-find "clisp"))
  (setq inferior-lisp-program (executable-find "sbcl"))
  ;(autoload 'paredit-mode "paredit" "Minor mode for structurally editing Lisp code.")
  ;(show-paren-mode 1)
  ;(setq sly-lisp-implementations
  ;  `((sbcl ("/usr/bin/sbcl" "--noinform" "--no-linedit") :coding-system utf-8-unix)))
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (global-company-mode 1)
  
  (defun cm/cl-cleanup-sly-maybe ()
    "Kill processes and leftover buffers when killing the last sly buffer."
    (unless (cl-loop for buf in (delq (current-buffer) (buffer-list))
      if (and (buffer-local-value 'sly-mode buf)
              (get-buffer-window buf))
        return t)
      (dolist (conn (sly--purge-connections))
        (sly-quit-lisp-internal conn 'sly-quit-sentinel t))
      (let (kill-buffer-hook kill-buffer-query-functions)
        (mapc #'kill-buffer
          (cl-loop for buf in (delq (current-buffer) (buffer-list))
            if (buffer-local-value 'sly-mode buf)
              collect buf)))))

  (defun cm/cl-init-sly ()
    "Attempt to auto-start sly when opening a lisp buffer."
    (cond ((or (equal (substring (buffer-name (current-buffer)) 0 1) " ")
               (sly-connected-p)))
          ((executable-find inferior-lisp-program)
           (let ((sly-auto-start 'always))
             (sly-auto-start)
             (add-hook 'kill-buffer-hook #'cm/cl-cleanup-sly-maybe nil t)))
          ((message "WARNING: Couldn't find `inferior-lisp-program' (%s)"
                    inferior-lisp-program))))

  (add-hook 'sly-mode-hook #'cm/cl-init-sly)

  (sp-with-modes '(sly-mrepl-mode)
    (sp-local-pair "'" "'" :actions nil)
    (sp-local-pair "`" "`" :actions nil)))

(provide 'init-lisp)
