indexing

	description: 
		"EiffelVision box, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_I
	
inherit
	EV_INVISIBLE_CONTAINER_I
	
feature -- Constants
	
	Default_homogeneous: BOOLEAN is False
	Default_spacing: INTEGER is 0
	Default_border_width: INTEGER is 0

feature -- Access

	border_width: INTEGER is
			-- Border width around container
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end
	
feature -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		require
			exist: not destroyed
		deferred
		end

	set_border_width (value: INTEGER) is
			-- Make `value' the new border width.
		require
			exist: not destroyed
			positive_value: value >= 0
		deferred
		ensure
			border_set: border_width = value
		end	
	
	set_spacing (value: INTEGER) is
			-- Spacing between the objects in the box
		require
			exist: not destroyed
			positive_value: value >= 0
		deferred
		end	
	
end -- class EV_BOX_I

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
