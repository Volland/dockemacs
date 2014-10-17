;; =========================== Interface  ==================================

(add-to-list 'load-path "~/.emacs.d")

;; ;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
;; (set-frame-parameter (selected-frame) 'alpha '(90 50))
;; (add-to-list 'default-frame-alist '(alpha 90 50))

(setq file-name-coding-system 'utf-8)
(fset 'yes-or-no-p 'y-or-n-p)
(setq display-time-interval 1)
(setq display-time-format "%H:%M")
(display-time-mode)
(setq-default tab-width 2)
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode t)
 '(ergoemacs-ctl-c-or-ctl-x-delay 0.2)
 '(ergoemacs-handle-ctl-c-or-ctl-x (quote both))
 '(ergoemacs-keyboard-layout "us")
 '(ergoemacs-smart-paste nil)
 '(ergoemacs-use-menus t)
 '(global-whitespace-mode t)
 '(initial-buffer-choice t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(initial-scratch-message nil)
 '(org-CUA-compatible nil)
 '(org-replace-disputed-keys nil)
 '(shift-select-mode nil)
 '(smex-prompt-string nil)
 '(whitespace-style (quote (face lines-tail))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-empty ((t (:background "VioletRed1" :foreground "DeepPink4")))))

(setq make-backup-files nil) ; Don't want any backup files
(setq auto-save-list-file-name nil) ; Don't want any .saves files
(setq auto-save-default nil) ; Don't want any auto saving

(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

(setq show-paren-style 'expression)
(show-paren-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(if window-system
    (load-theme 'spolsky t)
  (load-theme 'wombat t))

;; =========================== Remote ==================================

(require 'tramp)
(setq-default tramp-persistency-file-name nil)
(setq-default tramp-default-method "ssh2")
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))
(setq password-cache-expiry nil)
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)

;; =========================== Browser ==================================

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox-nightly")
(global-set-key (kbd "C-x q") 'ergoemacs-lookup-google) 

;; =========================== Org mode ==================================

(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp" t)
(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "DodgerBlue2" :weight bold))))
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))

;; =========================== GPG ==================================

(require 'epa-file)
(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; =========================== Features ==================================.

(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-auto-show-menu 0.5)
(setq ac-menu-height 20)
(global-auto-complete-mode 1)

(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)

(require 'ido-hacks)
(ido-mode t)
(setq ido-enable-flex-matching t)

(add-to-list 'load-path "~/.emacs.d/multiple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C-x C-m") 'mc/edit-lines)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-,") 'mc/mark-all-like-this)

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;; =========================== Sudo  ======================================

;;(defun sudo-edit-current-file ()
;; (interactive)
;; (let ((my-file-name) ; fill this with the file to open
;;       (position))    ; if the file is already open save position
;;   (if (equal major-mode 'dired-mode) ; test if we are in dired-mode 
;;       (progn
;;         (setq my-file-name (dired-get-file-for-visit))
;;         (find-alternate-file (prepare-tramp-sudo-string my-file-name)))
;;     (setq my-file-name (buffer-file-name); hopefully anything else is an already opened file
;;           position (point));
;;     (find-alternate-file (prepare-tramp-sudo-string my-file-name))
;;     (goto-char position))))


;;(defun prepare-tramp-sudo-string (tempfile)
;; (if (file-remote-p tempfile)
;;     (let ((vec (tramp-dissect-file-name tempfile)))

;;       (tramp-make-tramp-file-name
;;        "sudo"
;;        (tramp-file-name-user nil)
;;        (tramp-file-name-host vec)
;;        (tramp-file-name-localname vec)
;;        (format "ssh:%s@%s|"
;;                (tramp-file-name-user vec)
;;                (tramp-file-name-host vec))))
;;   (concat "/sudo:root@localhost:" tempfile)))

;;(define-key dired-mode-map [s-return] 'sudo-edit-current-file)

;; =========================== Commands  ==================================

(require 'smex)

;; =========================== Keybinding  ==================================

(add-to-list 'load-path "~/.emacs.d/ergoemacs-mode")
(require 'ergoemacs-mode)

(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)

(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key (if mod input-decode-map local-function-key-map)
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method 
      (activate-input-method current))))

(defadvice read-passwd (around my-read-passwd act)
  (let ((local-function-key-map nil))
    ad-do-it))

(reverse-input-method 'russian-computer)

;; =========================== Bookmark  ==================================

(global-set-key (kbd "`")         'bookmark-jump)
(global-set-key (kbd "C-x v")         'bookmark-set)
(global-set-key (kbd "s-SPC")         'bookmark-save)

;; =========================== Snippets  ==================================

(add-to-list 'load-path
              "~/.emacs.d/yasnippet")

(require 'yasnippet)
(yas-global-mode 1)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        "~/.emacs.d/some/collection/"           ;; foo-mode and bar-mode snippet collection
        "~/.emacs.d/yasnippet/yasmate/snippets" ;; the yasmate collection
        "~/.emacs.d/yasnippet/snippets"))

;; =========================== Packages  ==================================

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

 (add-to-list 'load-path "~/.emacs.d/el-get")

 (unless (require 'el-get nil 'noerror)
   (with-current-buffer
       (url-retrieve-synchronously
        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
     (goto-char (point-max))
     (eval-print-last-sexp)))

 (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/recipes")
 (el-get 'sync)

;; =========================== Ruby  ==================================

(require 'rvm)
(rvm-use-default)

(require 'flymake)

;; I don't like the default colors :)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
 (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
   (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
         '(lambda ()

	     ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
		 (flymake-mode))
	     ))

(require 'flyspell)
(setq flyspell-issue-message-flg nil)
(add-hook 'ruby-mode-hook
          (lambda () (flyspell-prog-mode)))

(setq-default ispell-program-name "aspell")
(setq ispell-local-dictionary "russian")

(require 'ruby-mode)
(require 'ruby-hash-syntax)
(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
;; for work with rvm
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
   (rvm-activate-corresponding-ruby))

 (add-hook 'robe-mode-hook 'ac-robe-setup)
 (add-hook 'robe-mode-hook
           (lambda ()
             (add-to-list 'ac-sources 'ac-source-robe)
             (set-auto-complete-as-completion-at-point-function)))

(setq rsense-home "$RSENSE_HOME")
(add-to-list 'load-path (concat rsense-home "/opt/rsense-0.3"))
(require 'rsense)

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'rsense-complete)))

;; =========================== JS  ==================================

(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)

;; =========================== Rinary  ==================================

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)

(add-to-list 'load-path "~/.emacs.d/rinari")
(require 'rinari)
(global-rinari-mode)

(setf
 my-rinari-jump-schema
 '((my-stylesheet "y" ((t . "app/assets/stylesheets/.*")) nil)
   (my-javascript "j" ((t . "app/assets/javascripts/.*")) nil)
   (my-spine-application "a" ((t . "app/assets/javascripts/app/.*\\.js\\.coffee")) nil)
   (my-spine-lib "l" ((t . "app/assets/javascripts/app/lib/.*")) nil)
   (my-spine-model "m" ((t . "app/assets/javascripts/app/models/.*")) nil)
   (my-spine-view "v" ((t . "app/assets/javascripts/app/views/.*")) nil)
   (my-soine-index "r" ((t . "app/assets/javascripts/app/.*")) nil)

(my-fabrication "f" ((t . "spec/fabricators/.*")) nil)
   (my-rspec
    "t"
    (("app/models/\\1.rb"                      . "spec/models/\\1_spec.rb")
     ("app/controllers/\\1.rb"                 . "spec/controllers/\\1_spec.rb")
     ("app/views/\\1\\..*"                     . "spec/views/\\1_spec.rb")
     ("lib/\\1.rb"                             . "spec/libs/\\1_spec.rb")
     ("db/migrate/.*_create_\\1.rb"            . "spec/models/\\1_spec.rb")
     ("config/routes.rb"                       . "spec/routing/.*\\.rb")
     (t                                        . "spec/.*\\.rb"))
    t)

(my-decorator
    "d"
    (("app/models/\\1.rb"                      . "app/decorators/\\1_decorator.rb")
     ("app/controllers/\\1.rb"                 . "app/decorators/\\1_decorator.rb")
     ("app/views/\\1\\..*"                     . "app/decorators/\\1_decorator.rb")
     ("db/migrate/.*_create_\\1.rb"            . "app/decorators/\\1_decorator.rb")
     (t                                        . "app/decorators/.*\\.rb"))
    t)

   (my-request-rspec "r" ((t . "spec/requests/.*")) nil)
))

(rinari-apply-jump-schema my-rinari-jump-schema)

(define-key rinari-minor-mode-map (kbd "C-c m") 'rinari-find-model)
(define-key rinari-minor-mode-map (kbd "C-c M") 'rinari-find-mailer)
(define-key rinari-minor-mode-map (kbd "C-c c") 'rinari-find-controller)
(define-key rinari-minor-mode-map (kbd "C-c o") 'rinari-find-configuration)
(define-key rinari-minor-mode-map (kbd "C-c a") 'rinari-find-application)
(define-key rinari-minor-mode-map (kbd "C-c e") 'rinari-find-environment)
(define-key rinari-minor-mode-map (kbd "C-c h") 'rinari-find-helper)
(define-key rinari-minor-mode-map (kbd "C-c v") 'rinari-find-view)
(define-key rinari-minor-mode-map (kbd "C-c i") 'rinari-find-migration)
(define-key rinari-minor-mode-map (kbd "C-c l") 'rinari-find-lib)
(define-key rinari-minor-mode-map (kbd "C-c r") 'rinari-find-my-request-rspec)
(define-key rinari-minor-mode-map (kbd "C-c t") 'rinari-find-my-rspec)
(define-key rinari-minor-mode-map (kbd "C-c f") 'rinari-find-my-fabrication)
(define-key rinari-minor-mode-map (kbd "C-c y") 'rinari-find-my-stylesheet)
(define-key rinari-minor-mode-map (kbd "C-c d") 'rinari-find-my-decorator)
(define-key rinari-minor-mode-map (kbd "C-c j") 'rinari-find-my-javascript)
(define-key rinari-minor-mode-map (kbd "C-c C-c a") 'rinari-find-my-spine-application)
(define-key rinari-minor-mode-map (kbd "C-c C-c m") 'rinari-find-my-spine-model)
(define-key rinari-minor-mode-map (kbd "C-c C-c r") 'rinari-find-my-spine-index)
(define-key rinari-minor-mode-map (kbd "C-c C-c v") 'rinari-find-my-spine-view)
(define-key rinari-minor-mode-map (kbd "C-c C-c l") 'rinari-find-my-spine-lib)
(define-key rinari-minor-mode-map (kbd "C-l x") 'rinari-extract-partial)
(define-key rinari-minor-mode-map (kbd "C-l c") 'rinari-console)
(define-key rinari-minor-mode-map (kbd "C-l s") 'rinari-web-server)
(define-key rinari-minor-mode-map (kbd "C-l r") 'rinari-web-server-restart)
(define-key rinari-minor-mode-map (kbd "C-l p") 'rinari-cap)

(defun my-find-gemfile ()
  (interactive)
  (find-file (concat (rinari-root) "Gemfile")))
(define-key rinari-minor-mode-map (kbd "C-c g") 'my-find-gemfile)

;; =========================== Templates...  ==================================

(require 'css-mode)
(require 'sass-mode)
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(require 'slim-mode)

(require 'coffee-mode)
(add-to-list 'auto-mode-alist
            '("\\.coffee$" . rinari-minor-mode)
            '("\\.coffee$" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'coffee-custom)

(eval-after-load "coffee-mode"
 '(progn
    (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
    (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(add-to-list 'load-path "~/.emacs.d/rhtml")
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.jst\\.eco$" . rhtml-mode))

;; ====================== To be continued... ==========================
