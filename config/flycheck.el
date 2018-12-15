;;; Flycheck Config

(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)


;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;;; Display flycheck errors in bottom window

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
               (display-buffer-reuse-window
                display-buffer-in-side-window)
               (reusable-frames . visible)
               (side            . bottom)
               (window-height   . 0.4)))


(defun quit-bottom-side-windows ()
  "Quit side windows of the current frame."
  (interactive)
  (dolist (window (window-at-side-list))
    (quit-window nil window)))

(global-set-key (kbd "C-c g") #'quit-bottom-side-windows)
