(ql:quickload :alexandria)
(ql:quickload :str)
(let ((lines (str:lines (alexandria:read-file-into-string #P"input")))
      (current-sum 0)
      (totals nil))
  (loop for line in lines
	if (str:blank? line)
	  do (progn (push current-sum totals)
		    (setf current-sum 0))
	else
	  do (incf current-sum (parse-integer (str:trim line))))
  (print (apply #'+ (let ((sorted (stable-sort totals #'>))) 
		      (list (first sorted)
			    (second sorted)
			    (third sorted))))))

