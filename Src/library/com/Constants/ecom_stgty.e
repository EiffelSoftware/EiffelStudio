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
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

