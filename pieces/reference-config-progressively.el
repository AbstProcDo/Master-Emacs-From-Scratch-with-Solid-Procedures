;;; ~/Public/Master-Emacs-From-Scrach-with-Solid-Procedures/config.el -*- lexical-binding: t; -*-

;; Half page 
(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2)))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (interactive)
  (scroll-up (/ (window-body-height) 2)))

(global-set-key "\M-n" 'scroll-half-page-up)
(global-set-key "\M-p" 'scroll-half-page-down)


;; Auto save 
(setq auto-save-visited-mode t)
(auto-save-visited-mode +1)


(define-minor-mode dired-follow-mode "Diplay file at point in dired after a move."
  :lighter " dired-f"
  :global t
  (if dired-follow-mode (advice-add 'dired-next-line
                                    :after (lambda (arg)
                                             (dired-display-file)))
    (advice-remove 'dired-next-line (lambda (arg)
                                      (dired-display-file)))))
