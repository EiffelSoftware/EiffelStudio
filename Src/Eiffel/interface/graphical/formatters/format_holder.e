indexing 

	description:
		"Class to hold a formatter plus its associated visual representations."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_HOLDER

inherit
	TWO_STATE_CMD_HOLDER
		rename
			change_state as set_selected
		redefine
			associated_menu_entry, set_selected,
			associated_command, associated_button,
			make_plain
		end

create
	make, 
	make_plain

feature -- Initialization

	make_plain (a_command: like associated_command) is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
			associated_command := a_command;
			a_command.set_holder (Current)
		end;

feature -- Properties

	associated_command: FORMATTER;
			-- Command to execute

	associated_button: FORMAT_BUTTON;
			-- Button to represent `associated_command'
			-- in the toolbar

	associated_menu_entry: EB_TICKABLE_MENU_ENTRY
			-- Menu entry with a tick

feature -- Status setting

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
			if associated_menu_entry /= Void then
				associated_menu_entry.set_selected (selection);
			end;
		end;

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

end -- class FORMAT_HOLDER
