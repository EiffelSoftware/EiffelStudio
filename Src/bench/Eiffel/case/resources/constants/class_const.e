indexing

	description: 
		"Constants for class graphical representation.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_CONST

feature -- Constants

	default_x: INTEGER is 100;
			-- center.x default.
				
	default_y: INTEGER is 100;
			-- center.y default.
				
	seg_space: INTEGER is 3;
		-- space between class_name and segment in the
			-- ellipse which symbolize the class.
				
	generic_space: INTEGER is 3;
			-- space between class_name and generic parameter in the
			-- ellipse which symbolize the class.
				
	root_space: INTEGER is 3;
			-- space between ellipse which symbolize the class
			-- and the ellipse which symbolize the root.

	bitmap_width: INTEGER is 5;
			-- width for each bitmap.
				
	bitmap_height: INTEGER is 5;
			-- Height for each bitmap
				
	circle_position: INTEGER is 1;
			-- circle bitmap position in array `symbol'.
				
	star_position: INTEGER is 2;
			-- star bitmap position in array `symbol'.
				
	triangle_position: INTEGER is 3;
			-- triangle bitmap position in array `symbol'.
				
	square_position: INTEGER is 4;
			-- square bitmap position in array `symbol'.
				
	plus_position: INTEGER is 5
			-- plus bitmap position in array `symbol'.

end -- class CLASS_CONST
