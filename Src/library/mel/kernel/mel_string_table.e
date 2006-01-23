indexing

	description: 
		"Implementation of XmStringTable. "
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_STRING_TABLE

inherit

	MEL_MEMORY
		rename
			make_from_existing as mem_make_from_existing
		end

create
	make,
	make_from_existing

feature {NONE} -- Initialization

	make_from_existing (a_table: POINTER; a_count: INTEGER) is
			-- Create the XmString Table.
		require
			table_not_null: a_table /= default_pointer;
			count_large_enough: a_count > 0
		do
			handle := a_table;
			count := a_count
		ensure
			exists: not is_destroyed
		end;

	make (size: INTEGER) is
			-- Allocate a table of XmString with size `size'.
		require
			positive_size: size > 0
		do
			handle := create_xm_string_table (size);
			count := size
		ensure
			count_set: count = size
		end;

feature -- Access

	count: INTEGER;
			-- Number of elements in table

	item (i: INTEGER): MEL_STRING is
			-- Get a string value (that is shared, i.e will not be
			-- collected automatically) at position `i'
		require
			valid_range: i > 0 and then i <= count;	
		do
			create Result.make_from_existing (get_i_th_table (handle, i))
		ensure
			non_void_result: Result /= Void and then Result.is_shared
		end;

	item_string (i: INTEGER): STRING is
			-- Eiffel string at position `i' (string value return
			-- will not be freed)
		require
			valid_range: i > 0 and then i <= count;	
		local
			ms: MEL_STRING
		do
			create ms.make_from_existing (get_i_th_table (handle, i));
			ms.set_shared;
			Result := ms.to_eiffel_string
		ensure
			non_void_result: Result /= Void
		end;

feature -- Element change

	put (ms: MEL_STRING; i: INTEGER) is
			-- Put a motif string `ms' at position `i'
			-- in current table.
			--| `ms' will not be collected automatically.
		require
			i_large_enough: i > 0
			i_small_enough: i <= count;
			valid_ms: ms /= Void and then not ms.is_destroyed;
			ms_is_shared: ms.is_shared
		do
			xm_list_put (handle, ms.handle, i)
		end;

	put_string (str: STRING; i: INTEGER) is
			-- Put an eiffel string `str' at position `i'
			-- in current table.
			--| A mel string with `shared' set to True is created.
		require
			valid_str: str /= Void 
			i_large_enough: i > 0
			i_small_enough: i <= count;
		local
			ms: MEL_STRING
		do
			create ms.make_localized (str);
			ms.set_shared;
			xm_list_put (handle, ms.handle, i);
		end;

feature -- Removal

	destroy is
			-- Free the memory used by the xmStringTable and its
			-- string contents using XmStringFree.
		do
			free_xm_string_table (handle, count);
			handle := default_pointer;
			count := 0
		end;

feature {NONE} -- External features

	create_xm_string_table (c: INTEGER): POINTER is
		external
			"C"
		end;

	free_xm_string_table (obj: POINTER; c: INTEGER) is
		external
			"C"
		end;

	get_i_th_table (table: POINTER; value: INTEGER): POINTER is
		external
			"C"
		end;

	xm_list_put (table, ms: POINTER; a_pos: INTEGER) is
		external
			"C"
		end;

invariant

	count_large_enough: not is_destroyed implies count >= 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_STRING_TABLE


