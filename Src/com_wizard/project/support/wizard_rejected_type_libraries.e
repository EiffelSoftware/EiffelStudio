indexing
	description: "Non generated type libraries"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_REJECTED_TYPE_LIBRARIES

feature -- Access

	Non_generated_type_libraries: ARRAY [ECOM_GUID] is
			-- Non generated type libraries
		local
			a_guid: ECOM_GUID
		once
			create a_guid.make_from_string (stdole32)
			create Result.make (1,1)
			Result.put (a_guid, 1)
			Result.compare_objects
		end

	stdole32: STRING is "{00020430-0000-0000-C000-000000000046}"
			-- Stdole32.tlb type library guid

end -- class WIZARD_REJECTED_TYPE_LIBRARIES
