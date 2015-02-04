note
	description: "Test basic control flow correctness for SCOOP exceptions."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_test: "SCOOP testsuite/Maude Tests/exceptions_and_once_routines/"
class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			failer: separate FAILER
			stop: BOOLEAN
		do
			if not stop then
				create failer

					-- Check that an asynchronous call can't forward an exception.
				execute_without_sync (failer)
				print ("OK: In make, after execute_without_sync.%N")

					-- Check that the previous exception is gone after an unlock.
				sync (failer)
				print ("OK: In make, after sync.%N")

					-- Check that the exception is correctly propagated upon synchronization.
				execute_with_sync (failer)
				print ("ERROR: In make, after execute_with_sync.%N")
			end
		rescue
			print ("OK: In rescue of make.%N")
			stop := True
			retry
		end

feature -- Basic operations

	sync (a_failer: separate FAILER)
			-- Synchronize with `a_failer'.
		local
			i: INTEGER
		do
			i := a_failer.counter
			print ("OK: In sync, after calling {FAILER}.counter.%N")
		rescue
			print ("ERROR: In rescue of sync%N")
		end


	execute_without_sync (a_failer: attached separate FAILER)
			-- Throw an exception in `a_failer' without a subsequent synchronization.
		do
			a_failer.fail
			print ("OK: In execute_without_sync, after callling {FAILER}.fail.%N")
		rescue
			print ("ERROR: In rescue of execute_without_sync%N")
		end

	execute_with_sync (a_failer: attached separate FAILER)
			-- Throw an exception in `a_failer' and synchronize.
		local
			i: INTEGER
		do
			a_failer.fail
			print ("OK: In execute_with_sync, after callling {FAILER}.fail.%N")

			i := a_failer.counter
			print ("ERROR: In execute_with_sync, after calling {FAILER}.counter.%N")
		rescue
			print ("OK: In rescue of execute_with_sync.%N")
		end
end
