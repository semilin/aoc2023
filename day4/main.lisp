(ql:quickload :ut)
(in-package :ut)

(-> (iter (for pair in
               (-<>> (uiop:read-file-lines "input")
                 (mapcar (lambda (line) (str:split "," line)))
                 (mapcar (lambda (pair)
                           (mapcar (lambda (it)
                                     (let ((n (mapcar (lambda (s)
                                                        (parse-integer s))
                                                      (str:split "-" it))))
                                       (iter (for x from (first n)
                                                  to (second n))
                                         (collect x))))
                                   pair)))))
      (if (intersection (first pair) (second pair))
          (collect 1)))
  length
  print)
