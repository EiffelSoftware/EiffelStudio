indexing
	description: "Application editor figure."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class APP_FIGURE

inherit
	EB_FIGURE
		redefine
			data,
			attach_drawing,
			deselect, select_figure,
			contains, is_superimposable
		end

	CONSTANTS

feature -- Access

	radius: INTEGER is
			-- Radius of Current
		deferred
		end 

	data: GRAPH_ELEMENT is
		deferred
		end 

	label: STRING is
		do
			Result := data.label
		end

	set_data (state: GRAPH_ELEMENT) is
			-- Set data to `state' and update the
			-- text to the data label.
		require
			not_void_state: not (state = Void)
		deferred
		end

	update_text is
		deferred
		end

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a drawing to the figure
		do
			inner_figure.attach_drawing_with_parent (Current, a_drawing)
			outer_figure.attach_drawing_with_parent (Current, a_drawing)
			text_image.attach_drawing_with_parent (Current, a_drawing)
			update_text
		end

	center: EV_POINT is
			-- Center of Current (outer_figure)
		do
			Result := outer_figure.center
		end

	deselect is
			-- Set the foreground color of interior and text_image 
			-- to white and draw itself.
		require else
			valid_inner
		local
			temp_int: EV_INTERIOR
		do
			temp_int := inner_figure.interior
			temp_int.set_foreground_color (Resources.app_background_figure_color)
			text_image_init
			draw
		end

	set_center (p: EV_POINT) is
			-- Set the center of the figure and the 
			-- text_image field.
		deferred
		end

	draw is
			-- Draw the figure. 
		require else 
			a_valid_outer: valid_outer
			a_valid_inner: valid_inner
			valid_text: valid_text_image 
		do
			outer_figure.draw
			inner_figure.draw
			text_image.draw
		end

	init is
			-- Initialize the outer and inner figures.
		do
			outer_figure_init
			inner_figure_init
			text_image_init
			set_radius (init_radius)
		end

	moving_figure: EV_CLOSED_FIGURE is
			-- Figure used for movement
		deferred
		end

	path: EV_PATH is
		do
			Result := outer_figure.path
		end

	select_figure is
			-- Set the foreground color of the interior
			-- and text_image to black and then draw itself.
		require else
			valid_inner
		local
			temp_int: EV_INTERIOR
		do
			temp_int := inner_figure.interior
			temp_int.set_foreground_color (Resources.app_foreground_figure_color)
			text_image.set_foreground_color (Resources.app_background_figure_color)
			text_image.set_background_color (Resources.app_foreground_figure_color)
			draw
		end

	set_radius (i: INTEGER) is
			-- Set the radius of the figure
		deferred
		end

	set_text (s: STRING) is
		do
			text_image.set_text (s)
		end

	set_copy_mode is
			-- Set copy mode to figure.
		do
			inner_figure.interior.set_copy_mode
			inner_figure.path.set_copy_mode
			outer_figure.interior.set_copy_mode
			outer_figure.path.set_copy_mode
		end

	set_xor_mode is
			-- Set xor mode to figure.
		do
			inner_figure.interior.set_xor_mode
			inner_figure.path.set_xor_mode
			outer_figure.interior.set_xor_mode
			outer_figure.path.set_xor_mode
		end

	text: STRING is
			-- Text of Current.
		do
			Result := text_image.text
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			outer_figure.xytranslate (vx, vy)
			if
				not (inner_figure.center = outer_figure.center)
			then
				inner_figure.xytranslate (vx, vy)
			end
			text_image.xytranslate (vx, vy)
		end

	xyscale (f: REAL; px, py: INTEGER) is
		do
			outer_figure.xyscale (f, px, py)
			inner_figure.xyscale (f, px, py)
			text_image.xyscale (f, px, py)
		end

	valid_inner: BOOLEAN is
		do
			Result := inner_figure /= Void
		end

	valid_outer: BOOLEAN is
		do
			Result := outer_figure /= Void
		end

	valid_text_image: BOOLEAN is
		do
			Result := text_image /= Void
		end

feature {NONE}

	is_superimposable (other: like Current): BOOLEAN is
		do
			Result := False
		end

	outer_figure: EV_CLOSED_FIGURE
			-- Outer figure 

	inner_figure: EV_CLOSED_FIGURE
			-- Inner figure 

	text_image: EV_TEXT_FIGURE
			-- Text image of figure

	contains (p: EV_POINT): BOOLEAN is
		do
			Result := outer_figure.contains (p)
		end
	
	inner_figure_init is
			-- Initialize the inner_figure (Secret).
		local
			a_path: EV_PATH
			int: EV_INTERIOR
		do
			create int.make
			int.set_foreground_color (Resources.app_background_figure_color)
			create a_path.make
			a_path.set_foreground_color (Resources.app_foreground_figure_color)
			a_path.set_line_width (App_const.standard_thickness)
			inner_figure.set_interior (int)
			inner_figure.set_path (a_path)
		end 

	outer_figure_init is
			-- Initialize the outer_figure.
		local
			a_path: EV_PATH
			interior: EV_INTERIOR
		do	
			create a_path.make
			a_path.set_line_width (App_const.standard_thickness)
			a_path.set_foreground_color (Resources.app_foreground_figure_color)
			create interior.make
			interior.set_foreground_color (Resources.app_background_figure_color)
			outer_figure.set_interior (interior)
			outer_figure.set_path (a_path)
		end

	init_radius: INTEGER is
		deferred
		end

	text_image_init is
			-- Initialize the text (Secret)
		do
			text_image.set_background_color (Resources.app_background_figure_color)
			text_image.set_foreground_color (Resources.app_foreground_figure_color)
		end
	
	xyrotate (f: REAL; px, py: INTEGER) is
		do
		end

	origin: EV_POINT

end -- class APP_FIGURE

