indexing

	description: 
		"Implementation of XmString. When instances of MEL_STRING are %
		%garbaged collected the associated C structure is automatically freed."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_STRING

inherit

	MEMORY
		rename
			free as memory_free
		export
			{NONE} all
		redefine
			dispose, is_equal
		end;
	ANY
		export
			{ANY} all
		redefine
			is_equal
		end

creation
	make,
	make_localized,
	make_l_to_r,
	make_from_existing

feature {NONE} -- Initialization

	make (a_string, a_tag: STRING) is
			-- Create the compound string.
		require
			a_string_not_void: a_string /= Void
			a_tag_not_void: a_tag /= Void
		local
			temp_str, temp_tag: ANY
		do
			temp_str := a_string.to_c;
			temp_tag := a_tag.to_c;
			handle := xm_string_create ($temp_str, $temp_tag)
		ensure
			exists: not is_destroyed;
			text_set: 
		end;

	make_localized (a_string: STRING) is
			-- Create the compound string in the current locale.
		require
			a_string_not_void: a_string /= Void
		local
			temp: ANY
		do
			temp := a_string.to_c;
			handle := xm_string_create_localized ($temp)
		ensure
			exists: not is_destroyed;
			text_set: 
		end;

	make_l_to_r (a_string, a_tag: STRING) is
			-- Create the compound string from left to right direction.
		require
			a_string_not_void: a_string /= Void
			a_tag_not_void: a_tag /= Void
		local
			temp_str, temp_tag: ANY
		do
			temp_str := a_string.to_c;
			temp_tag := a_tag.to_c;
			handle := xm_string_create_l_to_r ($temp_str, $temp_tag)
		ensure
			exists: not is_destroyed;
			text_set: 
		end;

	make_from_existing (a_xm_string: POINTER) is
			-- Create the MEL_STRING object from an existing compound string.
		require	
			a_xm_string_not_null: a_xm_string /= default_pointer
		do
			handle := a_xm_string;
		ensure
			exists: not is_destroyed
			text_set:
		end;

feature -- Access

	handle: POINTER;
			-- Associated C handle

	has_substring (a_compound_string: MEL_STRING): BOOLEAN is
			-- Does compound_string have sub-string `a_compound_string'?
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then
									  not a_compound_string.is_destroyed
		do
			Result := xm_string_has_substring (handle, a_compound_string.handle)
		end

feature -- Measurement

	baseline (a_font_list: MEL_FONT_LIST): INTEGER is
			-- Baseline spacing for a compound string
		require
			exists: not is_destroyed;
			a_font_list_exists:
		do
			-- Result := xm_string_baseline (, handle)
		ensure
			baseline_large_enough: Result >= 0
		end;

	height (a_font_list: MEL_FONT_LIST): INTEGER is
			-- Line height of a compound string
		require
			exists: not is_destroyed;
			a_font_list_exists:
		do
			-- Result := xm_string_height (, handle)
		ensure
			height_large_enough: Result >= 0
		end;

	width (a_font_list: MEL_FONT_LIST): INTEGER is
			-- Line width of a compound string
		require
			exists: not is_destroyed;
			a_font_list_exists:
		do
			-- Result := xm_string_width (, handle)
		ensure
			width_large_enough: Result >= 0
		end;

	length: INTEGER is
			-- Length of the compound string
		require
			exists: not is_destroyed
		do
			Result := xm_string_length (handle)
		ensure
			length_large_enough: Result >= 0
		end;

	line_count: INTEGER is
			-- Number of lines in the compound string
		require
			exists: not is_destroyed
		do
			Result := xm_string_line_count (handle)
		ensure
			line_count_large_enough: Result >= 0
		end;

feature -- Comparison

	compared, is_equal (a_compound_string: MEL_STRING): BOOLEAN is
			-- Is Current compound string equal to `a_compound_string'?
		require else
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then
									  not a_compound_string.is_destroyed
		do
			Result := xm_string_compare (handle, a_compound_string.handle)
		end;

	byte_compared, is_byte_equal (a_compound_string: MEL_STRING): BOOLEAN is
			-- Is Current compound string byte-per-byte equal to `a_compound_string'?
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then
									  not a_compound_string.is_destroyed
		do
			Result := xm_string_byte_compare (handle, a_compound_string.handle);
		end;

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is compound string destroyed?
		do
			Result := handle = default_pointer
		end;

	empty: BOOLEAN is
			-- Does the compound string have any text segments?
		require
			exists: not is_destroyed
		do
			Result := xm_string_empty (handle);
		end;

feature -- Element change

	append (a_compound_string: MEL_STRING) is
			-- Append `a_compound_string' to Current.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then
									  not a_compound_string.is_destroyed
		local
			temp: pointer
		do
			temp := xm_string_concat (handle, a_compound_string.handle);
			free;
			handle := temp
		end;

feature -- Removal

	dispose is
			-- GC calls this automatically when current object is
			-- not reference. By default, it destroys the associated
			-- C `handle'.
		do
			if not is_destroyed then
				free
			end
		end;

	free is
			-- Free the memory used by the compound string.
		require
			exists: not is_destroyed
		do
			xm_string_free (handle);
			handle := default_pointer
		ensure
			is_destroyed: is_destroyed
		end;

feature -- Conversion

	to_eiffel_string: STRING is
			-- Associated eiffel string
		require
			exists: not is_destroyed
		do
			Result := xm_string_to_eiffel (handle)
		ensure
			result_not_void: Result /= Void
		end;

	to_string: MEL_STRING is
			-- Create MEL_STRING that will automatically free 
			-- the C pointer
		do
			!! Result.make_from_existing (handle)
		end;

	to_shared_string: MEL_SHARED_STRING is
			-- Create shared MEL_STRING that doesn't 
			-- automatically free the C pointer (has to
			-- be freed by the programmer)
		do
			!! Result.make_from_existing (handle)
		end;

feature -- Duplication

	duplicate: MEL_STRING is
			-- Copy af this compound string
		require else
			exists: not is_destroyed
		do
			!! Result.make_from_existing (xm_string_copy (handle))
		ensure
			copy_exists: Result /= Void and then
						 not Result.is_destroyed
		end;

feature {NONE} -- Implementation

	xm_string_baseline (a_font_list, a_compound_string: POINTER): INTEGER is
		external
			"C [macro <Xm/Xm.h>] (XmFontList, XmString): EIF_INTEGER"
		alias
			"XmStringBaseline"
		end;

	xm_string_concat (compound_string1, compound_string2: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (XmString, XmString): EIF_POINTER"
		alias
			"XmStringConcat"
		end;

	xm_string_copy (a_compound_string: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (XmString): EIF_POINTER"
		alias
			"XmStringCopy"
		end;

	xm_string_create (a_c_string, a_c_tag_string: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (char *, char *): EIF_POINTER"
		alias
			"XmStringCreate"
		end;

	xm_string_create_localized (a_c_string: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (char *): EIF_POINTER"
		alias
			"XmStringCreateLocalized"
		end;

	xm_string_create_l_to_r (a_c_string, a_c_tag_string: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (char *, char *): EIF_POINTER"
		alias
			"XmStringCreateLtoR"
		end;

	xm_string_empty (a_compound_string: POINTER): BOOLEAN is
		external
			"C [macro <Xm/Xm.h>] (XmString): EIF_BOOLEAN"
		alias
			"XmStringEmpty"
		end;

	xm_string_free (a_compound_string: POINTER) is
		external
			"C [macro <Xm/Xm.h>] (XmString)"
		alias
			"XmStringFree"
		end;

	xm_string_has_substring (compound_string1, compound_string2: POINTER): BOOLEAN is
		external
			"C [macro <Xm/Xm.h>] (XmString, XmString): EIF_BOOLEAN"
		alias
			"XmStringHasSubstring"
		end;

	xm_string_height (a_font_list, a_compound_string: POINTER): INTEGER is
		external
			"C [macro <Xm/Xm.h>] (XmFontList, XmString): EIF_INTEGER"
		alias
			"XmStringHeight"
		end;

	xm_string_length (a_compound_string: POINTER): INTEGER is
		external
			"C [macro <Xm/Xm.h>] (XmString): EIF_INTEGER"
		alias
			"XmStringLength"
		end;

	xm_string_line_count (a_compound_string: POINTER): INTEGER is
		external
			"C [macro <Xm/Xm.h>] (XmString): EIF_INTEGER"
		alias
			"XmStringLineCount"
		end;

	xm_string_width (a_font_list, a_compound_string: POINTER): INTEGER is
		external
			"C [macro <Xm/Xm.h>] (XmFontList, XmString): EIF_INTEGER"
		alias
			"XmStringWidth"
		end;

	xm_string_byte_compare (a_compound_string: POINTER; another_compound_string: POINTER): BOOLEAN is
		external
			"C [macro <Xm/Xm.h>] (XmString, XmString): EIF_BOOLEAN"
		alias
			"XmStringByteCompare"
		end;

	xm_string_compare (a_compound_string: POINTER; another_compound_string: POINTER): BOOLEAN is
		external
			"C [macro <Xm/Xm.h>] (XmString, XmString): EIF_BOOLEAN"
		alias
			"XmStringCompare"
		end;

	xm_string_to_eiffel (a_compound_string: POINTER): STRING is
		external
			"C"
		end;

end -- class MEL_STRING

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
