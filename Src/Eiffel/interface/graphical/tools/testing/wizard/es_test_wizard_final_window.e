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
			on_processor_launch_error
		end

feature {NONE} -- Access

	wizard_information: ES_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

	factory_type: !TYPE [TEST_CREATOR_I]
			-- Factory type used to create tests
		deferred
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
		local
			l_conf: TEST_CREATOR_CONF
		do
			l_conf := wizard_information.current_conf
			check l_conf /= Void end
			has_error := False
			launch_processor (factory_type, l_conf, False)
			if not has_error then
				cancel_actions
			end
		end

feature {NONE} -- Events

	on_processor_launch_error (a_error: !STRING_32; a_type: !TYPE [TEST_PROCESSOR_I]; a_code: NATURAL_32)
			-- <Precursor>
		do
			has_error := True
			Precursor (a_error, a_type, a_code)
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
