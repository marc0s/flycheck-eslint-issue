;;; init.el --- My Emacs init file
;;; Commentary:
;;; 

;;; Code:
;; Set up the package system
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Set custom file
(setq custom-file "~/.emacs.d/custom.el")

(use-package flycheck
	     :ensure t)

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :preface
  (defun marc0s/fix-js2-indent ()
    "Set `tab-width' when loading js2-mode."
    (setq tab-width 4)
    (setq fill-column 100))
  (defun marc0s/js2-flycheck ()
    "Configure flycheck with eslint."
    (add-to-list 'exec-path "/home/marcos/.nvm/v4.6.1/bin")
    (flycheck-mode t)
    (when (executable-find "eslint")
      (flycheck-select-checker 'javascript-eslint)))
  :init
  (setq-local compile-command "gulp")
  :config
  (setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
  ;; Let flycheck handle parse errors
  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-highlight-external-variables nil)
  (setq-default js2-strict-trailing-comma-warning nil)
  (setq-default js2-strict-inconsistent-return-warning nil)
  (setq-default js-switch-indent-offset 4)
  (setq-default js2-global-externs '("module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
  (add-hook 'js2-mode-hook #'marc0s/fix-js2-indent)
  (add-hook 'js2-mode-hook #'marc0s/js2-flycheck))


;;; init.el ends here
