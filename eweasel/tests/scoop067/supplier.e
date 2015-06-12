note
	description: "A supplier class with several different queries and commands."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPLIER

feature -- Access

	failing_query: INTEGER
		do
			fail
			Result := 42
			print ("ERROR: Not propagated.%N")
		rescue
			print ("OK: failing_query.%N")
		end

	failing_command
		do
			fail
			print ("ERROR: Not propagated.%N")
		rescue
			print ("OK: failing_command.%N")
		end

	failing_callback_query (test: separate TEST): INTEGER
		do
			test.fail
			Result := 42
			print ("ERROR: Not propagated.%N")
		rescue
			print ("OK: failing_callback_query.%N")
		end

	failing_callback_command (test: separate TEST)
		do
			test.fail
			print ("ERROR: Not propagated.%N")
		rescue
			print ("OK: failing_callback_command.%N")
		end

feature {NONE} -- Implementation

	fail
		do
			(create {DEVELOPER_EXCEPTION}.default_create).raise
		end
end
