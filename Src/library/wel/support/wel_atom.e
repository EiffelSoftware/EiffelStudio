indexing
	description: "Atom associated to a string."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ATOM

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_GENERAL) is
			-- Make an atom named `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_name_not_too_long: a_name.count <= Max_name_length
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_name)
			item := cwin_add_atom (a_wel_string.item)
		ensure
			name_is_equal: item /= 0 implies name.is_equal (a_name)
		end

feature -- Access

	name: STRING_32 is
			-- Atom name
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create Result.make (Max_name_length + 1)
			Result.fill_blank
			create a_wel_string.make (Result)
			nb := cwin_get_atom_name (item, a_wel_string.item,
				Max_name_length + 1)
			Result := a_wel_string.string
			Result.keep_head (nb)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	Max_name_length: INTEGER is 80
			-- Maximum atom name length

	item: INTEGER
			-- Eiffel representation of ATOM.

feature {NONE} -- Removal

	dispose is
			-- Delete atom.
		do
			item := cwin_delete_atom (item)
			item := 0
		end

feature {NONE} -- Externals

	cwin_add_atom (str: POINTER): INTEGER is
			-- SDK AddAtom
		external
			"C [macro <wel.h>] (LPCTSTR): EIF_INTEGER"
		alias
			"AddAtom"
		end

	cwin_delete_atom (atom: INTEGER): INTEGER is
			-- SDK DeleteAtom
		external
			"C [macro <wel.h>] (ATOM): EIF_INTEGER"
		alias
			"DeleteAtom"
		end

	cwin_get_atom_name (atom: INTEGER; buffer: POINTER; length: INTEGER): INTEGER is
			-- SDK GetAtomName
		external
			"C [macro <wel.h>] (ATOM, LPTSTR, int): EIF_INTEGER"
		alias
			"GetAtomName"
		end

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




end -- class WEL_ATOM

