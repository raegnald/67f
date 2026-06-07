;;; 67-mode.el --- Major mode for editing .67 files  -*- lexical-binding: t; -*-

;; Copyright (C) 2026

;; Author: Ronaldo Gligan
;; Keywords: languages, esoteric

;;; Commentary:

;; An Emacs major mode for editing .67 files, an esoteric language
;; based on brainfuck.
;; Keybindings:
;;   C-c C-c: Run the current file in the 67f interpreter.

;;; Code:

(defgroup 67-mode nil
  "Support for the 67 programming language."
  :group 'languages)

(defcustom 67-indent-width 2
  "Number of spaces for each indentation level in `67-mode'."
  :type 'integer
  :group '67-mode)

(defvar 67-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; Define standard symbol constituents and punctuation
    (modify-syntax-entry ?+ "." st)
    (modify-syntax-entry ?- "." st)
    (modify-syntax-entry ?. "." st)
    (modify-syntax-entry ?, "." st)
    (modify-syntax-entry ?/ "." st)
    (modify-syntax-entry ?6 "." st)
    (modify-syntax-entry ?7 "." st)
    (modify-syntax-entry ?9 "." st)
    (modify-syntax-entry ?\; "." st)
    ;; Define parentheses matching for brackets to support syntax-ppss depth counting
    (modify-syntax-entry ?\[ "(]" st)
    (modify-syntax-entry ?\] ")[" st)
    st)
  "Syntax table for `67-mode'.")

(defvar 67-font-lock-keywords
  '(("[\\[\\]]" . font-lock-keyword-face)
    ("[67]" . font-lock-type-face)
    ("[+-]" . font-lock-constant-face)
    ("[.,]" . font-lock-builtin-face)
    ("9" . font-lock-variable-name-face)
    (";" . font-lock-warning-face))
  "Font-lock keywords for `67-mode'.")

(defun 67-syntax-propertise (start end)
  "Apply syntax properties to /67 ... 67/ comments."
  (funcall
   (syntax-propertize-rules
    ("\\(/\\)67" (1 "<"))
    ("67\\(/\\)" (1 ">")))
   start end))

(defun 67-indent-line ()
  "Indent the current line of 67f code based on loop nesting depth."
  (interactive)
  (let ((savep (point))
        (indent (let ((depth (car (syntax-ppss (line-beginning-position)))))
                  (save-excursion
                    (back-to-indentation)
                    (if (eq (char-after) ?\])
                        (* (max 0 (1- depth)) 67-indent-width)
                      (* depth 67-indent-width))))))
    (indent-line-to indent)
    (if (< (point) savep)
        (goto-char savep))))

(defvar 67-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") #'67-run)
    map)
  "Keymap for `67-mode'.")

;; Useful function for quick development on the interpreter
;;;###autoload
(defun 67-run ()
  "Run the current .67 file using the 67f interpreter.
Compiles the interpreter using the project's makefile first if not built."
  (interactive)
  (let* ((file (buffer-file-name))
         (proj-dir (locate-dominating-file (or file default-directory) "makefile"))
         (bin-dir (and proj-dir (expand-file-name "bin" proj-dir)))
         (interpreter (and bin-dir (expand-file-name "67f" bin-dir))))
    (unless file
      (user-error "Buffer is not visiting a file"))
    (unless proj-dir
      (user-error "Could not find project root containing makefile"))
    (when (buffer-modified-p)
      (save-buffer))
    ;; Compile the interpreter if it's missing
    (unless (file-exists-p interpreter)
      (let ((default-directory proj-dir))
        (message "Compiling 67f interpreter...")
        (shell-command "make")))
    (if (file-exists-p interpreter)
        (let ((cmd (format "%s %s"
                           (shell-quote-argument interpreter)
                           (shell-quote-argument file))))
          (compile cmd))
      (error "Could not find or compile 67f interpreter at %s" interpreter))))

;;;###autoload
(define-derived-mode 67-mode prog-mode "67f"
  "Major mode for editing .67 files."
  :syntax-table 67-mode-syntax-table
  (setq-local comment-start "/67 ")
  (setq-local comment-end " 67/")
  (setq-local comment-start-skip "/67[ \t]*")
  (setq-local syntax-propertize-function #'67-syntax-propertise)
  (setq-local font-lock-defaults '(67-font-lock-keywords))
  (setq-local indent-line-function #'67-indent-line)
  (setq-local tab-width 67-indent-width))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.67\\'" . 67-mode))

(provide '67-mode)
;;; 67-mode.el ends here
