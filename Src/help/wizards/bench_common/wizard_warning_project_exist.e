indexing
	description	: "Wizard state: Error in the choosen directory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_WARNING_PROJECT_EXIST

inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

	BENCH_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- basic Operations

	display_state_text is
			-- Display message text relative to current state.
		do
			title.set_text (Bench_interface_names.t_Project_already_exist)
			message.set_text (Bench_interface_names.m_Project_already_exist)
		end

	proceed_with_current_info is
		do
			Precursor
			proceed_with_new_state(create {WIZARD_SECOND_STATE}.make (wizard_information))
		end
		

	final_message: STRING is
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
indexing
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
end -- class WIZARD_WARNING_PROJECT_EXIST

