indexing
	description: 
		"EiffelVision vertical box. Implementation interface."
	status: "See notice at end of class"
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_VERTICAL_BOX_I
	
inherit
	EV_BOX_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_BOX

end -- class EV_VERTICAL_BOX_I

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

