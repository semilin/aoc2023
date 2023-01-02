(ql:quickload :ut)
(in-package :ut)

(defun move (pos dir amount)
  (alexandria:switch (dir)
    ('R (incf (first pos) amount))
    ('U (incf (second pos) amount))
    ('L (decf (first pos) amount))
    ('D (decf (second pos) amount))))

(defun x-dist (head tail)
  (- (first head) (first tail)))

(defun x-dir (head tail)
  (if (< (x-dist head tail) 0)
      'L
      'R))

(defun y-dist (head tail)
  (- (second head) (second tail)))

(defun y-dir (head tail)
  (if (< (y-dist head tail) 0)
      'D
      'U))

(defun tail-move (head-pos tail-pos)
  (if (not (and (<= (abs (x-dist head-pos tail-pos)) 1)
		(<= (abs (y-dist head-pos tail-pos)) 1)))
      (if (and (/= (first head-pos) (first tail-pos))
	       (/= (second head-pos) (second tail-pos)))
	  (progn (move tail-pos (x-dir head-pos tail-pos) 1)
		 (move tail-pos (y-dir head-pos tail-pos) 1))
	  (if (>= (abs (x-dist head-pos tail-pos)) 2)
	      (move tail-pos (x-dir head-pos tail-pos) 1)
	      (if (>= (abs (y-dist head-pos tail-pos)) 2)
		  (move tail-pos (y-dir head-pos tail-pos) 1))))))

(defun main ()
  (let* (
	 ;;(lines (uiop:read-file-lines "input"))
	 (lines (str:lines "R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20"))
	 (instructions (->> lines
			 (mapcar #'str:words)
			 (mapcar (lambda (it)
				   (list (intern (first it))
					 (parse-integer (second it)))))))
	 (positions nil)
	 (current-positions (iter (for x from 0 to 10)
			      (collect (copy-list (list 0 0))))))
    (iter (for (dir amount) in instructions)
      (dotimes (i amount)
	(move (car current-positions) dir 1)
	(iter
	  (for j from 1 to (- (length current-positions) 1))
	  (tail-move (nth (- j 1) current-positions)
		     (nth j current-positions)))
	(push (copy-list (last current-positions)) positions))
      (finally (return (remove-duplicates positions :test 'equal))))))
