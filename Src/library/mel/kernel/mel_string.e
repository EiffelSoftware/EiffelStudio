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

	MEL_MEMORY
		redefine
			is_equal
		end

creation
	make,
	make_localized,
	make_default_l_to_r,
	make_l_to_r,
	make_from_existing

feature {NONE} -- Initialization

	make (a_string, a_tag: STRING) is
			-- Create the compound string `a_string' with `a_tag'.
		require
			string_not_void: a_string /= Void
			tag_not_void: a_tag /= Void
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
			-- Create the compound string `a_string' with `a_tag'
			-- in current locale (default font list tag is 
			-- XmFONTLIST_DEFAULT_TAG).
		require
			string_not_void: a_string /= Void
		local
			temp: ANY
		do
			temp := a_string.to_c;
			handle := xm_string_create_localized ($temp)
		ensure
			exists: not is_destroyed
		end;

	make_l_to_r (a_string, a_tag: STRING) is
			-- Create the compound string with `a_tag' from left to 
			-- right direction interpreting `%N'.
		require
			string_not_void: a_string /= Void
			tag_not_void: a_tag /= Void
		local
			temp_str, temp_tag: ANY
		do
			temp_str := a_string.to_c;
			temp_tag := a_tag.to_c;
			handle := xm_string_create_l_to_r ($temp_str, $temp_tag)
		ensure
			exists: not is_destroyed
		end;

	make_default_l_to_r (a_string: STRING) is
			-- Create compound string with tag `XmFONTLIST_DEFAULT_TAG' 
			-- from left to right direction interpreting `%N'.
		require
			string_not_void: a_string /= Void
		local
			temp_str: ANY
		do
			temp_str := a_string.to_c;
			handle := xm_string_create_l_to_r ($temp_str, 
					XmFONTLIST_DEFAULT_TAG)
		ensure
			exists: not is_destroyed
		end;

feature -- Access

	has_substring (a_compound_string: MEL_STRING): BOOLEAN is
			-- Does compound_string have sub-string `a_compound_string'?
		require
			exists: not is_destroyed;
			compound_string_exists: a_compound_string /= Void and then
									  not a_compound_string.is_destroyed
		do
			Result := xm_string_has_substring (handle, a_compound_string.handle)
		end

feature -- Measurement

	baseline (a_font_list: MEL_FONT_LIST): INTEGER is
			-- Baseline spacing for a compound string
		require
			exists: not is_destroyed;
			font_list_exists: a_font_list /= Void and then a_font_list.is_valid
		do
			Result := xm_string_baseline (a_font_list.handle, handle)
		ensure
			baseline_large_enough: Result >= 0
		end;

	height (a_font_list: MEL_FONT_LIST): INTEGER is
			-- Line height of a compound string
		require
			exists: not is_destroyed;
			font_list_exists: a_font_list /= Void and then a_font_list.is_valid
		do
			Result := xm_string_height (a_font_list.handle, handle)
		ensure
			height_large_enough: Result >= 0
		end;

	width (a_font_list: MEL_FONT_LIST): INTEGER is
			-- Line width of a compound string
		require
			exists: not is_destroyed;
			font_list_exists: a_font_list /= Void and then a_font_list.is_valid
		do
			Result := xm_string_width (a_font_list.handle, handle)
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
			destroy;
			handle := temp
		end;

feature -- Removal

	destroy is
			-- Free the memory used by the compound string.
		do
			xm_string_free (handle);
			handle := default_pointer
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

feature -- Duplication

	duplicate: MEL_STRING is
			-- Copy this compound string
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
			"C (XmFontList, XmString): EIF_INTEGER | <Xm/Xm.h>"
		alias
			"XmStringBaseline"
		end;

	xm_string_concat (compound_string1, compound_string2: POINTER): POINTER is
		external
			"C (XmString, XmString): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmStringConcat"
		end;

	xm_string_copy (a_compound_string: POINTER): POINTER is
		external
			"C (XmString): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmStringCopy"
		end;

	xm_string_create (a_c_string, a_c_tag_string: POINTER): POINTER is
		external
			"C (char *, char *): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmStringCreate"
		end;

	xm_string_create_localized (a_c_string: POINTER): POINTER is
		external
			"C (char *): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmStringCreateLocalized"
		end;

	xm_string_create_l_to_r (a_c_string, a_c_tag_string: POINTER): POINTER is
		external
			"C (char *, char *): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmStringCreateLtoR"
		end;

	xm_string_empty (a_compound_string: POINTER): BOOLEAN is
		external
			"C (XmString): EIF_BOOLEAN | <Xm/Xm.h>"
		alias
			"XmStringEmpty"
		end;

	xm_string_free (a_compound_string: POINTER) is
		external
			"C (XmString) | <Xm/Xm.h>"
		alias
			"XmStringFree"
		end;

	xm_string_has_substring (compound_string1, compound_string2: POINTER): BOOLEAN is
		external
			"C (XmString, XmString): EIF_BOOLEAN | <Xm/Xm.h>"
		alias
			"XmStringHasSubstring"
		end;

	xm_string_height (a_font_list, a_compound_string: POINTER): INTEGER is
		external
			"C (XmFontList, XmString): EIF_INTEGER | <Xm/Xm.h>"
		alias
			"XmStringHeight"
		end;

	xm_string_length (a_compound_string: POINTER): INTEGER is
		external
			"C (XmString): EIF_INTEGER | <Xm/Xm.h>"
		alias
			"XmStringLength"
		end;

	xm_string_line_count (a_compound_string: POINTER): INTEGER is
		external
			"C (XmString): EIF_INTEGER | <Xm/Xm.h>"
		alias
			"XmStringLineCount"
		end;

	xm_string_width (a_font_list, a_compound_string: POINTER): INTEGER is
		external
			"C (XmFontList, XmString): EIF_INTEGER | <Xm/Xm.h>"
		alias
			"XmStringWidth"
		end;

	xm_string_byte_compare (a_compound_string: POINTER; another_compound_string: POINTER): BOOLEAN is
		external
			"C (XmString, XmString): EIF_BOOLEAN | <Xm/Xm.h>"
		alias
			"XmStringByteCompare"
		end;

	xm_string_compare (a_compound_string: POINTER; another_compound_string: POINTER): BOOLEAN is
		external
			"C (XmString, XmString): EIF_BOOLEAN | <Xm/Xm.h>"
		alias
			"XmStringCompare"
		end;

	xm_string_to_eiffel (a_compound_string: POINTER): STRING is
		external
			"C"
		end;

	XmFONTLIST_DEFAULT_TAG: POINTER is
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmFONTLIST_DEFAULT_TAG"
		end;

end -- class MEL_STRING


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

