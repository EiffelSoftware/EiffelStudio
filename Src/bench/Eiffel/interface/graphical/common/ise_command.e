indexing

	description:	
		"Command that has a name, menu entry and accelerator. %
		%Current command should be in a menu as well as actions for buttons"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_COMMAND

inherit

	COMMAND

feature -- Access

	name: STRING is
			-- Name of the command
		deferred
		end;

	menu_name: STRING is
			-- Name used in menu entry
		deferred
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		deferred
		end

feature -- Execution

	execute (argument: ANY) is
			-- Set cursor to watch shape, call `work' and restore cursor.
		local
			mp: MOUSE_PTR
		do
			create mp.set_watch_cursor;
			work (argument);
			mp.restore;
		end;

	work (argument: ANY) is
		deferred
		end;

feature {ISE_BUTTON, ISE_MENU_ENTRY} -- Implementation

	button_three_action: ANY is
			-- Action to specify that the third button was pressed
		once
			create Result
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

end -- class ISE_COMMAND
