note
	description: "[
			Gtk34 implementation for {EV_DOCKABLE_SOURCE_HINT}, to show the source of the Pick and drop.
			
			It uses an animation of circle growing and reducing around the source of the picking.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DOCKABLE_SOURCE_HINT_IMP

inherit
	EV_DOCKABLE_SOURCE_HINT_I
		redefine
			interface
		end

	EV_GTK_WINDOW_IMP
		redefine
			interface,
			make,
			set_size
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: EV_DOCKABLE_SOURCE_HINT)
			-- Creation method.
		do
			assign_interface (an_interface)
			make
		end

	make
		local
			c_win, c_screen, c_visual: POINTER
			l_app_imp: like app_implementation
			d: EV_DRAWING_AREA
		do
			set_is_initialized (False)
			c_win := {GTK}.gtk_window_new ({GTK}.gtk_window_popup_enum)
			set_c_object (c_win)

			initialize_defaults

			l_app_imp := app_implementation

			c_screen := {GDK}.gdk_screen_get_default
			c_visual := {GDK}.gdk_screen_get_rgba_visual (c_screen)
			if not c_visual.is_default_pointer and {GTK}.gdk_screen_is_composited (c_screen) then
				{GTK}.gtk_widget_set_visual (c_win, c_visual)
			end
			{GTK}.gtk_widget_set_app_paintable (c_win, True)
			{GTK}.gtk_window_set_skip_taskbar_hint (c_win, True)
			{GTK}.gtk_box_set_homogeneous (c_win, True)
			{GTK}.gtk_container_set_border_width (c_win, 10)

			l_app_imp.window_oids.extend (internal_id)

			create d
			drawing := d
			if attached {EV_DRAWING_AREA_IMP} d.implementation as d_imp then
				{GTK}.gtk_container_add (c_win, d_imp.c_object)
			end

			{GTK}.gtk_widget_show_all (c_win)

			set_is_initialized (True)
		end

	initialize_defaults
		do
			animation_steps := 20
			animation_delay := 40
		end

feature -- Settings

	animation_steps: INTEGER

	animation_delay: INTEGER
			-- Animation delay in ms

feature {NONE} -- Implementation

	window: POINTER

	drawing: EV_DRAWING_AREA

	timeout: detachable EV_TIMEOUT

	counter: INTEGER

feature {EV_ANY} -- Size change

	set_size (a_width, a_height: INTEGER)
		do
			Precursor (a_width, a_height)
			drawing.set_minimum_size (a_width, a_height)
		end

feature {NONE} -- Implementation

	on_expose (a_drawing: EV_DRAWING_AREA; a_x, a_y, a_width, a_height: INTEGER)
		local
			w,h: INTEGER
			l_pnd_x, l_pnd_y, l_x, l_y: INTEGER
			l_alpha: REAL_64
			l_angle: REAL_64
			nb: INTEGER
			cr: POINTER
		do
			set_position (source_position_x - width // 2, source_position_y - height // 2)

			nb := animation_steps
			counter := (counter \\ nb) + 1
			a_drawing.start_drawing_session
			if attached {EV_DRAWING_AREA_IMP} a_drawing.implementation as dw_imp then
				dw_imp.start_transparency (0.0)
				cr := dw_imp.cairo_context
			end
			a_drawing.clear
			l_alpha := 0.5 - (0.4 * counter / nb)


				-- Outer circle
			a_drawing.set_line_width (3)
			w := ( a_width  / 3 + (2 * a_width  / 3) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)
			h := ( a_height / 3 + (2 * a_height / 3) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)
			l_x := 1 + (a_width - w) // 2
			l_y := 1 + (a_height - h) // 2

			if w > 2 * a_drawing.line_width and h > 2 * a_drawing.line_width then
				a_drawing.set_foreground_color (colors.white)
				if not cr.is_default_pointer then
					{CAIRO}.set_source_rgba (cr, 1, 1, 1, l_alpha)
				end
				a_drawing.draw_ellipse (l_x + a_drawing.line_width, l_y + a_drawing.line_width, w - 2 * a_drawing.line_width, h - 2 * a_drawing.line_width)
			end
			if not cr.is_default_pointer then
				{CAIRO}.set_source_rgba (cr, 0, 0, 0, l_alpha)
			else
				a_drawing.set_foreground_color (colors.grey)
			end
			a_drawing.draw_ellipse (l_x, l_y, w, h)

				-- Inner circle
			a_drawing.set_line_width (2)
			w := ( a_width  / 2 - (a_width  / 2) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)
			h := ( a_height / 2 - (a_height / 2) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)

			l_x := 1 + (a_width - w) // 2
			l_y := 1 + (a_height - h) // 2

			l_pnd_x := app_implementation.pnd_pointer_x
			l_pnd_y := app_implementation.pnd_pointer_y

				-- move the inner cirle showing the direction...
			l_angle := {DOUBLE_MATH}.arc_tangent ((l_pnd_x - source_position_x) / (l_pnd_y - source_position_y))
			if l_pnd_x > source_position_x then
				if l_pnd_y > source_position_y then
					l_x := (l_x + {DOUBLE_MATH}.sine (l_angle) * (a_width // 4)).truncated_to_integer
					l_y := (l_y + {DOUBLE_MATH}.cosine (l_angle) * (a_height // 4)).truncated_to_integer
				else
					l_x := (l_x - {DOUBLE_MATH}.sine (l_angle) * (a_width // 4)).truncated_to_integer
					l_y := (l_y - {DOUBLE_MATH}.cosine (l_angle) * (a_height // 4)).truncated_to_integer
				end
			else
				if l_pnd_y > source_position_y then
					l_x := (l_x + {DOUBLE_MATH}.sine (l_angle) * (a_width // 4)).truncated_to_integer
					l_y := (l_y + {DOUBLE_MATH}.cosine (l_angle) * (a_height // 4)).truncated_to_integer
				else
					l_x := (l_x - {DOUBLE_MATH}.sine (l_angle) * (a_width // 4)).truncated_to_integer
					l_y := (l_y - {DOUBLE_MATH}.cosine (l_angle) * (a_height // 4)).truncated_to_integer
				end
			end

				-- draw the inner circle.
			if w < a_width - 2 * a_drawing.line_width and h < a_height - 2 * a_drawing.line_width then
				a_drawing.set_foreground_color (colors.white)
				if not cr.is_default_pointer then
					{CAIRO}.set_source_rgba (cr, 1, 1, 1, l_alpha)
				end
				a_drawing.draw_ellipse (l_x - a_drawing.line_width, l_y - a_drawing.line_width, w + 2 * a_drawing.line_width, h + 2 * a_drawing.line_width)
			end
			if not cr.is_default_pointer then
				{CAIRO}.set_source_rgba (cr, 0, 0, 0, l_alpha)
			else
				a_drawing.set_foreground_color (colors.grey)
			end
			a_drawing.fill_ellipse (l_x, l_y, w, h)

			if attached {EV_DRAWING_AREA_IMP} a_drawing.implementation as dw_imp then
				dw_imp.stop_transparency
			end
			a_drawing.end_drawing_session
		end

	on_timeout
		do
			if attached {EV_DRAWING_AREA} drawing as d then
				on_expose (d, 1, 1, d.width, d.height)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP}

	user_can_resize: BOOLEAN
			-- Can `Current' be resized by the user?
		do
		end

	on_key_event (a_key: detachable EV_KEY; a_key_string: detachable STRING_32; a_key_press: BOOLEAN)
			-- `a_key' has either been pressed or released
		do
		end

	call_close_request_actions
			-- Call the close request actions.
		do
		end

	colors: EV_STOCK_COLORS
		once
			create Result
		end

feature {EV_ANY} -- Execution

	is_activated: BOOLEAN
			-- Is visual activated?

	source_position_x,
	source_position_y: INTEGER

	activate (a_x, a_y: INTEGER; a_width, a_height: INTEGER)
		local
			t: like timeout
		do
			is_activated := True
			set_size (a_width, a_height)
			source_position_x := a_x
			source_position_y := a_y
			set_position ((a_x - a_width * 0.75).truncated_to_integer, (a_y - a_height * 0.75).truncated_to_integer)
			show
			create t
			t.actions.extend (agent on_timeout)
			t.set_interval (animation_delay)
			timeout := t
		end

	deactivate
		do
			hide
			if attached timeout as t then
				t.destroy
				timeout := t
			end
			is_activated := False
		end

	interface: detachable EV_DOCKABLE_SOURCE_HINT note option: stable attribute end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
