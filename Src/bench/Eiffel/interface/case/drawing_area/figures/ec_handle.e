indexing

	description: 
		"Filled box used to draw handles.";
	date: "$Date$";
	revision: "$Revision $"

class EC_HANDLE

inherit

	CONSTANTS;
	EC_COORD_XY
		rename
			make as make_coord_xy
		end
	EC_CLOSED_FIG
		

creation

	make

feature -- Initialization

	make (a_size : like size) is
			-- Create an handle
		do
			!!closure.make;
			!!path.make;
			!!interior.make;
			size := a_size
		ensure
			size_correctly_set : size = a_size
		end; -- make

feature -- Output

	draw is
			-- Draw a box at handle's coordinates
		do
			if drawing.is_drawable then
				interior.set_drawing_attributes (drawing);
				drawing.fill_rectangle (current, size, size, 0)
			end
		end; -- draw
			
	erase is
			-- Erase box drawn
		do
			if drawing.is_drawable then
				interior.set_drawing_attributes (drawing);
				drawing.set_foreground_color
					(Resources.get_color("drawing_background_color"))
				drawing.fill_rectangle (current, size, size, 0)
			end

		end; -- erase

feature -- Update

	recompute_closure is
		do
			closure.set (x - (size // 2), y - (size // 2), size, size)
		end -- recompute_closure


feature -- Access

	contains (a_point : EC_COORD_XY) : BOOLEAN is
			-- Is 'a_point' in current handle ?
		require else
			has_point : a_point /= Void	
		local
			up_left_corner, down_right_corner : EC_COORD_XY
		do
			!!up_left_corner;
			up_left_corner.set (x - (size // 2), y - (size // 2));
			!!down_right_corner;
			down_right_corner.set (x + (size // 2), y + (size // 2));
			Result := (a_point >= up_left_corner) and
				(a_point <= down_right_corner) 	
		end -- contains

feature -- Setting

	set_color (a_color: EV_COLOR) is
		require
		--	valid_a_color: a_color /= Void
		do
		--	path.set_foreground_color (a_color);
		--	interior.set_foreground_color (a_color);
		end;

feature {NONE} -- Implementation

	size: INTEGER;
			-- Size of the square representing the handle

	origin: EC_COORD_XY is
			-- Origin of current handle
		do
			!! Result;
			Result.set (x, y);
		end -- origin

end -- class EC_HANDLE
