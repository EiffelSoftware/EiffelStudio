indexing

	description: 
		"EiffelVision composite, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_CONTAINER_I
	
inherit
	EV_WIDGET_I
	
	

feature
	
	add_child (child_i: EV_WIDGET_I) is
			-- Add child into composite
		require
			valid_child: child_i /= Void
		deferred
		end

feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container
		deferred			
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		deferred
		end

end

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
