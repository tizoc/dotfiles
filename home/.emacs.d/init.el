(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t)
 '(ansi-color-names-vector ["#ecf0f1" "#e74c3c" "#2ecc71" "#f1c40f" "#2492db" "#9b59b6" "#1abc9c" "#2c3e50"])
 '(baud-rate 38400)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("1011be33e9843afd22d8d26b031fbbb59036b1ce537d0b250347c19e1bd959d0" "e35ef4f72931a774769da2b0c863e11d94e60a9ad97fb9734e8b28c7ee40f49b" "9fa173ced2e7a4d0a8e5aa702701629fa17b52c800391c37ea6678b8e790f7cd" "cd8130f57c8deaa95bfb08bf20dc724fe22a4ca03a346b61088ef9079ae3d0a5" "50edb7914e8d369bc03820d2dcde7e74b7efe2af5a39511d3a130508e2f6ac8f" "1c6693b96aab150f9739f19fc423770e0eb0b4cb8e2a95c8c6c48abcae719521" "bf648fd77561aae6722f3d53965a9eb29b08658ed045207fe32ffed90433eb52" "fc2782b33667eb932e4ffe9dac475f898bf7c656f8ba60e2276704fabb7fa63b" "6cf0e8d082a890e94e4423fc9e222beefdbacee6210602524b7c84d207a5dfb5" default)))
 '(custom-theme-load-path (quote ("~/.emacs.d/themes" custom-theme-directory t)))
 '(exec-path (quote ("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(fci-rule-color "#f1c40f")
 '(flycheck-python-flake8-executable "pyflakes")
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(ido-auto-merge-work-directories-length nil)
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-max-prospects 10)
 '(ido-mode (quote both) nil (ido))
 '(ido-ubiquitous-mode t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-virtual-buffers t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(jedi:server-command (quote ("python3" "/Users/bruno/.emacs.d/elpa/jedi-20140321.1323/jediepcserver.py")))
 '(jedi:setup-keys t)
 '(make-backup-files nil)
 '(menu-bar-mode t)
 '(ns-alternate-modifier (quote none))
 '(ns-command-modifier (quote meta))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(powerline-default-separator (quote butt))
 '(scalable-fonts-allowed t)
 '(scroll-bar-mode nil)
 '(shell-file-name "/bin/bash")
 '(show-paren-style (quote parenthesis))
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(speedbar-use-images nil)
 '(tool-bar-mode nil)
 '(url-cookie-file "/Users/bruno/.emacs.d/url/cookies")
 '(url-history-file "/Users/bruno/.emacs.d/url/history")
 '(vc-annotate-background "#ecf0f1")
 '(vc-annotate-color-map (quote ((30 . "#e74c3c") (60 . "#c0392b") (90 . "#e67e22") (120 . "#d35400") (150 . "#f1c40f") (180 . "#d98c10") (210 . "#2ecc71") (240 . "#27ae60") (270 . "#1abc9c") (300 . "#16a085") (330 . "#2492db") (360 . "#0a74b9"))))
 '(vc-annotate-very-old-color "#0a74b9"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:box (:line-width 1 :color "#2c3e50")))))
 '(mode-line-inactive ((t (:inherit mode-line :box (:line-width 1 :color "#dfe4ea")))))
 '(powerline-active1 ((t (:inherit mode-line :background "#6700B9" :foreground "white"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "gray80")))))

(defvar my-packages
  '(ag
    auto-complete
    cus-edit+
    diff-hl
    flycheck
    flycheck-tip
    go-eldoc
    go-mode
    magit
    ido-ubiquitous
    idris-mode
    jedi
    powerline
    smex
    ;;sr-speedbar
    tuareg
    wgrep
    wgrep-ag
    ))

;;;; Set default frame size/position

(if window-system
    (setq default-frame-alist
          '((top . 40)
            (left . 65)
            (height . 44)
            (width . 110))))

;;;; Settings

(defvar *opam-prefix* (substring
                       (shell-command-to-string
                        "/usr/local/bin/opam config var prefix 2> /dev/null")
                       0 -1))

(setenv "CAML_LD_LIBRARY_PATH" (concat *opam-prefix* "/lib/stublibs:/usr/local/lib/ocaml/stublibs"))
(setenv "OCAML_TOPLEVEL_PATH" (concat *opam-prefix* "/lib/toplevel"))

(require 'package)
(package-initialize)

;; Check if packages in my-packages are installed; if not, install.
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 my-packages)

;; Initializations

(load-theme 'soft-stone)

(windmove-default-keybindings)
(ido-mode t)
(show-paren-mode 1)
;; (powerline-default-theme)
;; (electric-indent-mode 1)

;; OCaml

(add-to-list 'load-path (concat
  *opam-prefix* "/share/emacs/site-lisp"))

(require 'ocp-indent)
;(require 'ocp-index)

(require 'merlin)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode t)

(setq merlin-use-auto-complete-mode t)
(setq merlin-command 'opam)

(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)

;; Shen

;; For some reason this is not handled by the package setup

(require 'shen-mode)

;; Python

(add-hook 'python-mode-hook 'jedi:setup)

;;;; Flycheck

(add-hook 'after-init-hook #'global-flycheck-mode)

;;;; Keybindings

(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "M-x") 'smex)

;;(global-set-key (kbd "C-<tab>") 'sr-speedbar-toggle)

(add-hook 'ag-mode-hook 'wgrep-custom-bindings)

(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; Speedbar

;; (require 'speedbar)

;; (mapc 'speedbar-add-supported-extension  
;;       '(".ml" ".mli" ".lua"))
;; (sr-speedbar-open)

;; (with-current-buffer sr-speedbar-buffer-name
;;   (setq window-size-fixed 'width))

;;;; Defuns

(defun wgrep-custom-bindings ()
  (local-set-key (kbd "C-x C-e") 'wgrep-change-to-wgrep-mode))

;; Smart C-a from prelude
(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.

Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;;;; Enabled "dangerous" settings

(put 'dired-find-alternate-file 'disabled nil)

;;;; Fix paths

(setenv "PATH" (concat
                *opam-prefix* "/bin" ":"
		"/usr/local/bin" ":"
		(getenv "PATH")))

(setq exec-path (append (split-string (getenv "PATH") ":")
			'("/Applications/Emacs.app/Contents/MacOS/libexec"
			  "/Applications/Emacs.app/Contents/MacOS/bin")))

(provide 'init)
;;; init.el ends here
