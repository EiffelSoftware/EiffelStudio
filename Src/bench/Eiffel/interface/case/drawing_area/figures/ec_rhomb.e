indexing

	description: 
		"Rhomb used to draw multiple feature of a relation.";
	date: "$Date$";
	revision: "$Revision $"

class EC_RHOMB

inherit

	CONSTANTS;
	EC_CLOSED_FIG;
	SINGLE_MATH

creation

	make

feature -- Initialization

	make (a_size: like size) is
			-- Make a rhomb with 'a_size' as size
		do
			!!closure.make;
			!!path.make;
			!!interior.make;
			!!center;
			--interior.set_foreground_color (Resources.drawing_bg_color);
			size := a_size;
			make_points;
		ensure
			has_path: path /= Void;
			has_center: center /= Void;
			size_correctly_set: size = a_size;
			has_points: points.count = 4
		end; -- make

	make_points is
		local
			corner: EC_COORD_XY;
			i: INTEGER
		do
			!!points.make_filled (4);
			from
				i := 1
			until
				i > 4
			loop
				!!corner;
				points.put_i_th (corner, i);
				i := i + 1
			end
		end -- make_points

feature -- Setting

	set_color (a_color: EV_COLOR) is
		require
			valid_color: a_color /= Void
		do
	--		path.set_foreground_color (a_color);
		end;

feature -- Definition

	center: EC_COORD_XY;

	size: INTEGER;

	points: FIXED_LIST[EC_COORD_XY];

	origin: EC_COORD_XY is
			-- origin of rhomb
		do
			Result := center
		end; -- origin

feature -- Setting

	set_center (a_point: like center) is
			-- Set 'center' to 'a_point'
		require
			has_point: a_point /= Void
		do
			center := a_point
		ensure
			center_correctly_set: center = a_point
		end; -- set_center

	set_size (a_size: INTEGER) is
			-- Set 'size' to 'a_size'
		do
			size := a_size
		ensure
			size_correctly_set: size = a_size
		end -- set_size

feature -- Update

	build is
			-- Build the rhomb from points
		do
			points.i_th (1).set (center.x - (size // 2), center.y -
									(size //2));
			points.i_th (2).set (center.x + (size // 2), center.y -
									(size //2));
			points.i_th (3).set (center.x + (size // 2), center.y +
									(size //2));
			points.i_th (4).set (center.x - (size // 2), center.y +
									(size //2));
			from
				points.start
			until
				points.off
			loop
				points.item.xyrotate (pi / 4.0, center.x, center.y);
				points.forth
			end
		end; -- build

	recompute_closure is
			-- Recalculate rhomb's closure.
		do
		--	closure.set (center.x - (size // 2) - path.line_width,
		--		center.y - (size // 2) - path.line_width,
		--		size + path.line_width,
		--		size + path.line_width)
		end 

feature -- Output

	draw is
			-- Draw current rhomb in drawing area
		do
			if drawing.is_drawable then
				interior.set_drawing_attributes (drawing);
				drawing.fill_polygon (points);
				path.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				drawing.draw_polyline (points, True)
			end
		end; -- Draw

	erase is
			-- Erase current rhomb from drawing area
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				interior.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				drawing.set_foreground_color
							(Resources.drawing_bg_color);
				drawing.fill_polygon (points);
				drawing.draw_polyline (points, true)
			end
		end; -- erase

feature -- Geometric management

	contains (a_point: EC_COORD_XY): BOOLEAN is
			-- Is 'a_point' in current rhomb?
		require else
			has_point: a_point /= Void
		local
			dx, dy: INTEGER
		do
			dx := a_point.x - center.x;
			dy := a_point.y - center.y;
			Result := ((center.x - (size // 2)) <= dx or
				dx <= (center.x + (size // 2))) and
				((center.y - (size // 2)) <= dy or
				dy <= (center.y + (size // 2)))
		end -- contains


invariant

	has_center: center /= Void;
	has_path: path /= Void;
	has_interior: interior /= Void;
	has_points: points.count = 4

end -- class EC_RHOMB
