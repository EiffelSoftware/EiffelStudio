indexing

	description: 
		"Segment used for persistent annotation (class)%
		%and shared, multiple separator (link)";
	date: "$Date$";
	revision: "$Revision $"

class EC_SEGMENT 

inherit

	EC_OPEN_FIG;
	--ENDED

creation

	make	

feature -- Initialization

	make is
			-- Create an ec_segment object.
		do
			!!path.make;
			!!start;
			!!final;
			!!closure.make;
			path.set_line_width (ec_line_width)
		end -- make

feature -- Properties

	start, final: EC_COORD_XY;
			-- Begin and End of the line

	origin: EC_COORD_XY is
			-- origin of segment.
		do
			Result := start
		end -- origin

feature -- Setting

	set_start (new_start: EC_COORD_XY) is
			-- Set double_link starting point with new_start
		require
			not (new_start = Void)
		do
			start := new_start
		ensure
			start = new_start
		end; -- set_start

	set_final (new_final: EC_COORD_XY) is
			-- Set double_link ending point with new_final
		require
			not (new_final = Void)
		do
			final := new_final
		ensure
			final = new_final
		end -- set_final

	set_color (a_color: EV_COLOR) is
		require
			valid_a_color: a_color /= Void
		do
		--	path.set_foreground_color (a_color)
		end;

feature -- Update

	recompute_closure is
			-- Recalculate ec_segment's closure.
		do
			closure.set_bound (start, final)
		end 

feature -- Output

	draw is
			-- Display ec_segment in analysis_view.
		require else
			drawing_attached: not (drawing = Void)
		do
			--if drawing.is_drawable then
			--	drawing.set_cap_style(cap_style);
			--	path.set_drawing_attributes (drawing);
			--	drawing.draw_segment (start, final)
			--end
		end; -- draw

	erase is
			-- Erase current figure.
		do
		--	if drawing.is_drawable then
		--		path.set_clear_mode;
		--		draw;
		--		path.set_copy_mode
		--	end
		end; -- erase

feature -- Access

	contains (p: EC_COORD_XY): BOOLEAN is
			-- Is p in ec_segment?
		require else
			point_exists: not (p = Void)
		do
	--		Result := is_contained (p, path.line_width)
		end -- contains

feature {NONE} -- Specification

	ec_line_width: INTEGER is 1
			-- Line's default width
	
invariant

	start /= void;
	final /= void

end -- class EC_SEGMENT
