indexing

	description: 
		"Implementation of Font List Entry.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_LIST_ENTRY

inherit

	MEL_MEMORY

creation
	make_from_existing, 
	make_from_font_struct,
	make_default_from_font_struct,
	make_using_font

feature {NONE} -- Initialization

	make_default_from_font_struct (a_font_struct: MEL_FONT_STRUCT) is
			-- Make a font_list entry from `a_font_struct' using
			-- the font list default tag (XmFONTLIST_DEFAULT_TAG). 
		require
			valid_font_struct: a_font_struct /= Void 
				and then a_font_struct.is_valid
		do
			handle := xm_font_list_entry_create 
				(XmFONTLIST_DEFAULT_TAG, XmFONT_IS_FONT, a_font_struct.handle)
		end;

	make_from_font_struct (a_tag: STRING; a_font_struct: MEL_FONT_STRUCT) is
			-- Make a font_list entry from `a_font_struct'.
		require
			tag_not_void: a_tag /= Void;
			valid_font_struct: a_font_struct /= Void 
				and then a_font_struct.is_valid
		local
			ext1: ANY
		do
			ext1 := a_tag.to_c;
			handle := xm_font_list_entry_create 
				($ext1, XmFONT_IS_FONT, a_font_struct.handle)
		end;

	make_using_font (a_display: MEL_DISPLAY; a_name: STRING; a_tag: STRING) is
			-- Make a font_list entry from `a_name' with tag `a_tag'
			-- for display `a_display' using XmFONT_IS_FONT for font format.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			name_not_void: a_name /= Void;
			tag_not_void: a_tag /= Void;
		local
			ext1, ext2: ANY
		do
			ext1 := a_name.to_c;
			ext2 := a_tag.to_c;
			handle := xm_font_list_entry_load (a_display.handle, 
						$ext1, XmFONT_IS_FONT, $ext2)
		end;

feature -- Access

	font_struct: MEL_FONT_STRUCT is
			-- Font structure of entry
		require
			is_valid: is_valid
		local
			p: POINTER;
			font_type: POINTER
		do
				-- At the moment only support XFontStruct
			p := xm_font_list_entry_get_font (handle, $font_type);
			check
				valid_font_type: font_type = XmFONT_IS_FONT or else
						font_type = XmFONT_IS_FONTSET
			end;
			
			if font_type = XmFONT_IS_FONT then
				!! Result.make_from_existing_handle (p)
			elseif font_type = XmFONT_IS_FONTSET then 
					-- We look at the C level for the first
					-- XFontStruct in the XFontSet returned
					-- by XmFontListEntryGetFont.
				p := x_build_font_from_set (p)
				!! Result.make_from_existing_handle (p)
			end
		end;

	tag: STRING is
			-- Tag of entry
		require
			is_valid: is_valid
		local
			p: POINTER
		do
			p := xm_font_list_entry_get_tag (handle);
			!! Result.make (0);
			Result.from_c (p);
			xt_free (p)
		end;

feature -- Removal

	destroy is
			-- Free the font list entry.
		do	
			xm_font_list_entry_free (handle);
			handle := default_pointer
		end;

feature {NONE} -- External features

	xm_font_list_entry_load (a_display, a_name, a_font_type, 
			a_tag: POINTER): POINTER is
		external
			"C (Display *, char *,%
				%XmFontType, char *): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmFontListEntryLoad"
		end;

	xm_font_list_entry_create (a_tag, a_font_type, a_font: POINTER): POINTER is
		external
			"C (char *, XmFontType, XtPointer): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmFontListEntryCreate"
		end;

	xm_font_list_entry_free (an_entry: POINTER) is
		external
			"C"
		end;

	xm_font_list_entry_get_tag (an_entry: POINTER): POINTER is
		external
			"C (XmFontListEntry): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmFontListEntryGetTag"
		end;

	xm_font_list_entry_get_font (an_entry: POINTER; 
				a_f_type: POINTER): POINTER is
		external
			"C (XmFontListEntry, XmFontType  *): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmFontListEntryGetFont"
		end;

	XmFONT_IS_FONT: POINTER is
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmFONT_IS_FONT"
		end;

	XmFONT_IS_FONTSET: POINTER is
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmFONT_IS_FONTSET"
		end;

	XmFONTLIST_DEFAULT_TAG: POINTER is
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmFONTLIST_DEFAULT_TAG"
		end;

	xt_free (obj: POINTER) is
		external
			"C (XtPointer) | <X11/Intrinsic.h>"
		alias
			"XtFree"
		end;

	x_build_font_from_set (p: POINTER): POINTER is
		external
			"C | %"font.h%""
		alias
			"x_build_font_from_set"
		end

end -- class MEL_FONT_LIST_ENTRY


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

