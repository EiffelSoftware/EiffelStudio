note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MULTIPLE_THREAD

inherit
	TEST_BASIC_DATABASE

	THREAD_CONTROL
		undefine
			default_create
		end

feature -- Test routines

	test_multiple_thread
			-- Test
		local
			i: INTEGER
			l_thread: DATA_OPERATION_THREAD
		do
			reset_database
			establish_connection

			prepare_repository ({DATA_OPERATION_THREAD}.Table_name)

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				if attached Manager.current_session.session_login as l_login then
					from
						i := 1
					until
						i > 5
					loop
						create l_thread.make_thread (l_login)
						l_thread.launch
						i := i + 1
					end

					join_all
				end
			end
			disconnect
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
			Result.force (create {BOOK2}.make, {DATA_OPERATION_THREAD}.Table_name)
		end

end
