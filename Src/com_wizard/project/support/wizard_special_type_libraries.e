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
			create Result.make (1,3)

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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
