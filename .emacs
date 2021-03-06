
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds
   (quote
    ("http://feeds.howtogeek.com/howtogeek"
     ("http://feeds.feedburner.com/linuxtoday/linux" linux-today)
     ("http://feeds.cyberciti.biz/Nixcraft-LinuxFreebsdSolarisTipsTricks" nixCraft)
	 ("http://sachachua.com/blog/category/emacs-news/feed" emacs-news))))
 
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-archives
   (quote
    (("marmalade" . "http://marmalade-repo.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(scroll-conservatively 10000)
 '(shell-completion-execonly t)
 '(transient-mark-mode (quote (only . t))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; start emacs single window
(setq inhibit-startup-message t)

;; hide toolbar, menu bar, scroll bar
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;;displaying current time.
(display-time-mode 1)

;; copy to clipboard
(setq x-select-enable-clipboard t)

;;delecting the selection
(delete-selection-mode 1)

;;line number mode
;;(global-linum-mode 1)
(column-number-mode 80)

;; c indentation
(setq-default c-basic-offset 4)

;; spell-check in text file
;; (defun fly-spell-check ()
;;   (when (and (stringp buffer-file-name)
;; 	     (string-match "\\.txt\\'" buffer-file-name))
;;     (flyspell-mode)))

;; (add-hook 'find-file-hook 'fly-spell-check)

;; eshell clear buffer
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
      '(lambda()
	  (local-set-key (kbd "C-l") 'eshell-clear-buffer)))


(setq case-fold-search nil)
(show-paren-mode 1)

;; mu4e
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'setup-mu4e)

;;initial emacs with startup message
(require 'scratch-message)
(setq scratch-message-mode t)

;; window switching
(require 'window-number)
(window-number-mode 1)

;; java-mode annotation
(add-hook 'java-mode-hook
	  (lambda ()
	    "Treat Java 1.5 @-style annotations as comments."
	    (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
	    (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

;; column marker
(require 'fill-column-indicator)
(setq fci-rule-color "brown")
(setq-default fci-rule-column 80)
;;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 1)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer) 

;; full-screen-mode
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
      (if (equal 'fullboth current-value)
        (if (boundp 'old-fullscreen) old-fullscreen nil)
        (progn (setq old-fullscreen current-value)
          'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)

;; multi-eshell
(require 'multi-eshell)

;; multi-eshell clear buffer
(defun my-shell-hook ()
  (local-set-key (kbd "C-l") 'erase-buffer))

(add-hook 'shell-mode-hook 'my-shell-hook)
(put 'erase-buffer 'disabled nil)

;; eshell complition
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; open pop-up buffer in horizontal
(setq split-width-threshold nil)

;; ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/lisp/ace-jump-mode.el")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; Emacs24 theme
;;(add-to-list 'load-path "~/.emacs.d/themes/dracula-theme.el")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'dracula t)
;;(load-theme 'flatland t)

;; (add-to-list 'load-path "~/.emacs.d/elpa/spacemacs-theme-20160806.515/")
;; (require 'spacemacs-common)
;; (load-theme 'spacemacs-dark t)

(load-theme 'challenger-deep t)

;; load eww-lnum
(load "~/.emacs.d/lisp/eww-lnum")
(eval-after-load "eww"
  '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)
          (define-key eww-mode-map "F" 'eww-lnum-universal)))

;; ace-window-jump
(global-set-key (kbd "M-q") 'ace-window)

;; switch to mini-buffer
(defun switch-to-minibuffer ()
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

(global-set-key "\C-co" 'switch-to-minibuffer)

;; buffer stack
(global-set-key (kbd "C-,") 'buffer-stack-up)
(global-set-key (kbd "C-.") 'buffer-stack-down)
(put 'downcase-region 'disabled nil)

;; elfeed
(global-set-key (kbd "C-x w") 'elfeed)

;; eshell path
(defun eshell-mode-hook-func ()
(setq eshell-path-env (concat "/home/user/.local/bin:" eshell-path-env))
(setenv "PATH" (concat "/home/user/.local/bin:" (getenv "PATH")))
(define-key eshell-mode-map (kbd "M-s") 'other-window-or-split))

(add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

;; hide password prompt in shell
(add-hook 'comint-output-filter-functions
'comint-watch-for-password-prompt)

;; set fontpp
(set-default-font "-apple-Monaco-normal-normal-normal-*-*-140-*-*-*-0-iso10646-1")

;; underline cursor(box, hollow, nil, bar, (bar . width), hbar, (hbar . height))
(setq-default cursor-type 'hbar)

;; emacs browser
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "/home/user/.local/usr/bin/conkeror")

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; scroll key
(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   4)))
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 4)))

;; single line only
(defun single-lines-only ()
  "replace multiple blank lines with a single one"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\\(^\\s-*$\\)\n" nil t)
    (replace-match "\n")
    (forward-char 1)))

;; entering the debugger on Error
;;(setq debug-on-error t)

;; Start Emacs server
(server-start)

;; interactive compilation
(defun compile-interactive()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'compile))
(global-set-key (kbd "<f9>") 'compile-interactive)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    
(setq uniquify-ignore-buffers-re "^\\*") 

;; c indentation
(setq-default c-basic-offset 4
			  indent-tabs-mode nil)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20160723.510")
(require 'yasnippet)
(yas-global-mode 1)
(global-set-key (kbd "s-w") #'aya-create)
(global-set-key (kbd "s-y") #'aya-expand)

;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(add-hook 'c++-mode-hook 'google-set-c-style)

;; hide password prompt for git using regexp
(setq comint-password-prompt-regexp
      (concat comint-password-prompt-regexp
              "\\|Password for .*:\\s *\\'"))
;; powerline
(require 'powerline)
(powerline-default-theme)

(global-set-key (kbd "C-c C-r") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

(setq-default fill-column 80)
