((nil . ((eval . (let ((mode-file
                        (expand-file-name "editors/67-mode.el"
                                          (locate-dominating-file default-directory ".dir-locals.el"))))

                   (when (file-exists-p mode-file)
                     (unless (fboundp '67-mode)
                       (load mode-file))

                     (add-to-list 'auto-mode-alist '("\\.67\\'" . 67-mode))

                     (when (and buffer-file-name
                                (string-match-p "\\.67\\'" buffer-file-name)
                                (not (eq major-mode '67-mode)))
                       (67-mode))))))))
