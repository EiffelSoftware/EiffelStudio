indexing

	description: 
		"Implementation of Motif Font List.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_LIST

inherit

	MEL_MEMORY

creation
	make_from_existing, 	
	append_entry

feature {NONE} -- Initialization

	append_entry (an_entry: MEL_FONT_LIST_ENTRY) is
			-- Append font list entry `an_entry' to
			-- Current font list.
		require
			valid_entry: an_entry /= Void and then an_entry.is_valid
		do
			handle := xm_font_list_append_entry (handle, an_entry.handle)
		ensure
			is_valid: is_valid
		end;

feature -- Access

	font_context: MEL_FONT_CONTEXT is
			-- Font context from Current font list
		require
			is_valid: is_valid
		do
			!! Result.make (Current)
		end;

feature -- Removal

	destroy is
			-- Free the font list.
		do
			xm_font_list_free (handle);	
			handle := default_pointer
		end;

feature {NONE} -- External features

	xm_font_list_append_entry (a_font_list, an_entry: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (XmFontList, XmFontListEntry): EIF_POINTER"
		alias
			"XmFontListAppendEntry"
		end;

	xm_font_list_free (a_font_list: POINTER) is
		external
			"C [macro <Xm/Xm.h>] (XmFontList)"
		alias
			"XmFontListFree"
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
