;;; iso-transl.el --- keyboard input definitions for ISO 8859-1  -*- coding: iso-8859-1 -*-

;; Copyright (C) 1987, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2001
;;   2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012  Free Software Foundation, Inc.

;; Author: Howard Gayle
;; Maintainer: FSF
;; Keywords: i18n

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Loading this package defines three ways of entering the non-ASCII
;; printable characters with codes above 127: the prefix C-x 8, and,
;; with `iso-transl-mode' enabled, also the Alt key, and a dead accent
;; key.  For example, you can enter uppercase A-umlaut as `C-x 8 " A'
;; or, if `iso-transl-mode' is enabled, `Alt-" A' (if you have an Alt
;; key) or `umlaut A' (if you have an umlaut/diaeresis key).

;; C-x 8 is set up to autoload this package, but Alt keys and dead
;; accent keys are only defined once you have loaded the package and
;; enabled `iso-transl-mode'.  It is nontrivial to make all of the Alt
;; keys autoload, and it is not clear that the dead accent keys SHOULD
;; autoload this package.

;; Note that C-h b will autoload this package, which is one reason
;; why the more destructive key sequences (without C-x 8 prefix) are
;; only defined in `iso-transl-mode', and are thus reversible.

;;; Code:

;;; Provide some binding for startup:
;;;###autoload (or key-translation-map (setq key-translation-map (make-sparse-keymap)))
;;;###autoload (define-key key-translation-map "\C-x8" 'iso-transl-ctl-x-8-map)
;;;###autoload (autoload 'iso-transl-ctl-x-8-map "iso-transl" "Keymap for C-x 8 prefix." t 'keymap)

(defvar iso-transl-dead-key-alist
  '((?\' . mute-acute)
    (?\` . mute-grave)
    (?\" . mute-diaeresis)
    (?^ . mute-asciicircum)
    (?\~ . mute-asciitilde)
    (?\' . dead-acute)
    (?\` . dead-grave)
    (?\" . dead-diaeresis)
    (?^ . dead-asciicircum)
    (?\~ . dead-asciitilde)
    (?^ . dead-circum)
    (?^ . dead-circumflex)
    (?\~ . dead-tilde)
    ;; Someone reports that these keys don't work if shifted.
    ;; This might fix it--no word yet.
    (?\' . S-dead-acute)
    (?\` . S-dead-grave)
    (?\" . S-dead-diaeresis)
    (?^ . S-dead-asciicircum)
    (?\~ . S-dead-asciitilde)
    (?^ . S-dead-circum)
    (?^ . S-dead-circumflex)
    (?\~ . S-dead-tilde))
  "Mapping of ASCII characters to their corresponding dead-key symbols.")

;; The two-character mnemonics are intended to be available in all languages.
;; The ones beginning with `*' have one-character synonyms, but a
;; language-specific table might override the short form for its own use.

(defvar iso-transl-char-map
  '(("* "   . [?�])
    (" "    . [?�])
    ("*!"   . [?�])
    ("!"    . [?�])
    ("\"\"" . [?�])
    ("\"A"  . [?�])
    ("\"E"  . [?�])
    ("\"I"  . [?�])
    ("\"O"  . [?�])
    ("\"U"  . [?�])
    ("\"a"  . [?�])
    ("\"e"  . [?�])
    ("\"i"  . [?�])
    ("\"o"  . [?�])
    ("\"s"  . [?�])
    ("\"u"  . [?�])
    ("\"y"  . [?�])
    ("''"   . [?�])
    ("'A"   . [?�])
    ("'E"   . [?�])
    ("'I"   . [?�])
    ("'O"   . [?�])
    ("'U"   . [?�])
    ("'Y"   . [?�])
    ("'a"   . [?�])
    ("'e"   . [?�])
    ("'i"   . [?�])
    ("'o"   . [?�])
    ("'u"   . [?�])
    ("'y"   . [?�])
    ("*$"   . [?�])
    ("$"    . [?�])
    ("*+"   . [?�])
    ("+"    . [?�])
    (",,"   . [?�])
    (",C"   . [?�])
    (",c"   . [?�])
    ("*-"   . [?�])
    ("-"    . [?�])
    ("*."   . [?�])
    ("."    . [?�])
    ("//"   . [?�])
    ("/A"   . [?�])
    ("/E"   . [?�])
    ("/O"   . [?�])
    ("/a"   . [?�])
    ("/e"   . [?�])
    ("/o"   . [?�])
    ("1/2"  . [?�])
    ("1/4"  . [?�])
    ("3/4"  . [?�])
    ("*<"   . [?�])
    ("<"    . [?�])
    ("*="   . [?�])
    ("="    . [?�])
    ("*>"   . [?�])
    (">"    . [?�])
    ("*?"   . [?�])
    ("?"    . [?�])
    ("*C"   . [?�])
    ("C"    . [?�])
    ("*L"   . [?�])
    ("L"    . [?�])
    ("*P"   . [?�])
    ("P"    . [?�])
    ("*R"   . [?�])
    ("R"    . [?�])
    ("*S"   . [?�])
    ("S"    . [?�])
    ("*Y"   . [?�])
    ("Y"    . [?�])
    ("^1"   . [?�])
    ("^2"   . [?�])
    ("^3"   . [?�])
    ("^A"   . [?�])
    ("^E"   . [?�])
    ("^I"   . [?�])
    ("^O"   . [?�])
    ("^U"   . [?�])
    ("^a"   . [?�])
    ("^e"   . [?�])
    ("^i"   . [?�])
    ("^o"   . [?�])
    ("^u"   . [?�])
    ("_a"   . [?�])
    ("_o"   . [?�])
    ("`A"   . [?�])
    ("`E"   . [?�])
    ("`I"   . [?�])
    ("`O"   . [?�])
    ("`U"   . [?�])
    ("`a"   . [?�])
    ("`e"   . [?�])
    ("`i"   . [?�])
    ("`o"   . [?�])
    ("`u"   . [?�])
    ("*c"   . [?�])
    ("c"    . [?�])
    ("*o"   . [?�])
    ("o"    . [?�])
    ("*u"   . [?�])
    ("u"    . [?�])
    ("*m"   . [?�])
    ("m"    . [?�])
    ("*x"   . [?�])
    ("x"    . [?�])
    ("*|"   . [?�])
    ("|"    . [?�])
    ("~A"   . [?�])
    ("~D"   . [?�])
    ("~N"   . [?�])
    ("~O"   . [?�])
    ("~T"   . [?�])
    ("~a"   . [?�])
    ("~d"   . [?�])
    ("~n"   . [?�])
    ("~o"   . [?�])
    ("~t"   . [?�])
    ("~~"   . [?�])
    ("' "   . "'")
    ("` "   . "`")
    ("\" "  . "\"")
    ("^ "   . "^")
    ("~ "   . "~"))
  "Alist of character translations for entering ISO characters.
Each element has the form (STRING . VECTOR).
The sequence STRING of ASCII chars translates into the
sequence VECTOR.  (VECTOR is normally one character long.)")

;; Language-specific translation lists.
(defvar iso-transl-language-alist
  '(("Esperanto"
     ("C"  . [?�])
     ("G"  . [?�])
     ("H"  . [?�])
     ("J"  . [?�])
     ("S"  . [?�])
     ("U"  . [?�])
     ("c"  . [?�])
     ("g"  . [?�])
     ("h"  . [?�])
     ("j"  . [?�])
     ("s"  . [?�])
     ("u"  . [?�]))
    ("French"
     ("C"  . [?�])
     ("c"  . [?�]))
    ("German"
     ("A"  . [?�])
     ("O"  . [?�])
     ("U"  . [?�])
     ("a"  . [?�])
     ("o"  . [?�])
     ("s"  . [?�])
     ("u"  . [?�]))
    ("Portuguese"
     ("C"  . [?�])
     ("c"  . [?�]))
    ("Spanish"
     ("!"  . [?�])
     ("?"  . [?�])
     ("N"  . [?�])
     ("n"  . [?�]))))

(defvar iso-transl-ctl-x-8-map nil
  "Keymap for C-x 8 prefix.")
(or iso-transl-ctl-x-8-map
    (fset 'iso-transl-ctl-x-8-map
	  (setq iso-transl-ctl-x-8-map (make-sparse-keymap))))
(put 'iso-transl-ctl-x-8-map 'iso-transl-backup nil)
(or key-translation-map
    (setq key-translation-map (make-sparse-keymap)))
(define-key key-translation-map "\C-x8" iso-transl-ctl-x-8-map)
(put 'key-translation-map 'iso-transl-backup nil)

(defmacro iso-transl-define-key (keymap key def)
  "Back up definition of KEY in KEYMAP, then `define-key'."
  `(progn
     (put ',keymap 'iso-transl-backup
	  (cons (cons ,key (or (lookup-key ,keymap ,key) 'none))
		(get ',keymap 'iso-transl-backup)))
     ;; can't use push, since `cl' is not available during compilation
     ;; (push (cons ,key (or (lookup-key ,keymap ,key) 'none))
     ;; 	   (get ',keymap 'iso-transl-backup))
     (define-key ,keymap ,key ,def)))

;; For each entry in the alist, we'll make up to three ways to generate
;; the character in question: the prefix `C-x 8'; the ALT modifier on
;; the first key of the sequence; and (if applicable) replacing the first
;; key of the sequence with the corresponding dead key.  For example, a
;; character associated with the string "~n" can be input with `C-x 8 ~ n'
;; or `Alt-~ n' or `mute-asciitilde n'.
(defun iso-transl-define-prefix-keys (alist)
  (while alist
    (let ((translated-vec (cdr (car alist))))
      (iso-transl-define-key iso-transl-ctl-x-8-map (car (car alist)) translated-vec))
    (setq alist (cdr alist))))
(defun iso-transl-define-keys (alist)
  (while alist
    (let ((translated-vec (cdr (car alist))))
      ;(iso-transl-define-key iso-transl-ctl-x-8-map (car (car alist)) translated-vec)
      (let ((inchar (aref (car (car alist)) 0))
	    (vec (vconcat (car (car alist))))
	    (tail iso-transl-dead-key-alist))
	(aset vec 0 (logior (aref vec 0) ?\A-\^@))
	(iso-transl-define-key key-translation-map vec translated-vec)
	(iso-transl-define-key isearch-mode-map (vector (aref vec 0)) nil)
	(while tail
	  (if (eq (car (car tail)) inchar)
	      (let ((deadvec (copy-sequence vec))
		    (deadkey (cdr (car tail))))
		(aset deadvec 0 deadkey)
		(iso-transl-define-key isearch-mode-map (vector deadkey) nil)
		(iso-transl-define-key key-translation-map deadvec translated-vec)))
	  (setq tail (cdr tail)))))
    (setq alist (cdr alist))))

(defun iso-transl-set-language (lang)
  (interactive (list (let ((completion-ignore-case t))
		       (completing-read "Set which language? "
					iso-transl-language-alist nil t))))
  (iso-transl-define-keys (cdr (assoc lang iso-transl-language-alist))))


;; unconditional definitions
(iso-transl-define-prefix-keys iso-transl-char-map)
(define-key isearch-mode-map "\C-x" nil)
(define-key isearch-mode-map [?\C-x t] 'isearch-other-control-char)
(define-key isearch-mode-map "\C-x8" nil)

(define-minor-mode iso-transl-mode
 "ISO Key translation mode.
This mode defines two ways of entering the non-ASCII printable
characters with codes above 127: the Alt key and 
a dead accent key.  For example, you can enter uppercase A-umlaut as
`Alt-\" A' (if you have an Alt key) or `umlaut A' (if
you have an umlaut/diaeresis key).

This character can always be entered as `C-x 8 \" A' regardless of
this mode."
 :group 'i18n
 :lighter " ISO"

 (if iso-transl-mode
     ;; The standard mapping comes automatically.  You can partially overlay it
     ;; with a language-specific mapping by using `M-x iso-transl-set-language'.
     (iso-transl-define-keys iso-transl-char-map)
   (mapc
    (lambda (key-def) 
      (define-key key-translation-map (car key-def) 
	(and (not (eq (cdr key-def) 'none)) (cdr key-def))))
    (nreverse (get 'key-translation-map 'iso-transl-backup)))
   (put 'key-translation-map 'iso-transl-backup nil)
   (mapc
    (lambda (key-def) 
      (condition-case nil
	  (define-key isearch-mode-map (car key-def) 
	    (and (not (eq (cdr key-def) 'none)) (cdr key-def)))
	;; if some of the unconditional definitions above are instead made conditional
	;; restoring the default keys fails.
	(error nil)))
    (nreverse (get 'isearch-mode-map 'iso-transl-backup)))
   (put 'isearch-mode-map 'iso-transl-backup nil)))

(provide 'iso-transl)

;; arch-tag: 034cfedf-7ebd-461d-bcd0-5c79e6dc0b61
;;; iso-transl.el ends here
