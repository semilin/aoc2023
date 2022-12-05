(ql:quickload :ut)
(in-package :ut)

(defparameter lines (uiop:read-file-lines "input"))

(defparameter initial-stack (picl:take 8 (picl:make-iterator lines)))

(defparameter stacks (iter (for x from 0 to 8)
		       (collect (remove-if #'str:blank? (mapcar (lambda (line)
								  (str:s-nth (+ 1 (* x 4)) line))
								initial-stack)))))

(defparameter raw-instructions (iter (for x from 10 to (- (length lines) 1))
				 (collect (nth x lines))))

(defparameter instructions (mapcar (lambda (raw) (let ((words (str:words raw)))
					      (list (parse-integer (nth 1 words))
						    (parse-integer (nth 3 words))
						    (parse-integer (nth 5 words)))))
				   raw-instructions))

(defun basic-move (stacks from to)
  (let ((a (first (nth from stacks))))
    (push a (nth to stacks))
    (setf (nth from stacks) (cdr (nth from stacks)))))

(defun do-step (stacks instr)
  (dotimes (i (first instr))
    (basic-move stacks (- (second instr) 1)
		(- (third instr) 1))))

(iter (for instr in instructions)
  (do-step stacks instr))
(print (str:join "" (mapcar #'car stacks)))

