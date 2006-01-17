indexing

	description:
		"Menu entry for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EB_MENU_ENTRY

inherit
	ISE_MENU_ENTRY
		redefine
			make,
			associated_command
		end;
	PUSH_B
		rename
			make as button_make
		end;
	SYSTEM_CONSTANTS

create
	make, 
	make_default,
	make_button_only

feature {NONE} -- Initialization

	make (a_cmd: TOOL_COMMAND; a_parent: MENU) is
			-- Initialize button with tool command `a_cmd' and parent `a_parent'.
			-- The action will pass `tool' to the argument of the command.
		do
			make_button_only (a_cmd, a_parent);
			add_activate_action (a_cmd, a_cmd.tool);
		end;

	make_default (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize button with default command type `a_cmd' and parent `a_parent'.
			-- The action will pass Void to the argument of the command.
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void;
		do
			make_button_only (a_cmd, a_parent);
			add_activate_action (a_cmd, Void);
		end;

	make_button_only (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button part.
			-- Do not add any action.
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void
		local
			act: STRING;
		do
			button_make (a_cmd.menu_name, a_parent);	
			act := a_cmd.accelerator;
			if act /= Void then
				set_accelerator_action (act)
			end
		end;

	associated_command: ISE_COMMAND is
			-- Command type that menu entry expects
		do
		end

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

end -- class EB_MENU_ENTRY
