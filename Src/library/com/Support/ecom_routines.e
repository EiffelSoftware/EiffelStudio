indexing
	description: "COM Routines"
	status: "See notice at end of class"
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

end -- class ECOM_ROUTINES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

