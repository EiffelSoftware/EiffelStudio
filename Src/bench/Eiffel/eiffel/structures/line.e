indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class LINE [T -> ANY] 

inherit
	ARRAY [T]
		rename
			make as basic_make,
			wipe_out as array_wipe_out,
			item as array_item
		export
			{LINE} all
		end

create

	make

	
feature

	cursor: INTEGER;
			-- Cursor in the line

	make is
		do
			basic_make (1, Chunk);
		end;

feature {NONE}

	Chunk: INTEGER is 50;

	
feature 

	insert (a: T) is
			-- Insert `a' in the line.
		do
			cursor := cursor + 1;
			if cursor > count then
				conservative_resize (1, count + Chunk);
			end;
			put (a, cursor);
		ensure
			item = a;
		end;

	change_item (t: T) is
			-- Remove one item
		require
			cursor > 0;
			not after;
		do
			put (t, cursor);
		end;

	remove is
			-- Remove current item
		require
			valid_cursor: cursor >0
			not_after: not after
		local
			l_default: T
		do
			put (l_default, cursor)
			cursor := cursor - 1
		end
		
	start is
			-- Start the iteration
		do
			cursor := 1;
		end;

	after: BOOLEAN is
			-- Is the cursor after ?
		do
			Result := cursor > count;
		end;

	offright: BOOLEAN is obsolete "Use `after'"
		do
			Result := after
		end;

	forth is
			-- Iteration
		require
			not after
		do
			cursor := cursor + 1;
		end;

	item: T is
			-- Item at cursor position
		require
			not after
		do
			Result := array_item (cursor);
		end;

	wipe_out is
			-- Clear the structure
		do
			cursor := 0;
			clear_all;
		end;

	go_i_th (i: INTEGER) is
		do
			cursor := i
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

end
