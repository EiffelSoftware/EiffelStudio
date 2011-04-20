note
	description:
		"EiffelVision implentation for retrieving a WEL_PEN"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_PEN

inherit
	EV_GDI_OBJECT
		redefine
			item
		end

create
	make_with_values

feature -- Initialization

	make_with_values (a_style: INTEGER; a_width: INTEGER;
		a_brush: WEL_LOG_BRUSH)
			-- Set the style of the pen to `a_dashed_mode',
			-- the line width to `a_width' and the brush
			-- to `a_brush'.
		do
			set_values (a_style, a_width, a_brush)
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value.
		local
			color_hash_value: REAL
		do
			if computed_hash_code = 0 then
				color_hash_value :=
					{REAL_32} 262144.0*color_red +
					{REAL_32} 4096.0*color_green +
					{REAL_32} 64.0*color_blue
				computed_hash_code := (
					color_hash_value.abs.floor +
					line_width * 2 +
					style
				).abs
			end
			Result := computed_hash_code
		end

	style: INTEGER
			-- Style of the pen.

	line_width: INTEGER
			-- Width of the pen.

	color_red: INTEGER
			-- Color of the pen (red component).

	color_blue: INTEGER
			-- Color of the pen (blue component).

	color_green: INTEGER
			-- Color of the pen (green component).

	item: detachable WEL_PEN
			-- WEL Pen object.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `Current' look the same as `other'?
		do
			Result :=
				style = other.style and then
				line_width = other.line_width and then
				color_red = other.color_red and then
				color_green = other.color_green and then
				color_blue = other.color_blue
		end

feature -- Element change

	set_values (a_style: INTEGER; a_width: INTEGER;
		a_brush: WEL_LOG_BRUSH)
			-- Set the style of the pen to `a_style',
			-- the line width to `a_width' and the color
			-- to `a_color'.
		local
			l_color: WEL_COLOR_REF
		do
			style := a_style
			line_width := a_width
			l_color := a_brush.color
			color_red := l_color.red
			color_blue := l_color.blue
			color_green := l_color.green

				-- Reset hash code so that it may be recomputed.
			computed_hash_code := 0
		end

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




end -- class EV_GDI_PEN










