indexing

	description: "Description of a clip";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	CLIP 

feature -- Access

	upper_left: COORD_XY;
			-- Upper-left coiner of the clip area

	width: INTEGER;
			-- Width of the clip area

	height: INTEGER
			-- Height of the clip area

feature -- Element change

	set (a_coin: COORD_XY; a_width, a_height: INTEGER) is
			-- Set the clip
		require
			a_coin_exists: a_coin /= Void;
			a_width_positive: a_width >= 0;
			a_height_positive: a_height >= 0
		do
			upper_left := a_coin;
			width := a_width;
			height := a_height
		end; 

end -- class CLIP



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

