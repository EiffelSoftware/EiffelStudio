indexing

	description: 
		"Implementation of font names for a particular pattern.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_LIST_NAMES

inherit

	FIXED_LIST [STRING]
		rename
			make as list_make
		export
			{NONE} list_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_display: MEL_DISPLAY; a_pattern: STRING; max: INTEGER) is
			-- Make from an existing C `a_font_list_ptr'.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			pattern_not_void: a_pattern /= Void;
			valid_max: max >=0 
		local
			c: INTEGER;
			ext: ANY;
			handle: POINTER
		do 
			ext := a_pattern.to_c;
			handle := x_list_fonts (a_display.handle, $ext, max, $c);
			if handle = default_pointer then
				list_make (0);
			else
				list_make (c);
				fill_from_handle (handle);
				x_free_font_names (handle)
			end
		end;

feature {NONE} -- Implementation

	fill_from_handle (handle: POINTER) is
			-- Fill list from C `handle'.
		require
			handle_not_null: handle /= default_pointer
		local
			ptr: POINTER;
			str: STRING
		do
			from
				start;
			until
				after
			loop
				!! str.make (0);
				str.from_c (mel_font_list_name (handle, index));
				replace (str);
				forth
			end
		ensure
			valid_list: not has (Void)
		end;

feature {NONE} -- External features

	mel_font_list_name (a_font_list: POINTER; a_pos: INTEGER): POINTER is
		external
			"C [macro %"font.h%"] (char **, int): EIF_POINTER"
		alias
			"mel_font_list_name"
		end;

	x_free_font_names (a_font_list: POINTER) is
		external
			"C (char **) | <X11/Xlib.h>"
		alias
			"XFreeFontNames"
		end;

	x_list_fonts (a_display, a_pattern: POINTER; max: INTEGER; a_count: POINTER): POINTER is
		external
			"C (Display *, char *, int, int *): EIF_POINTER | <X11/Xlib.h>"
		alias
			"XListFonts"
		end;

end -- class MEL_FONT_LIST

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
