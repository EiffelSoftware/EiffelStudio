indexing
	description: "Atom associated to a string."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ATOM

inherit
	WEL_ANY

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Make an atom named `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.empty
			a_name_not_too_long: a_name.count <= Max_name_length
		local
			a: ANY
		do
			a := a_name.to_c
			item := cwin_add_atom ($a)
		ensure
			name_is_equal: exists implies name.is_equal (a_name)
		end

feature -- Access

	name: STRING is
			-- Atom name
		require
			exists: exists
		local
			a: ANY
		do
			!! Result.make (Max_name_length + 1)
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_get_atom_name (item, $a,
				Max_name_length + 1))
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.empty
		end

	Max_name_length: INTEGER is 80
			-- Maximum atom name length

feature {NONE} -- Removal

	destroy_item is
			-- Delete atom.
		do
			cwin_delete_atom (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_add_atom (str: POINTER): POINTER is
			-- SDK AddAtom
		external
			"C [macro <wel.h>] (LPCSTR): EIF_POINTER"
		alias
			"AddAtom"
		end

	cwin_delete_atom (atom: POINTER) is
			-- SDK DeleteAtom
		external
			"C [macro <wel.h>] (ATOM)"
		alias
			"DeleteAtom"
		end

	cwin_get_atom_name (atom, buffer: POINTER; length: INTEGER): INTEGER is
			-- SDK GetAtomName
		external
			"C [macro <wel.h>] (ATOM, LPSTR, int): EIF_INTEGER"
		alias
			"GetAtomName"
		end

end -- class WEL_ATOM

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
