; time stamp this thing.
; Time-stamp: <2013-10-08 14:59:12 jhannus .emacs>

;;; My location for external packages.
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(autoload 'coffee-mode "coffee-mode" "Major mode for editing coffee scripte")
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

(autoload 'groovy-mode "groovy-mode" "Major mode for editing grooovy scripts")
(add-to-list 'auto-mode-alist '("\\.groovy$" . groovy-mode))

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
'(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
'(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;; create the autosave dir if necessary, since emacs won’t.
(make-directory "~/.emacs.d/autosaves/" t)

;; start gnuserv stuff. Put it up front so you don't get into a
;; timeout problem when starting emacs from gnuclient or gnudoit,
;; according to Cristian Ionescu-Idbohrn
;; <cristian.ionescu-idbohrn@axis.com>
(if (memq window-system '(win32 w32)) ; Windows NT/95
    (progn
      (require 'gnuserv)
      (setq server-done-function 'bury-buffer
	        gnuserv-frame (car (frame-list)))
      (gnuserv-start)
      ;;; open buffer in existing frame instead of creating new one...
      (setq gnuserv-frame (selected-frame))
      (message "gnuserv started.")))

(if (string-equal system-type "gnu/linux")
;;     (or (string-equal (getenv "OSTYPE") "Linux" )
    ;; (string-equal (getenv "OSTYPE") "linux-gnu" ))
  (server-start)
  (message "emacsserver started."))
; end gnuserv stuff

(transient-mark-mode t)
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "English")
 '(desktop-buffers-not-to-save "(^nn.a[0-9]+\\|.log\\|(ftp)\\|^tags\\|^TAGS\\|^mutt-charlesc)$")
 '(global-font-lock-mode t nil (font-lock))
 '(message-log-max 250)
 '(next-line-add-newlines nil)
 '(ps-bottom-margin 72)
 '(recentf-exclude (quote ("/tmp/mutt")))
 '(recentf-max-menu-items 25)
 '(recentf-max-saved-items 25)
 '(show-paren-mode t nil (paren))
 '(sort-fold-case t t)
 '(tidy-shell-command "/usr/bin/tidy")
 '(woman-cache-filename "~/.wmncach.el"))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;; (load "clearcase")
(load "buffer-move")

(global-set-key (kbd "<C-x-up>")     'buf-move-up)
(global-set-key (kbd "<C-x-down>")   'buf-move-down)
(global-set-key (kbd "<C-x-left>")   'buf-move-left)
(global-set-key (kbd "<C-x-right>")  'buf-move-right)

;; insert the Sams Lib
;(load "sams-lib")
;(sams-write-abbrev-at-once)
;(global-set-key [(control T)] 'sams-transpose-prev-chars)
;; end insertion of the Sams Lib

;; Set the frame's title. %b is the name of the buffer. %+ indicates
;; the state of the buffer: * if modified, % if read only, or -
;; otherwise. Two of them to emulate the mode line. %f for the file
;; name. Incredibly useful!
;; (setq frame-title-format "Emacs: %b %+%+ %f")
;; (setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq frame-title-format (concat invocation-name "@" system-name ": %b %+%+ %f"))

;; get what-env so we can customize for different environments. I
;; wrote this before Jesper Pedersen wrote sams-lib.el.
;(load "what-env")

;; .emacs file font-lock stuff. I got this from someone else, and
;; would like to be able to give credit. Would the author please step
;; forward?
(defun my-recenter (&optional arg)
  "Centre point in window and run font-lock-fontify-block"
  (interactive "P")
  (recenter arg)
  (font-lock-fontify-block (window-height)))

(require 'font-lock)
(setq font-lock-face-attributes
      '((font-lock-comment-face "orange")
	(font-lock-string-face    "SpringGreen4")
	(font-lock-keyword-face  "RoyalBlue")
	(font-lock-function-name-face  "Blue")
	(font-lock-variable-name-face  "GoldenRod")
	(font-lock-type-face    "DarkGoldenRod")
	;(font-lock-reference-face   "Purple")
	))

;(if (<= sams-Gnu-Emacs-p 19); 20.2 doesn't like
;    (font-lock-make-faces)); this.
;
;(add-hook 'font-lock-mode-hook
;	    '(lambda ()
;	            (substitute-key-definition
;		           'recenter 'my-recenter (current-global-map))))

(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))
;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-decoration t)

(setq lazy-lock-defer-after-change t)

;; Set up tests to determine which system we are running. Ah, the
;; convenience of subroutines.

(defun system-is-teckla-dos ()
  (interactive)
  "Return true if the system we are running on is Charles' laptop running W98."
  (string-equal system-name "TECKLA" )
  )

(defun system-is-teckla-linux ()
  (interactive)
  "Return true if the system we are running on is Charles' laptop running Linux."
  (or (string-equal system-name "teckla.localdomain")
      (string-equal system-name "teckla"))
  )

(defun system-is-charlesc ()
  (interactive)
  "Return true if the system we are running on is Charles' desktop."
  (or (string-equal system-name "charlesc.localdomain")
      (string-equal system-name "charlesc"))
  )

(defun system-is-issola ()
  (interactive)
  "Return true if the system we are running on is issola."
  (or (string-equal system-name "issola.localdomain")
      (string-equal system-name "issola"))
  )

(defun system-is-jhereg ()
  (interactive)
  "Return true if the system we are running on is jhereg."
  (or (string-equal system-name "jhereg.localdomain")
      (string-equal system-name "jhereg"))
  )


;; A problem with emacs on Red Hat 8.0 is that to doesn't seem to
;; handle *.pl files as perl; it thinks they're something else.
(setq auto-mode-alist (cons '("\.pl$" . perl-mode) auto-mode-alist))


; begin html-helper-mode goodies
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)

;; My own definition of html extensions to recognize html files. The match
;; is case-rude, as follows: period ("\.") followed by an optional s
;; ("s?"), a required htm, and an optional l ("l?"). The l must be
;; last. ("\\>"). Nelson ended his regex with a $, which means "end of
;; line". I decided to be conservative and just match the end of the
;; word. Case sensitivity is not required on Windows NT, but is on Linux.

;; The extension .shtml is used by some sites to indicate files to parse
;; for server side includes. On those sites, plain vanilla .html files are
;; not parsed for SSIs for speed. The l at the end is optional because
;; early versions of Microsoft IIS used .htm for their extension, and some
;; people stick to that Microsoftism. Might as well catch 'em all.
(if (not (system-is-teckla-dos))
    (setq auto-mode-alist (cons '("\.s?html?\\'" . html-helper-mode) auto-mode-alist))
  )

;; This line catches .php and .php3 files & adds them to the list.
;; (setq auto-mode-alist (cons '("\.php3?\\>" . html-helper-mode) auto-mode-alist))

;; catch text files as well...
;; (setq auto-mode-alist (cons '("\.txt$" . text-mode) auto-mode-alist))

; The original from Nelson
; (setq auto-mode-alist (cons '("\.html$" . html-helper-mode) auto-mode-alist))
; I also set Ispell to do complete words in the Ispell4 region of this file.

(setq html-helper-do-write-file-hooks t)
(setq html-helper-build-new-buffer t)
(setq html-helper-address-string "<a href=\"mailto:charlescurley@charlescurley.com\">Charles Curley</a>")

(setq html-helper-use-expert-menu t)
(setq html-helper-mode-insert-attributes-always nil)
; Turn on prompting.
;(setq tempo-interactive t)
; Turn off prompting.
(setq tempo-interactive nil)
;; end html-helper-mode goodies

;; allow the use of htmlpp minor mode.
;(if (not (or (system-is-issola)
;	          (system-is-jhereg)))
;    (progn (require 'htmlpp)
;	      (global-set-key "\C-ch" 'htmlpp-mode))
;  )

;; latex mode for .lyx files.
(if (system-is-charlesc)
    (setq auto-mode-alist (cons '("\.lyx$\\>" . latex-mode) auto-mode-alist))
  )

; For Bruce mode
(autoload 'bruce "bruce" "Use the Bruce program to protest the CDA")

;; Begin: Set up browse-url to use Mozilla without Netscape around.
(setq browse-url-netscape-program "mozilla")
(setq browse-url-new-tab-flag t)
;; End: Set up browse-url to use Mozilla without Netscape around.


;; Don't display the time on W95. I have problems w/ this interfering
;; with my screen saver/monitor power control SW on w95. NT 4 and W2k
;; seem to be OK. You need this to enable the appointment
;; notification.
;(if (not (string-equal what-env "Windows_95"))
;    (progn (setq display-time-24hr-format t)
;	      (setq display-time-day-and-date t)
;	         (display-time)
;		    ))
;
; disable backups to work around w95 bug.
;(if (string-equal what-env "Windows_95")
;    (setq make-backup-files nil))


; Add time stamp capabilities. See time-stamp.el for doc.
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S %u %f")
(add-hook 'write-file-hooks 'time-stamp)

;; A function to insert the time stamp at point.
(defun stamp ()
  "Insert at point the dummy time stamp string to activate the time stamp facility."
  (interactive "*")
  (insert "Time-stamp: <>")             ;insert the bare bones
  (time-stamp)                          ;call the function to fill it in
                                        ;where we put it.
  )


;; enable narrowing w/out a prompt
(put 'narrow-to-region 'disabled nil)

(if (not ( or (system-is-issola)
	            (system-is-teckla-dos)
		          (system-is-jhereg)))
    (progn
; Compilation setup:
; Visual C++ Debug:
; (setq compile-command '("nmake -f .mak" . 10))
; Visual C++ Release:
; (setq compile-command '("nmake -f .mak CFG=\"MyProject - Win32 Release\"" . 10))
; Htmlpp
;      (setq compile-command '("htmlpp .txt" . 8))

      ;; shamelessly lifted from Steve Kemp's htmlpp minor mode, which I
      ;; also use. http://www.gnusoftware.com/
;       (let ((compile-command (format "%s %s"
					;  htmlpp-path (buffer-file-name) htmlpp-arg))))
      (setq compilation-scroll-output t)
      )
  )


; (setq ispell-command "")

(setq text-mode-hook '(lambda ()
			(local-set-key "\M-\t" 'ispell-complete-word)))
(setq tex-mode-hook '(lambda ()
		              (local-set-key "\M-\t" 'ispell-complete-word)))
(setq latex-mode-hook '(lambda ()
			  (local-set-key "\M-\t" 'ispell-complete-word)))
(setq html-helper-mode-hook '(lambda ()
			              (local-set-key "\M-\t" 'ispell-complete-word)))
(setq ispell-enable-tex-parser t)


;; Word Count tool, per sshteingold@cctrading.com
(defun sds-word-count (start end)
  ;; replacement for count-lines-region
  "Count lines/words/characters from START to END"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (min start end))
      (message "Region (%d to %d) has: lines: %d; words: %d; characters: %d."
	              start end (count-lines start end)
		             (string-to-number (how-many "\\<")) (- end start)))))
(define-key esc-map "=" 'sds-word-count)


;; Use follow mode when emacs window is wide enough...
(global-set-key [f8] 'follow-mode)
(global-set-key [f7] 'follow-delete-other-windows-and-split)

;; woman (Man page reader) stuff:
(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)
(global-set-key [f6] 'woman-find-file)
(autoload 'woman-dired-find-file "woman"
  "In dired, run the WoMan man-page browser on this file." t)
(add-hook 'dired-mode-hook
	    (function
	        (lambda ()
		       (define-key dired-mode-map "W" 'woman-dired-find-file))))

(let (help-menu manuals)
  (if (setq help-menu (lookup-key global-map [menu-bar help-menu]))
      (if (setq manuals (lookup-key help-menu [manuals]))
	    (define-key-after
	          manuals [woman] '("Read Man Page (WoMan)..." . woman) t)
	(define-key-after
	    help-menu [woman] '("WoMan..." . woman) 'man))))


;(if (eq sams-Gnu-Emacs-p 20)
;    (defgroup woman nil
;      "Browse UNIX manual pages `wo (without) man'."
;      :tag "WoMan" :group 'help :load "woman"))

;; Use colo(u)r instead of bold & underscore.
(setq woman-always-colour-faces t)

;; Fill up the full width of the frame when laying out the page.
(setq woman-fill-frame t)

;; End Woman Mode Stuff


;; Abbreviations stuff:
(setq-default abbrev-mode t)
(cond ((file-exists-p "~/.abbrev_defs")
       (read-abbrev-file "~/.abbrev_defs")))
(setq save-abbrevs t)


;; Window shifting. C-x-o lets us go forward a window (or several). This
;; one lets us go back one or more windows. From Glickstein.
(defun other-window-backward (&optional n)
  "Select previous Nth window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

;; now bind it to C-x p
(global-set-key "\C-x\p" 'other-window-backward)
;; end window shifting.


;; begin browse-url mode
(setq browse-url-save-file t)

;;To bind the browse-url commands to keys with the `C-c u' prefix:
(global-set-key "\C-cu." 'browse-url-at-point)
(global-set-key "\C-cub" 'browse-url-of-buffer)
(global-set-key "\C-c\C-zr" 'browse-url-of-region)
(global-set-key "\C-c\C-zu" 'browse-url)
(global-set-key "\C-cuf" 'browse-url-of-file)
(add-hook 'dired-mode-hook
	    (lambda ()
	          (local-set-key "\C-cuf" 'browse-url-of-dired-file)))
(if (boundp 'browse-url-browser-function)
    (global-set-key "\C-cuu" browse-url-browser-function)
  (eval-after-load
   "browse-url"
   '(global-set-key "\C-cuu" browse-url-browser-function)))

;; Note: this depends on Theodore Jump's W32-shellex tool, which should be
;; included below somewhere.
;; (if (memq window-system '(win32 w32)); Windows NT/95
;;     (setq browse-url-netscape-command
;;   "f:\\Program Files\\Netscape\\Communicator\\Program\\netscape.exe")
;;   )

;; To display a URL by shift-clicking on it, put this in your ~/.emacs
;; file:
(global-set-key [S-mouse-2] 'browse-url-at-mouse)
;; (Note that using Shift-mouse-1 is not desirable because
;; that event has a standard meaning in Emacs.)

(autoload 'browse-url "browse-url" "browse-url loaded!" t)
;; end browse-url mode


; Insert the date, the time, and the date and time at point. Insert the
; date 31 days hence at point (eventually...). Useful for keeping
; records. These are based on Glickstein.

(defvar insert-time-format "%T"
  "*Format for \\[insert-time] (c.f. 'format-time-string' for how to format).")

(defvar insert-date-format "%Y %m %d"
  "*Format for \\[insert-date] (c.f. 'format-time-string' for how to format).")

(defun insert-time ()
  "Insert the current time according to the variable \"insert-time-format\"."
  (interactive "*")
  (insert (format-time-string insert-time-format
			            (current-time))))

(defun insert-date ()
  "Insert the current date according to the variable \"insert-date-format\"."
  (interactive "*")
  (insert (format-time-string insert-date-format
			            (current-time))))

(defun insert-time-and-date ()
  "Insert the current date according to the variable \"insert-date-format\", then a space, then the current time according to the variable \"insert-time-format\"."
  (interactive "*")
  (progn
    (insert-date)
    (insert " ")
    (insert-time)))

(global-set-key [f3] 'insert-date)
(global-set-key [f4] 'insert-time)
(global-set-key [f5] 'insert-time-and-date)

;(defun insert-month-date ()
;  "Insert the date 31 days from now according to the variable \"insert-date-format\"."
;  (interactive "*")
;  (insert (format-time-string insert-date-format
					;      (current-time))))

;;; Windows keystrokes...
(if (memq window-system '(win32 w32)); Windows NT/95
    (global-set-key [M-f4] 'save-buffers-kill-emacs)
  )

;; Cascading Style Sheets
;; (autoload 'css-mode "css-mode")
;; (setq auto-mode-alist
;;       (cons '("\.css\\'" . css-mode) auto-mode-alist))

(if (memq window-system '(win32 w32)); Windows NT/95
    (setq w32-enable-italics t); This must be done before font settings!
  )

;;;************************************************************
;;; Set the default font and frame size for all frames. See the two
;;; related functions in comments below.
;;;************************************************************
;; These font-related goodies came from Chris McMahan
;; <cmcmahan@surefirev.com>, except that I converted the font selection
;; box stuff into a function and assigned it a key.

;(if (string-equal what-env "Windows_NT")
;    (if (not window-system)
;	nil
;      (setq default-frame-alist
;	        (append default-frame-alist
;			    '(
;			             (top . 10) (left . -15)
;				            (width . 96) (height . 40)
;					;       (background-color . "Gray92")
;					;       (foreground-color . "Black")
;					           (background-color . "light blue")
;						          (foreground-color . "navy")
;							  (cursor-color . "red3")
;							         ;; set the font in the registry....
;							         )))
;
;  ;;; Set the default font and frame size for the initial frame.
;       (setq initial-frame-alist
;	         '(
;		         (top . -10) (left . 240)
;			       (width . 96) (height . 40)
;					;      (background-color . "Gray92")
;					;      (foreground-color . "Black")
;			             (background-color . "light blue")
;				           (foreground-color . "navy")
;					   (cursor-color. "red3")
;					         )))
;   )

(if (and (system-is-teckla-dos)
	  (memq window-system '(win32 w32)))
    (progn (message "Setting teckla dos with windows frame lists")
	      (setq default-frame-alist
		     (append default-frame-alist
			      '( (top . 20) (left . (- 5)) (width . 96) (height . 38)
					;      (background-color . "Gray92")
				     (foreground-color . "Black")
				     (cursor-color. "red3")
				         (font . "-*-Courier New-normal-r-*-*-16-120-*-*-c-*-*-ansi-") ;; 12 pt
					     )))

  ;;; Set the default font and frame size for the initial frame.
	         (setq initial-frame-alist
		        '( (top . 10) (left . (- 5)) (width . 96) (height . 38)
					;       (background-color . "Gray92")
			       (foreground-color . "Black")
			       (cursor-color . "red3")
			           ))
		    )
  )

(if (and (system-is-teckla-dos)
	  (not (memq window-system '(win32 w32))))
    (progn (message "Setting teckla dos with no windows frame lists")
	      (setq default-frame-alist
		     (append default-frame-alist
			      '( (top . 0) (left . 0) (width . 82) (height . 32)
				     ;; (background-color . "Gray92")
				     (foreground-color . "Black")
				     (cursor-color . "red3")
				         (font . "-*-Courier New-normal-r-*-*-15-112-*-*-c-*-*-ansi-") ;; 11 pt
					     )))

  ;;; Set the default font and frame size for the initial frame.
	         (setq initial-frame-alist
		        '( (top . 0) (left . 0) (width . 82) (height . 32)
			       ;; (background-color . "Gray92")
			       (foreground-color . "Black")
			       (cursor-color . "red3")
			           )))
  )


; Known to work on Fedora Core 1 Linux, on an LCD monitor set to
; 1280x1024.

(if (system-is-charlesc)
    (progn (message "Setting X11 windowing 1280x1024")
	      (setq default-frame-alist
		     (append default-frame-alist
			      '((top . 190) (left . -20)
				   (width . 96) (height . 40)
				      (background-color . "Gray94")
				         (foreground-color . "Black")
					 (cursor-color . "red3")
					    (font . "-Adobe-Courier-Medium-R-Normal--14-140-75-75-*-*-ISO8859-1")
					       (user-position t)
					          )))

  ;;; Set the default font and frame size for the initial frame.
	         (setq initial-frame-alist
		        '((top . 200) (left . -15)
			     (width . 96) (height . 40)
			        (background-color . "Gray94")
				   (foreground-color . "Black")
				   (cursor-color. "red3")
				      (user-position t)
				         ))
		    )
  )

; Known to work on Fedora Core Linux 1.0, on a 17" monitor set to
; 800x600.

(if (system-is-issola)
    (progn (message "Setting X11 windowing 800x600")
	      (setq default-frame-alist
		     (append default-frame-alist
			      '((top . 10) (left . -20)
				   (width . 80) (height . 34)
				      (background-color . "Gray94")
				         (foreground-color . "Black")
					 (cursor-color . "red3")
					    (font . "-Adobe-Courier-Medium-R-Normal--14-140-75-75-*-*-ISO8859-1")
					       (user-position t)
					          )))

  ;;; Set the default font and frame size for the initial frame.
	         (setq initial-frame-alist
		        '((top . 10) (left . -15)
			     (width . 80) (height . 34)
			        (background-color . "Gray94")
				   (foreground-color . "Black")
				   (cursor-color. "red3")
				      (user-position t)
				         ))
		    )
  )

; Known to work on Red Hat Linux 5.0, on a 17" monitor set to
; 1024x768.

;(if (and (string-equal what-env "X11_windows")
;	  (not (system-is-charlesc))
;	   (not (system-is-issola)))
;    (progn (message "Setting X11 windowing 1024x768")
;	      (setq default-frame-alist
;		     (append default-frame-alist
;			      '((top . 30) (left . -20)
;				   (width . 96) (height . 40)
;				      (background-color . "Gray94")
;				         (foreground-color . "Black")
;					 (cursor-color . "red3")
;					    (font . "-Adobe-Courier-Medium-R-Normal--14-140-75-75-*-*-ISO8859-1")
;					       (user-position t)
;					          )))

  ;;; Set the default font and frame size for the initial frame.
;	         (setq initial-frame-alist
;		        '((top . 40) (left . -15)
;			     (width . 96) (height . 40)
;			        (background-color . "Gray94")
;				   (foreground-color . "Black")
;				   (cursor-color. "red3")
;				      (user-position t)
;				         ))
;		    )
;  )

;; Note: as you change these, if you have equivalent goodies as part
;; of your emacs command line options or X resources, you must change
;; those to agree, or comment them out. Otherwise, they will over-ride
;; these. The appropriate file for Red Hat Linux 5.x is your
;; .Xdefaults file and .fwvm2rc.init if you have either one. And
;; possibly others. Try also .xinitrc.  -- C^2


;;; Begin: cascade frames as new ones are opened.
;;; From: andy.ling@quantel.com
;(if (string-equal what-env "X11_windows")
;    (progn (require 'cl)
;	      (defvar top-step 15
;		     "The increment for top in default-frame-alist.")
;	         (defvar left-step 15
;		        "The increment for left in default-frame-alist.")
;		    (defvar max-top 140
;		           "The maximum increment for top in default-frame-alist.")
;		       (defvar max-left 550
;			      "The maximum increment for left in default-frame-alist.")
;		       ;(add-hook 'after-make-frame-hook
;					;(lambda ()
;		          (add-hook 'after-make-frame-functions
;				         (lambda (dummy)
;					          (let ((top (assq 'top default-frame-alist))
;							     (left (assq 'left default-frame-alist)))
;						     (if left
;							      (progn
;								       (incf (cdr left) left-step)
;								              (if (> (cdr left) max-left)
;										     (setf (cdr left) left-step)))
;						          (push (append '(left) left-step) default-frame-alist))
;						      (if top
;							       (progn
;								        (incf (cdr top) top-step)
;									       (if (> (cdr top) max-top)
;										      (setf (cdr top) top-step)))
;							   (push (append '(top) top-step) default-frame-alist)))))
;			     (message "Cascading frames loaded!")
;			        ))


;(if (string-equal what-env "Windows_NT")
;    (progn (require 'cl)
;	      (defvar top-step 15
;		     "The increment for top in default-frame-alist.")
;	         (defvar left-step -15
;		        "The increment for left in default-frame-alist.")
;		    (defvar max-top 140
;		           "The maximum increment for top in default-frame-alist.")
;		       (defvar max-left 550
;			      "The maximum increment for left in default-frame-alist.")
;		          (add-hook 'after-make-frame-hook
;				         (lambda ()
;					   ;  (add-hook 'after-make-frame-functions
;					;    (lambda (dummy)
;					          (let ((top (assq 'top default-frame-alist))
;							     (left (assq 'left default-frame-alist)))
;						     (if left
;							      (progn
;								       (incf (cdr left) left-step)
	;							              (if (> (cdr left) max-left)
;										     (setf (cdr left) left-step)))
;						          (push (append '(left) left-step) default-frame-alist))
;						      (if top
;							       (progn
;								        (incf (cdr top) top-step)
;									       (if (> (cdr top) max-top)
;										      (setf (cdr top) top-step)))
;							   (push (append '(top) top-step) default-frame-alist)))))
;			     (message "Cascading frames loaded!")
;			        ))
;;; End: cascade frames as new ones are opened.


;This command will call up the font dialog box and then insert at point
;the x-style name of the selected font. The font selection dialog box will
;pop up. Select the desired font, and the font name will appear
;immediately at point, complete with quotes, available for your cutting
;and pasting pleasure!

(if (eq window-system 'w32)
    (defun insert-x-style-font()
      "Insert a string in the X format which describes a font the user can select from the Windows font selector."
      (interactive)
      (insert (prin1-to-string (w32-select-font)))))

;; bind it to C-c C-f
;(if (memq window-system '(win32 w32)) ; Windows NT/95
;  (global-set-key "\C-c\C-f" 'insert-x-style-font))

;;;Insert following expression in the *scratch* buffer: Execute 'M-x
;;;eval-buffer' and this will list all available fonts. All fonts that
;;;have a letter 'm' or a 'c' in the fourth field from the right, are
;;;m(onospaced) c(haracter) fonts
;
;(insert (prin1-to-string (x-list-fonts "*")))

;; end of font goodies from Chris McMahan <cmcmahan@surefirev.com>


;; A lot of Microsoft files use c++ goodies, like c++ comments, in files
;; with the standard C extensions of .c and .h. So I'll change the mode
;; associated with them.
;; (setq auto-mode-alist (cons '("\.[ch]\\>" . c++-mode) auto-mode-alist))

;; and add .idl files to the list. There is an idl mode somewhere, but I
;; haven't bothered to get it yet.
;; (setq auto-mode-alist (cons '(".idl\\>" . c++-mode) auto-mode-alist))

;; and add .tlh & .tlb files to the list
;; (setq auto-mode-alist (cons '("\.tl[hbi]\\>" . c++-mode) auto-mode-alist))

;;; give elisp access to windows controls, then minimize it.
; (if (memq window-system '(win32 w32)) ; Windows NT/95
;    (progn
;      (load "emwinmsg")
;      (win32-minimize-frame)))


;;; generic extras loaded here.
;(require 'generic-extras)

;(if (not (or (system-is-jhereg)
;	          (system-is-issola)))
;    (require 'htmlize)
;  )

;; begin Cygnus Bash as shell setup. For NT & W95
(if (system-is-teckla-dos)
    (progn

      (setenv "PID" nil)
      (setq w32-quote-process-args ?\")
      (setq shell-command-switch "-c")
;      (setq shell-file-name "c:\\gnu\\Cygnus\\cygwin-b20\\H-i586-cygwin32\\bin\\bash")
      (setq shell-file-name "c:\\cygwin\\bin\\bash")
;      (setq explicit-shell-file-name "c:\\gnu\\Cygnus\\cygwin-b20\\H-i586-cygwin32\\bin\\bash")
      (setq explicit-shell-file-name "c:\\cygwin\\bin\\bash")
      (load "comint")
      (fset 'original-comint-exec-1 (symbol-function 'comint-exec-1))
      (defun comint-exec-1 (name buffer command switches)
	(let ((binary-process-input t)
	            (binary-process-output nil))
	    (original-comint-exec-1 name buffer command switches)))

     ;;; set the environment, from cygnus.bat. No cygnus.bat for 20.0,
     ;;; hurrah, hurrah! but we still need some of these variables.
;      (setenv "CYGROOT" "C:\\gnu\\cygnus\\cygwin-b20")
;      (setenv "CYGFS" "C:/gnu/Cygnus/cygwin-b20")
     ;; (setenv "CYGREL" "B19")
     ;; ones I haven't converted...
      ;;     SET GCC_EXEC_PREFIX=%CYGROOT%\H-i386-cygwin32\lib\gcc-lib     ;;     SET TCL_LIBRARY=%CYGROOT%\share\tcl8.0     ;;     SET GDBTK_LIBRARY=%CYGFS%/share/gdbtcl
;     (setenv "PATH" (concat(getenv "CYGROOT" ) "\\H-i586-cygwin32\\bin;"
					;   (getenv "PATH") ))

; moved to autoexec.bat
;      (setenv "PATH" (concat "c:\\cygwin\\usr\\local\\bin;c:\\cygwin\\usr\\bin;c:\\cygwin\\bin;"  (getenv "PATH")))

     ;; fix for shell script font-lock problem with BASH scripts. From
     ;; Nils Goesche <ngo@teles.de>
      (setq sh-shell-file "bash")
      ;; Add the capability to use cygwin pathology. It uses cygwin
      ;; code, so it only works if emacs is launched from bash, or if
      ;; cygwin stuff is otherwise in the path.
      (require 'cygwin-mount)
      (cygwin-mount-activate)

      ;; follow cygwin symlinks. Handles old-style (text file)
      ;; symlinks and new-style (.lnk file) symlinks. From Markus
      ;; Hoenicka (hoenicka_markus@compuserve.com)'s NT SGML setup
      ;; tutorial.
      (defun follow-cygwin-symlink ()
	(save-excursion
	    (goto-char 0)
	      (if (looking-at "L\x000\x000\x000\x001\x014\x002\x000\x000\x000\x000\x000\x0C0\x000\x000\x000\x000\x000\x000\x046\x00C")
		        (progn
			  (re-search-forward "\x000\([-A-Za-z0-9_\.\\\\\\$%@(){}~!#^'`][-A-Za-z0-9_\.\\\\\\$%@(){}~!#^'`]+\\)")
			  (find-alternate-file (match-string 1)))
		    (if (looking-at "!<symlink>")
			(progn
			    (re-search-forward "!<symlink>\(.*\\)\0")
			      (find-alternate-file (match-string 1))))
		        )))
      (add-hook 'find-file-hooks 'follow-cygwin-symlink)

      ;; use Unix-style line endings
      (setq-default buffer-file-coding-system 'undecided-unix)
     )
 )

;; no C-Ms in the shell window, please.
(if  (memq window-system '(win32 w32))
    (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t))
;; end Cygnus Bash as shell setup

;; Begin fix for W95/98.
;(if (and (> sams-Gnu-Emacs-p 19)
;	  (string-equal what-env "Windows_95"))
;    (setq process-coding-system-alist
;	    '(("cmdproxy" . (raw-text-dos . raw-text-dos)))))
;; End fix for W95/98.


;; Begin setup for printing on Win32. Note that setting both printers
;; to an HP Deskjet works only because the server is a Linux box, and
;; the printcap detects postscript and runs it through ghostscript
;; before printing it.
(if (system-is-teckla-dos)
    (progn (setq printer-name "//charlesc/lp")
	      (setq ps-printer-name "//charlesc/lp"))
;; End setup for printing on Win32


;; Begin setup for printing on computers running Linux. Note that
;; setting both printers to an HP Deskjet works only because the
;; server is a Red Hat Linux box, and the printcap detects postscript
;; and runs it through ghostscript before printing it.
    (progn (setq printer-name "lp")
	      (setq ps-printer-name "lp"))
  )
;; End setup for printing on Linux, Emacs 20.3.1

(column-number-mode t)

;; Always have minibuffer the appropriate size. Useful for long file
;; names, etc. Courtesy of "Dr Francis J. Wright" <F.J.Wright@qmw.ac.uk>
;(resize-minibuffer-mode)

;; Set dynamic abbreviations to case rude.
(setq dabbrev-case-fold-search nil)

;; add tool to strip trailing white space.
(require 'whitespace)

;; set type of sound for beep.
;(if (string-equal what-env "Windows_95")
;    (set-message-beep 'hand))


;; Begin completion mode.
;(load "completion")
;(partial-completion-mode t)
;; End completion mode.


;; Begin auto-revert, VC++
(autoload 'auto-revert-mode "autorevert" nil t)
(autoload 'turn-on-auto-revert-mode "autorevert" nil nil)
(autoload 'global-auto-revert-mode "autorevert" nil t)

;; Originally from Ray Rizzuto, as customized by me. "I'm using a hook
;; to turn on auto-revert in .c, .cpp, .h files:"

;; I abstracted out the indentation stuff so that I could use it with
;; c-comment-mode's c-comment-edit-hook. If I find I need other
;; variable to be common between C mode and C comment edit mode, I'll
;; move them to this function as well. C comment edit mode is
;; available from http://www.wonderworks.com/
(defun c-comment-setup-stuff ()
  "Set some indentation stuff for C mode and c-comment-mode. These are
hard coded for now. What I would really like to do is copy these (and
possibly other values) in from the source buffer. Or else do the final
indentation in the source buffer. C^2 2001 04 10"
;;;    (if (system-is-rbtshaw)
(setq tab-width 4); 
(setq indent-tabs-mode nil));

(setq c-comment-edit-hook 'c-comment-setup-stuff)

(defun rays_c_mode ()
  "ray's c/c++ mode hook"
  (message "Loading Ray's C mode...")
;;  (c-set-style "BSD")
;;  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-map "\C-m" 'newline-and-indent)
  (define-key c-mode-map [f11] 'complete-tag)
  ;;  (setq truncate-lines t)
  (setq c-tab-always-indent nil)
;;  (c-set-offset 'case-label '+)
;;  (c-set-offset 'inline-open '0)
;;  (c-set-offset 'arglist-close '0)
  (c-toggle-hungry-state 1)
  (font-lock-mode 1)
  (auto-revert-mode 1)
  (c-toggle-auto-state 1)
  (setq comment-multi-line t)
  ;; Also load c-comment-mode & related stuff. 2002 08 05 -- C^2
  (require 'c-comment-edit)
  (define-key c-mode-map [(control \;)] 'c-comment-edit)
  (c-comment-setup-stuff)
  (message "Loading Ray's C mode... Done")
  )
(add-hook 'c-mode-common-hook 'rays_c_mode)

;; Ray adds: "Emacs automatically reverts the file when I edit it in
;; DevStudio (remember to save it!) and then switch back to Emacs.  Emacs
;; doesn't prompt me - I don't know if there is a way to turn that on."

;;"I have DevStudio set to NOT prompt me for reloading of files modified
;;in Emacs.  Under Tools->Options, the Editor tab, I have "Automatic
;;reload of externally modified files" checked. "

;; End auto-revert, VC++



(if (memq window-system '(win32 w32)); Windows NT/95
    (progn

      ;; add w32-shellex. First we turn off having C-x f execute a file
      ;; while we are in dir-ed mode instead of visit it. Instead, M-x
      ;; shell-execute-file. It also turns off having j execute
      ;; w32-shellex-dired-on-objects.
      (setq w32-shellex-no-dired-hook t)
      (require 'w32-shellex)

      ;; NT Emacs on W95 has a problem leaving command.com or cmdproxy.exe
      ;; as a orphan process when Emacs is shut down. This fixes that
      ;; problem. It appears to be harmless on NT.
      (add-hook 'comint-exec-hook
		(function (lambda () (require 'msdos-shell-fix))))
      ))


;; now do what we need to do to add psgml mode in. First add the path,
;; then add psgml. We only do this on my desktop and laptop computers.
(if (or (system-is-charlesc)
	(system-is-teckla-linux); teckla running linux
	(system-is-teckla-dos)); teckla running w98
    (progn

      (fset 'psgml-insert-listitem-and-para
	        [?\C-c ?\C-e ?l ?i ?s ?t ?i ?t ?e ?m return ?\C-c ?\C-e ?p ?a ?r ?a return])

      (add-hook 'sgml-mode-hook
		'(lambda ()
		      (define-key sgml-mode-map "\C-cl" 'psgml-insert-listitem-and-para)))

      ;; Begin Windows Teckla Specific Goodies.
      (if (system-is-teckla-dos)
	    ;; Begin Marcus Hoenicka's Customizations
	    (progn
	          (setq load-path (cons "c:/cygwin/usr/share/emacs-21.2/site-lisp/psgml" load-path ))
		      (setq sgml-validate-command "/usr/local/bin/onsgmls -s %s %s")

		          ;; Start DTD mode for editing SGML-DTDs
		          (autoload 'dtd-mode "tdtd" "Major mode for SGML and XML DTDs.")
			      (autoload 'dtd-etags "tdtd"
				      "Execute etags on FILESPEC and match on DTD-specific regular expressions."
				            t)
			          (autoload 'dtd-grep "tdtd" "Grep for PATTERN in files matching FILESPEC." t)

				      ;; Turn on font lock when in DTD mode
				      (add-hook 'dtd-mode-hooks
						      'turn-on-font-lock)

				          (setq auto-mode-alist
						  (append
						      (list
						           '("\.dcl$" . dtd-mode)
							       '("\.dec$" . dtd-mode)
							           '("\.dtd$" . dtd-mode)
								       '("\.ele$" . dtd-mode)
								           '("\.ent$" . dtd-mode)
									       '("\.mod$" . dtd-mode))
						         auto-mode-alist))

					      ;; the regexp for NTEmacs etags
					      (setq dtd-etags-regex-option
						      "--regex=\'/<!\(ELEMENT\\|ENTITY[ \\t]+%\\|NOTATION\\|ATTLIST\\)[ \\t]+\([^ \\t]+\\)/\\2/\'")

					          ;; we need the NTEmacs etags, not the cygwin etags
					          (setq dtd-etags-program "/usr/share/emacs-21.2/bin/etags.exe")

						      ;; load psgml-jade extension
						      (setq
						            sgml-command-list
							         (list
								        (list "Jade" "/usr/local/bin/openjade -c%catalogs -t%backend -d%stylesheet %file"
									          'sgml-run-command t
										      '(("jade:\(.*\\):\(.*\\):\(.*\\):E:" 1 2 3)))
									      (list "JadeTeX" "jadetex %tex"
										        'sgml-run-command nil)
									            (list "JadeTeX PDF" "pdfjadetex %tex"
											      'sgml-run-command t)
										          (list "dvips" "dvips -o %ps %dvi"
												    'sgml-run-command nil)
											        (list "View dvi" "windvi %dvi"
												          'sgml-run-background t)
												      (list "View PDF" "gsview32 %pdf"
													        'sgml-run-command nil)
												            (list "View ps" "gsview32 %ps"
														      'sgml-run-command nil))
								      )

						          (setq sgml-sgml-file-extension "sgml")

							      (setq sgml-dsssl-file-extension "dsl")

							          (setq sgml-expand-list
									  (list
									      (list "%file" 'file nil) ; the current file as is
									         (list "%sgml" 'file sgml-sgml-file-extension) ;   with given extension
										    (list "%tex" 'file "tex") ;   dito
										       (list "%dvi" 'file "dvi") ;   dito
										          (list "%pdf" 'file "pdf") ;   dito
											     (list "%ps" 'file "ps") ;   dito
											        (list "%dsssl" 'file sgml-dsssl-file-extension) ;   dito
												   (list "%dir" 'file nil t) ; the directory part
												      (list "%stylesheet" 'sgml-dsssl-spec) ; the specified style sheet
												      (list "%backend" 'sgml-jade-backend); the selected backend
												         (list "%catalogs" 'sgml-dsssl-catalogs 'sgml-catalog-files 'sgml-local-catalogs)
													 ; the catalogs listed in sgml-catalog-files and sgml-local-catalogs.
													    )
									    )

								      (setq sgml-shell "sh")
								          (setq sgml-shell-flag "-c")

									      (add-hook 'sgml-mode-hook '(lambda () (require 'psgml-jade)))

									          ;; load dsssl support
									          (autoload 'sgml-dsssl-make-spec "psgml-dsssl" nil t)

										      ;; add TeX-support
										      (load "tex-site")
										          (custom-set-variables
											        '(TeX-expand-list (quote (("%p" TeX-printer-query)
															         ("%q" (lambda nil (TeX-printer-query TeX-queue-command 2)))
																        ("%v" TeX-style-check (("^a5$" "windvi %d -paper a5")
																			             ("^landscape$" "windvi %d -paper a4r -s 4") ("." "windvi %d")))
																	       ("%l" TeX-style-check (("." "latex"))) ("%s" file nil t) ("%t" file t t)
																	              ("%n" TeX-current-line) ("%d" file "dvi" t) ("%f" file "ps" t)
																		             ("%a" file "pdf" t)))))
											      ;; End Marcus Hoenicka's Customizations
											      )
	)
      ;; End Windows Teckla Specific Goodies.

      ;; Begin Marcus Hoenicka's Customizations

      ;; PSGML menus for creating new documents
      (setq sgml-custom-dtd
	        '(
		        ( "HTML 2.0"
			  "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">")
			      ( "HTML 2.0 Strict"
				"<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0 Strict//EN\">")
			            ( "HTML 2.0 Level 1"
				      "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0 Strict Level 1//EN\">")
				          ( "HTML 3.2 Final"
					    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">")
					        ( "HTML 4"
						  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\">")
						      ( "HTML 4 Frameset"
							"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Frameset//EN\">")
						            ( "HTML 4 Transitional"
							      "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">")
							          ( "DocBook 4.1"
								    "<!DOCTYPE Book PUBLIC \"-//OASIS//DTD DocBook V4.1//EN\"\n  \"/usr/share/sgml/docbook/sgml-dtd-4.2/docbook.dtd\">\n\n"
								    "/etc/sgml/sgml-docbook-4.1.ced")
								        ( "DocBook XML 4.1.2"
									  "<!DOCTYPE book PUBLIC \"-//OASIS//DTD DocBook XML V4.1.2//EN\"\n  \"/usr/share/sgml/docbook/xml-dtd-4.1.2/docbookx.dtd\">\n\n"
									  "/etc/sgml/xml-docbook-4.1.2.ced")
									      ;; http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd\"
									      ( "DocBook 4.2 XML"
										"<!DOCTYPE article PUBLIC \"-//OASIS//DTD DocBook XML V4.2//EN\"\n  \"/usr/share/sgml/docbook/xml-dtd-4.2/docbookx.dtd\">\n\n"
										"/etc/sgml/xml-docbook-4.2.ced")
									            )
		    )

      ;; ecat support
      (if (system-is-teckla-dos)
	    (setq sgml-ecat-files
		  (list
		    (expand-file-name "c:/cygwin/usr/local/lib/sgml/dtd/html/ecatalog")
		     (expand-file-name "c:/cygwin/usr/local/lib/sgml/dtd/docbook41/ecatalog")
		      (expand-file-name "c:/cygwin/usr/local/lib/xml/dtd/docbookx412/ecatalog")
		       (expand-file-name "c:/docbook/dtd/ecatalog")
		        ))
	(setq sgml-ecat-files
	            (list
		            (expand-file-name "/etc/sgml/ecatalog")
			           ))
	)

    ;; Set default HTML DTD to use. This gets used for validating the
    ;; document. I'd rather leave it to the default.
;;       (if (system-is-teckla-dos)
      ;;   (setq sgml-declaration "Fix/me/up/later")
      ;; (setq sgml-declaration "/usr/share/sgml/html/HTML4.dcl")
      ;; )

;;       (if (system-is-teckla-dos)
      ;;     (setq sgml-declaration "c:\\cygwin\\usr\\local\\lib\\sgml\\dtd\\docbook41\\docbook.dcl")
      ;;   (setq sgml-declaration "Fix/Me/Up/Later")
      ;; )

      ;; End Marcus Hoenicka's Customizations


      (autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t )
      (autoload 'xml-mode "psgml" "Major mode to edit XML files." t)

      (setq auto-mode-alist
	        (append
		      (list
		             '("\.sgm$" . sgml-mode)
			           '("\.sgml$" . sgml-mode)
				   ;;       '("\.htm$" . sgml-mode)
				   ;;       '("\.html$" . sgml-mode)
				         )
		           auto-mode-alist))

;;       (if (system-is-teckla-dos)
      ;;   (setq auto-mode-alist
      ;; (append
      ;;  (list
      ;;   '("\.htm$" . sgml-mode)
      ;;   '("\.html$" . sgml-mode)
      ;;   )
      ;;  auto-mode-alist))
      ;; )

      ;; set some psgml variables

      (setq sgml-auto-activate-dtd t)
      (setq sgml-omittag-transparent t)
      (setq sgml-balanced-tag-edit t)
      (setq sgml-auto-insert-required-elements t)
      (setq sgml-live-element-indicator t)
      (setq sgml-indent-step 2)
      (setq sgml-auto-insert-required-elements nil)

      ;; create faces to assign to markup categories

      (make-face 'sgml-comment-face)
      (make-face 'sgml-start-tag-face)
      (make-face 'sgml-end-tag-face)
      (make-face 'sgml-entity-face)
      (make-face 'sgml-doctype-face); DOCTYPE data
      (make-face 'sgml-ignored-face); data ignored by PSGML
      (make-face 'sgml-ms-start-face); marked sections start
      (make-face 'sgml-ms-end-face); end of marked section
      (make-face 'sgml-pi-face); processing instructions
      (make-face 'sgml-sgml-face); the SGML declaration
      (make-face 'sgml-shortref-face); short references

      ;; load xml-mode
      (setq auto-mode-alist
	        (append (list (cons "\.xml\\'" 'xml-mode)) auto-mode-alist))
      (autoload 'xml-mode "psgml" nil t)
      (if (system-is-teckla-dos)
	    (setq sgml-xml-declaration "c:/cygwin/usr/local/lib/sgml/dtd/html/xml.dcl")
	  (setq sgml-xml-declaration "/usr/share/sgml/xml.dcl")
	  )

      ;; view a list of available colors with the emacs-lisp command:
      ;;
      ;; list-colors-display
      ;;
      ;; please assign your own groovy colors, because these are pretty bad
      (set-face-foreground 'sgml-comment-face "coral")
      ;(set-face-background 'sgml-comment-face "cornflowerblue")
      (set-face-foreground 'sgml-start-tag-face "slateblue")
      ;(set-face-background 'sgml-start-tag-face "cornflowerblue")
      (set-face-foreground 'sgml-end-tag-face "slateblue")
      ;(set-face-background 'sgml-end-tag-face "cornflowerblue")
      (set-face-foreground 'sgml-entity-face "limegreen")
      ;(set-face-background 'sgml-entity-face "cornflowerblue")
      (set-face-foreground 'sgml-doctype-face "limegreen")
      ;(set-face-background 'sgml-doctype-face "cornflowerblue")
      (set-face-foreground 'sgml-ignored-face "cornflowerblue")
      ;(set-face-background 'sgml-ignored-face "cornflowerblue")
      (set-face-foreground 'sgml-ms-start-face "coral")
      ;(set-face-background 'sgml-ms-start-face "cornflowerblue")
      (set-face-foreground 'sgml-ms-end-face "coral")
      ;(set-face-background 'sgml-ms-end-face "cornflowerblue")
      (set-face-foreground 'sgml-pi-face "coral")
      ;(set-face-background 'sgml-pi-face "cornflowerblue")
      (set-face-foreground 'sgml-sgml-face "coral")
      ;(set-face-background 'sgml-sgml-face "cornflowerblue")
      (set-face-foreground 'sgml-shortref-face "coral")
      ;(set-face-background 'sgml-shortref-face "cornflowerblue")

      ;; assign faces to markup categories

      (setq sgml-markup-faces '
	        (
		      (comment . sgml-comment-face)
		           (start-tag . sgml-start-tag-face)
			        (end-tag . sgml-end-tag-face)
				     (entity . sgml-entity-face)
				          (doctype . sgml-doctype-face)
					       (ignored . sgml-ignored-face)
					            (ms-start . sgml-ms-start-face)
						         (ms-end . sgml-ms-end-face)
							      (pi . sgml-pi-face)
							           (sgml . sgml-sgml-face)
								        (shortref . sgml-shortref-face)
									     ))

      ;; tell PSGML to pay attention to face settings
      (setq sgml-set-face t)

      (add-hook 'sgml-mode-hook
		(lambda ()
		    (unless (or (file-exists-p "makefile")
				      (file-exists-p "Makefile"))
		          (set (make-local-variable 'compile-command)
			        (concat "./build "
					 (file-name-sans-extension buffer-file-name))))))


      ;; Begin setup for xslide
      ;; XSL mode
      (autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)

      ;; Turn on font lock when in XSL mode
      (add-hook 'xsl-mode-hook
		'turn-on-font-lock)

;; There seems to be a collision between one of these and ".htm". If
;; this is after the definition for html-helper-mode, .htm files end
;; up here. So I've commented them out.

;;       (setq auto-mode-alist
      ;;     (append
      ;;      (list
      ;;       '("\.fo" . xsl-mode)
      ;;       '("\.xsl" . xsl-mode))
      ;;      auto-mode-alist))

      ;; Uncomment if using abbreviations
      ;; (abbrev-mode t)
      ;; End setup for xslide

      ;; ...done setting up psgml-mode.
      ;; *******************************************************************
      ))

;; from Dave Pearson:
(defalias 'muttrc-mode 'sh-mode)

;; Coriolis minor mode:
;; (autoload 'coriolis-mode "coriolis" "Coriolis minor mode" t)

;; kill-mailto. This is useful for email. If I get an email address from a
;; web page, it is likely to be a "mailto:" url. This function cleans up
;; all instances of such an email address in the current buffer.
(defun kill-mailto ()
  "Kill off \"mailto:\" portion of an email address imported from a web
browser via the \"copy link location\" function."
  (interactive)
  (progn
    (save-excursion
      (save-restriction
	(save-match-data
	    (widen)
	      (goto-char (point-min))
	        (while (search-forward "mailto:" nil t)
		      (replace-match "")
		          (delete-horizontal-space)
			      (insert " "))
		  )))))


;; Setup to use mail mode on files from mutt. From Walt Mankowski,
;; waltman@pobox.com.
;(if (not (string-equal what-env "Windows_95"));

;    (progn
;    ;; from Dave Pearson:
;    (defalias 'muttrc-mode 'sh-mode)

    ;; Automatically go into mail-mode if filename starts with /tmp/mutt
;    (setq auto-mode-alist (append (list (cons "^\/tmp\/mutt" 'mail-mode))
;				    auto-mode-alist))

;  (defun my-mail-mode-hook ()
;    (auto-fill-mode 1)
;    )
;  (add-hook 'mail-mode-hook 'my-mail-mode-hook)
;  )
;)
;; End setup to use mail mode on files from mutt.


;; build and ship a quick reply to sircam virus mail.
(fset 'sircam-reply
   [C-down C-down C-down C-down down ?\C-x ?i ?/ ?~ ?/ ?s ?i ?r ?c ?a ?m ?. ?t ?x ?t return next ?\C-x ?\C-s ?\C-x ?#])



;; Begin tramp initialization, but skip if 1) we're on teckla running
;; W95 or 2) we're on jhereg or issola.
(if (and (not (system-is-teckla-dos))
	  (not (system-is-jhereg))
	   (not (system-is-issola)))
    (progn
;;       (setq tramp-default-method "sm")
;;    (add-to-list 'load-path "/usr/share/emacs/site-lisp/tramp/lisp/")
;;       (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/tramp/lisp")
      (require 'tramp)
      )
  )
;; End tramp initialization

;; Begin tidy initialization
;; (autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
;; (autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
;; (autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
;; (autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)
;; End tidy initialization

;; make point more likely to return to where it had been after several
;; scroll operation.
(setq scroll-preserve-screen-position t)

;; autoload html checker tool.
;; (message "Loading Weblint...")
;; (autoload 'weblint "weblint" "Weblint syntax checker" t)
;; (message "Loading Weblint... done.")

;; recentf maintains a list of recently opened files.
(require 'recentf)
(recentf-mode 1)

;; smbconf mode to edit samba config files.
(autoload 'smb-mode "smb-mode" "SMB Major Mode" t)
(setq auto-mode-alist
      (cons '("smb\.conf$" . smb-mode) auto-mode-alist))


(setq time-stamp-line-limit 16)

; Begin: a program to add "spook" to the end of email

(defun add-spook ()
  (interactive)
  (save-excursion        ; Ensure that the point doesn't move.
    (insert "-- \n")     ; The extra space is required for signatures.
    (spook)))

; end: a program to add "spook" to the end of email


(defun new-splat ()
  (interactive)
  "Written for the Wyoming Writers web page. After inserting a new item in a list, this adds the date it was added as a comment (so you can search on it), and then adds the \"new\" splat to the new line."
  (progn
    (save-excursion
    (beginning-of-line)
    (insert "<!-- " )
    (insert-date)
    (insert " -->\n")
    (save-match-data
      (search-forward "<li>" nil t))
    (insert "<img src=\"Aart/new3.gif\"  alt=\"New!\" height=\"46\" width=\"75\" align=\"bottom\">")
    )))

; (add-hook 'mail-setup-hook 'my-mail-signature-maker)


;; A function to insert a text cross reference at point.
(defun xref ()
  "Insert at point the cross reference note \" ((Page X\)\)\". Note the leading space."
  (interactive "*")
  (insert " ((Page X\)\)");insert the bare bones.
  )


(defun initial ()
  (interactive)
  "Insert my initials as needed at point."
  (insert " -- C^2"))

(global-set-key [f12] 'initial)

;; globrep, to do global search and replace on a number of files.
(setq grep-command "grep -i -n ")
(autoload 'global-replace-lines "globrep"
  "Put back grepped lines" t)
(autoload 'global-replace "globrep"
  "query-replace across files" t)
(autoload 'global-grep-and-replace "globrep"
  "grep and query-replace across files" t)


;; Allow us to extract Blue Wave archive files automatically.
;; (setq auto-mode-alist (cons '("lvractn\." . archive-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("chatshop\." . archive-mode) auto-mode-alist))

;; Now set up to hack OpenOffice.org documents.
(setq auto-mode-alist (cons '("\.sx.$" . archive-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\.sxc$" . archive-mode) auto-mode-alist))

;; mutt-* files, from Rebecca Lynne Sutton <rsutton@emory.edu>, except
;; I don't want them.
;; (if (not (string-equal what-env "Windows_95"))
;;     (setq auto-mode-alist (cons '("mutt-" . text-mode) auto-mode-alist))
;;   (setq auto-mode-alist (cons '("mutt-" . auto-fill-mode) auto-mode-alist))
;;   )

;; Begin Desktop stuff

;; Desktop.el says, "To use this, first put these three lines in the
;; bottom of your .emacs file (the later the better)", so we keep this
;; stuff at the bottom.

(load "desktop")
(desktop-load-default)
(desktop-read)

(add-hook 'kill-emacs-hook
	    '(lambda ()
	            (desktop-truncate search-ring 3)
		         (desktop-truncate regexp-search-ring 3)))

;; End Desktop stuff

;; Calendar stuff:
;(if (not (or (system-is-issola)
;	          (system-is-jhereg)))
;    (progn
      ;; set my home co-ordinates for sunrise/sunset calculations
      ;(setq calendar-latitude 43.6)
      ;(setq calendar-longitude -108.2)
      ;(setq calendar-location-name "Thermopolis, Wyo")
      ;(calendar)       ; fire up the calendar display.
      ;(setq cal-tex-diary t)
      ;(setq cal-tex-rules t)
      ;(mark-calendar-holidays)
      ;(mark-diary-entries)
      ;; (other-window 1)   ; Now switch to the main window on this frame.

      ;; Add the appointment generator to the diary hook. Then set a vector for
      ;; the number of days in advance to show appointments. Then turn the diary
      ;; mode on.
      ;(setq number-of-diary-entries [2 3 3 3 3 5 2])
      ;(add-hook 'diary-hook 'appt-make-list)
      ;(add-hook 'diary-display-hook 'fancy-diary-display)
      ;; If this is non-nil, Emacs rings the terminal bell for appointment
      ;; reminders. The default is t.
      ;; (setq appt-audible nil)
      ;(diary)
;      )
;  )
;; end calendar/diary stuff


;; End Charles Curley's .emacs

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)


