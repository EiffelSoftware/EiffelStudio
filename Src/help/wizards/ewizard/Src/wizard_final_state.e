note
	description	: "Template for the last state of a wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

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

feature -- Basic Operations

	proceed_with_current_info
		local
			ace_location: FILE_NAME
		do
			create ace_location.make_from_string (wizard_information.project_location)
			ace_location.set_file_name ("Ace")
			ace_location.add_extension ("ace")
			wizard_information.set_ace_location (ace_location)

			project_generator.generate_code
			write_bench_notification_ok (wizard_information)

			Precursor
		end

feature {NONE} -- Implementation

	display_state_text
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.t_Final_state)
			message.set_text (Interface_names.m_Final_state(wizard_information.compile_project,
					wizard_information.project_name, wizard_information.project_location))
		end

	final_message: STRING
		do
		end

	pixmap_icon_location: FILE_NAME
			-- Icon for the Eiffel Store Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_FINAL_STATE
