;; evil
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)
;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)


;; direnv
(use-package! direnv
  :config
  (direnv-mode))


;; dired
(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))


;; terminal
(setq evil-escape-excluded-major-modes
      (delete 'vterm-mode evil-escape-excluded-major-modes))

(defun open-popup-terminal ()
  "Toggle a terminal popup window."
  (interactive)
  (+term/toggle t)
  (evil-window-set-height 10))


;; trello
(defun org-trello-sync-buffer-from-trello ()
  "Sync Trello buffer."
  (interactive)
  (org-trello-sync-buffer t))


;; agenda
(setq org-agenda-files '("~/dev/org/" "~/dev/org/google-calendar/"))

(setq org-agenda-custom-commands
      '(("c" "Custom agenda view"
         ((agenda ""
                  ((org-agenda-overriding-header "Today's agenda")
                   (org-agenda-start-day "4d")
                   (org-agenda-span 1)))
          (agenda "" ((org-agenda-overriding-header "10 days' agenda")))
          (alltodo "" ((org-agenda-overriding-header "All tasks")))))))



;; plantuml
(setq org-plantuml-jar-path plantuml-jar-path)


;; alert
(setq alert-default-style 'notifier)


;; mu4e
(after! mu4e
  (set-email-account! "gmail"
                      '((mu4e-sent-folder       . "/gmail/sent")
                        (mu4e-drafts-folder     . "/gmail/drafts")
                        (mu4e-trash-folder      . "/gmail/trash")
                        (mu4e-refile-folder     . "/gmail/all")
                        (smtpmail-smtp-user     . "yevhenshymotiuk@gmail.com")
                        (smtpmail-smtp-server   . "smtp.gmail.com")
                        (smtpmail-smtp-service  . 587)
                        (user-mail-address      . "yevhenshymotiuk@gmail.com"))
                      t)
  (set-email-account! "protonmail"
                      '((mu4e-sent-folder       . "/protonmail/sent")
                        (mu4e-drafts-folder     . "/protonmail/drafts")
                        (mu4e-trash-folder      . "/protonmail/trash")
                        (mu4e-refile-folder     . "/protonmail/all")
                        (smtpmail-smtp-user     . "yevhenshymotiuk@protonmail.com")
                        (smtpmail-smtp-server   . "127.0.0.1")
                        (smtpmail-smtp-service  . 1025)
                        (user-mail-address      . "yevhenshymotiuk@pm.me"))
                      t)
  (add-to-list 'gnutls-trustfiles "~/.config/protonmail/bridge/cert-imap.pem")
  (add-to-list 'gnutls-trustfiles "~/.config/protonmail/bridge/cert-smtp.pem")
  (setq send-mail-function 'smtpmail-send-it
        mu4e-headers-fields '((:flags . 6)
                              (:account-stripe . 2)
                              (:from-or-to . 25)
                              ;; (:folder . 10)
                              ;; (:recipnum . 2)
                              (:subject . 80)
                              (:human-date . 8))
        +mu4e-min-header-frame-width 142
        mu4e-headers-date-format "%d/%m/%y"
        mu4e-headers-time-format "⧖ %H:%M"
        mu4e-headers-results-limit 1000
        mu4e-index-cleanup t)
  (defvar +mu4e-header--folder-colors nil)
  (appendq! mu4e-header-info-custom
            '((:folder .
               (:name "Folder" :shortname "Folder" :help "Lowest level folder" :function
                (lambda (msg)
                  (+mu4e-colorize-str
                   (replace-regexp-in-string "\\`.*/" "" (mu4e-message-field msg :maildir))
                   '+mu4e-header--folder-colors)))))))

(use-package! mu4e-alert
  :after mu4e
  :config
  (mu4e-alert-set-default-style 'notifier)
  (mu4e-alert-enable-mode-line-display)
  (mu4e-alert-enable-notifications))


;; twitter
(setq twittering-allow-insecure-server-cert t)
