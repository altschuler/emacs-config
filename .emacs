;; Enable opening of files in a running Emacs instance
(server-start)

;; Load paths
(add-to-list 'load-path "~/.emacs.d/")
;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-jedi")
(add-to-list 'load-path "~/.emacs.d/plugins/expand-region/")
(add-to-list 'load-path "~/.emacs.d/plugins/auctex/")
(add-to-list 'load-path "~/.emacs.d/plugins/auctex/preview/")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet/")
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/plugins/slime/")
(add-to-list 'load-path "~/.emacs.d/plugins/fsharp/")
(add-to-list 'load-path "~/.emacs.d/plugins/html5/")
;;;(add-to-list 'load-path "~/.emacs.d/plugins/pony/")

;;; Emacs flavor
(delete-selection-mode t)
(show-paren-mode t)
;; do not make backup files
(setq make-backup-files nil)

;;; Setup plugins
;; Simple requires
(require 'linum)
(require 'ace-jump-mode)
(require 'expand-region)
(require 'paredit)
(require 'ctable)
(require 'recentf)

;; HTML5 nxml setup
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files "~/.emacs.d/plugins/html5/schemas.xml"))
(require 'whattf-dt)

;; Zen Coding setup
(require 'zencoding-mode)
(add-hook 'html-mode-hook 'zencoding-mode)

;; Auto-Complete setup
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict")
(ac-config-default)
(add-hook 'find-file-hook (lambda () (auto-complete-mode)))
(global-auto-complete-mode +1)

;; Jedi setup
(require 'jedi)
(setq jedi:setup-keys t)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; SLIME setup
(require 'slime)
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-asdf))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode t)))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))

;; AUCTeX setup
(load "auctex.el" nil t t)
(load "preview/preview-latex.el" nil t t)
(add-hook 'tex-mode (lambda () (tex-pdf-mode 1))) ;PDF output

;; YASnippet setup
(require 'yasnippet)
(setq yas/prompt-functions '(yas/dropdown-prompt))
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/plugins/yasnippet/snippets/")

;; FSharp major mode
(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)

;;; Keybindings
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)
(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-p") 'scroll-down-line)
; plugin specific bindings
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-M-d") 'jedi:goto-definition)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(inhibit-startup-screen t)
 '(preview-gs-command "GSWIN64C.EXE")
 '(preview-gs-options (quote ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(safe-local-variable-values (quote ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'dired-find-alternate-file 'disabled nil)
