indexing

	description: 
		"Implementation of XmStringTable. The associated C `handle' %
		%will not be collected automatically."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_STRING_TABLE

creation
	make_from_existing, make

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

	handle: POINTER;
			-- Associated C Pointer to XmStringTable structure

	count: INTEGER;
			-- Number of elements in table

	item (i: INTEGER): MEL_SHARED_STRING is
			-- Get a MEL_SHARED_STRING item at position `i'
		require
			valid_range: i > 0 and then i <= count;	
		do
			!! Result.make_from_existing (get_i_th_table (handle, i))
		ensure
			non_void_result: Result /= Void
		end;

	item_string (i: INTEGER): STRING is
			-- Eiffel string at position `i'
		require
			valid_range: i > 0 and then i <= count;	
		local
			ms: MEL_SHARED_STRING
		do
			!! ms.make_from_existing (get_i_th_table (handle, i));
			Result := ms.to_eiffel_string
		ensure
			non_void_result: Result /= Void
		end;

feature -- Element change

	put (ms: MEL_SHARED_STRING; i: INTEGER) is
			-- Put a motif string `ms' at position `i'
			-- in current table.
			--| `ms' will not be collected automatically.
		require
			i_large_enough: i > 0
			i_small_enough: i <= count;
			valid_ms: ms /= Void and then not ms.is_destroyed
		do
			xm_list_put (handle, ms.handle, i)
		end;

	put_string (str: STRING; i: INTEGER) is
			-- Put an eiffel string `str' at position `i'
			-- in current table.
			--| A MEL_SHARED_STRING is created.
		require
			valid_str: str /= Void 
			i_large_enough: i > 0
			i_small_enough: i <= count;
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (str);
			xm_list_put (handle, ms.handle, i);
		end;

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is the table destroyed?
		do
			Result := (handle = default_pointer) 
		end;

feature -- Removal

	free is
			-- Free the memory used by the xmStringTable and its
			-- contents.
		require
			exists: not is_destroyed
		do
			free_xm_string_table (handle, count);
			handle := default_pointer;
			count := 0
		ensure
			is_destroyed: is_destroyed
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

end -- class MEL_STRING_TABLE

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
