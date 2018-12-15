;;; javascript - Javascript Mode:

;;; Code
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; use eslint with js2-mode for node files
(flycheck-add-mode 'javascript-eslint 'js2-mode)



;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)


;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-hook 'web-mode-hook
      (lambda ()
        ;; short circuit js mode and just do everything in jsx-mode
        (if (equal web-mode-content-type "javascript")
            (web-mode-set-content-type "jsx")
          (message "now set to: %s" web-mode-content-type))))

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))


(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(setq tern-command (cons (executable-find "tern") '()))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)


(defun quit-bottom-side-windows ()
  "Quit side windows of the current frame."
  (interactive)
  (dolist (window (window-at-side-list))
    (quit-window nil window)))

(global-set-key (kbd "C-c g") #'quit-bottom-side-windows)


(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)
