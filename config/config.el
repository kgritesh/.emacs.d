;; require cl to solve issues with libs not updated

(require 'cl)

;; Loading zenburn
(load-theme 'zenburn t)

;; Vertical Split by default
(setq split-width-threshold 0)

;; Show line numbers
(global-linum-mode t)

;; Show Column Numbers
(setq column-number-mode t)

;; Set Font Size

(set-frame-font "Menlo 11" nil t)

;;;;;;;;;;;;;;;;;;;;;;Taken From http://whattheemacsd.com/;;;;;;;;;;;;;;;;;;;;;;

;; No splash screen please ... jeez
(setq inhibit-startup-message t)


;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Webjump Config

(global-set-key (kbd "C-x g") 'webjump)

;; Add Urban Dictionary to webjump
(eval-after-load "webjump"
'(add-to-list 'webjump-sites
              '("Urban Dictionary" .
                [simple-query
                 "www.urbandictionary.com"
                 "http://www.urbandictionary.com/define.php?term="
                 ""])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")


(require 'auto-complete)
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))


(global-auto-complete-mode t)

;; white space cleanup
(add-hook 'before-save-hook 'whitespace-cleanup)


(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


(defun my-invalidate-cache ()
  "Invalidate projectile and recentf cache."
  (interactive)
  (progn (projectile-invalidate-cache nil)
         (recentf-cleanup)))


(setq projectile-enable-caching nil)
