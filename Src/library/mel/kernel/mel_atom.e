indexing

	description: 
		"Representation of an atom.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_ATOM

creation
	make,
	make_from_existing,
	make_primary,
	make_string

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
			-- Initialize atom with C Atom `an_id'.
		require
			an_id_not_null: an_id /= default_pointer
		do
			identifier := an_id
		ensure
			set: identifier = an_id
		end;

	make_primary is
			-- Create a XA_PRIMARY atom.
		do
			identifier := XA_PRIMARY
		ensure
			set: identifier = XA_PRIMARY
		end;

	make_string is
			-- Create a XA_STRING atom.
		do
			identifier := XA_STRING
		ensure
			set: identifier = XA_STRING
		end;

feature -- Access

	identifier: POINTER;
			-- Identifier of an atom

	is_valid: BOOLEAN is
			-- Is the atom valid?
		do
			Result := identifier /= default_pointer
		end;

	name (a_display: MEL_DISPLAY): STRING is
			-- Name of the atom from `a_display'
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			is_valid: is_valid
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
			 "C [macro <Xm/AtomMgr.h>] (Display *, String, Boolean): EIF_POINTER"
		alias
			"XmInternAtom"
		end;

	xm_get_atom_name (display_ptr, id: POINTER): POINTER is
		external
			 "C [macro <Xm/AtomMgr.h>] (Display *, Atom): EIF_POINTER"
		alias
			"XmGetAtomName"
		end;

	xt_free (obj: POINTER) is
		external
			"C (XtPointer) | <X11/Intrinsic.h>"
		alias
			"XtFree"
		end;

	XA_PRIMARY: POINTER is
		external
			"C [macro <X11/Xatom.h>]: EIF_POINTER | <X11/X.h>"
		alias
			"XA_PRIMARY"
		end;

	XA_STRING: POINTER is
		external
			"C [macro <X11/Xatom.h>]: EIF_POINTER | <X11/X.h>"
		alias
			"XA_STRING"
		end;

end -- class MEL_ATOM


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

