(ql:quickload :ut)
(in-package :ut)

(-<>> (uiop:read-file-lines "input")
      (split-sequence-if #'str:blank?)
      seq
      (map! (lambda (l)
	      (apply #'+ (mapcar #'parse-integer l))))
      collect
      (sort <> #'>)
      (subseq <> 0 3)
      print)
