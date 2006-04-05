indexing

	description:
		"Abstract notion of a menu entry."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_MENU_ENTRY

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void;
		deferred
		end;

feature -- Properties

	text: STRING is
			-- Text as displayed on the button.
		deferred
		end;

	associated_command: COMMAND is
			-- Command type that menu entry expects
		require
			never_be_called: false
		do
		end;

	insensitive: BOOLEAN is
			-- Is current widget insensitive to
			-- user actions? (If it is, events will
			-- not be dispatched to Current widget or
			-- any of its children)
		deferred
		end;

feature -- Status setting

	set_text (a_string: STRING) is
			-- Set the text to `a_string'.
		deferred
		end;

	set_insensitive is
			-- Make Current widget insensitive
		deferred
		end;

	set_sensitive is
			-- Make Current widget sensitive.
		deferred
		end;

feature {NONE} -- Properties

	menu_entry_name: STRING is "menu_entry";

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

end -- class MENU_ENTRY
