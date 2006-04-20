indexing

	description:
		"Abstract notion of a tool button."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EB_BUTTON

inherit
	ISE_BUTTON
		rename
			make as button_make
		end;
	WINDOWS;
	WIDGET_ROUTINES

create
	make,
	make_without_action

feature {NONE} -- Initialization

	make (cmd: PIXMAP_COMMAND; a_parent: COMPOSITE) is
			-- Initialize button  and automatically add the activate
			-- action callback to current button.
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			init_button (implementation);
			set_symbol (cmd.symbol);
			add_activate_action (cmd, cmd.tool);
			set_focus_string (associated_command.name)
			initialize_focus 
		end;

	make_without_action (cmd: PIXMAP_COMMAND; a_parent: COMPOSITE) is
			-- Initialize button  and do not add the activate
			-- action callback to current button.
		do
			associated_command := cmd;
			button_make (button_name, a_parent);
			init_button (implementation);
			set_symbol (cmd.symbol);
			set_focus_string (associated_command.name)
			initialize_focus 
		end;

feature -- Element change

	add_third_button_action is
			-- Add the `associated_command' to the third mouse button action.
		do
			add_button_press_action (3, associated_command,
				associated_command.button_three_action)
		end;

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		do
			Result := associated_command.symbol
		end;

feature {NONE} -- Properties

	associated_command: PIXMAP_COMMAND;

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

end -- class EB_BUTTON
