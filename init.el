(require 'package)
(package-initialize)


(load "~/.emacs.d/load-directory")
(load-directory "~/.emacs.d/config")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (flymake-solidity solidity-mode afternoon-theme ## discover-js2-refactor xref-js2 rjsx-mode groovy-mode neotree auto-complete tern-auto-complete helm-ag exec-path-from-shell helm-projectile helm magit better-defaults zenburn-theme js2-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'neotree)
  (global-set-key [f5] 'neotree-toggle)
