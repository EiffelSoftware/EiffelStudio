note
	description:
		"Base class to execute a Vision2 test case"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISION2_TEST

inherit
	THREAD_CONTROL

	SHARED_GUI

	SHARED_MOUSE

	SHARED_KEYBOARD

	SHARED_SPECIAL_COMMANDS

	EXCEPTIONS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
			-- Start application and execute test
		do
			launch_application_threaded

			run_safe_test (agent run_test)

			wait_until_destroyed
		end

feature -- Basic operations

	launch_application
			-- Launch application under test
			-- This must be implemented by the test case. Create the
			-- original root class with the root feature.
		deferred
		end

	launch_application_threaded
			-- Launch application under test in a separate thread
		local
			l_thread: WORKER_THREAD
		do
			create l_thread.make_with_procedure (agent launch_application)
			l_thread.launch
			from until
				gui.application_under_test /= Void
			loop
				sleep (100_000_000)
			end
		ensure
			application_under_test_not_void: gui.application_under_test /= Void
		end

	wait_until_destroyed
			-- Wait until `application_under_test' is destroyed.
		require
			application_under_test_not_void: gui.application_under_test /= Void
		local
			l_app: EV_APPLICATION
		do
			from
				l_app := gui.application_under_test
			until
				l_app.is_destroyed
			loop
				sleep (100_000_000)
			end
		ensure
			application_under_test_destroyed: gui.application_under_test.is_destroyed
		end

	run_safe_test (a_test: PROCEDURE [ANY, TUPLE])
			-- Run a test procedure in a rescue clause.
		local
			failed: BOOLEAN
		do
			if failed then
				-- TODO: show error
				if exception = developer_exception then
					io.put_string ("a "+developer_exception_name+" exception occured")
				else
					-- TODO: raise again
				end
			else
				a_test.call ([])
			end
		rescue
			failed := True
			retry
		end

	run_test
			-- Run a test.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
