indexing

	description: "EiffelVision rectangle. Rectangular area.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	EV_RECTANGLE

inherit
	GENERAL
		rename
			do_nothing as make_empty
		end
	
creation
	make_empty,
	set

feature -- Access

	upper_left: EV_COORD
			-- Upper-left coiner of the clip area

	width: INTEGER
			-- Width of the clip area

	height: INTEGER
			-- Height of the clip area

feature -- Debug
	
	print_contents is
		do
			io.put_string ("Upper left corner: ")
			upper_left.print_contents
			io.put_string ("width: ")	
			print (width)
			io.put_string ("height: ")	
			print (height)
		end
	

feature -- Element change

	set (upper_left_coord: EV_COORD; new_width, new_height: INTEGER) is
			-- Set the clip
		require
			upper_left_coord: upper_left_coord /= Void
			new_width_positive: new_width >= 0
			new_height_positive: new_height >= 0
		do
			upper_left := upper_left_coord
			width := new_width
			height := new_height
		end

end -- class EV_CLIP


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

