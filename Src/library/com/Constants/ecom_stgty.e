indexing

	description: "SToraGe TYpe flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_STGTY

feature -- Access

	Stgty_storage: INTEGER is
			-- Storage object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_STORAGE"
		end
		
	Stgty_stream: INTEGER is
			-- Stream object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_STREAM"
		end
		
	Stgty_lockbytes: INTEGER is
			-- Byte array object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_LOCKBYTES"
		end

	is_valid_stgty (stgty: INTEGER): BOOLEAN is
			-- Is `stgty' a valid storage type flag?
		do
			Result := stgty = Stgty_storage or
						stgty = Stgty_stream or
						stgty = Stgty_lockbytes
		end		

end -- class EOLE_STGTY

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

