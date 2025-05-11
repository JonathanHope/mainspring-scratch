;;; mainspring-scratch.el --- Launch scratch buffers. -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Jonathan Hope

;; Author: Jonathan Hope <jhope@theflatfield.net>
;; Version: 1.0
;; Keywords: scratch
;; Package-Requires: ((emacs "29.1"))

;;; Commentary:

;; Launch scratch buffers.

;;; Code:

(defgroup mainspring-scratch nil
  "Launch scratch buffers"
  :group 'extensions)

(defcustom mainspring-scratch-modes '((org . org-mode)
                                      (text . text-mode))
  "Modes supported by `mainspring-scratch'."
  :type 'alist
  :group 'mainspring-scratch)

(defcustom mainspring-scratch-separator ":"
  "What to separate the buffer name segments with."
  :group 'mainspring-org-prettify)

(defvar mainspring-scratch-indexes
  (let* ((keys (mapcar 'car mainspring-scratch-modes))
         (indexes (mapcar (lambda (key) (cons key 0)) keys)))
    indexes))

;;;###autoload
(defun mainspring-scratch (arg)
  "Launch a scratch buffer."
  (interactive
   (list
    (completing-read "Scratch mode: " (mapcar 'car mainspring-scratch-modes))))
  (let* ((index (alist-get (intern arg) mainspring-scratch-indexes))
         (buffer-name (concat "*scratch" mainspring-scratch-separator arg mainspring-scratch-separator (number-to-string index) "*"))
         (mode (alist-get (intern arg) mainspring-scratch-modes)))
    (get-buffer-create buffer-name)
    (switch-to-buffer buffer-name)
    (funcall mode)
    (setf (alist-get (intern arg) mainspring-scratch-indexes) (+ index 1))))

(provide 'mainspring-scratch)
;;; mainspring-scratch.el ends here
