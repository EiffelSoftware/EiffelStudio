indexing

	description: 
		"Implementation of XmTextSource."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT_SOURCE

create
	make_from_existing

feature {NONE} -- Initialization

	make_from_existing (a_xm_text_source: POINTER) is
			-- Create the MEL_TEXT_SOURCE object from an existing text source.
		require	
			xm_text_source_not_null: a_xm_text_source /= default_pointer
		do
			handle := a_xm_text_source;
		ensure
			exists: not is_destroyed
		end;

feature -- Access

	handle: POINTER
			-- Associated C handle pointing to a XmTextSource structure

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is the text source destroyed?
		do
			Result := handle = default_pointer
		end;

feature -- Removal

	destroy is
			-- Free the object.
		require
			exists: not is_destroyed
		do
			handle := default_pointer
		ensure
			destroyed: is_destroyed
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




end -- class MEL_TEXT_SOURCE


