indexing
	description: "[
						First page of new unit test wizard

																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_ONE

inherit
	EB_WIZARD_INITIAL_STATE_WINDOW
		redefine
			make,
			wizard_information
		end

create
	make

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- Redefine
		do
			wizard_information := an_info
		end

feature {NONE} -- Implementation

	wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION;
			-- Redefine

feature -- Access

	proceed_with_current_info
			-- Redefine
		do
			proceed_with_new_state(create {ES_NEW_UNIT_TEST_WIZARD_TWO}.make (wizard_information))
		end

	display_state_text
			-- Redefine
		do
			title.set_text (title_string)
			message.set_text (message_string)

			-- This is used for end user navigate back from sencond wizard page
			if first_window /= Void then
				first_window.enable_next_button
			end
		end

	title_string: !STRING_GENERAL is
			-- Message string shown in title
		do
			if {l_string: STRING_GENERAL} interface_names.t_Welcome_to_new_unit_test_wizard then
				Result := l_string
			else
				check not_possible: False end
			end
		end

	message_string: !STRING_GENERAL is
			-- Message string shown in the wizard
		do
			if {l_string: STRING_GENERAL} interface_names.t_Using_this_wizard then
				Result := l_string
			else
				check not_possible: False end
			end
		end

indexing
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
