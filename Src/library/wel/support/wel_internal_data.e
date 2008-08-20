indexing
	description: "Small wrapper around an Eiffel INTEGER C structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INTERNAL_DATA

feature -- Access

	frozen structure_size: INTEGER is
			-- Size of an Eiffel INTEGER at the C level.
		external
			"C inline"
		alias
			"sizeof(EIF_INTEGER)"
		end

	frozen object_id (p: POINTER): INTEGER is
			-- Retrieve `object_id' from `p'
		external
			"C inline"
		alias
			"return *(EIF_INTEGER *) $p;"
		end

feature -- Setting

	frozen set_object_id (p: POINTER; id: INTEGER) is
			-- Set `object_id' from `p' with `id'.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"*(EIF_INTEGER *) $p = $id;"
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

end -- class WEL_INTERNAL_DATA
