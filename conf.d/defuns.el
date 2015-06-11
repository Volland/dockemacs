; ==================================== Date ===================================

(defun insert-date ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

;; ==================================== Copy ===================================

(defun copy-region-to-cut-buffer (beg end)
  (interactive "r")
    (call-process-region beg end "parcellite"))

(defun quick-copy-line ()
        "Copy the whole line that point is on and
move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
        (interactive)
        (let ((beg (line-beginning-position 1))
              (end (line-beginning-position 2)))
          (if (eq last-command 'quick-copy-line)
              (kill-append (buffer-substring beg end) (< end beg))
            (kill-new (buffer-substring beg end))))
        (beginning-of-line 2))

;; ==================================== Cut ====================================

(defun quick-cut-line ()
  "Cut the whole line that point is on.
Consecutive calls to this command append each line to the kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
        (end (line-beginning-position 2)))
    (if (eq last-command 'quick-cut-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end)))
    (delete-region beg end))
  (beginning-of-line 1)
  (setq this-command 'quick-cut-line))

(defun copy-to-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "echo $1 | parcellite")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

;; ========================= To be continued... ================================
