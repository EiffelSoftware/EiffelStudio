indexing
	description: "Element of SAFEARRAY"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_SAFEARRAY_ELEMENT

inherit
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Initialize
		deferred
		end

feature -- Access

	type: INTEGER is
			-- element type
		deferred
		end

	item: POINTER is
			-- Pointer to element placeholder
		deferred
		end

end -- class ECOM_SAFEARRAY_ELEMENT

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

