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
			create Result.make_from_string (Iunknown_guid_string)
		end

	Iunknown_guid_string: STRING is "{00000000-0000-0000-C000-000000000046}"
			-- IUnknown IID

	Idispatch_guid: ECOM_GUID is
			-- IDispatch IID
		once
			create Result.make_from_string (Idispatch_guid_string)
		end

	Idispatch_guid_string: STRING is "{00020400-0000-0000-C000-000000000046}"
			-- IDispatch IID

	Itypeinfo_guid: ECOM_GUID is
			-- IDispatch IID
		once
			create Result.make_from_string (Itypeinfo_guid_string)
		end

	Itypeinfo_guid_string: STRING is "{00020401-0000-0000-C000-000000000046}"
			-- IDispatch IID

feature -- Status Report

	is_well_known_interface_guid (a_guid: ECOM_GUID): BOOLEAN is
			-- Is `a_guid' IID of predefined interface?
			-- Should be tru for interfaces for which we don't want to generate a namespace
			-- when used in signatures
		require
			non_void_guid: a_guid /= Void
		do
			Result := a_guid.is_equal (Iunknown_guid) or a_guid.is_equal (Idispatch_guid) or
						a_guid.is_equal (Itypeinfo_guid)
		end
		
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
