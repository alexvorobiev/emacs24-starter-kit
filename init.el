;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; remember this directory
(setq starter-kit-dir
      (file-name-directory (or load-file-name (buffer-file-name))))

(require 'cl)

;; Remove leftover older packages
(let* ((all-dirs
        (remove-if-not
         #'(lambda (f) (and (file-directory-p f) (string-match "-" f)))
         (directory-files "~/.emacs.d/elpa" t)))
       (unique-dirs 
        (cl-remove-duplicates
         all-dirs
         :test #'(lambda (s1 s2)
                   (flet ((strip-off-version
                           (str)
                           (substring str 0
                                      (1- (string-match "[0-9]+\.[0-9]+" str)))))
                     (string= (strip-off-version s1)
                              (strip-off-version s2))))))
       (to-delete (cl-set-difference all-dirs unique-dirs)))
  (message "Deleting older packages:\n %s"
           (mapconcat #'(lambda (d) (delete-directory d t) d) to-delete "...ok\n")))


;; org is special
;; remove org-mode shipped with emacs from the load-path
(setq custom-org-path (car (file-expand-wildcards
                            (concat starter-kit-dir "elpa/org-plus-contrib-20*"))))
(when custom-org-path 
  (setq load-path (remove-if (lambda (x) (string-match-p "org$" x)) load-path))

  (add-to-list 'load-path custom-org-path)

  (eval-after-load 'info
    '(add-to-list 'Info-default-directory-list custom-org-path)))

(require 'org)

;; load up the starter kit
(org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))

;;; init.el ends here

