(ql:quickload :str)
(ql:quickload :arrows)
(ql:quickload :alexandria)
(use-package :arrows)

(defparameter alphabet (coerce "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 'list))

(defun prioritize (l)
  (mapcar (lambda (it) (+ 1 (position it alphabet))) l))

(defun groups (l)
  (loop for x from 0 to (- (/ (length l) 3) 1)
	collect (let* ((a (nth (* 3 x) l))
		       (b (nth (+ 1 (* 3 x)) l))
		       (c (nth (+ 2 (* 3 x)) l)))
		  (intersection (intersection a b)
				c))))

(-<>> (uiop:read-file-lines "input")
      (mapcar (lambda (it) (prioritize (coerce it 'list))))
      groups
      (mapcar #'car)
      (apply #'+)
      print)

