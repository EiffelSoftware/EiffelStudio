indexing

	description: 
		"Representation of an atom.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_ATOM

creation
	make,
	make_from_existing

feature {NONE} -- Initialization

	make (display: MEL_DISPLAY; a_name: STRING; only_if_exists: BOOLEAN) is
			-- Create Atom with property `a_name' for `display'.
			-- If `only_if_exists' and no atom exists with `a_name'
			-- then a NULL pointer is returned. Otherwize, an atom
		local
			ext: ANY
		do
			ext := a_name.to_c;
			identifier := xm_intern_atom (display.handle, $ext, only_if_exists)
		end;

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
			-- Identifier of an atom

	name (a_display: MEL_DISPLAY): STRING is
			-- Name of the atom from `a_display'
		require
			valid_display: a_display /= Void and then a_display.is_valid
		local
			p: POINTER
		do
			p := xm_get_atom_name (a_display.handle, identifier);
			!! Result.make (0);
			if p /= default_pointer then
				Result.from_c (p);
				xt_free (p);
			end
		end

feature {NONE} -- External features

	xm_intern_atom (display_ptr, str: POINTER; b: BOOLEAN): POINTER is
		external
			 "C (Display *, String, Boolean): EIF_POINTER | <Xm/AtomMgr.h>"
		alias
			"XmInternAtom"
		end;

	xm_get_atom_name (display_ptr, id: POINTER): POINTER is
		external
			 "C (Display *, Atom): EIF_POINTER | <Xm/AtomMgr.h>"
		alias
			"XmGetAtomName"
		end;

	xt_free (obj: POINTER) is
		external
			"C (XtPointer) | <X11/Intrinsic.h>"
		alias
			"XtFree"
		end;

invariant

	non_null_identifier: identifier /= default_pointer

end -- class MEL_ATOM

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
