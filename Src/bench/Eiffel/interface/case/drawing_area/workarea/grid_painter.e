indexing

	description: 
		"Painter to draw a magnetic grid on workareas.";
	date: "$Date$";
	revision: "$Revision $"

class GRID_PAINTER

inherit

	PATCH_PAINTER
		redefine
			draw_segment
		end

	CONSTANTS

creation

	make

feature {NONE} -- Initialization

	make (a_workarea: WORKAREA) is
			-- Initialize the grid painter.
		require
			has_a_workarea: a_workarea /= void
		do
			workarea := a_workarea;
			set_drawing (workarea);
		ensure
			workarea_set: workarea = a_workarea;
		end -- make

feature -- Property

	workarea: WORKAREA
			-- Associated workarea 

feature -- Output

	draw_in (closure: EC_CLOSURE) is
			-- Draw grid in closure area if visible.
		local
			x, y: INTEGER;
			closure_value1: INTEGER;
			closure_value2: INTEGER;
			closure_value3: INTEGER;
			closure_value4: INTEGER;
			spacing: INTEGER
		do
			if is_drawable and system.is_grid_visible then
				set_logical_mode (3);
				set_line_width (1);
				set_line_style (0);
				set_foreground_color (Resources.grid_color);
				spacing := system.grid_spacing;
				from
					closure_value1 := closure.up_left_x;
					closure_value2 := closure.down_right_x;
					closure_value3 := closure.up_left_y -
							closure.up_left_y \\ spacing;
					closure_value4 := closure.down_right_y;
					x := spacing-1
				until
					x >= closure_value1
				loop
					x := x+spacing;
				end;
				from
				until
					x >= closure_value2
				loop
					draw_segment (x, closure_value3, x, closure_value4);
					x := x+spacing;
				end;
				from
					closure_value1 := closure.up_left_y;
					closure_value2 := closure.down_right_y;
					closure_value3 := closure.up_left_x -
							closure.up_left_x \\ spacing;
					closure_value4 := closure.down_right_x;
					y := spacing-1
				until
					y >= closure_value1
				loop
					y := y+spacing;
				end;
				from
				until
					y >= closure_value2
				loop
					draw_segment (closure_value3, y, closure_value4, y);
					y := y+spacing;
				end;
			end
		end 

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw a segment between (`x1', `y1') and (`x2', `y2').
		do
			drawing_i.draw_segment (coord_xy (x1, y1), coord_xy (x2, y2))
		end; -- draw_segment


invariant

	non_void_workarea: workarea /= Void

end -- class GRID_PAINTER
