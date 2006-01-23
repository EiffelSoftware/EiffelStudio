indexing
	description: "Objects that represent a Windows ABC struct."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ABC_STRUCT
	
inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_abc
		end

feature -- Status report

	a: INTEGER is
			-- A spacing of character.
		do
			Result := cwel_abc_get_abca (item)
		end
		
	b: INTEGER is
			-- B spacing of character.
		do
			Result := cwel_abc_get_abcb (item)
		end
		
	c: INTEGER is
			-- C spacing of character.
		do
			Result := cwel_abc_get_abcc (item)
		end

feature {NONE} -- Externals

	c_size_of_abc: INTEGER is
		external
			"C [macro <wingdi.h>]"
		alias
			"sizeof (ABC)"
		end
		
	cwel_abc_get_abca (ptr: POINTER): INTEGER is
		external
			"C [struct %"wingdi.h%"] (ABC): EIF_INTEGER"
		alias
			"abcA"
		end
		
	cwel_abc_get_abcb (ptr: POINTER): INTEGER is
		external
			"C [struct %"wingdi.h%"] (ABC): EIF_INTEGER"
		alias
			"abcB"
		end
		
	cwel_abc_get_abcc (ptr: POINTER): INTEGER is
		external
			"C [struct %"wingdi.h%"] (ABC): EIF_INTEGER"
		alias
			"abcC"
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




end -- class WEL_ABC_STRUCT

