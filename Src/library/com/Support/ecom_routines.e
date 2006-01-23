indexing
	description: "COM Routines"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ROUTINES

feature -- Access

--	com_api: ECOM_COM is
--		once
--			create Result
--		end

	guid_routines: ECOM_GUID_ROUTINES is
		once
			create Result
		end

feature {NONE} -- Implementation

	initializer_routines: POINTER is
			-- Pointer to structure
		once
			Result := ccom_create_e_routines
		end


feature {NONE} -- Externals

	ccom_create_e_routines: POINTER is
		external
			"C++ [new E_Routines %"E_Routines.h%"]()"
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




end -- class ECOM_ROUTINES

