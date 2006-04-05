indexing

	description: 
		"Cursor management. To do: Provides features to change %
		%the graphical aspect of the mouse pointer."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class MOUSE_PTR  

inherit
	
	GRAPHICS

create

	set_watch_cursor, do_nothing

feature -- Access

	Watch_cursor: SCREEN_CURSOR is
			-- Cursor to be used when waiting for the end of an execution
		local
			ct: CURSOR_TYPE;
		once
			create ct;
			create Result.make;
			Result.set_type (ct.watch)
		end;
	
feature -- Setting

	set_watch_cursor is
			-- Display the mouse pointer 
			-- shaped as a watch.
		do
			if not watch_shaped.item then
				set_global_cursor (Watch_cursor);
				watch_shaped.set_item (True)
			end
		end;

feature -- Restoring

	restore is
			-- Restore the mouse pointer back to
			-- its arrow shape.
		do
			if watch_shaped.item then
				restore_cursors;
				watch_shaped.set_item (False)
			end
		end

feature {NONE}

	watch_shaped: BOOLEAN_REF is
			-- Is the mouse pointer a watch shape?
		once
			create Result
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

end -- class MOUSE_PTR
