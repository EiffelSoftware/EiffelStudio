indexing

	description: 
		"Implementation of an XFontStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_STRUCT

inherit

	MEL_RESOURCE

creation
	make, 
	make_from_existing_handle

feature {NONE} -- Initialization

	make (a_display: MEL_DISPLAY; a_font_name: STRING) is 
			-- Create a font structure with name `a_font_name'
			-- for `display'.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			valid_font_name: a_font_name /= Void
		local
			ext_name: ANY
		do 
			ext_name := a_font_name.to_c;
			display_handle := a_display.handle;
			handle := x_load_query_font (display_handle, $ext_name);
			is_shared := True
		ensure
			is_shared: is_shared
		end;

feature -- Access

	font_id: POINTER is
			-- Font id
		require
			is_valid: is_valid
		do
			Result := mel_font_id (handle)
		end;

	ascent: INTEGER is
			-- Ascent value in pixels
		require
			is_valid: is_valid
		do
			Result := mel_font_ascent (handle)
		end;

	descent: INTEGER is
			-- Descent value in pixels
		require
			is_valid: is_valid
		do
			Result := mel_font_descent (handle)
		end;

	text_width (a_text: STRING): INTEGER is
			-- Width of string `a_text' in pixels
		require
			is_valid: is_valid
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			Result := x_text_width (handle, $ext_name, a_text.count)
		end;

	font_list: MEL_FONT_LIST is
			-- Create a font list from Current font structure
			-- Use the default font and append a single entry
			-- to the Result
		local
			an_entry: MEL_FONT_LIST_ENTRY
		do
			!! an_entry.make_default_from_font_struct (Current);
			!! Result.append_entry (an_entry);
			an_entry.destroy
		end;

feature -- Removal

	destroy is
			-- Free font structure.
		do
			check
				valid_display: has_valid_display
			end;
			x_free_font (display_handle, handle);
			handle := default_pointer
		end;

feature {NONE} -- External features

	mel_font_id (a_font: POINTER): POINTER is
		external
			"C [macro %"font.h%"] (XFontStruct *): EIF_POINTER"
		alias
			"mel_font_id"
		end;

	mel_font_descent (a_font: POINTER): INTEGER is
		external
			"C [macro %"font.h%"] (XFontStruct *): EIF_INTEGER"
		alias
			"mel_font_descent"
		end;

	mel_font_ascent (a_font: POINTER): INTEGER is
		external
			"C [macro %"font.h%"] (XFontStruct *): EIF_INTEGER"
		alias
			"mel_font_ascent"
		end;

	x_free_font (a_display: POINTER; a_font: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, XFontStruct *) | <X11/Xlib.h>"
		alias
			"XFreeFont"
		end;

	x_load_query_font (a_display: POINTER; font_name: POINTER): POINTER is
		external
			"C (Display *, char *): EIF_POINTER | <X11/Xlib.h>"
		alias
			"XLoadQueryFont"
		end;

	x_text_width (a_font: POINTER; a_string: POINTER; count: INTEGER): INTEGER is
		external
			"C (XFontStruct *, char *, int): EIF_INTEGER | <X11/Xlib.h>"
		alias
			"XTextWidth"
		end;

end -- class MEL_FONT_STRUCT


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

