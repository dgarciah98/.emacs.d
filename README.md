# .emacs.d

Welcome to my Emacs config repo!

I managed to build my config file into an ``org`` file using ``org-babel`` that you can check in a nifty page with comments!
However, Emacs still needs an ``.el`` file to load, then read all the code blocks from the ``org`` file and tangle them into
another ``elisp`` file that Emacs can evaluate.

Therefore, I have to set up Emacs before reading my main configuration file.

## Pre-Setup

```emacs
;;; init.el --- Pre-Setup
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
```

First I add the main package repositories and make sure that ``use-package`` is installed, for proper package managing.

```emacs
(use-package org
  :ensure t)
```

Followed by making sure that ``org`` is installed, otherwise I can't load my config file.

```emacs
;; Main Configuration

;;(load-file "~/.emacs.d/init.el")
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))

;; Custom Variables

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; init.el ends here
```

And lastly I load the ``org`` file along with an ``elisp`` file that contains all the variables modified by Emacs.

And now, after setting up Emacs, feel free to check my simple, junky Emacs config file.

# [Check my Config File!](https://github.com/ElMiamiMan/.emacs.d/emacs.org)
