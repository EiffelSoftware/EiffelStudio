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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

