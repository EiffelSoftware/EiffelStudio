indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_CMD_HOLDER

feature -- Initialization

	make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		require
			non_void_button: a_button /= Void;
			non_void_menu_entry: a_menu_entry /= Void;
		deferred
		ensure
			button_set: associated_button = a_button;
			menu_entry_set: associated_menu_entry = a_menu_entry;
		end;

	make_plain is
			-- Initialize Current, with `associated_command' as `a_command'.
		deferred
		end;

feature -- Setting

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		require
			non_void_button: a_button /= Void
		deferred
		ensure
			properly_set: associated_button = a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		require
			non_void_menu_entry: a_menu_entry /= Void
		deferred
		ensure
			properly_set: associated_menu_entry = a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according to `selection'.
		deferred
		end;

feature -- Properties

	associated_button: ISE_BUTTON;
			-- Button on the toolbars.

	associated_menu_entry: ISE_MENU_ENTRY;
			-- Menu entry in the menus.

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

end -- class ISE_CMD_HOLDER
