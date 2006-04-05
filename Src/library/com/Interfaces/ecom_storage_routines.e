indexing
	description: "Storage Routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STORAGE_ROUTINES

inherit 
	ECOM_ROUTINES

feature -- Basic Operations

	is_compound_file (a_name: STRING): BOOLEAN is
			-- Does file `a_name' contain a storage object?
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			Result := ccom_is_compound_file (initializer_routines, l_string.item) = 1
		end

feature {NONE} -- Externals

	ccom_is_compound_file (cpp_obj: POINTER; a_name: POINTER): INTEGER is
		external
			"C++ [E_Routines %"E_Routines.h%"] (WCHAR *): EIF_INTEGER"
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




end -- class ECOM_STORAGE_ROUTINES

