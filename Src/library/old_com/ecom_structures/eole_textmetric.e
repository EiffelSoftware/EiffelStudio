indexing

	description: "TEXTMETRIC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class EOLE_TEXTMETRIC

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
feature -- Element Change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_textmetric_allocate
		end

	set_height (hei: INTEGER) is
			-- Set 'tmHeight' member of corresponding
			-- C++ structure to `hei'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_height (ole_ptr, hei)
		ensure
			height_set: height = hei
		end

	set_ascent (asc: INTEGER) is
			-- Set 'tmAscent' member of corresponding
			-- C++ structure to `asc'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_ascent (ole_ptr, asc)
		ensure
			ascent_set: ascent = asc
		end

	set_descent (desc: INTEGER) is
			-- Set 'tmDescent' member of corresponding
			-- C++ structure to `desc'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_descent (ole_ptr, desc)
		ensure
			descent_set: descent = desc
		end

	set_internal_leading (inleading: INTEGER) is
			-- Set 'tmInternalLeading' member of corresponding
			-- C++ structure to `inleading'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_internal_leading (ole_ptr, inleading)
		ensure
			internal_leading_set: internal_leading = inleading
		end

	set_external_leading (exleading: INTEGER) is
			-- Set 'tmExternalLeading' member of corresponding
			-- C++ structure to `exleading'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_external_leading (ole_ptr, exleading)
		ensure
			external_leading_set: external_leading = exleading
		end

	set_ave_char_width (char_width: INTEGER) is
			-- Set 'tmAveCharWidth' member of corresponding
			-- C++ structure to `char_width'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_ave_char_width (ole_ptr, char_width)
		ensure
			ave_char_width_set: ave_char_width = char_width
		end

	set_weight (w: INTEGER) is
			-- Set 'tmWeight' member of corresponding
			-- C++ structure to `w'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_weight (ole_ptr, w)
		ensure
			weight_set: weight = w
		end

	set_max_char_width (char_width: INTEGER) is
			-- Set the 'tmMaxCharWidth' member of the corresponding
			-- C++ structure to `char_width'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_max_char_width (ole_ptr, char_width)
		ensure
			max_char_width_set: max_char_width = char_width
		end

	set_italic (ital: BOOLEAN) is
			-- Set 'tmItalic' member of corresponding
			-- C++ structure to `ital'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_italic (ole_ptr, ital)
		ensure
			italic_set: italic = ital
		end

	set_underlined (under: BOOLEAN) is
			-- Set 'tmUnderlined' member of corresponding
			-- C++ structure to `under'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_underlined (ole_ptr, under)
		ensure
			underlined_set: underlined = under
		end

	set_struck_out (sout: BOOLEAN) is
			-- Set 'tmStruckOut' member of corresponding
			-- C++ structure to `struck_out'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_struck_out (ole_ptr, sout)
		ensure
			struck_out_set: struck_out = sout
		end

	set_first_char (fchar: INTEGER) is
			-- Set 'tmFirstChar' member of corresponding
			-- C++ structure to `fchar'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_first_char (ole_ptr, fchar)
		ensure
			first_char_set: first_char = fchar
		end

	set_last_char (lchar: INTEGER) is
			-- Set 'tmLastChar' member of corresponding
			-- C++ structure to `lchar'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_last_char (ole_ptr, lchar)
		ensure
			last_char_set: last_char = lchar
		end

	set_default_char (dchar: INTEGER) is
			-- Set the 'tmDefaultChar' member of the corresponding
			-- C++ structure to `default_char'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_default_char (ole_ptr, dchar)
		ensure
			default_char_set: default_char = dchar
		end

	set_break_char (bchar: INTEGER) is
			-- Set 'tmBreakChar' member of corresponding
			-- C++ structure to `bchar'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_break_char (ole_ptr, bchar)
		ensure
			break_char_set: break_char = bchar
		end

	set_pitch_and_family (paf: INTEGER) is
			-- Set 'tmPitchAndFamily' member of corresponding
			-- C++ structure to `pitch_and_family'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_pitch_and_family (ole_ptr, paf)
		ensure
			pitch_and_family_set: pitch_and_family = paf
		end

	set_char_set (cset: INTEGER) is
			-- Set the 'tmCharSet' member of the corresponding
			-- C++ structure to `cset'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_char_set (ole_ptr, cset)
		ensure
			char_set_set: char_set = cset
		end

	set_overhang (overh: INTEGER) is
			-- Set 'tmOverhang' member of corresponding
			-- C++ structure to `overh'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_overhang (ole_ptr, overh)
		ensure
			overhang_set: overhang = overh
		end

	set_digitized_aspect_x (daspect_x: INTEGER) is
			-- Set the 'tmDigitizedAspectX' member of the corresponding
			-- C++ structure to `daspect_x'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_digitized_aspect_x (ole_ptr, daspect_x)
		ensure
			digitized_aspect_x_set: digitized_aspect_x = daspect_x
		end

	set_digitized_aspect_y (daspect_y: INTEGER) is
			-- Set the 'tmDigitizedAspectY' member of the corresponding
			-- C++ structure to `daspect_y'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_textmetric_set_digitized_aspect_y (ole_ptr, daspect_y)
		ensure
			digitized_aspect_y_set: digitized_aspect_y = daspect_y
		end
		
feature -- Access

	height: INTEGER is
			-- Height of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_height (ole_ptr)
		end
		
	ascent: INTEGER is
			-- Ascent of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_ascent (ole_ptr)
		end
		
	descent: INTEGER is
			-- Descent of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_descent (ole_ptr)
		end

	internal_leading: INTEGER is
			-- Internal leading of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_internal_leading (ole_ptr)
		end

	external_leading: INTEGER is
			-- External leading of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_external_leading (ole_ptr)
		end

	ave_char_width: INTEGER is
			-- Average character width of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_ave_char_width (ole_ptr)
		end

	max_char_width: INTEGER is
			-- Maximum character width of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_max_char_width (ole_ptr)
		end

	weight: INTEGER is
			-- Weight of textmetric element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_weight (ole_ptr)
		end

	italic: BOOLEAN is
			-- Is font italic?
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_italic (ole_ptr) /= 0
		end

	underlined: BOOLEAN is
			--	Is font underlined?
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_underlined (ole_ptr) /= 0
		end

	struck_out: BOOLEAN is
			-- Is font strikeout?
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_struck_out (ole_ptr) /= 0
		end

	first_char: INTEGER is
			-- First character defined in font
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_first_char (ole_ptr)
		end

	last_char: INTEGER is
			-- Last character defined in font
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_last_char (ole_ptr)
		end

	default_char: INTEGER is
			-- Character to be substituted for characters not in font
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_default_char (ole_ptr)
		end

	break_char: INTEGER is
			-- Character that will be used to define word breaks for text justification
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_break_char (ole_ptr)
		end

	pitch_and_family: INTEGER is
			-- information about pitch, technology, and family of physical font
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_pitch_and_family (ole_ptr)
		end

	char_set: INTEGER is
			-- character set of font
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_char_set (ole_ptr)
		end

	overhang: INTEGER is
			-- Extra width per string that may be added to some synthesized fonts
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_overhang (ole_ptr)
		end

	digitized_aspect_x: INTEGER is
			-- Horizontal aspect of device for which font was designed
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_digitized_aspect_x (ole_ptr)
		end

	digitized_aspect_y: INTEGER is
			-- Vertical aspect of device for which font was designed
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_textmetric_get_digitized_aspect_y (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_textmetric_allocate: POINTER is
		external
			"C"
		alias
			"eole2_textmetric_allocate"
		end

	ole2_textmetric_set_height (this: POINTER; h: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_height"
		end

	ole2_textmetric_get_height (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_height"
		end

	ole2_textmetric_set_ascent (this: POINTER; asc: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_ascent"
		end

	ole2_textmetric_get_ascent (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_ascent"
		end

	ole2_textmetric_set_descent (this: POINTER; desc: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_descent"
		end

	ole2_textmetric_get_descent (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_descent"
		end

	ole2_textmetric_set_internal_leading (this: POINTER; inleading: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_internal_leading"
		end

	ole2_textmetric_get_internal_leading (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_internal_leading"
		end

	ole2_textmetric_set_external_leading (this: POINTER; exleading: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_external_leading"
		end

	ole2_textmetric_get_external_leading (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_external_leading"
		end

	ole2_textmetric_set_ave_char_width (this: POINTER; width: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_ave_char_width"
		end

	ole2_textmetric_get_ave_char_width (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_ave_char_width"
		end

	ole2_textmetric_set_max_char_width (this: POINTER; width: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_max_char_width"
		end

	ole2_textmetric_get_max_char_width (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_max_char_width"
		end

	ole2_textmetric_set_weight (this: POINTER; w: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_weight"
		end

	ole2_textmetric_get_weight (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_weight"
		end

	ole2_textmetric_set_italic (this: POINTER; ital: BOOLEAN) is
		external
			"C"
		alias
			"eole2_textmetric_set_italic"
		end

	ole2_textmetric_get_italic (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_italic"
		end

	ole2_textmetric_set_underlined (this: POINTER; underl: BOOLEAN) is
		external
			"C"
		alias
			"eole2_textmetric_set_underlined"
		end

	ole2_textmetric_get_underlined (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_underlined"
		end

	ole2_textmetric_set_struck_out (this: POINTER; sout: BOOLEAN) is
		external
			"C"
		alias
			"eole2_textmetric_set_struck_out"
		end

	ole2_textmetric_get_struck_out (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_struck_out"
		end

	ole2_textmetric_set_first_char (this: POINTER; fchar: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_first_char"
		end

	ole2_textmetric_get_first_char (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_first_char"
		end

	ole2_textmetric_set_last_char (this: POINTER; lchar: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_last_char"
		end

	ole2_textmetric_get_last_char (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_last_char"
		end

	ole2_textmetric_set_default_char (this: POINTER; dchar: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_default_char"
		end

	ole2_textmetric_get_default_char (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_default_char"
		end

	ole2_textmetric_set_break_char (this: POINTER; bchar: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_break_char"
		end

	ole2_textmetric_get_break_char (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_break_char"
		end

	ole2_textmetric_set_pitch_and_family (this: POINTER; paf: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_pitch_and_family"
		end

	ole2_textmetric_get_pitch_and_family (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_pitch_and_family"
		end

	ole2_textmetric_set_char_set (this: POINTER; cset: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_char_set"
		end

	ole2_textmetric_get_char_set (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_char_set"
		end

	ole2_textmetric_set_overhang (this: POINTER; overh: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_overhang"
		end

	ole2_textmetric_get_overhang (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_overhang"
		end

	ole2_textmetric_set_digitized_aspect_x (this: POINTER; daspect_x: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_digitized_aspect_x"
		end

	ole2_textmetric_get_digitized_aspect_x (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_digitized_aspect_x"
		end

	ole2_textmetric_set_digitized_aspect_y (this: POINTER; d_y: INTEGER) is
		external
			"C"
		alias
			"eole2_textmetric_set_digitized_aspect_y"
		end

	ole2_textmetric_get_digitized_aspect_y (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_textmetric_get_digitized_aspect_y"
		end
	
end -- class EOLE_TEXTMETRIC

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

