indexing
	description: "Special type libraries"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPECIAL_TYPE_LIBRARIES

feature -- Access

	Non_generated_type_libraries: ARRAY [ECOM_GUID] is
			-- Non generated type libraries
		local
			a_guid: ECOM_GUID
		once
			create Result.make (1,1)

			create a_guid.make_from_string (stdole32)
			Result.put (a_guid, 1)

			Result.compare_objects
		end

	prefixed_libraries : ARRAY [ECOM_GUID] is
			-- Prefixed type libraries.
		local
			a_guid: ECOM_GUID
		once
			create Result.make (1,1)

			create a_guid.make_from_string (vba_tlb)
			Result.put (a_guid, 1)

			Result.compare_objects
		end

feature {NONE} -- Implementation

	stdole32: STRING is "{00020430-0000-0000-C000-000000000046}"
			-- Stdole32.tlb type library guid.

	vba_tlb: STRING is "{000204EF-0000-0000-C000-000000000046}"
			-- MSVBVM60.DLL type library guid.

end -- class WIZARD_SPECIAL_TYPE_LIBRARIES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

