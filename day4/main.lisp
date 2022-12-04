(ql:quickload :ut)
(in-package :ut)

;; 211 incorrect

(print (length (iter (for pair in
			  (-<>> (uiop:read-file-lines "input")
				(mapcar (lambda (it) (str:split "," it)))
				(mapcar (lambda (pair)
					  (mapcar (lambda (it)
						    (mapcar (lambda (s)
							      (parse-integer s))
							    (str:split "-" it)))
						  pair)))))
		 (if (or (and (<= (caar pair)
				  (caadr pair))
			      (>= (cadar pair)
				  (cadadr pair)))
			 (and (<= (caadr pair)
				  (caar pair))
			      (>= (cadadr pair)
				  (cadar pair))))
		     (collect 1)))))

