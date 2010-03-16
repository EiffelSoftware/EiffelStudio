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

	make_with_values (a_dashed_mode: INTEGER; a_width: INTEGER;
		a_color: WEL_COLOR_REF)
			-- Set the style of the pen to `a_dashed_mode',
			-- the line width to `a_width' and the color
			-- to `a_color'.
		do
			set_values(a_dashed_mode, a_width, a_color)
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
					dashed_line_mode
				).abs
			end
			Result := computed_hash_code
		end

	dashed_line_mode: INTEGER
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

	is_equal(other: like Current): BOOLEAN
			-- Does `Current' look the same as `other'?
		do
			Result :=
				dashed_line_mode = other.dashed_line_mode and then
				line_width = other.line_width and then
				color_red = other.color_red and then
				color_green = other.color_green and then
				color_blue = other.color_blue
		end

feature -- Element change

	set_values (a_dashed_mode: INTEGER; a_width: INTEGER;
		a_color: WEL_COLOR_REF)
			-- Set the style of the pen to `a_dashed_mode',
			-- the line width to `a_width' and the color
			-- to `a_color'.
		do
			dashed_line_mode := a_dashed_mode
			line_width := a_width
			color_red := a_color.red
			color_blue := a_color.blue
			color_green := a_color.green
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










