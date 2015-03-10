note
	description: "Test if a processor is correctly unlocked when its client fails with an exception."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

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
		end

feature -- Basic operations

	execute_test (a_supplier: separate SUPPLIER)
			-- Call a query on `a_supplier'.
		local
			l_sync: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_sync := a_supplier.perform_query
				print ("ERROR: No deadlock occurred.%N")
			end
		rescue
			print ("OK: Exception propagated to root processor.%N")
			retried := True
			retry
		end

end
