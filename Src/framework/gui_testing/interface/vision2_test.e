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

feature -- Access

	application_under_test: EV_APPLICATION is
			-- Application under test
		deferred
		end

feature -- Element change

	set_application_under_test (an_app: EV_APPLICATION) is
			-- Set application under test to `an_app'.
		require
			an_app_not_void: an_app /= Void
		do
			gui.set_application_under_test (an_app)
		ensure
			ev_application_set: gui.application_under_test = an_app
		end

feature -- Basic operations

	launch_application is
			-- Launch application under test
		deferred
		end

	launch_application_threaded is
			-- Launch application under test in a separate thread
		do
			create {WORKER_THREAD}thread.make_with_procedure (agent launch_application)
			thread.launch
			from until
				application_under_test /= Void
			loop
				sleep (1000000)
			end
			set_application_under_test (application_under_test)
		end

	wait_until_destroyed is
			-- Wait until `application_under_test' is destroyed.
		require
			application_under_test_not_void: gui.application_under_test /= Void
		do
			from until
				gui.application_under_test.is_destroyed
			loop
				sleep (1000000)
			end
		ensure
			application_under_test_destroyed: gui.application_under_test.is_destroyed
		end

	run_safe_test (a_test: PROCEDURE [ANY, TUPLE])
			--
		local
			failed: BOOLEAN
		do
			if not failed then
				a_test.call ([])
			end
		rescue
			failed := True
			retry
		end

feature {NONE} -- Implementation

	thread: THREAD
		-- Thread used to launch Vision2 application

invariant

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
