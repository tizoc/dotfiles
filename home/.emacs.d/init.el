(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t)
 '(baud-rate 38400)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango)))
 '(custom-theme-load-path (quote ("~/.emacs.d/themes" custom-theme-directory t)))
 '(exec-path (quote ("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(flycheck-python-flake8-executable "pyflakes")
 '(ido-auto-merge-work-directories-length nil)
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-max-prospects 10)
 '(ido-mode (quote both) nil (ido))
 '(ido-ubiquitous-mode t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-virtual-buffers t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(make-backup-files nil)
 '(menu-bar-mode t)
 '(merlin-use-auto-complete-mode t)
 '(ns-alternate-modifier (quote none))
 '(ns-command-modifier (quote meta))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(powerline-default-separator (quote butt))
 '(scalable-fonts-allowed t)
 '(scroll-bar-mode nil)
 '(shell-file-name "/bin/bash")
 '(show-paren-style (quote mixed))
 '(tool-bar-mode nil)
 '(url-cookie-file "/Users/bruno/.emacs.d/url/cookies")
 '(url-history-file "/Users/bruno/.emacs.d/url/history"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(powerline-active1 ((t (:inherit mode-line :background "indian red"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "gray80")))))

(defvar my-packages 
  '(ag
    auto-complete
    cus-edit+
    flycheck
    flycheck-tip
    magit
    ido-ubiquitous
    powerline
    smex
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
            (width . 160))))

;;;; Settings

(setenv "CAML_LD_LIBRARY_PATH" "/Users/bruno/.opam/system/lib/stublibs:/usr/local/lib/ocaml/stublibs")
(setenv "OCAML_TOPLEVEL_PATH" "/Users/bruno/.opam/system/lib/toplevel")

(setenv "PATH" (concat
		(expand-file-name "~/.opam/system/bin/") ":"
		"/usr/local/bin" ":"
		(getenv "PATH")))

(setq exec-path (append (split-string (getenv "PATH") ":")
			'("/Applications/Emacs.app/Contents/MacOS/libexec"
			  "/Applications/Emacs.app/Contents/MacOS/bin")))

;; Packages

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

(ido-mode t)
(show-paren-mode 1)
(powerline-default-theme)

;; OCaml

(add-to-list 'load-path (concat
  (replace-regexp-in-string "\n$" ""
    (shell-command-to-string "opam config var share"))
  "/emacs/site-lisp"))

(require 'ocp-indent)

(require 'merlin)
(add-hook 'tuareg-mode-hook 'merlin-mode)

;;;; Flycheck

(add-hook 'after-init-hook #'global-flycheck-mode)

;;;; Keybindings

(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "M-x") 'smex)

(add-hook 'ag-mode-hook 'wgrep-custom-bindings)

(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

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
