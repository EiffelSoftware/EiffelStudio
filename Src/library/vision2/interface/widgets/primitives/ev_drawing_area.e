indexing
	description: "EiffelVision drawing area. A drawing area%
			% is a primitive on which the user can draw%
			% pixmaps or his own figures."
	note: "A drawing area as a (0, 0) minimum_size by default%
			% and a (10, 10) size. A non nul size because then,%
			% the user doesn't wonder why nothing appear."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA

inherit
	EV_DRAWABLE
		redefine
			implementation
		end

	EV_PRIMITIVE
		redefine
			implementation
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty drawing area.
		do
			!EV_DRAWING_AREA_IMP! implementation.make (par)
			widget_make (par)
		end

feature -- Implementation

	implementation: EV_DRAWING_AREA_I

end -- class EV_DRAWING_AREA

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
