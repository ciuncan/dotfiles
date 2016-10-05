; compiled/inspired/stolen from:
; https://github.com/svaiter/emacs.d/blob/master/my-emacs.org
; http://juanjoalvarez.net/es/detail/2014/sep/19/vim-emacsevil-chaotic-migration-guide/
; https://github.com/aaronbieber/dotfiles/blob/master/configs/emacs.d/lisp/init-evil.el
(require 'package)
(add-to-list 'package-archives
             '("melpa"     . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


(when (not package-archive-contents)
  (package-refresh-contents))
(defvar my-packages
  '(projectile
    package-utils
    evil
    evil-leader
    magit
    relative-line-numbers
    powerline
    powerline-evil
    slime
    paredit
    evil-paredit
    cider
    cider-eval-sexp-fu
    clojure-mode
    clojure-mode-extra-font-locking
    ensime
    rainbow-delimiters
    ace-jump-mode
    auto-complete
    helm
    helm-projectile
    ido-ubiquitous
    diminish
    ppd-sr-speedbar
    ac-cider
    ac-slime
    kooten-theme))

(dolist (pack my-packages)
  (unless (package-installed-p pack)
    (package-install pack)))

(setq visible-bell 1)
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(load-theme 'kooten t)

(when (display-graphic-p)
  (set-face-font 'default "Iosevka-12")
  (set-face-font 'variable-pitch "Iosevka-12")
  (set-face-font 'fixed-pitch "Iosevka-12"))

; editing
;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)
;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))
;; Highlights matching parenthesis
(show-paren-mode 1)
;; Highlight current line
(global-hl-line-mode 1)
(setq show-paren-delay 0)
(electric-pair-mode t)
;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)
;; No need for ~ files when editing
(setq create-lockfiles nil)
;; Go straight to scratch buffer on startup
(setq inhibit-startup-screen t)
;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)
;; Show line numbers
(global-linum-mode)
;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

(global-set-key [f1] 'apropos-command)
(global-set-key [S-f1] 'describe-key)
(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-[") 'previous-buffer)

;; useful shortcuts:

;;;; eval
;; eval-lisp                        => M-:
;; shell-command                    => M-!

;;;; windows
;; window-configuration-to-register => C-x r w
;; jump-to-register                 => C-x r j

;;;; cider
;; eval-last-sexp                   => C-x C-e
;; cider-eval-defun-at-point        => C-c C-c
;; compile & run current buffer     => C-c C-k 
;; switch to current buffer's ns    => C-c M-n
;; run tests                        => C-c ,

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'projectile)
(projectile-global-mode)

(require 'helm)
(helm-mode)
(global-set-key [f4]        'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'ido)
(require 'ido-ubiquitous)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-use-virtual-buffers t)
(ido-ubiquitous-mode 1)

(require 'magit)
(global-set-key [f5] 'magit-status)

;;(push "~/.emacs.d/evil" 'load-path)
(require 'evil)
(evil-mode 1)
(setq evil-move-cursor-back nil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "a" 'helm-apropos
  "e" 'eval-last-sexp
  "w" 'save-buffer
  "k" 'kill-buffer
  "q" 'kill-buffer-and-window
  "b" 'switch-to-buffer
  "B" 'helm-buffers-list
  "f" 'find-file
  "x" 'helm-M-x)
(setq evil-emacs-state-cursor    '("red" box))
(setq evil-normal-state-cursor   '("green" box))
(setq evil-visual-state-cursor   '("orange" box))
(setq evil-insert-state-cursor   '("red" bar))
(setq evil-replace-state-cursor  '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(require 'relative-line-numbers)
(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
;; Make escape quit everything, whenever possible.
(define-key evil-normal-state-map           [escape]      'keyboard-quit)
(define-key evil-visual-state-map           [escape]      'keyboard-quit)
(define-key minibuffer-local-map            [escape]      'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map         [escape]      'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape]      'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape]      'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map    [escape]      'minibuffer-keyboard-quit)
(define-key evil-normal-state-map           (kbd "C-S-P") 'helm-projectile-switch-project)
(define-key evil-normal-state-map           (kbd "C-p")   'helm-projectile)
(define-key evil-normal-state-map           (kbd "-")     'helm-find-files)

(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

(require 'ace-jump-mode)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(autoload 'ace-jump-mode          "ace-jump-mode" "Emacs quick move minor mode" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(require 'auto-complete-config)
(ac-config-default)
(global-set-key (kbd "M-\\") 'ac-start)

(require 'diminish)
(diminish 'visual-line-mode)
(eval-after-load 'undo-tree       '(diminish 'undo-tree-mode))
(eval-after-load 'projectile      '(diminish 'projectile-mode))
(eval-after-load 'eldoc           '(diminish 'eldoc-mode))
(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))

; Lisp
(setq inferior-lisp-program (executable-find "sbcl"))
(setq slime-contribs '(slime-fancy))
; paredit autoload.
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
(add-hook 'ielm-mode-hook 'eldoc-mode)
(slime-setup)
; Scala
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; OPTIONAL
;; there are some great Scala yasnippets, browse through:
;; https://github.com/AndreaCrotti/yasnippet-snippets/tree/master/scala-mode
; (add-hook 'scala-mode-hook #'yas-minor-mode)
;; but company-mode / yasnippet conflict. Disable TAB in company-mode with
; (define-key company-active-map [tab] nil)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))


; Clojure
(require 'ac-cider)
; (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;; (evil-make-override-map cider-mode-map 'normal)
(require 'clojure-mode)
(require 'cider-mode)
(require 'clojure-mode-extra-font-locking)
; (add-hook 'clojure-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'subword-mode)
;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.clj.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojurescript-mode))
(eval-after-load "cider-mode"
  '(progn
     (define-key evil-normal-state-map (kbd "M-.")     'cider-find-var)
     (define-key evil-normal-state-map (kbd "M-,")     'cider-pop-back)
     (define-key clojure-mode-map      (kbd "C-M-r")   'cider-refresh)
     (define-key clojure-mode-map      (kbd "C-c u")   'cider-user-ns)
     (define-key cider-mode-map        (kbd "C-c u")   'cider-user-ns)
     (global-set-key                   (kbd "C-c C-f") 'cider-figwheel-repl)))

(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))
(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

; ClojureScript
(defun cider-figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    ;; (insert "(require 'figwheel-sidecar.repl-api)
    ;;          (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
    ;;          (figwheel-sidecar.repl-api/cljs-repl)")
    (insert "(load-file \"script/figwheel.clj\")")
    ;;(cider-repl-return)
    ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a25c42c5e2a6a7a3b0331cad124c83406a71bc7e099b60c31dc28a1ff84e8c04" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
