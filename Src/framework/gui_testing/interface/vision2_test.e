indexing
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

feature -- Basic operations

	launch_application is
			-- Launch application under test
			-- This must be implemented by the test case. Create the
			-- original root class with the root feature.
		deferred
		end

	launch_application_threaded is
			-- Launch application under test in a separate thread
		local
			l_thread: WORKER_THREAD
		do
			create l_thread.make_with_procedure (agent launch_application)
			l_thread.launch
			from until
				gui.application_under_test /= Void
			loop
				sleep (10_000_000)
			end
		ensure
			application_under_test_not_void: gui.application_under_test /= Void
		end

	wait_until_destroyed is
			-- Wait until `application_under_test' is destroyed.
		require
			application_under_test_not_void: gui.application_under_test /= Void
		do
			from until
				gui.application_under_test.is_destroyed
			loop
				sleep (10_000_000)
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
			else
				a_test.call ([])
			end
		rescue
			failed := True
			retry
		end

indexing
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
