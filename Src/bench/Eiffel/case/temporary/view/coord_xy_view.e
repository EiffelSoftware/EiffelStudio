indexing

	description: "X-y values in a cluster within a given view.";
	date: "$Date$";
	revision: "$Revision $"

		-- Factorization of referencable data
class COORD_XY_VIEW

inherit

	VIEW;

feature -- Properties

	x, y: INTEGER
			-- Current's coordinates relative to its containing cluster.

feature -- Setting

	set_x_y (x0, y0: INTEGER) is
			-- Set x to `x0' and y to `y0'.
		require
			valid_coordinate: x0 >= 0;
			valid_coordinate: y0 >= 0;
		do
			x := x0;
			y := y0;
		ensure
			values_set: x = x0 and then y = y0
		end 

feature {NONE} -- Setting

	update_from (coord_data: COORD_XY_DATA) is
			-- Update Current from `coord_data'.
		do
			x := coord_data.x;
			y := coord_data.y
		ensure
			updated: x = coord_data.x and then y = coord_data.y
		end;

	update_data (coord_data: COORD_XY_DATA) is
			-- Update `coord_data' from Current.
		do
			coord_data.set_x (x);
			coord_data.set_y (y);
		end;

end -- class COORD_XY_VIEW
