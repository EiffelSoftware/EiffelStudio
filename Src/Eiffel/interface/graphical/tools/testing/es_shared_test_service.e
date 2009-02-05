note
	description: "[
		Shared access to testing facilities.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_SHARED_TEST_SERVICE

inherit
	SHARED_TEST_SERVICE
		redefine
			test_suite,
			on_processor_launch_error
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature {NONE} -- Access

	test_suite: !SERVICE_CONSUMER [TEST_SUITE_S]
			-- <Precursor>
		local
			l_observer: ES_TEST_CLUSTER_OBSERVER
		do
			Result := Precursor
			l_observer := observer_cell.item
			if l_observer = Void then
				create l_observer.make
				observer_cell.put (l_observer)
			end
		end

	current_window: !EV_WINDOW
			-- Window in which `Current' is used.
		deferred
		end

	observer_cell: CELL [?ES_TEST_CLUSTER_OBSERVER]
			-- Observer which notifies test suite whenever a class is removed
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Events

	on_processor_launch_error (a_error: like error_message; a_type: !TYPE [TEST_PROCESSOR_I]; a_code: NATURAL)
			-- <Precursor>
		do
			prompts.show_error_prompt (a_error, current_window, Void)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
