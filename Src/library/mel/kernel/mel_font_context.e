indexing

	description: 
		"Implementation of Motif Font context.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_CONTEXT

inherit

	MEL_MEMORY

creation
	make

feature {NONE} -- Initialization

	make (a_font_list: MEL_FONT_LIST) is
			-- Create a font context for `a_font_list'.
		require
			valid_font_list: a_font_list /= Void and then a_font_list.is_valid
		do
			handle := xm_font_list_init_font_context (a_font_list.handle)
		end

feature -- Access

	next_entry: MEL_FONT_LIST_ENTRY is
			-- Next entry in a font_list
		require
			is_valid: is_valid
		local
			p: POINTER
		do
			p := xm_font_list_next_entry (handle);
			if p /= default_pointer then	
				!! Result.make_from_existing (p)
			end
		ensure
			valid_result: Result /= Void implies Result.is_valid
		end;

feature -- Removal

	destroy is
			-- Free font context.
		do
			xm_font_list_free_font_context (handle);
			handle := default_pointer
		end;

feature {NONE} -- External features

	xm_font_list_init_font_context (a_font_list: POINTER): POINTER is
		external
			"C"
		end;

	xm_font_list_next_entry (a_font_context: POINTER): POINTER is
		external
			"C [macro <Xm/Xm.h>] (XmFontContext): EIF_POINTER"
		alias
			"XmFontListNextEntry"
		end;

	xm_font_list_free_font_context (a_font_context: POINTER) is
		external
			"C [macro <Xm/Xm.h>] (XmFontContext)"
		alias
			"XmFontListFreeFontContext"
		end;

end -- class MEL_RESOURCE

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
