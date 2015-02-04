note
	description: "Test if accountability is correctly handed over during lock passing."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_tests: "Maude Tests/searchers/"

class
	CONTROLLER

create
	make

feature

	make
		local
			s1, s2: separate SEARCHER
			log: separate LOGGER
			retried: BOOLEAN
		do
			if not retried then
				create s1
				create s2
				create log

				test_no_propagation (s1, s2, log)
					-- Make sure no exceptions are stored after an unlock.
				sync (s1)
				sync (s2)

				test_late_propagation (s1, s2, log)
				sync (s1)
				sync (s2)

				test_accountability_transfer (s1, s2, log)
				sync (s1)
				sync (s2)

				print("OK: At end of {CONTROLLER}.make.%N")
			end
		rescue
			print ("ERROR: In rescue of {CONTROLLER}.make.%N")
			retried := True
			retry
		end

	test_no_propagation (s1, s2: separate SEARCHER; log: separate LOGGER)
			-- Test if an exception is properly forgotten.
		do
			s1.search (1)
			s2.search (-1)
			log.log (s1, s2)
			
			sync (s1)
				-- Don't sync with s2 - we ingore this exception.
			print ("OK: At end of {CONTROLLER}.test_no_propagation.%N")
		end

	test_late_propagation (s1, s2: separate SEARCHER; log: separate LOGGER)
			-- Test if an exception is still there after an accountability transfer.
		local
			retried: BOOLEAN
		do
			if not retried then
				s1.search (1)
				s2.search (-1)
				log.log (s1, s2)
				sync (s1)

				print ("OK: In body of {CONTROLLER}.test_late_propagation.%N")

				sync (s2) -- Exception should propagate here.

				print ("ERROR: At end of {CONTROLLER}.test_late_propagation.%N")
			end
		rescue
			print ("OK: In rescue of {CONTROLLER}.test_late_propagation.%N")
			retried := True
			retry
		end

	test_accountability_transfer  (s1, s2: separate SEARCHER; log: separate LOGGER)
			-- Test if accountability is properly transferred to `log'.
		do
			s1.search (0)
			s2.search (-1)
			log.log (s1, s2)
				-- Also test that exception is now successfully handled.
			sync (s2) -- should not throw.
			print ("OK: At end of {CONTROLLER}.test_accountability_transfer.%N")
		end

	sync (searcher: separate SEARCHER)
		local
			i: INTEGER
		do
			i := searcher.solution
		end
end
