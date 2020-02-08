;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;; Fonts
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14))

(load-theme 'doom-city-lights t)

(setq doom-modeline-buffer-file-name-style 'truncate-except-project
      doom-modeline-buffer-encoding 'nil
      doom-modeline-lsp t)

(setq python-shell-interpreter "python3")
;(defvaralias 'flycheck-python-flake8-executable 'python-shell-interpreter)
;(setq flycheck-python-pycompile-executable 'python-shell-interpreter)

(projectile-add-known-project "~/work/augere-tagging")
(projectile-add-known-project "~/work/nuc-software")
