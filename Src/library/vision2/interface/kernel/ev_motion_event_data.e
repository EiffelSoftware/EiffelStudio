indexing
	description: "EiffelVision motion event data.% 
	%Class for representing motion event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MOTION_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			implementation
		end

creation
	make
	
feature -- Initialization
	
	make is
		do
			!EV_MOTION_EVENT_DATA_IMP! implementation
		end

feature -- Access	
	
	x: INTEGER is
			-- x coordinate of mouse pointer
		do
			Result := implementation.x
		end

	y: INTEGER is
			-- y coordinate of mouse pointer 
		do
			Result := implementation.y
		end

	state: INTEGER is
			-- State of the mouse buttons
		do
			Result := implementation.state
		end

feature {EV_WIDGET_IMP} -- Implementation
	
	implementation: EV_MOTION_EVENT_DATA_I

end -- EV_MOTION_EVENT_DATA

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
