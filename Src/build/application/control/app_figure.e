
deferred class APP_FIGURE 

inherit

	APP_SHARED
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	FIGURE
		export
			{NONE} all
		redefine
			attach_drawing, attach_drawing_imp, 
			deselect, select_figure, contains
		end
	
feature 

	radius: INTEGER is
			-- Radius of Current
		deferred
		end;

	original_stone: GRAPH_ELEMENT is
		deferred
		end; 

	label: STRING is
		deferred
		end;

	set_stone (state: GRAPH_ELEMENT) is
			-- Set original_stone to `state' and update the
			-- text to the original_stone label.
		require
			not_void_state: not (state = Void)
		deferred
		end; -- set_stone
	
	attach_drawing (a_drawing: DRAWING) is
			-- Attach a drawing to the figure
		do
			inner_figure.attach_drawing (a_drawing);
			outer_figure.attach_drawing (a_drawing);
			text_image.attach_drawing (a_drawing);
		end; -- attach_drawing_imp

	attach_drawing_imp (a_drawing_imp: DRAWING_I) is
			-- Attach a drawing to the figure
		do
			inner_figure.attach_drawing_imp (a_drawing_imp);
			outer_figure.attach_drawing_imp (a_drawing_imp);
			text_image.attach_drawing_imp (a_drawing_imp);
		end; -- attach_drawing_imp

	center: COORD_XY_FIG is
			-- Center of Current (outer_figure)
		do
			Result := outer_figure.center	
		end;
	
	deselect is
			-- Set the foreground color of interior and text_image 
			-- to white and draw itself.
		require else
			valid_inner;
		local
			temp_int: INTERIOR
		do
			temp_int := inner_figure.interior;
			temp_int.set_foreground_color (white);
			draw;
		end; -- deselect

	draw is
			-- Draw the figure. 
		require else 
			valid_outer: outer_figure /= Void;
			valid_inner: inner_figure /= Void;
			valid_text: text_image /= Void; 
		do
			outer_figure.draw;
			inner_figure.draw;
			text_image.draw;
		end; -- draw

	init is
			-- Initialize the outer and inner figures.
		do
			outer_figure_init;
			inner_figure_init;
			text_image_init;
			set_radius (init_radius);
		end; -- init

	moving_figure: CLOSED_FIG is
			-- Figure used for movement
		deferred
		end;

	path: PATH is
		do
			Result := outer_figure.path
		end;

	set_center (p: COORD_XY_FIG) is
			-- Set the center of the figure
		deferred
		end; 

	set_radius (i: INTEGER) is
			-- Set the radius of the figure
		deferred
		end;

	set_copy_mode is
			-- Set copy mode to figure.
		do
			inner_figure.interior.set_copy_mode;
			inner_figure.path.set_copy_mode;
			outer_figure.interior.set_copy_mode;
			outer_figure.path.set_copy_mode;
		end;

	set_xor_mode is
			-- Set xor mode to figure.
		do
			inner_figure.interior.set_xor_mode;
			inner_figure.path.set_xor_mode;
			outer_figure.interior.set_xor_mode;
			outer_figure.path.set_xor_mode;
		end;

	text: STRING is
			-- Text of Current.
		do
		--	Result := text_image.text
		end; -- text

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			outer_figure.xytranslate (vx, vy);
			if
				not (inner_figure.center = outer_figure.center)
			then
				inner_figure.xytranslate (vx, vy)
			end;
			text_image.xytranslate (vx, vy);
		end;

	xyscale (f: REAL; px, py: INTEGER) is
		do
			outer_figure.xyscale (f, px, py);
			inner_figure.xyscale (f, px, py);
			text_image.xyscale (f, px, py);
		end;

	valid_inner: BOOLEAN is
		do
			result := inner_figure /= Void;
		end;

feature {NONE}

	is_surimposable (other: like Current): BOOLEAN is
		do
			Result := false
		end;

	outer_figure: CLOSED_FIG; 
			-- Outer figure 

	inner_figure: CLOSED_FIG;
			-- Inner figure 

	text_image: APP_TEXT_IMAGE;
			-- Text image of figure

	contains (p: COORD_XY_FIG): BOOLEAN is
		do
			Result := outer_figure.contains (p)
		end; -- contains
	
	inner_figure_init is
			-- Initialize the inner_figure (Secret).
		local
			a_path: PATH;
			int: INTERIOR
		do
			!!int.make;
			int.set_stipple (app_interior_stipple);
			int.set_stippled_fill;
			int.set_foreground_color (white);
			!!a_path.make;
			a_path.set_foreground_color (black);
			a_path.set_line_width (standard_thickness);
			inner_figure.set_interior (int);
			inner_figure.set_path (a_path);
		end; 

	outer_figure_init is
			-- Initialize the outer_figure.
		local
			a_path: PATH;
			interior: INTERIOR
		do	
			!!a_path.make;
			a_path.set_line_width (standard_thickness);
			a_path.set_foreground_color (black);
			!!interior.make;
			interior.set_foreground_color (white);
			outer_figure.set_interior (interior);
			outer_figure.set_path (a_path);
		end;

	select_figure is
			-- Set the foreground color of the interior
			-- and text_image to black and then draw itself.
		require else
			valid_inner;
		local
			temp_int: INTERIOR
		do
			temp_int := inner_figure.interior;
			temp_int.set_foreground_color (black);
			draw
		end;

	init_radius: INTEGER is
		deferred
		end;

	set_text (s: STRING) is
		do
			text_image.set_text (s)
		end; -- set_text

	text_image_init is
			-- Initialize the text (Secret)
		do
			text_image.set_background_color (white);
			text_image.set_foreground_color (black);
		end; -- text_image_init
	
	xyrotate (f: REAL; px, py: INTEGER) is
		do
		end;

	origin: COORD_XY_FIG;

end 
	

