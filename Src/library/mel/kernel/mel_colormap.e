indexing

	description: 
		"Implementation of Colormap";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COLORMAP

creation
	make_from_existing

feature {NONE} -- Initialization

    make_from_existing (an_id: like identifier) is
            -- Initialize atom with C pointer `an_id'.
        require
            an_id_not_null: an_id /= default_pointer
        do
            identifier := an_id
        ensure
            set: identifier = an_id
        end;

feature -- Access

	identifier: POINTER;
			-- Associated C identifier

invariant

    non_null_identifier: identifier /= default_pointer

end -- class MEL_COLORMAP

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
