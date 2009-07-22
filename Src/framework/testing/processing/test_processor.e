note
	description: "[
		Objects that provide common functionality needed for implementations of {TEST_PROCESSOR_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_PROCESSOR

inherit
	TEST_PROCESSOR_I

	TEST_COLLECTION
		rename
			make as make_collection
		redefine
			is_interface_usable
		end

	TEST_SUITE_OBSERVER

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
		do
			test_suite := a_test_suite
			test_suite.test_suite_connection.connect_events (Current)
			make_collection
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				--| FIXME: Arno, correctly clean up resources	
			end
		end

feature -- Access

	test_suite: TEST_SUITE_S
			-- <Precursor>

feature {NONE} -- Access

	internal_progress: like progress
			-- Internal storage of `progress'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then test_suite.is_interface_usable
		ensure then
			test_suite_is_interface_usable: Result implies test_suite.is_interface_usable
		end

	is_idle: BOOLEAN
			-- <Precursor>

	is_stop_requested: BOOLEAN
			-- <Precursor>

	progress: REAL
			-- <Precursor>
		do
			if is_finished then
				Result := {REAL} 1.0
			else
				Result := internal_progress
			end
		end

feature -- Status setting

	request_stop
			-- <Precursor>
		do
			is_stop_requested := True
		end

feature {TEST_SUITE_S} -- Status setting

	frozen proceed
			-- <Precursor>
		do
			is_idle := False
			proceed_process
			is_idle := True
		end

	frozen stop
			-- <Precursor>
		do
			stop_process
			is_idle := False
			is_stop_requested := False
		end

feature {NONE} -- Status setting

	frozen start_process (a_arg: like conf_type)
			-- <Precursor>
		do
			internal_progress := {REAL} 0.0
			start_process_internal (a_arg)
			is_idle := True
		end

	start_process_internal (a_arg: like conf_type)
			-- Start performing a task for given arguments.
			--
			-- Note: `start_process' does not need to care about the idle status.
			--
			-- `a_arg': Configuration defining the task.
		require
			test_suite_valid: are_tests_available
			ready: is_ready
			a_arg_valid: is_valid_configuration (a_arg)
		deferred
		end

	proceed_process
			-- Proceed with actual task
		require
			running: is_running
			not_idle: not is_idle
		deferred
		end

	stop_process
			-- Stop task
		require
			running: is_running
			finished: is_finished
		deferred
		ensure
			not_running: not is_running
		end

feature {TEST_SUITE_S} -- Events

	on_test_changed (a_collection: ACTIVE_COLLECTION_I [TEST_I]; a_item: TEST_I)
			-- <Precursor>
		do
			if tests.has (a_item) then
					-- Note: replace `as_attached' with Current when compiler treats Current as attached
				test_changed_event.publish ([as_attached, a_item.as_attached])
			end
		end

invariant
	internal_progress_valid: internal_progress >= {REAL} 0.0 and internal_progress <= {REAL} 1.0

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
