note
	description: "Test if a processor is correctly unlocked when its client fails with an exception."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	SUPPLIER

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_supplier: separate SUPPLIER
		do
			create l_supplier
			execute_test (l_supplier)

			create l_supplier
			execute_callback_test (l_supplier)

			execute_unlock_test
		end

feature -- Tests

	execute_test (a_supplier: separate SUPPLIER)
			-- Call a query on `a_supplier'.
		local
			l_sync: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_sync := a_supplier.perform_query
				print ("ERROR: No exception occurred.%N")
			end
		rescue
			print ("OK: Exception propagated to root processor.%N")
			retried := True
			retry
		end

	execute_callback_test (a_supplier: separate SUPPLIER)
			-- Call a query on `a_supplier'.
		local
			l_sync: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_sync := a_supplier.perform_callback (Current)
				print ("ERROR: No exception occurred.%N")
			end
		rescue
			print ("OK: Exception propagated to root processor.%N")
			retried := True
			retry
		end

	execute_unlock_test
			-- See if a locked object is properly unlocked during an exception.
		local
			retried: BOOLEAN
			l_sync: INTEGER
		do
			if not retried then
				l_sync := perform_query
				print ("ERROR: No exception occurred.%N")
			end
		rescue
			print ("OK: Exception catched.%N")
			retried := True
			retry
		end

end
