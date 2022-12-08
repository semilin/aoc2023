(ql:quickload :ut)
(in-package :ut)

;; not 1616
;; not 1155
(defun run ()
  (let* ((lines (uiop:read-file-lines "input"))
	 
	 (grid (iter (for line in lines)
		 (collect (mapcar (lambda (it)
				    (parse-integer (coerce (list it) 'string)))
				  (coerce line 'list)))))
	 (visible 0))
    (iter (for y from 1 to (- (length grid) 2))
      (iter (for x from 1 to (- (length (car grid)) 2))
	(let ((current (nth x (nth y grid))))
	  (if (or (not (remove-if (lambda (it) (eq t it)) ;; left
				  (mapcar (lambda (it) (< it current))
					  (picl:take x (picl:make-iterator (nth y grid))))))
		  (not (remove-if (lambda (it) (eq t it)) ;; right
				  (mapcar (lambda (it) (< it current))
					  (picl:take (- (length (car grid)) x 1)
						     (picl:make-iterator (reverse (nth y grid)))))))
		  (not (remove-if (lambda (it) (eq t it)) ;; up
				  (mapcar (lambda (it) (< it current))
					  (picl:take y
						     (picl:make-iterator (mapcar (lambda (row)
										   (nth x row))
										 grid))))))
		  (not (remove-if (lambda (it) (eq t it)) ;; down
				  (mapcar (lambda (it) (< it current))
					  (picl:take (- (length grid) y 1)
						     (picl:make-iterator (reverse (mapcar (lambda (row)
											    (nth x row))
											  grid))))))))
	      (incf visible))))
      (print (+ (* 2 (length grid)) (* 2 (- (length (car grid))
					    2))
		visible)))))

(run)
