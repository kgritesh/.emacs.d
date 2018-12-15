;;;; Install required packages if missing

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


;;******************************************************************************
;; Taken from https://github.com/purcell/emacs.d
;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

;;******************************************************************************


(defvar packages
  '(zenburn-theme
    better-defaults
    helm
    idle-highlight-mode
    ido-ubiquitous
    find-file-in-project
    magit
    smex
    scpaste
    js2-mode
    json-mode
    projectile
    helm-projectile
    diminish
    emmet-mode
    evil-matchit
    flycheck
    smartparens
    tern
    tern-auto-complete
    web-beautify
    web-mode
    exec-path-from-shell
    helm-ag
    ac-js2
    js2-refactor
    yasnippet
    neotree
    )
  "A list of packages to ensure are installed at launch."
  )

(defun install-packages ()
  (cl-loop for p in packages
           when (not (package-installed-p p)) do (require-package p)
           finally (return t)))


(install-packages)
