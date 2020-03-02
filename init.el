;;; init.el --- Pre Setup
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

(use-package org
  :ensure t)

;; Main Configuration

;;(load-file "~/.emacs.d/init.el")
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))

;; Custom Variables

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; init.el ends here
