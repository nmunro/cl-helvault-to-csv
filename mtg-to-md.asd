(defsystem "mtg-to-md"
  :version "0.0.1"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on (:cl-csv
               :csv-to-md-table
               :cl-scryfall-api)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Generate a skeleton for modern project"
  :in-order-to ((test-op (test-op "mtg-to-md/tests"))))

(defsystem "mtg-to-md/tests"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on ("mtg-to-md"
               :rove)
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for mtg-to-md"
  :perform (test-op (op c) (symbol-call :rove :run c)))
