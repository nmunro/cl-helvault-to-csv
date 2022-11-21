(defpackage mtg-to-md
  (:use :cl)
  (:export #:main))

(in-package mtg-to-md)

(defun get-card (cols vals)
  (loop :for c :in cols :for v :in vals :collect (read-from-string (format nil ":~A" c)) :collect v))

(defun get-cards (input)
  (let ((data (cl-csv:read-csv input)))
    (loop :for row :in (cdr data) :collect (get-card (car data) row))))

(defun build-url (scryfall-id name)
  (format nil "<a href='~A'>~A</a>" (cl-scryfall-api:scryfall-uri (cl-scryfall-api:get-by-scryfall-id scryfall-id)) name))

(defun build-new-card-structure (input)
  (let ((cards (get-cards input)))
    (loop :for row :in cards
          :for num :from 1 :to (length cards)
          :collect `(,(build-url (getf row :scryfall_id) (getf row :name)) ,(getf row :estimated_price) ,(getf row :quantity))
          :do (format t "Processing: ~A/~A -> ~A~%" num (length cards) (getf row :name)))))

(defun main (input output)
  (with-output-to-string (s)
    (cl-csv:write-csv-row '(name price quantity) :stream s :separator #\;)
    (dolist (card (build-new-card-structure input))
      (cl-csv:write-csv-row card :stream s :separator #\;))

    (with-open-file (f output :direction :output :if-exists :supersede)
      (format f "~A" (csv-to-md-table:main s :separator #\;)))))

(main #p"~/Downloads/helvaultPro.csv" #p"~/Desktop/tmp.md")
