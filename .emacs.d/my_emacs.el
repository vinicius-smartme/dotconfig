;; Auto setup for Python editing mode
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/.*\.py\'" . python-mode)) auto-mode-alist))

;; Auto setup for Lua editing mode
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; Auto setup for Haskell editing mode
(setq auto-mode-alist (cons '("\.hs$" . haskell-mode) auto-mode-alist))
(autoload 'haskell-mode "haskell-mode" "Haskell editing mode." t)
(setq auto-mode-alist (cons '("\.lhs$" . haskell-mode) auto-mode-alist))
(autoload 'haskell-mode "haskell-mode" "Haskell editing mode." t)
