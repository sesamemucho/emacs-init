;;; init.el --- emacs initialization file
;; -*- lexical-binding: t; -*-

;; From:
;; Copyright (C) 2017-2018 Adam Taylor

;;; Commentary:
;;      This file is documented in config.org
;;

;;; Code:
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)
(prefer-coding-system 'utf-8)
;; (unless (boundp 'package-user-dir)
;;   (unless (boundp 'package-archive-contents)
;;     (package-initialize))
;;   (unless (assoc 'use-package package-archive-contents)
;;     (package-refresh-contents)
;;     (package-install (elt (cdr (assoc 'org-plus-contrib package-archive-contents)) 0))
;;     (package-install (elt (cdr (assoc 'use-package package-archive-contents)) 0))))
;; (assoc-delete-all 'org package--builtins)

;; straight brings in just too much stuff (in repos)
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))
;; (setq ssmm/cfg-dir user-emacs-directory)
;; (setq ssmm/cfg-file (concat ssmm/cfg-dir "config"))

;; (setq package-user-dir (concat ssmm/cfg-dir "elpa"))
  (defun ssmm/is-android-p ()
    (string-equal system-type "android")
    ;; Debugging git
    ;; t
    )
  (unless (ssmm/is-android-p)
    (defvar bootstrap-version)
    (unless (boundp 'straight-use-package)
      (let ((bootstrap-file
             (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
            (bootstrap-version 5))
        (unless (file-exists-p bootstrap-file)
          (with-current-buffer
              (url-retrieve-synchronously
               "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
               'silent 'inhibit-cookies)
            (goto-char (point-max))
            (eval-print-last-sexp)))
        (load bootstrap-file nil 'nomessage))
      (straight-use-package 'use-package))
    (setq straight-use-package-by-default t)
    )
(require 'package)
;;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa"   . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '( "jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
)
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; (when (< emacs-major-version 27)
;;   (package-initialize))

(add-to-list 'load-path (expand-file-name "startup/use-package" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "startup/bind-key" user-emacs-directory))
;; (require 'use-package)
;; (setq use-package-always-ensure nil)
;; ;;(load-library 'org)
;;; remove references to older org in path
;(setq load-path (cl-remove-if (lambda (x) (string-match-p "org$" x)) load-path))
(use-package org
  :ensure t
  :pin elpa)
;;  "The base name for the .org file to use for Emacs initialization.")
(setq ssmm/cfg-dir user-emacs-directory)
(setq ssmm/cfg-file (concat ssmm/cfg-dir "config"))
(when (file-newer-than-file-p (concat ssmm/cfg-file ".org") (concat ssmm/cfg-file ".el"))
  (org-babel-tangle-file (concat ssmm/cfg-file ".org")))
(load ssmm/cfg-file)
;; Local Variables:
;; byte-compile-warnings: (not free-vars noruntime)
;; End:
;;; init.el ends here
