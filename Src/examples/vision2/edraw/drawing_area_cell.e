indexing
	description: "Objects that allows to draw figures by click and move."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_CELL

inherit
	EV_MODEL_WORLD_CELL
		redefine
			on_pointer_button_press_on_drawing_area,
			on_pointer_button_move_on_drawing_area,
			on_pointer_button_release_on_drawing_area,
			initialize
		end
	
	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end
		
	EV_FIGURE_MATH
		undefine
			default_create,
			copy
		end
	
create
	make_with_world
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_MODEL_WORLD_CELL}
			mode_name := ""
			drawing_area.pointer_double_press_actions.extend (agent on_point_double_press_on_area)
			drawing_area.key_press_string_actions.extend (agent user_text_input)
		end

feature -- Status report

	mode_name: STRING
			-- Currents drawing mode name.
			-- line, rect, parallelogram, ...

	is_grid_enabled: BOOLEAN is
			-- Is snapp to grid enabled?
		do
			Result := world.grid_enabled
		end
	
	is_grid_visible: BOOLEAN is
			-- Is grid visible?
		do
			Result := world.grid_visible
		end

	is_line_draw_mode: BOOLEAN is
			-- Is current mode line draw mode?
		 do
		 	Result := mode_name.is_equal ("line")
		 end
			
	is_rect_draw_mode: BOOLEAN is
			-- Is current mode rectangle draw mode?
		do
			Result := mode_name.is_equal ("rect")
		end
		
	is_parallelogram_draw_mode: BOOLEAN is
			-- Is current mode parallelogram draw mode?
		do
			Result := mode_name.is_equal ("parallelogram")
		end
		
	is_polygone_draw_mode: BOOLEAN is
			-- Is current mode polygone draw mode?
		do
			Result := mode_name.is_equal ("polygon")
		end
		
	is_polyline_draw_mode: BOOLEAN is
			-- Is current mode polyline draw mode?
		do
			Result := mode_name.is_equal ("polyline")
		end
		
	is_ellipse_draw_mode: BOOLEAN is
			-- Is current ode ellipse draw mode?
		do
			Result := mode_name.is_equal ("ellipse")
		end
		
	is_dot_draw_mode: BOOLEAN is
			-- Is current mode dot draw mode?
		do
			Result := mode_name.is_equal ("dot")
		end
		
	is_text_draw_mode: BOOLEAN is
			-- Is current mode text draw mode?
		do
			Result := mode_name.is_equal ("text")
		end
		
	is_text_input_mode: BOOLEAN
			-- Is current in text input mode
			
	is_arc_draw_mode: BOOLEAN is
			-- Is current in arc draw mode?
		do
			Result := mode_name.is_equal ("arc")
		end
		
	is_arc_set_start_angle_mode: BOOLEAN
			-- Is current in arc set start angle mode?
			
	is_arc_set_aperture_mode: BOOLEAN
			-- Is current in arc set aperture mode?
			
	is_pie_draw_mode: BOOLEAN is
			-- Is current in pie draw mode?
		do
			Result := mode_name.is_equal ("pie")
		end
		
	is_pie_set_start_angle_mode: BOOLEAN
			-- Is current in pie set start angle mode?
			
	is_pie_set_aperture_mode: BOOLEAN
			-- Is current in pie set aperture mode?
			
	is_equilateral_draw_mode: BOOLEAN is
			-- Is current mode equilateral_draw_mode?
		do
			Result := mode_name.is_equal ("equilateral")
		end
		
	is_equilateral_side_count_select_mode: BOOLEAN
			-- Is equilateral side count select mode?
			
	is_picture_draw_mode: BOOLEAN is
			-- Is current mode picture draw mode?
		do
			Result := mode_name.is_equal ("picture")
		end
		
	is_rounded_rectangle_mode: BOOLEAN is
			-- Is current mode rounded rectangle draw mode?
		do
			Result := mode_name.is_equal ("rounded_rect")
		end		
		
	is_rounded_rectangle_select_radius_mode: BOOLEAN
			-- Is current mode rounded rectangle selcet radius mode?
			
	is_rounded_parallelogram_mode: BOOLEAN is
			-- Is current mode rounded parallelogram draw mode?
		do
			Result := mode_name.is_equal ("rounded_parallelogram")
		end
		
	is_rounded_parallelogram_select_radius_mode: BOOLEAN
			-- Is current mode rounded parallelogram draw mode?
			
	is_star_draw_mode: BOOLEAN is
			-- Is current mode star draw mode?
		do
			Result := mode_name.is_equal ("star")
		end
		
	is_star_line_select_mode: BOOLEAN
			-- Is current mode star line count select mode?
			
feature -- Access

	new_figure_foreground_color: EV_COLOR
			-- Foreground color for new figur.
	
	new_figure_line_width: INTEGER
			-- Line width for new figure.
	
	new_figure_is_dashed_line_style: BOOLEAN
			-- Is new figures line style dashed?
	
	new_figure_background_color: EV_COLOR
			-- Background color for new figure.

feature -- Element change

	set_new_figure_foreground_color (a_foreground_color: like new_figure_foreground_color) is
			-- Set `new_figure_foreground_color' to `a_foreground_color'.
		require
			a_foreground_color_exists: a_foreground_color /= Void
		do
			new_figure_foreground_color := a_foreground_color
		ensure
			set: new_figure_foreground_color = a_foreground_color
		end
		
	set_new_figure_line_width (a_line_width: like new_figure_line_width) is
			-- Set `new_figure_line_width' to `a_line_width'.
		require
			positive: a_line_width >= 0
		do
			new_figure_line_width := a_line_width
		ensure
			set: new_figure_line_width = a_line_width
		end
		
	new_figure_enable_dashed_line_style is
			-- Set `new_figure_is_dashed_line_style' to True.
		do
			new_figure_is_dashed_line_style := True
		ensure
			set: new_figure_is_dashed_line_style
		end
		
	new_figure_disable_dashed_line_style is
			-- Set `new_figure_is_dashed_line_style' to False.
		do
			new_figure_is_dashed_line_style := False
		ensure
			set: not new_figure_is_dashed_line_style
		end
		
	set_new_figure_background_color (a_background_color: like new_figure_background_color) is
			-- Set `new_figure_background_color' to `a_background_color'.
		do
			new_figure_background_color := a_background_color
		ensure
			set: new_figure_background_color = a_background_color
		end

feature -- Status setting

	set_drawing_mode (a_mode_name: STRING) is
			-- Set `mode_name' to `a_mode_name'.
		require
			a_mode_name_not_void: a_mode_name /= Void
		do
			mode_name := a_mode_name
		ensure
			set: mode_name = a_mode_name
		end
		
feature -- Element change

	stop_drawing is
			-- Force `Current' to stop drawing new created figure.
		do
			new_line := Void
			new_rectangle := Void
			new_parallelogram := Void
			new_polygone := Void
			new_polyline := Void
			new_ellipse := Void
			new_dot := Void
			new_text := Void
			new_arc := Void
			new_pie := Void
			new_equilateral := Void
			new_picture := Void
			new_rounded_rectangle := Void
			new_rounded_parallelogram := Void
			new_star := Void
			is_pie_set_aperture_mode := False
			is_pie_set_start_angle_mode := False
			is_arc_set_aperture_mode := False
			is_arc_set_start_angle_mode := False
		end
		
feature {NONE} -- Implementation

	state_forth (ax, ay: INTEGER) is
			-- Button was pressed at `ax' `ay' make a transition
			-- in drawing state machine. 
		local
			pixmap: EV_PIXMAP
			file_open: EV_FILE_OPEN_DIALOG
		do
			new_figure := Void
			if is_line_draw_mode then
				if new_line = Void then
					create new_line.make_with_positions (ax, ay, ax, ay)
					new_figure := new_line
					is_scroll := True
				else
					end_draw
				end
			elseif is_rect_draw_mode then
				if new_rectangle = Void then
					create new_rectangle.make_rectangle (ax, ay, 0, 0)
					new_figure := new_rectangle	
					is_scroll := True
				else
					end_draw
				end
			elseif is_parallelogram_draw_mode then
				if new_parallelogram = Void then
					create new_parallelogram.make_rectangle (ax, ay, 0, 0)
					new_figure := new_parallelogram
					is_scroll := True
				else
					end_draw
				end
			elseif is_rounded_rectangle_mode then
				if new_rounded_rectangle = Void then
					create new_rounded_rectangle.make_rectangle (ax, ay, 0, 0)
					new_figure := new_rounded_rectangle
					is_rounded_rectangle_select_radius_mode := False
					is_scroll := True
				elseif not is_rounded_rectangle_select_radius_mode then
					is_rounded_rectangle_select_radius_mode := True
					is_scroll := True
				else
					end_draw
				end
			elseif is_rounded_parallelogram_mode then
				if new_rounded_parallelogram = Void then
					create new_rounded_parallelogram.make_rectangle (ax, ay, 0, 0)
					new_figure := new_rounded_parallelogram
					is_rounded_parallelogram_select_radius_mode := False
					is_scroll := True
				elseif not is_rounded_parallelogram_select_radius_mode then
					is_rounded_parallelogram_select_radius_mode := True
					is_scroll := True
				else
					end_draw
				end
			elseif is_polygone_draw_mode then
				if new_polygone = Void then
					create new_polygone
					new_polygone.extend_point (create {EV_COORDINATE}.make (ax, ay))
					new_polygone.extend_point (create {EV_COORDINATE}.make (ax, ay))
					new_figure := new_polygone
					is_scroll := True
				else
					new_polygone.extend_point (create {EV_COORDINATE}.make (ax, ay))
				end
			elseif is_polyline_draw_mode then
				if new_polyline = Void then
					create new_polyline
					new_polyline.extend_point (create {EV_COORDINATE}.make (ax, ay))
					new_polyline.extend_point (create {EV_COORDINATE}.make (ax, ay))
					new_figure := new_polyline
					is_scroll := True
				else
					new_polyline.extend_point (create {EV_COORDINATE}.make (ax, ay))
				end
			elseif is_ellipse_draw_mode then
				if new_ellipse = Void then
					create new_ellipse.make_with_positions (ax, ay, ax, ay)
					new_figure := new_ellipse
					is_scroll := True
				else
					end_draw
				end
			elseif is_dot_draw_mode then
				if new_dot = Void then
					create new_dot.make_with_position (ax, ay)
					new_figure := new_dot
					is_scroll := True
				else
					end_draw
				end
			elseif is_text_draw_mode then
				if new_text = Void then
					create new_text.make_with_text ("I")
					new_text.set_point_position (ax, ay)
					new_figure := new_text
					is_text_input_mode := True
					is_scroll := True
				elseif not is_text_input_mode then
					new_text := Void
					is_scroll := True
				else
					end_draw
				end
			elseif is_arc_draw_mode then
				if new_arc = Void then
					create new_arc.make_with_positions (ax, ay, ax, ay)
					new_arc.set_start_angle (0)
					new_arc.set_aperture (2 * new_arc.pi)
					is_arc_set_aperture_mode := False
					is_arc_set_start_angle_mode := False
					new_figure := new_arc
					is_scroll := True
				elseif not is_arc_set_start_angle_mode then
					is_arc_set_start_angle_mode := True
					new_arc.set_aperture (0.1)
					is_scroll := True
				elseif not is_arc_set_aperture_mode then
					is_arc_set_aperture_mode := True
					is_scroll := True
				elseif is_arc_set_aperture_mode then
					end_draw
				end
			elseif is_pie_draw_mode then
				if new_pie = Void then
					create new_pie.make_with_positions (ax, ay, ax, ay)
					new_pie.set_start_angle (0)
					new_pie.set_aperture (2 * new_pie.pi - 0.1)
					is_pie_set_aperture_mode := False
					is_pie_set_start_angle_mode := False
					new_figure := new_pie
					is_scroll := True
				elseif not is_pie_set_start_angle_mode then
					is_pie_set_start_angle_mode := True
					new_pie.set_aperture (0.1)
					is_scroll := True
				elseif not is_pie_set_aperture_mode then
					is_pie_set_aperture_mode := True
					is_scroll := True
				elseif is_pie_set_aperture_mode then
					end_draw
				end
			elseif is_equilateral_draw_mode then
				if new_equilateral = Void then
					create new_equilateral.make_with_positions (ax, ay, ax, ay)
					new_figure := new_equilateral
					is_equilateral_side_count_select_mode := False
					is_scroll := True
				elseif not is_equilateral_side_count_select_mode then
					is_equilateral_side_count_select_mode := True
					is_scroll := True
				else
					end_draw
				end
			elseif is_picture_draw_mode then
				if new_picture = Void then
					create file_open

					file_open.filters.extend (["*.png", "PNG Files"])
					file_open.show_modal_to_window (window)
					
					if not file_open.file_name.is_empty then
						create pixmap
						pixmap.set_with_named_file (file_open.file_name)
						
						create new_picture.make_with_pixmap (pixmap)
						new_picture.set_point_position (ax, ay)
						new_figure := new_picture
						is_scroll := True
					end
				else
					end_draw
				end
			elseif is_star_draw_mode then
				if new_star = Void then
					create new_star.make_with_positions (ax, ay, ax, ay)
					new_figure := new_star
					is_star_line_select_mode := False
					is_scroll := True
				elseif not is_star_line_select_mode then
					is_star_line_select_mode := True
					is_scroll := True
				else
					end_draw
				end
			end
		end
		
	end_draw is
			-- End drawing reached.
		do
			is_scroll := False
			stop_drawing
			current_figure := Void
		end
		
	start_drawing (a_figure: EV_MODEL) is
			-- Start drawing `a_figure'.
		require
			a_figure /= Void
		do
			current_figure := a_figure
		end

	new_figure: EV_MODEL
			-- Newly created figure.
			
	current_figure: EV_MODEL
			-- Figure that is currently build by user.
	
	on_pointer_button_press_on_drawing_area (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- A button was pressed on the drawable.
		local
			
			af: EV_MODEL_ATOMIC
			cf: EV_MODEL_CLOSED
			ax, ay: INTEGER
		do
			if is_grid_enabled then
				ax := snapped_x (x + horizontal_scrollbar.value)
				ay := snapped_y (y + vertical_scrollbar.value) 
			else
				ax := x + horizontal_scrollbar.value
				ay := y + vertical_scrollbar.value
			end
			if button = 1 and not ev_application.ctrl_pressed and then world.capture_figure = Void then
		
				state_forth (ax, ay)

				if new_figure /= Void then
					af ?= new_figure
					if af /= Void then
						af.set_foreground_color (new_figure_foreground_color)
						af.set_line_width (new_figure_line_width)
						if new_figure_is_dashed_line_style then
							af.enable_dashed_line_style
						end
					end
					cf ?= new_figure
					if cf /= Void and new_figure_background_color /= Void then
						cf.set_background_color (new_figure_background_color)
					end
					
					world.extend (new_figure)
					
					start_x := ax
					start_y := ay
					
					start_drawing (new_figure)
				end
			elseif button = 3 then
				if new_polygone /= Void then
					end_draw
				elseif new_polyline /= Void then
					end_draw
				end
			end
			if not is_scroll then
				if projector.is_figure_selected then		
					is_scroll := True
					is_selected_scroll := True
				else
					drawing_area.set_pointer_style (default_pixmaps.busy_cursor)
					is_hand := True
					start_x := x
					start_y := y
					start_horizontal_value := horizontal_scrollbar.value
					start_vertical_value := vertical_scrollbar.value
				end
			end
		end
		
	user_text_input (keystring: STRING) is
			-- User made a text input
		local
			i: INTEGER
			a_new_text: STRING
		do
			if new_text /= Void and is_text_input_mode then
				if keystring.count > 0 then
					if keystring.has ('%R') then
						from
							i := 1
						until
							i > keystring.count
						loop
							if keystring.item (i) = '%R' then
								keystring.put ('%N', i)
							end
							i := i + 1
						end
					end
					a_new_text := new_text.text
					if keystring.item (keystring.count).is_equal ('%B') then
						if a_new_text.count > 1 then
							a_new_text.keep_head (new_text.text.count - 2)
							a_new_text := a_new_text + "I"
						end
					else	
						a_new_text.keep_head (new_text.text.count - 1)
						a_new_text := a_new_text + keystring
						if a_new_text.count >= 2 and then (a_new_text.item (a_new_text.count) = '%N' and a_new_text.item (a_new_text.count - 1) = '%N') then
							a_new_text.keep_head (a_new_text.count - 2)
							is_text_input_mode := False
							is_scroll := False
						else
							a_new_text := a_new_text + "I"
						end
					end
					new_text.set_text (a_new_text)
					projector.project
				end
			end
		end
		
	on_point_double_press_on_area (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- User double pressed on drawing area.
		do
			if new_polygone /= Void then
				end_draw
			elseif new_polyline /= Void then
				end_draw
			end
		end

	on_pointer_button_move_on_drawing_area (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Pointer moves over drawable.
		local
			new_angle, start_angle: DOUBLE
			ax, ay, rax, ray: INTEGER
			a_x, a_y: INTEGER
		do
			if is_grid_enabled then
				a_x := snapped_x (x + horizontal_scrollbar.value)
				a_y := snapped_y (y + vertical_scrollbar.value) 
			else
				a_x := x + horizontal_scrollbar.value
				a_y := y + vertical_scrollbar.value
			end
			if new_line /= Void then
				new_line.set_point_b_position (a_x, a_y)
				projector.project
			elseif new_rectangle /= Void then
				new_rectangle.set_point_b_position (a_x, a_y)
				projector.project
			elseif new_parallelogram /= Void then
				new_parallelogram.set_point_a_position (a_x, a_y)
				projector.project
			elseif new_rounded_rectangle /= Void then
				if not is_rounded_rectangle_select_radius_mode then
					new_rounded_rectangle.set_point_b_position (a_x, a_y)
					projector.project
				else
					new_rounded_rectangle.set_radius ((((a_x - new_rounded_rectangle.x).abs) // 2))
					projector.project
				end	
			elseif new_rounded_parallelogram /= Void then
				if not is_rounded_parallelogram_select_radius_mode then
					new_rounded_parallelogram.set_point_b_position (a_x, a_y)
					projector.project
				else
					new_rounded_parallelogram.set_radius ((((a_x - new_rounded_parallelogram.x).abs) // 2))
					projector.project
				end	
			elseif new_polygone /= Void then
				new_polygone.set_i_th_point_position (new_polygone.point_count, a_x, a_y)
				projector.project
			elseif new_polyline /= Void then
				new_polyline.set_i_th_point_position (new_polyline.point_count, a_x, a_y)
				projector.project
			elseif new_ellipse /= Void then
				new_ellipse.set_point_b_position (a_x, a_y)
				projector.project
			elseif new_dot /= Void then
				new_dot.set_point_position (a_x, a_y)
				projector.project
			elseif new_text /= Void and not is_text_input_mode then
				new_text.set_point_position (a_x, a_y)
				projector.project
			elseif new_arc /= Void then
				if is_arc_set_aperture_mode then
					start_angle := new_arc.start_angle
					ax := a_x - new_arc.x
					ay := a_y - new_arc.y
					rax := (ax * cosine (start_angle) - ay * sine (start_angle)).truncated_to_integer
					ray := (ax * sine (start_angle) + ay * cosine (start_angle)).truncated_to_integer
					new_angle := 2*pi - line_angle (0,0, rax, ray)
					new_arc.set_aperture (new_angle)
				elseif is_arc_set_start_angle_mode then
					new_angle := 2*pi - line_angle (new_arc.x, new_arc.y, a_x, a_y) 
					new_arc.set_start_angle (new_angle)
				else
					new_arc.set_point_b_position (a_x, a_y)
				end
				projector.project
			elseif new_pie /= Void then
				if is_pie_set_aperture_mode then
					start_angle := new_pie.start_angle
					ax := a_x - new_pie.x
					ay := a_y - new_pie.y
					rax := (ax * cosine (start_angle) - ay * sine (start_angle)).truncated_to_integer
					ray := (ax * sine (start_angle) + ay * cosine (start_angle)).truncated_to_integer
					new_angle := 2*pi - line_angle (0,0, rax, ray)
					new_pie.set_aperture (new_angle)
				elseif is_pie_set_start_angle_mode then
					new_angle := 2*pi - line_angle (new_pie.x, new_pie.y, a_x, a_y) 
					new_pie.set_start_angle (new_angle)
				else
					new_pie.set_point_b_position (a_x, a_y)
				end
				projector.project
			elseif new_equilateral /= Void then
				if not is_equilateral_side_count_select_mode then
					new_equilateral.set_point_b_position (a_x, a_y)
				else
					new_equilateral.set_side_count ((((a_x - new_equilateral.corner_point.x).abs) // 10) + 3)
				end
				projector.project
			elseif new_picture /= Void then
				new_picture.set_point_position (a_x, a_y)
				projector.project
			elseif new_star /= Void then
				if not is_star_line_select_mode then
					new_star.set_point_b_position (a_x, a_y)
					projector.project
				else
					new_star.set_line_count ((((a_x - new_star.x).abs) // 2) + 3)
					projector.project
				end
			end
			Precursor {EV_MODEL_WORLD_CELL} (x, y, x_tilt, y_tilt, pressure, a_screen_x, a_screen_y)
		end
		
	on_pointer_button_release_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was released over `drawing_area'.
		do
			if is_selected_scroll then
				is_scroll := False
				is_selected_scroll := False
			end
			is_hand := False
			drawing_area.set_pointer_style (default_pixmaps.standard_cursor)
		end
		
	is_selected_scroll: BOOLEAN
			-- Is scroll mode?
	
	new_line: EV_MODEL_LINE
	new_rectangle: EV_MODEL_RECTANGLE
	new_parallelogram: EV_MODEL_PARALLELOGRAM
	new_polygone: EV_MODEL_POLYGON
	new_polyline: EV_MODEL_POLYLINE
	new_ellipse: EV_MODEL_ROTATED_ELLIPSE
	new_dot: EV_MODEL_DOT
	new_text: EV_MODEL_TEXT
	new_arc: EV_MODEL_ROTATED_ARC
	new_pie: EV_MODEL_ROTATED_PIE_SLICE
	new_equilateral: EV_MODEL_EQUILATERAL
	new_picture: EV_MODEL_PICTURE
	new_rounded_rectangle: EV_MODEL_ROUNDED_RECTANGLE
	new_rounded_parallelogram: EV_MODEL_ROUNDED_PARALLELOGRAM
	new_star: EV_MODEL_STAR
			-- Figure currently creating (if any not void)	
			
	snapped_x (ax: INTEGER): INTEGER is
			-- Nearest point on horizontal grid to `ax'.
		do
			if ax \\ world.grid_x < world.grid_x // 2 then
				Result := ax - ax \\ world.grid_x
			else
				Result := ax - ax \\ world.grid_x + world.grid_x
			end
		end

	snapped_y (ay: INTEGER): INTEGER is
			-- Nearest point on vertical grid to `ay'.
		do			
			if ay \\ world.grid_y < world.grid_y // 2 then
				Result := ay - ay \\ world.grid_y
			else
				Result := ay - ay \\ world.grid_y + world.grid_y
			end
		end
		
	window: EV_WINDOW is
			-- Window `Current' is part of.
		local
			cur: EV_CONTAINER
		do
			from
				cur := Current
			until
				Result /= Void
			loop
				Result ?= cur.parent
				cur := cur.parent
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DRAWING_AREA_CELL
