note
	description: "Test exceptions on separate callbacks."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_tests: "Maude Tests/exceptions_and_retry/, %
					%Maude Tests/exceptions_and_retry_sync/, %
					%Maude Tests/exceptions_and_separate_callbacks/"

class
	CLIENT

create
	make

feature

	make
			-- Entry point for the test.
		local
			retried: BOOLEAN
			supplier: separate SUPPLIER
		do
			create supplier
			if not retried then 
				do_unsynced (supplier)
				print ("OK: In {CLIENT}.make, Step 1.%N%N")

				do_synced (supplier)
				print ("OK: In {CLIENT}.make, Step 2.%N%N")

				do_fail (supplier)
				print ("OK: In {CLIENT}.make, Step 3.%N%N")

			end
		rescue
			print ("ERROR: In Rescue of {CLIENT}.make.%N")
			retried := True
			retry
		end

	do_unsynced (a_supplier: separate SUPPLIER)
			-- SCOOP helper to control `a_supplier'.
		do
			a_supplier.execute_callback (Current)
		end

	do_synced (a_supplier: separate SUPPLIER)
			-- SCOOP helper to control `a_supplier'.
		do
			a_supplier.execute_callback_sync (Current)
		end

	do_fail (a_supplier: separate SUPPLIER)
			-- SCOOP helper to control `a_supplier'.
		local
			retried: BOOLEAN
		do
			if not retried then
				a_supplier.execute_callback_fail (Current)
				print ("ERROR: In body of {CLIENT}.do_fail.%N")
			end
		rescue
			print ("OK: In rescue of {CLIENT}.do_fail.%N")
			retried := True
			retry
		end

	fail
			-- Throw an exception.
		do
			print ("OK: At start of {CLIENT}.fail.%N")
			my_exception.raise
			print ("ERROR: At end of {CLIENT}.fail.%N")
		rescue
			print ("OK: In rescue of {CLIENT}.fail.%N")
		end

	succeed
			-- Do not throw an exception.
		do
			print ("OK: In body of {CLIENT}.succeed.%N")
		rescue
			print ("ERROR: In rescue of {CLIENT}.succeed.%N")
		end

	sync: BOOLEAN
		do
			print ("OK: In body of {CLIENT}.sync.%N")
			Result := True
		rescue
			print ("ERROR: In rescue of {CLIENT}.sync.%N")
		end

	my_exception: DEVELOPER_EXCEPTION
            once
                create Result
            end
end
