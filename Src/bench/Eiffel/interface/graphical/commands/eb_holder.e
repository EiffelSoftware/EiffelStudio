indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry for EBench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EB_HOLDER

inherit
	ISE_CMD_HOLDER
		rename
			make as ise_make,
			make_plain as ise_make_plain
		redefine
			associated_button
		end

feature -- Initialization

	make (a_command: like associated_command; a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		do
			associated_button := a_button;
			associated_menu_entry := a_menu_entry;
			make_plain (a_command);
		ensure then
			command_set: associated_command.is_equal (a_command)
		end;

	make_plain (a_command: like associated_command) is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
			associated_command := a_command;
		end;

feature -- Execution

	execute (arg: ANY) is
			-- Execute `associated_command'.
		do
			associated_command.execute (arg)
		end

feature -- Setting

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		do
			associated_button := a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		do
			associated_menu_entry := a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according to `selection'.
		do
		end;

	set_sensitive (sensitivity: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be sensitive or not, according to `sensitivity'.
		do
			if associated_button /= Void then
				if sensitivity then
					associated_button.show
				else
					associated_button.hide
				end
			end;
			if associated_menu_entry /= Void then
				if sensitivity then
					associated_menu_entry.set_sensitive
				else
					associated_menu_entry.set_insensitive
				end
			end;
		end;

feature -- Properties

	associated_command: TOOL_COMMAND;
			-- Command held by Current

	associated_button: EB_BUTTON
			-- Button to represent `associated_command'

feature {NONE} -- Useless

	ise_make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		do
		end;

	ise_make_plain is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_HOLDER
