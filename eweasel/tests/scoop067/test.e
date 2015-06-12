note
	description: "Test if exceptions are handled correctly with passive processors."
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
			create <NONE> l_supplier

			test_propagation_query (l_supplier)
			test_propagation_command (l_supplier)
			test_callback_propagation_query (l_supplier)
			test_callback_propagation_command (l_supplier)
		rescue
			print ("Error: Exception propagated to root feature.%N")
		end

feature -- Basic operations

	test_propagation_query (supp: separate SUPPLIER)
		local
			retried: BOOLEAN
			trash: INTEGER
		do
			if not retried then
				trash := supp.failing_query
				print ("ERROR: Not propagated.%N")
			end
		rescue
			print ("OK: test_propagation_query.%N")
			retried := True
			retry
		end

	test_propagation_command (supp: separate SUPPLIER)
		local
			retried: BOOLEAN
		do
			if not retried then
				supp.failing_command
				print ("ERROR: Not propagated.%N")
			end
		rescue
			print ("OK: test_propagation_command.%N")
			retried := True
			retry
		end

	test_callback_propagation_query (supp: separate SUPPLIER)
		local
			retried: BOOLEAN
			trash: INTEGER
		do
			if not retried then
				trash := supp.failing_callback_query (Current)
				print ("ERROR: Not propagated.%N")
			end
		rescue
			print ("OK: test_callback_propagation_query.%N")
			retried := True
			retry
		end

	test_callback_propagation_command (supp: separate SUPPLIER)
		local
			retried: BOOLEAN
		do
			if not retried then
				supp.failing_callback_command (Current)
				print ("ERROR: Not propagated.%N")
			end
		rescue
			print ("OK: test_callback_propagation_command.%N")
			retried := True
			retry
		end

	fail
		do
			(create {DEVELOPER_EXCEPTION}.default_create).raise
		end
end
