(defpackage mtg-to-md/tests/main
  (:use :cl
        :mtg-to-md
        :rove))
(in-package :mtg-to-md/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :mtg-to-md)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
  (format t "Testing~%")
    (ok (= 1 1))))