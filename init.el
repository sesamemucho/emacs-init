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

(when (< emacs-major-version 27)
  (package-initialize))

(add-to-list 'load-path (expand-file-name "startup/use-package" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "startup/bind-key" user-emacs-directory))
(require 'use-package)
(setq use-package-always-ensure nil)
;;(load-library 'org)
(use-package org)
(setq ssmm/cfg-dir user-emacs-directory)
(setq ssmm/cfg-file (concat ssmm/cfg-dir "config"))
;;  "The base name for the .org file to use for Emacs initialization.")
(when (file-newer-than-file-p (concat ssmm/cfg-file ".org") (concat ssmm/cfg-file ".el"))
  (org-babel-tangle-file (concat ssmm/cfg-file ".org")))
(load ssmm/cfg-file)
;; Local Variables:
;; byte-compile-warnings: (not free-vars noruntime)
;; End:
;;; init.el ends here
