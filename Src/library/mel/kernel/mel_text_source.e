indexing

	description: 
		"Implementation of XmTextSource.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT_SOURCE

creation
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

end -- class MEL_TEXT_SOURCE

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
