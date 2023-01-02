(ql:quickload :ut)
(in-package :ut)

;; not 1616
;; not 1155
;; not 392
(defun run ()
  (let* ((lines '("30373"
		  "25512"
		  "65332"
		  "33549"
		  "35390"))
	 ;;(lines (uiop:read-file-lines "input"))
	 
	 (grid (iter (for line in lines)
		 (collect (mapcar (lambda (it)
				    (parse-integer (coerce (list it) 'string)))
				  (coerce line 'list)))))
	 (visible 0)
	 (best 0))
    (iter (for y from 1 to (- (length grid) 2))
      (iter (for x from 1 to (- (length (car grid)) 2))
	(let* ((current (nth x (nth y grid)))
	       (left (- x 1))
	       (right (+ x 1))
	       (up (- y 1))
	       (down (+ y 1))
	       (score (* (iter (for nx from left downto 0)
			   (if (>= (nth nx (nth y grid))
				   current)
			       (return (- x 1)))
			   (finally (return (- x (min 0 nx)))))
			 (iter (for nx from right to (- (length (car grid)) 1))
			   (if (>= (nth nx (nth y grid))
				   current)
			       (return (- nx x)))
			   (finally (return (- (- (length (car grid)) 1) x))))
			 (iter (for ny from up downto 0)
			   (if (>= (nth x (nth ny grid))
				   current)
			       (return (- y ny)))
			   (finally (return (- y 1))))
			 (iter (for ny from down to (- (length grid) 1))
			   (if (>= (nth x (nth ny grid))
				   current)
			       (return (- ny y)))
			   (finally (return (- (- (length grid) 1) y)))))))
	  (if (< best score)
	      (progn (setf best score)
		     (format t "best: ~d (~d, ~d)~%" best x y)))))
      (finally (return best)))))

(run)
