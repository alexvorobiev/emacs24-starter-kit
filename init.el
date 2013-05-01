;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; remember this directory
(setq starter-kit-dir
      (file-name-directory (or load-file-name (buffer-file-name))))

;; org is special
;; remove org-mode shipped with emacs from the load-path
(require 'cl)

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
(put 'narrow-to-region 'disabled nil)
