# .emacs.d

Welcome to my Emacs config file!

As of now, my current setup consists of an ``.emacs`` file in my home directory, which mainly just loads the main config file ``init.el`` :


```
;; Main Configuration
(load-file "~/.emacs.d/init.el")

;; Custom Variablea

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
```

...which nowadays may be redundant. Therefore my goal will be making my ``init.el`` into a literate file using ``org-babel``, thus making proper documemtation for my configuration.

So for the time being this will be the main README for this repo. Anyway, feel free to check my simple, junky Emacs config file.
