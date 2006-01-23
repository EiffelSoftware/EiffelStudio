indexing

	description: 
		"Implementation of Motif Font List."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_LIST

inherit

	MEL_MEMORY

create
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
			create Result.make (Current)
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
			"C (XmFontList, XmFontListEntry): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmFontListAppendEntry"
		end;

	xm_font_list_free (a_font_list: POINTER) is
		external
			"C (XmFontList) | <Xm/Xm.h>"
		alias
			"XmFontListFree"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_FONT_LIST


