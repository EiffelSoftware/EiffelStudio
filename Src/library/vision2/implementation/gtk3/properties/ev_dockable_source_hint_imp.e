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

			l_app_imp := app_implementation

			c_screen := {GDK}.gdk_screen_get_default
			c_visual := {GDK}.gdk_screen_get_rgba_visual (c_screen)
			if not c_visual.is_default_pointer and {GDK}.gdk_screen_is_composited (c_screen) then
				{GTK}.gtk_widget_set_visual (c_win, c_visual)
			end
			{GTK}.gtk_widget_set_app_paintable (c_win, True)
			{GTK}.gtk_window_set_skip_taskbar_hint (c_win, True)
			{GTK}.gtk_box_set_homogeneous (c_win, True)
			{GTK}.gtk_container_set_border_width (c_win, 0)

			l_app_imp.window_oids.extend (internal_id)

			create d
			drawing := d
			if attached {EV_DRAWING_AREA_IMP} d.implementation as d_imp then
				{GTK}.gtk_container_add (c_win, d_imp.c_object)
			end

			{GTK}.gtk_widget_show_all (c_win)

			set_is_initialized (True)

			initialize_defaults

			if attached {EXECUTION_ENVIRONMENT}.item ("EV_PND_STYLE") as l_ev_pnd_style then
				if l_ev_pnd_style.has_substring ("-transparent") then
					disable_transparency
				end
				if l_ev_pnd_style.has_substring ("+screenshot") then
					enable_screenshot_hack_enabled
				end
				if l_ev_pnd_style.has_substring ("+colors") then
					enable_colors
				end
				if l_ev_pnd_style.has_substring ("+blinking") then
					enable_blinking
				end
				if {PLATFORM}.is_mac then
						-- No transparency on Mac, but user can force the choice.
						-- in case, gtk3 on macosx is improved for transparency...
					if not l_ev_pnd_style.has_substring ("+transparent") then
						disable_transparency
					end
				end
			elseif {PLATFORM}.is_mac then
					-- No transparency on Mac
				disable_transparency
			end
		end

	initialize_defaults
		do
			transparency_enabled := True
			animation_steps := 20
			animation_delay := 40
			step := 1
		end

feature -- Settings change

	enable_transparency
		do
			transparency_enabled := True
		end

	disable_transparency
		do
			transparency_enabled := False
		end

	enable_screenshot_hack_enabled
		do
			screenshot_hack_enabled := True
		end

	enable_colors
		do
			colors_enabled := True
		end

	enable_blinking
		do
			is_blinking := True
		end

feature -- Settings

	animation_steps: INTEGER

	animation_delay: INTEGER
			-- Animation delay in ms

	transparency_enabled: BOOLEAN

	screenshot_hack_enabled: BOOLEAN

	colors_enabled: BOOLEAN

	is_blinking: BOOLEAN

feature {NONE} -- Implementation

	window: POINTER

	pixbuf: POINTER

	pixbuf_rectangle: detachable EV_RECTANGLE

	drawing: EV_DRAWING_AREA

	timeout: detachable EV_TIMEOUT

	counter: INTEGER

feature {EV_ANY} -- Size change

	set_size (a_width, a_height: INTEGER)
		do
			Precursor (a_width, a_height)
			drawing.set_minimum_size (a_width, a_height)
		end

	get_pixbuf
		local
			p_root: POINTER
			l_prev_rect, l_rect: like pixbuf_rectangle
			l_was_shown: BOOLEAN
		do
			create l_rect.make (x_position, y_position, width, height)

			l_prev_rect := pixbuf_rectangle
			if l_prev_rect = Void then
				create l_rect.make ((l_rect.x - l_rect.width).max (1) , (l_rect.y - l_rect.height).max (1), 3 * l_rect.width, 3 * l_rect.height)
			end
			if
				l_prev_rect = Void or else
				not l_prev_rect.contains (l_rect)
			then
				discard_pixbuf
				p_root := {GDK}.gdk_get_default_root_window
				if not p_root.is_default_pointer then
					l_was_shown := is_show_requested
					if l_was_shown then
						hide
					end
					pixbuf := {GDK}.gdk_pixbuf_get_from_window (p_root, l_rect.x, l_rect.y, l_rect.width, l_rect.height)
					if l_was_shown then
						show
					end
					pixbuf_rectangle := l_rect
				end
			end
		end

	discard_pixbuf
		do
			if not pixbuf.is_default_pointer then
				{GDK}.g_object_unref (pixbuf)
				pixbuf := default_pointer
				pixbuf_rectangle := Void
			end
		end

feature {NONE} -- Implementation

	update (a_drawing: EV_DRAWING_AREA; a_x, a_y, a_width, a_height: INTEGER)
		local
			w,h: INTEGER
			l_pnd_x, l_pnd_y, l_x, l_y: INTEGER
			l_alpha: REAL_64
			l_angle: REAL_64
			nb: INTEGER
			cr: POINTER
			fg,bg: EV_COLOR
			l_app_implementation: like app_implementation
		do
			l_app_implementation := app_implementation
			if transparency_enabled or screenshot_hack_enabled then
				nb := animation_steps
			else
				nb := animation_steps // 2
			end
			counter := counter + step
			if step > 0 then
				if counter >= nb then
					step := -step
				end
			else
				if counter <= 1 then
					step := -step
				end
			end
--			counter := (counter \\ nb) + 1
			fg := foreground_color
			if fg = Void then
				fg := colors.default_foreground_color
			end
			bg := background_color
			if bg = Void then
				bg := colors.default_background_color
			end

			if transparency_enabled or screenshot_hack_enabled then
				set_position (l_app_implementation.x_origin - width // 2, l_app_implementation.y_origin - height // 2)


				a_drawing.start_drawing_session
				if attached {EV_DRAWING_AREA_IMP} a_drawing.implementation as dw_imp then
					if transparency_enabled then
						dw_imp.start_transparency (0.0)
					end
					cr := dw_imp.cairo_context
				end
				a_drawing.clear

				if
					screenshot_hack_enabled and then
					not cr.is_default_pointer and then
					not pixbuf.is_default_pointer and then
					attached pixbuf_rectangle as rect
				then
					{GDK}.gdk_cairo_set_source_pixbuf (cr, pixbuf, -(x_position - rect.x), - (y_position - rect.y))
					{CAIRO}.paint (cr)
				end


				l_alpha := 0.7 - (0.4 * counter / nb)

					-- Outer circle
				a_drawing.set_line_width (3)
				w := ( a_width  / 3 + (2 * a_width  / 3) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)
				h := ( a_height / 3 + (2 * a_height / 3) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)
				l_x := 1 + (a_width - w) // 2
				l_y := 1 + (a_height - h) // 2

				if w > 2 * a_drawing.line_width and h > 2 * a_drawing.line_width then
					a_drawing.set_foreground_color (bg)
					if not cr.is_default_pointer then
						{CAIRO}.set_source_rgba (cr, bg.red, bg.green, bg.blue, l_alpha)
					end
					a_drawing.draw_ellipse (l_x + a_drawing.line_width, l_y + a_drawing.line_width, w - 2 * a_drawing.line_width, h - 2 * a_drawing.line_width)
				end
				if not cr.is_default_pointer then
					{CAIRO}.set_source_rgba (cr, fg.red, fg.green, fg.blue, l_alpha)
				else
					a_drawing.set_foreground_color (fg)
				end
				a_drawing.draw_ellipse (l_x, l_y, w, h)

					-- Inner circle
				a_drawing.set_line_width (2)
				w := ( a_width  / 2 - (a_width  / 2) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)
				h := ( a_height / 2 - (a_height / 2) * (counter / nb) - 2 * a_drawing.line_width).truncated_to_integer.max (1)

				l_x := 1 + (a_width - w) // 2
				l_y := 1 + (a_height - h) // 2

				l_pnd_x := l_app_implementation.pnd_pointer_x
				l_pnd_y := l_app_implementation.pnd_pointer_y

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
					a_drawing.set_foreground_color (bg)
					if not cr.is_default_pointer then
						{CAIRO}.set_source_rgba (cr, bg.red, bg.green, bg.blue, l_alpha)
					end
					a_drawing.draw_ellipse (l_x - a_drawing.line_width, l_y - a_drawing.line_width, w + 2 * a_drawing.line_width, h + 2 * a_drawing.line_width)
				end
				if not cr.is_default_pointer then
					{CAIRO}.set_source_rgba (cr, fg.red, fg.green, fg.blue, l_alpha)
				else
					a_drawing.set_foreground_color (fg)
				end
				a_drawing.fill_ellipse (l_x, l_y, w, h)

				if attached {EV_DRAWING_AREA_IMP} a_drawing.implementation as dw_imp then
					if dw_imp.background_transparency_set then
						dw_imp.stop_transparency
					end
				end
				a_drawing.end_drawing_session
			else
					-- Dirty hack ...
				if is_blinking and then counter \\ 2 = 1 then
					hide
				else
					show
				end
				w := width
				h := height
--				w := (counter * hint_width // nb).max (1)
--				h := (counter * hint_height // nb).max (1)
				a_drawing.start_drawing_session

				if attached {EV_DRAWING_AREA_IMP} a_drawing.implementation as dw_imp then
					cr := dw_imp.cairo_context
				end
				a_drawing.set_background_color (bg)
				a_drawing.clear

				if not cr.is_default_pointer then
					l_alpha := 1 - counter / nb
					{CAIRO}.set_source_rgba (cr, fg.red, fg.green, fg.blue, l_alpha)
					a_drawing.fill_rectangle (0, 0, width, height)
				end

				w := (w * counter / nb).truncated_to_integer
				h := (h * counter / nb).truncated_to_integer

				if w > 2 and h > 2 then
					a_drawing.set_line_width (1)
					if not cr.is_default_pointer then
						{CAIRO}.set_source_rgba (cr, fg.red, fg.green, fg.blue, counter / nb)
					else
						a_drawing.set_foreground_color (fg)
					end
					a_drawing.fill_ellipse ((width - w) // 2, (height - h) // 2, w, h)
				end

				a_drawing.end_drawing_session
				set_position (l_app_implementation.x_origin - width // 2, l_app_implementation.y_origin - height // 2)
			end
		end

	on_timeout
		do
			if attached {EV_DRAWING_AREA} drawing as d then
				update (d, 1, 1, d.width, d.height)
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

	step: INTEGER
			-- Positive or negative steps ( default +1 )

	source_position_x,
	source_position_y: INTEGER

	hint_width, hint_height: INTEGER

	foreground_color, background_color: detachable EV_COLOR

	activate (a_x, a_y: INTEGER; a_width, a_height: INTEGER; a_pebble_src: EV_PICK_AND_DROPABLE)
		local
			t: like timeout
		do
			if
				colors_enabled and then
				attached {EV_COLORIZABLE} a_pebble_src as l_ev_col
			then
				foreground_color := l_ev_col.foreground_color
				background_color := l_ev_col.background_color
				if
					(foreground_color ~ background_color) or
					(foreground_color = Void or background_color = Void)
				then
					foreground_color := Void
					background_color := Void
				end
			end
			is_activated := True
			counter := 0
			if transparency_enabled or screenshot_hack_enabled then
				hint_width := a_width
				hint_height := a_height
			else
				hint_width := a_width // 3
				hint_height := a_height // 3
			end

			set_size (hint_width, hint_height)
			if not is_blinking then
				show
			end
			if attached app_implementation as l_app_implementation then
				source_position_x := l_app_implementation.x_origin
				source_position_y := l_app_implementation.y_origin
			else
				source_position_x := a_x
				source_position_y := a_y
			end
			set_position (source_position_x - width // 2, source_position_y - height // 2)

			if
				screenshot_hack_enabled
			then
				get_pixbuf
			end

			create t
			timeout := t
			t.actions.extend (agent on_timeout)
			if transparency_enabled or screenshot_hack_enabled then
				t.set_interval (animation_delay)
			else
				t.set_interval (animation_delay * 2) -- slower
			end
		end

	deactivate
		do
			hide
			if attached timeout as t then
				t.destroy
				timeout := t
			end
			if
				screenshot_hack_enabled
			then
				discard_pixbuf
			end
			foreground_color := Void
			background_color := Void

			is_activated := False
		end

	interface: detachable EV_DOCKABLE_SOURCE_HINT note option: stable attribute end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
