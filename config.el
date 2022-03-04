;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jan Pajerski"
      user-mail-address "janpajerski@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dropbox (personal)/org/org-mode")


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Directories to act as inputs to my agenda
(setq org-agenda-files (quote ("~/dropbox (personal)/org/org-mode/inbox"
                               "~/dropbox (personal)/org/org-mode/todo"
                               "~/dropbox (personal)/org/org-mode/projects"
                               "~/dropbox (personal)/org/org-mode/areas"
                               "~/dropbox (personal)/org/org-mode/resources"
                               "~/dropbox (personal)/org/org-mode/tickler" )))



;; The following load after org is loaded to prevent being over ridden
(after! org
  (setq org-hide-emphasis-markers t)
  (setq org-file-apps '((auto-mode . emacs)
                        ("\\.xlsx\\'" . default)
                        ("\\.pdf\\'" . default)))
  (setq org-image-actual-width (list 1500))
  (setq org-capture-templates
     '(("i" "Inbox" entry (file "~/dropbox (personal)/org/org-mode/inbox/inbox.org")
            "* TODO %?\n ")))
   (setq org-todo-keywords
         '((sequence "TODO(t)" "CLOCK(k)" "RECURRING(r)" "INPROGRESS(i)" "WAITING(w)" "NEXT(n)" "TICKLER(x)" "|" "DONE(d)" "CANCELLED(c)"))
         org-todo-keyword-faces
         '(("TODO" :foreground "#f57542" :weight bold :underline t)
           ("CLOCK" :foreground "#2fde5a" :weight bold :underline t)
           ("RECURRING" :foreground "#2fc4de" :weight bold :underline t)
           ("WAITING" :foreground "#cfb317" :weight bold :underline t)
           ("INPROGRESS" :foreground "#425df5" :weight bold :underline t)
           ("NEXT" :foreground "#ff00e1" :weight bold :underline t)
           ("TICKLER" :foreground "#fb9e00" :weight bold :underline t)
           ("DONE" :foreground "#809167" :weight bold :underline t)
           ("CANCELLED" :foreground "#adadad" :weight bold :underline t)))
   (setq org-priority-lowest 69
         org-priority-faces '((?A :foreground "#ff0dd3" :weight bold)
                              (?B :foreground "#ff0d0d" :weight bold)
                              (?C :foreground "#ff9e0d" :weight bold)
                              (?D :foreground "#27cf40" :weight bold)
                              (?E :foreground "#9d27cf" :weight bold))
         org-agenda-archives-mode t
         org-clocktable-defaults '(:maxlevel 2
                                   :lang "en"
                                   :scope file
                                   :block nil
                                   :wstart 1
                                   :mstart 1
                                   :tstart nil
                                   :tend nil
                                   :step nil
                                   :stepskip0 nil
                                   :fileskip0 nil
                                   :tags nil
                                   :match nil
                                   :emphasize nil
                                   :link nil
                                   :hidefiles nil
                                   :narrow 40!
                                   :IndenT t
                                   :formula nil
                                   :timestamp nil
                                   :level nil
                                   :tcolumns nil
                                   :formatter nil)))

;; The following sets the order/name of my priorities
(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . "[MIT]")
                                    (?B . "[A]")
                                    (?C . "[B]")
                                    (?D . "[C]")
                                    (?E . "[IMPORTANT]"))))


;; org-download settings
(after! org
  (setq org-download-image-dir "~/dropbox (personal)/org/images"))


;;(use-package org-download
;;  :ensure t
;;  :defer t
;;  :init (with-eval-after-load 'org
;;          (org-download-enable)))


;; (defun janpa/org-download-paste-clipboard (&optional use-default-filename)
;;   (interactive "P")
;;   (require 'org-download)
;;   (let ((file
;;          (if (not use-default-filename)
;;              (read-string (format "Filename [%s]: "
;;                                   org-download-screenshot-basename)
;;                           nil nil org-download-screenshot-basename)
;;            nil)))
;;     (org-download-clipboard file)))

;; (after! org
;;   (setq org-download-method 'directory)
;;   (setq org-download-image-dir "images")
;;   (setq org-download-heading-lvl nil)
;;   (setq org-download-timestamp "%Y%m%d-%H%M%S_")
;;   (setq org-image-actual-width 300)
;;   (map! :map org-mode-map
;;         "C-c l a y" #'janpa/org-download-paste-clipboard
;;         "C-M-y" #'janpa/org-download-paste-clipboard))



;;The following package lets me configure my agenda the way I want it to look.
(use-package! org-super-agenda
  :init
  (setq org-deadline-warning-days 7)
  (setq org-agenda-custom-commands
        '(("c" "contexts"
           ((alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:auto-tags t)))))))
         ("k" "clock"
           ((alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:discard (:tag "personal"))
                            (:name "Clock"
                             :todo "CLOCK")
                            (:name "Recurring"
                             :todo "RECURRING")
                            (:discard (:anything t))))))))
         ("w" "work view"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "Calendar"
                            :time-grid t
                            :scheduled today
                            :order 1)
                           (:name "Due Today"
                            :deadline today
                            :order 2)
                           (:name "Overdue"
                            :deadline past
                            :order 3)
                           (:name "Due Next 7 Days"
                            :deadline future
                            :order 4)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:discard (:tag ("personal") :todo ("RECURRING" "CLOCK")))
                            (:name "MOST IMPORTANT TASKS"
                             :priority "A"
                             :todo ("NEXT")
                             :order 1)
                            (:name "Today"
                             :priority>= "D"
                             :order 4)
                            (:name "Active"
                             :todo ("INPROGRESS" "WAITING")
                             :order 5)
                            (:name "On Deck"
                             :priority "E"
                             :order 6)
                            (:name "Projects"
                             ;:auto-parent t
                             :tag "projects"
                             :order 7)
                            (:name "Areas"
                             :tag "areas"
                             :order 8)
                            (:name "Tickler"
                             :todo ("TICKLER")
                             :order 9)
                               ))))))
          ("p" "personal view"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:discard (:scheduled past))
                           (:discard (:tag "work"))
                           (:name "Calendar"
                            :time-grid t
                            :scheduled today
                            :order 1)
                           (:name "Due Today"
                            :deadline today
                            :order 2)
                           (:name "Overdue"
                            :deadline past
                            :order 3)
                           (:name "Due Next 7 Days"
                            :deadline future
                            :order 4)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:discard (:tag "work"))
                            (:name "MOST IMPORTANT TASKS"
                             :priority "A"
                             :order 1)
                            (:name "Today"
                             :priority>= "D"
                             :order 4)
                            (:name "Active"
                             :todo ("INPROGRESS" "WAITING")
                             :order 5)
                            (:name "On Deck"
                             :priority "E"
                             :order 6)
                            (:name "General Tasks"
                             :tag "genTasks"
                             :order 7)
                            (:auto-category t
                             :order 10))
                          )))))
          ))
 :config
  (org-super-agenda-mode)
 )

(setq org-agenda-start-day "+0d")




;; Setting my org-roam directory
(setq org-roam-directory  (file-truename "~/dropbox (personal)/org/org-roam"))


;; Settings for org-roam daily note capture

(use-package! org-roam-dailies
  :config
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %?" :if-new
         (file+head "%<%Y-%m-%d>.org"
                    "#+title: %<%Y-%m-%d>")))))

;; Settings for deft
(setq deft-directory "~/dropbox (personal)/org/"
       deft-extensions '("org" "txt")
       deft-recursive t
       deft-strip-summary-regexp
             (concat "\\("
                     "^:.+:.*\n" ; any line with a :SOMETHING:
                     "\\|^#\\+.*\n" ; anyline starting with a #+
                     "\\|^\\*.+.*\n" ; anyline where an asterisk starts the line
                     "\\)"))
 (advice-add 'deft-parse-title :override
                 (lambda (file contents)
                 (if deft-use-filename-as-title
                 (deft-base-filename file)
                 (let* ((case-fold-search 't)
                         (begin (string-match "title: " contents))
                         (end-of-begin (match-end 0))
                         (end (string-match "\n" contents begin)))
                 (if begin
                         (substring contents end-of-begin end)
                         (format "%s" file))))))


;; A temporary BUG fix

(defun native-comp-available-p nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
