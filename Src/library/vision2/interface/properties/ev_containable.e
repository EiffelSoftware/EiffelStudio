indexing
	description:
		"Abstraction for objects that may be parented."
	status: "See notice at end of class"
	keywords: "parentable, containable, child"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_CONTAINABLE

inherit
	EV_ANY
	
feature -- Status report

	parent: EV_ANY is
			-- The parent that `Current' is contained within, if any.
		require
			not_destroyed: not is_destroyed
		deferred
		end

end -- class EV_CONTAINABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

