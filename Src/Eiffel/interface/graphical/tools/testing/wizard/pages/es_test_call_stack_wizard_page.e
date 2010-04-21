note
	description: "Summary description for {ES_TEST_CALL_STACK_WIZARD_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_CALL_STACK_WIZARD_PAGE

inherit
	ES_TEST_EXTRACTION_WIZARD_PAGE
		redefine
			new_panel
		end

create
	make

feature {NONE} -- Initialization

	make (an_app_status: like application_status)
			-- Initialize `Current'.
		do
			application_status := an_app_status
			create call_stack_elements.make (0)
			default_create
		end

feature -- Access

	call_stack_elements: SEARCH_TABLE [INTEGER]
			-- Call stack items selected by user

feature {NONE} -- Access

	application_status: APPLICATION_STATUS
			-- Current application status for which a test should be extracted

feature {NONE} -- Factory

	new_panel (a_composition: ES_TEST_WIZARD_COMPOSITION): ES_TEST_CALL_STACK_WIZARD_PAGE_PANEL
			-- <Precursor>
		do
			create Result.make (a_composition, application_status)
			call_stack_elements := Result.call_stack_elements
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
