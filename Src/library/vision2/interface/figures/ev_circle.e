indexing
	description: "EiffelVision circle figure."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CIRCLE

inherit
	EV_ELLIPSE
		rename
			radius1 as radius,
			set_radius1 as set_radius
		export
			{NONE} orientation, radius2,
			set_orientation, set_radius2
		redefine
			set_radius, is_superimposable
		end

creation
	make

feature -- Status setting

	set_radius (new_radius: like radius) is
			-- Set `radius' to `new_radius', change `size_of_side'.
		do
			radius2 := new_radius
			Precursor (new_radius)
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current circle superimposable to `other' ?
			--| not finished
		do
			Result := center.is_superimposable (other.center) and 
				(radius = other.radius)
		end

invariant
	only_one_radius: radius = radius2

end -- class EV_CIRCLE

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

