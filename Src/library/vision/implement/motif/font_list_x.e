indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FONT_LIST_X 

inherit

	FONT_LIST_I;

	MEMORY
		undefine
			is_equal, copy, consistent, setup
		redefine
			dispose
		end;

	FIXED_LIST [FONT]
		rename
			make as list_create,
			item as list_item,
			i_th as list_i_th,
			first as list_first,
			last as list_last,
			index_of as list_index_of,
			has as list_has,
			put as list_put,
			put_i_th as list_put_i_th,
			wipe_out as list_wipe_out,
			search as list_search
		export
			{NONE} all
		end;

creation

	make

feature 

	make (a_font_list: FONT_LIST) is
			-- Create a font list
		local
			display_ptr, void_pointer: POINTER
		do
			display_ptr := a_font_list.screen.implementation.screen_object;
			fonts_ptr := get_font_list (display_ptr);
			if fonts_ptr /= void_pointer then
				list_create (get_font_count)
			end
		end; 

	dispose is
			-- Free the font list pointer.
		do
			x_free_font_names (fonts_ptr);
		end;

	destroy is
			-- Free memory allocated for current font list
			-- and init `fonts_ptr' to `Void' and `count' to `0'.
		local
			void_pointer: POINTER	
		do
			x_free_font_names (fonts_ptr);
			fonts_ptr := void_pointer;
			list_wipe_out
		end; 

	first: FONT is
			-- Item at first position
		require else
			not_empty: not empty
		
		do
			Result := list_first;
			if (Result = Void) then
				!!Result.make;
				Result.set_name (font_table_item (fonts_ptr));
				list_put_i_th (Result, 1)
			end
		ensure then
			element_exists: not (Result = Void)
		end; 

	
feature {NONE}

	fonts_ptr: POINTER;
			-- Pointer on X fonts list
	
feature 

	has (v: like first): BOOLEAN is
			-- Does `v' appear in the chain ?
		require else
			not_v_void: not (v = Void)
		do
			Result := list_has (v)
		end; 

	i_th (i: INTEGER): FONT is
			-- Item at `i'_th position
		require else
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		
		do
			Result := list_i_th (i);
			if (Result = Void) then
				!!Result.make;
				Result.set_name (font_table_i_th (fonts_ptr, i));
				list_put_i_th (Result, i)
			end
		ensure then
			element_exists: not (Result = Void)
		end; 

	index_of (v: like first; i: INTEGER): INTEGER is
			-- Index of `i'-th item `v'; 0 if none
		require else
			search_element_exists: not (v = Void);
			positive_occurrence: i > 0
		do
			Result := list_index_of (v, i)
		ensure then
			Result >= 0
		end; 

	item: FONT is
			-- Item at cursor position
		require else
			not_off: not off
		
		do
			Result := list_item;
			if (Result = Void) then
				!!Result.make;
				Result.set_name (font_table_i_th (fonts_ptr, index));
				list_put (Result)
			end
		ensure then
			element_exists: not (Result = Void)
		end; 

	last: FONT is
			-- Item at last position
		require else
			not_empty: not empty
		
		local
			font_index: INTEGER
		do
			Result := list_last;
			if (Result = Void) then
				!!Result.make;
				Result.set_name (font_table_i_th (fonts_ptr, count));
				list_put_i_th (Result, count)
			end
		ensure then
			element_exists: not (Result = Void)
		end; 

	search_equal (v: like first) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		do
			from
				start
			until
				off or v.name.is_equal (item.name)
			loop
				forth
			end
		end; 

	
feature {NONE}

	search_same (v: like first) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (reference equality);
			-- go off right if none.
		require
			search_element_exists: not (v = Void)
		local
			keep_object_comparison: BOOLEAN;
		do
			keep_object_comparison := object_comparison;
			object_comparison := false;	
			list_search (v);
			object_comparison := keep_object_comparison
		ensure
			(not off) implies (v = item)
		end

feature {NONE} -- External features

	get_font_list (disp: POINTER): POINTER is
		external
			"C"
		end; 

	font_table_i_th (ptr: POINTER; i: INTEGER): STRING is
		external
			"C"
		end; 

	font_table_item (ptr: POINTER): STRING is
		external
			"C"
		end; 

	x_free_font_names (ptr: POINTER) is
		external
			"C"
		alias
			"XFreeFontNames"
		end; 

	get_font_count: INTEGER is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
