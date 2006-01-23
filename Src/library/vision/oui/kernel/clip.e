indexing

	description: "Description of a clip"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CLIP

