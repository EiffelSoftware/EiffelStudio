note
	description: "Test if a precondition violation is correctly handled."
	author: "Florian Besser"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_test: "SCOOP testsuite/Maude Tests/correctness_preconditions/"

class
	A

create
	make

feature

	make
		local
			b: separate B
			c1: separate C
			c2: C
			retried: BOOLEAN
		do
			if not retried then
				create b
				create c1
				create c2

				f (b, c1, c2)

				print ("ERROR: At end of {A}.make. This should not happen because f should trigger an exception.%N")
			else
				print ("OK: Exception successfully caught.%N")
			end
		rescue
			print("OK: In Rescue of {A}.make.%N")
			retried := True
			retry
		end

	f (b: separate B; c1, c2: separate C)
		do
			b.g(c1, c2)
		end
end
