indexing
	description: "Well known interface GUIDs"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_GUIDS

feature -- Access

	Iunknown_guid: ECOM_GUID is
			-- IUnknown IID
		once
			create Result.make_from_string (Iunknown_guid_string.twin)
		end

	Iunknown_guid_string: STRING is "{00000000-0000-0000-C000-000000000046}"
			-- IUnknown IID

	Idispatch_guid: ECOM_GUID is
			-- IDispatch IID
		once
			create Result.make_from_string (Idispatch_guid_string.twin)
		end

	Idispatch_guid_string: STRING is "{00020400-0000-0000-C000-000000000046}"
			-- IDispatch IID

end -- class WIZARD_GUIDS

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
