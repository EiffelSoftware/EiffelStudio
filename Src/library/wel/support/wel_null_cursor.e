indexing
	description: "Special cursor used for creating a WEL_WND_CLASS%
		% structure when an application must explicitly set the cursor%
		% shape whenever the mouse moves into the window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NULL_CURSOR

inherit
	WEL_CURSOR
		redefine
			exists,
			destroy_item
		end

feature -- Status report

	exists: BOOLEAN is True
			-- A null cursor always exists.

feature {NONE} -- Removal

	destroy_item is
			-- Nothing to destroy.
		do
		end

invariant
	exists: exists
	no_item: item = default_pointer

end -- class WEL_NULL_CURSOR

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

