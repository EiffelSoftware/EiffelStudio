indexing

	description: "Description of a clip";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CLIP 

feature 

	set (a_coin: COORD_XY; a_width, a_height: INTEGER) is
			-- Set the clip
		require
			a_coin_exists: not (a_coin = Void);
			a_width_positive: a_width >= 0;
			a_height_positive: a_height >= 0
		do
			upper_left := a_coin;
			width := a_width;
			height := a_height
		end; -- set

	upper_left: COORD_XY;
			-- Upper-left coiner of the clip area

	width: INTEGER;
			-- Width of the clip area

	height: INTEGER
			-- Height of the clip area

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
