;; Racket setup

(use-package racket-mode
  :ensure t
  :init
  (setq racket-program "/usr/local/bin/racket")
  ;:hook
  ;(racket-mode . (lambda ())
  ;"r R" 'racket-run
  ;"r r" 'racket-run-and-switch-to-repl
  ;"r p" 'racket-repl
  ;"r e" 'racket-repl-switch-to-edit
  ;"r d" 'racket-doc
  :general
  (:keymaps 'racket-mode-map
   "<F5>" '(lambda () (progn
              (end-of-buffer-other-window)
              (racket-run-and-switch-to-repl)
              (evil-insert-state)))
  ;(:keymaps 'racket-repl-mode-map
  ;"<F6>" 'racket-repl-switch-to-edit)
  )
  :hook (racket-mode . smartparens-strict-mode))


(provide 'init-racket)
