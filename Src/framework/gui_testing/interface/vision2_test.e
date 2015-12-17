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
	EXECUTION_ENVIRONMENT

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

	run_safe_test (a_test: PROCEDURE)
			-- Run a test procedure in a rescue clause.
		local
			failed: BOOLEAN
		do
			if failed then
				-- TODO: show error
				if exception = developer_exception then
					io.put_string ("a "+developer_exception_name+" exception occurred")
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
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"

end
