indexing
	description: 
		"EiffelVision box. Invisible container that allows unlimited number of other widgets to be packed inside it. Box controls the location the children's location and size automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_BOX

inherit
	EV_INVISIBLE_CONTAINER
		redefine
			implementation
		end

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Is the current box homogeneous
		require
			exists: not destroyed
		do
			Result := implementation.is_homogeneous
		end

	border_width: INTEGER is
			-- Border width around container
		require
			exists: not destroyed
		do
			Result := implementation.border_width
		ensure
			positive_result: Result >= 0
		end

	spacing: INTEGER is
			-- Spacing between the objects in the box
		require
			exists: not destroyed
		do
			Result := implementation.spacing
		ensure
			positive_result: Result >= 0
		end 

feature -- Status report

	is_child_expandable (child: EV_WIDGET): BOOLEAN is
			-- Is the child corresponding to `index' expandable. ie: does it
			-- accept the parent to resize or move it.
		require
			exist: not destroyed
			has_child: -- To do
		do
			Result := implementation.is_child_expandable (child)
		end

feature -- Statu setting
	
	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		require
			exist: not destroyed
		do
			implementation.set_homogeneous (flag)
		end

	set_border_width (value: INTEGER) is
			-- Make `value' the new border width.
		require
			exist: not destroyed
			positive_value: value >= 0
		do
			implementation.set_border_width (value)
		ensure
			border_set: border_width = value
		end

	set_spacing (value: INTEGER) is
			-- Spacing between the objects in the box
		require
			exist: not destroyed
			positive_value: value >= 0
		do
			implementation.set_spacing (value)
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		require
			exist: not destroyed
			has_child: -- To do
		do
			implementation.set_child_expandable (child, flag)
		end

feature -- Implementation
	
	implementation: EV_BOX_I
			-- Platform dependent access.
			
end -- class EV_BOX

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
