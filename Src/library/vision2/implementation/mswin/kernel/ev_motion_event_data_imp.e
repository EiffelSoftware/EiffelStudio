indexing
	description: "EiffelVision motion event data. Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MOTION_EVENT_DATA_IMP

inherit
	EV_MOTION_EVENT_DATA_I

	EV_EVENT_DATA_IMP

feature -- Access	

	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
		local
			ww: WEL_WINDOW
			pt: WEL_POINT
		do
			ww ?= widget.implementation
			!! pt.make (x, y)
			pt.client_to_screen (ww)
			Result := pt.x
		end

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
		local
			ww: WEL_WINDOW
			pt: WEL_POINT
		do
			ww ?= widget.implementation
			!! pt.make (x, y)
			pt.client_to_screen (ww)
			Result := pt.y
		end

end -- class EV_MOTION_EVENT_DATA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
