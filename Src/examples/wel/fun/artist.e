note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ARTIST

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			class_cursor,
			class_icon,
			class_name,
			on_mouse_move,
			on_left_button_down,
			on_left_button_up,
			on_size
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW)
		do
			make_child (a_parent, "Artist")
			resize (300, 300)
			show
			create dc.make (Current)
		end

feature {NONE} -- Implementation

	dc: detachable WEL_CLIENT_DC

	sqr_3_2: REAL = 0.86602540
		-- sqrt (3) / 2

	x_bak, y_bak: INTEGER
		-- Last mouse position

	mid_width, mid_height: INTEGER
		-- Window's height and width divided by 2

	button_down: BOOLEAN
		-- Is the mouse button down?

	on_size (size_type, a_width, a_height: INTEGER)
			-- The window has been resized
		do
			mid_width := a_width // 2
			mid_height := a_height // 2
			x_bak := mid_width
			y_bak := mid_height
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- The button has been pressed down.
		do
			button_down := True
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- The button has been released.
		do
			button_down := False
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- The mouse has been moved.
		local
			l_dc: like dc
		do
			l_dc := dc
				-- Per invariant
			check l_dc_attached: l_dc /= Void end
			l_dc.get
			if not button_down then
				draw (x_bak, y_bak, black)
			end
			x_bak := x_pos
			y_bak := y_pos
			draw (x_pos, y_pos, colors.item ((x_pos * y_pos) \\
				16 + 1))
			l_dc.release
		end

feature {NONE} -- Implementation

	draw (x_pos, y_pos: INTEGER; color: WEL_COLOR_REF)
			-- Draw the 16 points
		local
			xx, yy, dx, dy: INTEGER
			l_dc: like dc
		do
			dx := (x_pos - mid_width).abs
			dy := (y_pos - mid_height).abs
			xx := (dx / 2 - sqr_3_2 * dy).rounded
			yy := (dy / 2 + sqr_3_2 * dx).rounded
			l_dc := dc
				-- Per invariant
			check l_dc_attached: l_dc /= Void end
			l_dc.set_pixel (mid_width + dx, mid_height + dy, color)
			l_dc.set_pixel (mid_width + dy, mid_height + dx, color)
			l_dc.set_pixel (mid_width - dx, mid_height + dy, color)
			l_dc.set_pixel (mid_width - dy, mid_height + dx, color)
			l_dc.set_pixel (mid_width + dx, mid_height - dy, color)
			l_dc.set_pixel (mid_width + dy, mid_height - dx, color)
			l_dc.set_pixel (mid_width - dx, mid_height - dy, color)
			l_dc.set_pixel (mid_width - dy, mid_height - dx, color)
			l_dc.set_pixel (mid_width + xx, mid_height + yy, color)
			l_dc.set_pixel (mid_width + yy, mid_height + xx, color)
			l_dc.set_pixel (mid_width - xx, mid_height + yy, color)
			l_dc.set_pixel (mid_width - yy, mid_height + xx, color)
			l_dc.set_pixel (mid_width + xx, mid_height - yy, color)
			l_dc.set_pixel (mid_width + yy, mid_height - xx, color)
			l_dc.set_pixel (mid_width - xx, mid_height - yy, color)
			l_dc.set_pixel (mid_width - yy, mid_height - xx, color)
		end

	colors: ARRAY [WEL_COLOR_REF]
			-- Array of standard colors
		once
			Result := <<
				white,
				black,
				grey,
				dark_grey,
				blue,
				dark_blue,
				cyan,
				dark_cyan,
				green,
				dark_green,
				yellow,
				dark_yellow,
				red,
				dark_red,
				magenta,
				dark_magenta >>
		ensure
			resut_not_void: Result /= Void
		end

	class_background: WEL_BLACK_BRUSH
			-- Black background
		once
			create Result.make
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_artist)
		end

	class_cursor: WEL_CURSOR
			-- No cursor
		once
			create Result.make_by_id (Id_cur_invisible)
		end

	class_name: STRING_32
		once
			Result := "GDI Artist"
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ARTIST

