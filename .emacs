;; Enable opening of files in a running Emacs instance
(server-start)

;; Load paths
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/expand-region/")
(add-to-list 'load-path "~/.emacs.d/plugins/auctex/")
(add-to-list 'load-path "~/.emacs.d/plugins/auctex/preview/")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet/")
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/plugins/slime/")

;;; Emacs flavor
(delete-selection-mode t)
(show-paren-mode t)
;; do not make backup files
(setq make-backup-files nil)

;;; Setup plugins
;; Simple plugins
(require 'linum)
(require 'ace-jump-mode)
(require 'expand-region)
(require 'paredit)

;; SLIME setup
(require 'slime)
(setq inferior-lisp-program "clisp")
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

;; Auto-Complete setup
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

;;; Keybindings
; windmove
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)
; expand reqion keybinding
(global-set-key (kbd "C-=") 'er/expand-region)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(preview-gs-command "GSWIN64C.EXE")
 '(preview-gs-options (quote ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'dired-find-alternate-file 'disabled nil)
