
class STATE_LINE 

inherit

	ARROW_LINE
		rename
           	make as arrow_create,
           	attach_drawing_imp as arrow_attach_drawing_imp,
           	attach_drawing as arrow_attach_drawing,
           	draw as arrow_draw,
			contains as arrow_contains
		redefine
			deselect, select_figure
		end;
	ARROW_LINE
		redefine
			deselect, select_figure, contains, draw, attach_drawing_imp, attach_drawing,
			make
		select
			attach_drawing, attach_drawing_imp, contains, make, draw
		end;
	BASIC_ROUTINES;
	PIXMAPS
		export
			{NONE} all
		end;
	TRANS_STONE
		rename source as w_source
		export
			{NONE} all
		end;
			

creation

	make
	
feature -- Creation

	make is
			-- Create the state_line.
		do
			init_line;
			init_selection_square;
		end; -- Create
	
feature 

	source: APP_FIGURE;
			-- Source of the connection
	
	destination: APP_FIGURE;
			-- Destination of the connection

	bi_directional: BOOLEAN;
			-- Is there another arrow going the other direction,
			-- i.e. is there a bi-directional arrow between source
			-- and destination ?

	attach_drawing (a_drawing: DRAWING) is
			-- Attach a_drawing_imp to the figure 
		do
			arrow_attach_drawing (a_drawing);
			selection_square.attach_drawing (a_drawing);
		end; -- attach_drawing


	attach_drawing_imp (a_drawing_imp: DRAWING_I) is
			-- Attach a_drawing_imp to the figure 
		do
			arrow_attach_drawing_imp (a_drawing_imp);
			selection_square.attach_drawing_imp (a_drawing_imp);
		end; -- attach_drawing_imp


	contains (p: COORD_XY_FIG):BOOLEAN is
			-- Is `p' in Current (in selection_square) ?
		do
			Result := selection_square.contains (p)
		end;

	deselect is
			-- Set the width of the line to its default value.
		do
			set_line_width (standard_thickness);
		end; -- deselect

	calculate is
			-- Calculate the points for the line. 
		require
			have_source_and_dest: not (source = Void) and not (destination = Void);
			not_void_selection_square: not (selection_square = Void)
		local
			temp: FIXED_LIST [COORD_XY_FIG];
			point1, point2: COORD_XY_FIG;
			sub_app: SUB_APP_SQ;
			real_nbr: REAL
		do
			temp := find_limit_points (source.center, destination.center);
			point1 := temp.i_th (1);
			sub_app ?= destination;
			if
				(sub_app = Void)
			then
				point2 := temp.i_th (2);
				if
					bi_directional
				then
					point1.rotate (integer_to_real (20), source.center);
					point2.rotate (integer_to_real (340), destination.center);
				end
			else
				point2 := sub_app.closest_point (point1);
			end;
			set_from_points (point1, point2);
		end; -- calculate

	display_point (point: COORD_XY_FIG; s: STRING) is
		do
			io.putstring (s);
			io.putstring (" : ");
			io.putint(point.x);
			io.putstring (" : ");
			io.putint (point.y);
			io.new_line;

		end;

	set_elements (s: like source; d: like destination) is
			-- Set source to `s' and destination to `d'.
		require
			s_not_void: not (s = Void);
			d_not_void: not (d = Void);
			s_has_center: not (s.center = Void);
			d_has_center: not (s.center = Void);
			
		do
			source := s;
			destination := d;
		end; -- set_elements

	set_bi_directional (b: BOOLEAN) is
			-- Set bi_directional to `b'.
		do
			bi_directional := b
		end; -- set_bi_directional

	set_from_points (point1, point2: COORD_XY_FIG) is
		do
			set_arrow (point1, point2, arrow_head_w, arrow_head_h);
			set_origin_to_middle;
			selection_square.set_center (origin);
		end;	
	
feature {NONE}

	draw is
		require else
			arrow_attached: arrow_head /= Void
			selection_square_exists: selection_square /= Void
		do
			arrow_draw;
			selection_square.draw;
		end; 
			
	find_limit_points (pt1, pt2: COORD_XY_FIG): FIXED_LIST [COORD_XY_FIG] is
			-- Find the two points of the arrow line from center points pt1 and pt2 
			-- using the radius.
		require
			pt1_not_void: not (pt1 = Void);
			pt2_not_void: not (pt2 = Void)
		local
			point: COORD_XY_FIG;
			p_high, p_low: COORD_XY_FIG;
			coeff: REAL;
			tempX, tempY: INTEGER
		do
			point := calculate_vector (pt1, pt2, integer_to_real (source.radius));
			p_high := clone (pt2);
			p_low := clone (pt1);
			p_high.xytranslate (- point.x, - point.y);
			p_low.xytranslate (point.x, point.y);
			!!Result.make (2);
			Result.put_i_th (p_low, 1);
			Result.put_i_th (p_high, 2);
		ensure
			Result.count = 2;
		end; 

	init_line is
			-- Initialize the line.
		do
			arrow_create;
			set_foreground_color (black);
			set_line_width (standard_thickness);
		end; 

	init_selection_square is
			-- Initialize the selection_square.
		local
			path: PATH;
			int: INTERIOR
		do
			!!path.make;
			path.set_foreground_color (black);
			path.set_line_width (selection_square_thickness_sl);
			!!int.make;
			int.set_foreground_color (white);
			!!selection_square.make;	
			selection_square.set_path (path);
			selection_square.set_interior (int);
			selection_square.set_size_of_side (selection_square_side_length);
		end;

	select_figure is
			-- Increase the width of line by 1 to indicate Current
			-- has been selected. 
		do
			set_line_width (standard_thickness + 1);
		end;

feature -- Stone

	original_stone: STATE_LINE is
		do
			Result := Current
		end;
	
feature {NONE} -- Stone

	w_source: WIDGET is
		do
		end;

	symbol: PIXMAP is
		do
		end;

	label: STRING is
		do
		end;

feature 

	selection_square: SQUARE;
			-- The selection square

end 
	

