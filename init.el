(require 'package)

;; Melpa packages
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Defaults
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";;Stay happy")

(setq c-basic-offset 4) ; indents 4 chars
(setq tab-width 4)          ; and 4 char wide for TAB
(setq-default indent-tabs-mode nil)

(setq backup-directory-alist
       `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
  (defun save-all ()
    (interactive)
    (save-some-buffers t))
  (add-hook 'focus-out-hook 'save-all)

;; Aytisave
(setq auto-save-default nil)

;;Magic that was added by Melpa install
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(org-agenda-files
   (quote
    ("~/notes/home/tasks.org" "~/notes/work/ideas.org" "~/notes/work/planning.org" "~/notes/guidelines.org")))
 '(package-selected-packages
   (quote
    (which-key multiple-cursors nlinum clojure-snippets common-lisp-snippets react-snippets powerline org-beautify-theme cider-eval-sexp-fu timesheet clocker helm-flyspell org-alert org-bullets org-pomodoro js-auto-beautify js2-refactor darkokai-theme company-math cljr-helm undo-tree mic-paren neotree rjsx-mode flycheck-pos-tip flycheck-tip paredit-everywhere flycheck-css-colorguard flycheck-demjsonlint tern-auto-complete rainbow-delimiters paredit helm-cider helm-cider-history helm-projectile helm solarized-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Theme
(load-theme 'darkokai t)

;; Helm mode
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action

(helm-mode 1)

;; autocomplete
(global-auto-complete-mode t)
(global-company-mode)

(add-hook 'flyspell #'org-mode)

;; cider
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

;;Paredit
(require 'paredit)
(require 'paredit-everywhere)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)

;;Rainbow
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;Javascript
;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
	  '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'js2-minor-mode)
(global-set-key (kbd "RET") 'newline-and-indent)
(electric-indent-mode +1)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "js")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))
 
;; Projectile
(require 'helm-projectile)
(helm-projectile-on)
(global-set-key (kbd "C-x p") 'helm-projectile)


(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook 'tern-mode)
(add-hook 'js-mode-hook 'tern-mode)

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;; Highlight parenthesis
(show-paren-mode 1)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; org mode
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(require 'org-install)
(require 'org-capture)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f6>") 'org-capture)
(setq org-todo-keywords
      '((sequence "NEXT(n)" "PROJECT(p@)" "TODO(t)" "WAIT(w@/!)" "PEER_REVIEW(r!)" "QA(q)" "|" "DONE(d!)" "CANCELED(c@)")))

;; powerline stuff
(powerline-center-theme)
(setq powerline-default-separator 'wave)
;;yasnippet
(yas-global-mode 1)
;; line number
(global-linum-mode)
;;undo tree default
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-visualize)

;; multi cursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-unset-key (kbd "C-<down-mouse-1>"))
(global-set-key (kbd "C-<mouse-1>") 'mc/add-cursor-on-click)

;; Key suggestion
(which-key-mode)

;;magit
(global-set-key (kbd "C-x g") 'magit-status)


