;;; init.el --- Main Configuration
;;; Commentary:
;;; Code:

(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (featurep 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Variables Globales
;;(global-display-line-numbers-mode)
(global-nlinum-mode)
(fringe-mode '(nil . 0))
(show-paren-mode t)
(size-indication-mode t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(column-number-mode t)
(electric-layout-mode t)
(electric-pair-mode t)
(company-quickhelp-mode)
(add-to-list 'default-frame-alist '(font . "FuraCode Nerd Font Mono 9"))
(set-face-attribute 'default nil :family "FuraCode Nerd Font Mono 9")
(set-frame-font "FuraCode Nerd Font Mono 9")

;; Page Break Lines
(use-package page-break-lines
  :ensure t
  :config
  (setq page-break-lines-char 45
	page-break-lines-max-width 0))

;; Dashboard
(use-package dashboard
  :ensure t
  ;;:diminish (dashboard-mode)
  ;;(add-hook 'after-init-hook 'dashboard-refresh-buffer)
  :init
  (add-hook 'dashboard-mode-hook (lambda () (page-break-lines-mode 1)))
  (add-hook 'dashboard-mode-hook (lambda () (nlinum-mode -1)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
	 dashboard-items '((recents . 3)
			   (bookmarks . 3)
			   (projects . 3)
			   (agenda))
	 dashboard-center-content t
	 dashboard-set-init-info t
	 dashboard-set-footer t
	 dashboard-show-shortcuts t
	 dashboard-page-separator "\n\f\n"
	 show-week-agenda-p t)
  (dashboard-setup-startup-hook)
  :config)
  ;;(add-to-list 'dashboard-items '(agenda) t))

;; Calendar
(use-package calfw
  :ensure t
  :config
  (require 'calfw)
  (require 'calfw-org)
  (setq cfw:org-overwrite-default-keybinding t
	calendar-week-start-day 1)
  :bind ("C-c c" . cfw:open-org-calendar))

;; Org-Mode Calendar
(load-file "~/.emacs.d/orggcal.el")

;; Org-Mode
(use-package org
  :ensure t
  :config
  (require 'org-beautify-theme)
  (setq org-support-shift-select t))

;; PlatformIO
(use-package platformio-mode
  :ensure t
  :commands (platformio-conditionally-enable))

;; Ciao
(if (file-exists-p "/home/diego/.ciaoroot/master/ciao_emacs/elisp/ciao-site-file.el")
	(load-file "/home/diego/.ciaoroot/master/ciao_emacs/elisp/ciao-site-file.el"))

;; Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))
(use-package flycheck-rust
  :ensure t
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Projectile
(use-package projectile
  :ensure t
  :bind (("M-p" . projectile-command-map))
  :init  (projectile-mode)
  (setq projectile-enable-caching t
	projectile-indexing-method 'alien
	projectile-sort-order 'recently-active
	projectile-completion-system 'ivy))

;; Rust
(use-package toml-mode
  :ensure t)
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

;; Company
(use-package company
  :diminish
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-auto-complete t
	company-auto-complete-chars '(40 34 60)
	company-idle-delay 0
	company-minimum-prefix-length 3))
(use-package company-lsp
  :ensure t
  :commands company-lsp)
(push 'company-lsp company-backends)

;; LSP
(use-package lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)
	 (sh-mode . lsp)
	 (python-mode . lsp)
	 (c-mode . lsp)
	 (arduino-mode . lsp)
	 (rust-mode . lsp))
  :commands lsp)

;; LSP UI
(use-package lsp-ui
  :ensure t
  :bind (("C-c l i" . lsp-ui-imenu)
	 ("C-c l f" . lsp-ui-doc-focus-frame)
	 ("C-c l u" . lsp-ui-doc-unfocus-frame))
  :init
  (lsp-ui-mode)
  (lsp-ui-doc-mode)
  (setq lsp-ui-doc-delay 1)
  :commands lsp-ui-mode)

;; Which key
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode 1))

;; helm
(use-package helm
  :ensure t
  :init (helm-mode 1)
  :bind (("<menu>" . helm-M-x)
	 ("M-x" . helm-M-x)
	 ("C-x r b" . helm-filtered-bookmarks)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)
	 ("C-x C-b". helm-buffers-list))
  :config
  (helm-autoresize-mode 1))

;; Neotree
(use-package neotree
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :config
  (setq-default neo-show-hidden-files t)
  (setq neo-smart-open t
	projectile-switch-project-action 'neotree-projectile-action)
  
;;   ;; Disable line-numbers minor mode for neotree
  (add-hook 'neo-after-create-hook
	    ;;(lambda (&rest _) (display-line-numbers-mode -1))))
	    (lambda (&rest _) (nlinum-mode -1))))

;; Ranger
(use-package ranger
  :ensure t
  :bind (("<f9>" . ranger)))

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :defer t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 10
	doom-modeline-buffer-file-name-style 'truncate-from-project
	doom-modeline-icon t
	doom-modeline-major-mode-icon t
	doom-modeline-minor-modes nil
	doom-modeline-lsp nil
	doom-modeline-github t
	doom-modeline-github-interval (* 30 60)))

;; Doom Themes
(use-package doom-themes
  :ensure t
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
  (doom-themes-org-config)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
)

;; Kaolin Themes
(use-package kaolin-themes
  :ensure t
  :init (load-theme 'kaolin-dark t))

;; esto es un apaño para doom-modeline con emacsclient
(if (daemonp)
    (add-hook 'after-make-frame-functions
		(setq doom-modeline-icon t)))

;; All The Icons
(use-package all-the-icons
  :ensure t)

;;; init.el ends here
