(ql:quickload :ut)
(in-package :ut)

(defparameter file (uiop:read-file-string "input"))

(print (let ((previous nil))
	 (iter
	   (for i from 0)
	   (for c in (-<>> file
		       (str:trim)
		       (coerce <> 'list)))
	   (print previous)
	   (if (= 14 (length (remove-duplicates previous)))
	       (return (list i (remove-if (lambda (x)
					    (eq c x))
					  previous)))
	       (progn
		 (push c previous)
		 (if (> (length previous) 14)
		     (setf previous (iter (for x from 0 to (- (length previous) 2))
				      (collect (nth x previous)))))))))))
