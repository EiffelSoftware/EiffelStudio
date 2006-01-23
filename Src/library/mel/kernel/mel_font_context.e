indexing

	description: 
		"Implementation of Motif Font context."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_CONTEXT

inherit

	MEL_MEMORY

create
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
				create Result.make_from_existing (p)
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
			"C (XmFontContext): EIF_POINTER | <Xm/Xm.h>"
		alias
			"XmFontListNextEntry"
		end;

	xm_font_list_free_font_context (a_font_context: POINTER) is
		external
			"C (XmFontContext) | <Xm/Xm.h>"
		alias
			"XmFontListFreeFontContext"
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




end -- class MEL_FONT_CONTEXT


