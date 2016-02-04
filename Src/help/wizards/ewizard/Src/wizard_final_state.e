note
	description: "Template for the last state of a wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

	WIZARD_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	proceed_with_current_info
		do
			wizard_information.set_ace_location (wizard_information.project_location.extended
				(wizard_information.project_name.as_lower + ".ecf"))
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.t_Final_state)
			message.set_text (Interface_names.m_Final_state(wizard_information.compile_project,
					wizard_information.project_name, wizard_information.project_location.name))
		end

	final_message: STRING_32
		do
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
