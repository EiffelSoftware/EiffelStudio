
class STATE_LINE 

inherit

	DATA;
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
	TRANS_STONE;
	EDITABLE;
	WINDOWS;

creation

	make
	
feature -- Creation

	make is
			-- Create the state_line.
		do
			init_line;
			init_selection_square;
		end; -- Create

	help_file_name: STRING is
		do
			Result := Help_const.transition_help_fn
		end;

feature -- Editor creation

	create_editor is
		do
			App_editor.popup_labels_window (Current)
		end;

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
			set_line_width (App_const.standard_thickness);
		end; -- deselect

	calculate is
			-- Calculate the points for the line. 
		require
			have_source_and_dest: not (source = Void) and not (destination = Void);
			not_void_selection_square: not (selection_square = Void)
		local
			temp: FIXED_LIST [COORD_XY_FIG];
			point1, point2: COORD_XY_FIG;
			--sub_app: SUB_APP_SQ;
			real_nbr: REAL
		do
			temp := find_limit_points (source.center, destination.center);
			point1 := temp.i_th (1);
			--sub_app ?= destination;
			point2 := temp.i_th (2);
			if bi_directional then
				point1.rotate (20, source.center);
				point2.rotate (340, destination.center);
				--point2 := sub_app.closest_point (point1);
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
			set_arrow (point1, point2, App_const.arrow_head_w, App_const.arrow_head_h);
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
			point := calculate_vector (pt1, pt2, (source.radius));
			p_high := clone (pt2);
			p_low := clone (pt1);
			p_high.xytranslate (- point.x, - point.y);
			p_low.xytranslate (point.x, point.y);
			!!Result.make (2);
			Result.extend (p_low);
			Result.extend (p_high);
		ensure
			two_points_in_list: Result.count = 2;
		end; 

	init_line is
			-- Initialize the line.
		do
			arrow_create;
			set_foreground_color (Resources.foreground_figure_color);
			set_line_width (App_const.standard_thickness);
		end; 

	init_selection_square is
			-- Initialize the selection_square.
		local
			path: PATH;
			int: INTERIOR
		do
			!!path.make;
			path.set_foreground_color (Resources.foreground_figure_color);
			path.set_line_width (App_const.selection_square_thickness_sl);
			!!int.make;
			int.set_foreground_color (Resources.background_figure_color);
			!!selection_square.make;	
			selection_square.set_path (path);
			selection_square.set_interior (int);
			selection_square.set_size_of_side (App_const.selection_square_side_length);
		end;

	select_figure is
			-- Increase the width of line by 1 to indicate Current
			-- has been selected. 
		do
			set_line_width (App_const.standard_thickness + 1);
		end;

feature -- Stone

	data: STATE_LINE is
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
	

