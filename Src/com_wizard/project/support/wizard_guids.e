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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
