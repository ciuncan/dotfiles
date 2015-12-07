; advices from:
; https://github.com/svaiter/emacs.d/blob/master/my-emacs.org
(require 'package)
(add-to-list 'package-archives
             '("melpa"     . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (pack '(projectile
		evil
		slime
		paredit
		evil-paredit
		cider
		cider-eval-sexp-fu
		ace-jump-mode
		auto-complete
		ppd-sr-speedbar
		ac-cider
		ac-slime
		white-sand-theme))
  (unless (package-installed-p pack)
    (package-install pack)))

(when (display-graphic-p)
  (set-face-font 'default "Iosevka-12")
  (set-face-font 'variable-pitch "Iosevka-12")
  (set-face-font 'fixed-pitch "Iosevka-12"))

(setq visible-bell 1)

(load-theme 'white-sand t)

; editing
(show-paren-mode 1)
(setq show-paren-delay 0)
(electric-pair-mode t)

(global-set-key [f1] 'apropos-command)
(global-set-key [S-f1] 'describe-key)

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

(require 'projectile)
(projectile-global-mode)

(require 'helm)
(helm-mode)
(global-set-key [f4] 'helm-mini)

(require 'ido)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)

(require 'magit)
(global-set-key [f5] 'magit-status)

;;(push "~/.emacs.d/evil" 'load-path)
(require 'evil)
(evil-mode 1)

(require 'ace-jump-mode)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(autoload 'ace-jump-mode          "ace-jump-mode" "Emacs quick move minor mode" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(require 'auto-complete-config)
(ac-config-default)

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
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;; (evil-make-override-map cider-mode-map 'normal)
(require 'clojure-mode)
(require 'cider-mode)
(add-hook 'clojure-mode-hook 'cider-turn-on-eldoc-mode)
(eval-after-load "cider-mode"
  '(progn
    (define-key evil-normal-state-map (kbd "M-.") 'cider-find-var)
    (define-key evil-normal-state-map (kbd "M-,") 'cider-pop-back)))

; ClojureScript
(defun cider-figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             (figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))
(global-set-key (kbd "C-c C-f") 'cider-figwheel-repl)

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
