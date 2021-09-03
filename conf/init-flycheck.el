(use-package flycheck
  :ensure t
  :hook
  (prog-mode . flycheck-mode)
  (text-mode . flycheck-mode))

(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

(provide 'init-flycheck)
