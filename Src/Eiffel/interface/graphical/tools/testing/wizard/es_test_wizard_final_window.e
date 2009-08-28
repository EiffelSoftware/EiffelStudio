note
	description: "Summary description for {ES_TEST_WIZARD_FINAL_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_WIZARD_FINAL_WINDOW

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			is_final_state,
			wizard_information
		end

	ES_TEST_WIZARD_WINDOW
		redefine
			is_final_state,
			wizard_information,
			on_session_launch_error
		end

feature {NONE} -- Access

	wizard_information: ES_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

	session (a_test_suite: TEST_SUITE_S): TEST_CREATION_I
			-- Configured session ready to be launched.
		require
			has_valid_conf: has_valid_conf (wizard_information)
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
			result_ready: not Result.has_next_step
		end

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	has_error: BOOLEAN
			-- Has error occured launching processor?

feature {NONE} -- Status report

	is_final_state: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Basic operations

	proceed_with_current_info
			-- <Precursor>
		do
			if has_valid_conf (wizard_information) then
				has_error := False
				perform_with_test_suite (
					agent (a_test_suite: TEST_SUITE_S)
						require
							a_test_suite_attached: a_test_suite /= Void
							a_test_suite_usable: a_test_suite.is_interface_usable
						local
							l_session: like session
						do
							l_session := session (a_test_suite)
							a_test_suite.launch_session (l_session)
						end)
			else
				has_error := True
				on_session_launch_error ("Wizard failure")
			end
			if not has_error then
				cancel_actions
			end
		end

feature {NONE} -- Events

	on_session_launch_error (a_error: STRING_32)
			-- <Precursor>
		do
			has_error := True
			Precursor (a_error)
		end

;note
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
