indexing

	description:
		"Dialog with only one OK button to show an error"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ERROR_WINDOW

inherit
	ERROR_D
		redefine
			make
		end;

	COMMAND;

create
	
	make

feature -- creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a message dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
			valid_parent: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			Precursor {ERROR_D} (a_name, a_parent)
			add_ok_action (Current, ok);
			hide_help_button
			hide_cancel_button
		ensure then
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end;

feature -- Execution argument

	ok: ANY is
		once
			create Result
		end

feature -- Execute
	
	execute (arg: ANY) is
		do
			popdown
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

end -- ERROR_WINDOW
