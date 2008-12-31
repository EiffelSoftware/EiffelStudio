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
			wizard_information
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
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
			l_info: like wizard_information
		do
			l_info := wizard_information
			check l_info /= Void end
			launch_processor (factory_type, l_info, False)
		end

;note
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
