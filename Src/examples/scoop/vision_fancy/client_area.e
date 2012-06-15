note
	description: "Client area where drawing will be performed"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT_AREA

inherit
	EV_DRAWING_AREA

feature -- Element Change

	set_separate_foreground_color (a_color: separate EV_COLOR)
			-- Set `foreground_color' from separate color.
		local
			l_color: EV_COLOR
		do
			create l_color.make_with_rgb (a_color.red, a_color.green, a_color.blue)
			set_foreground_color (l_color)
		end

feature -- Draw

	draw_text_from_separate (x, y: INTEGER_32; a_text: separate READABLE_STRING_32)
			-- Draw text from separate object.
		local
			l_string: STRING_32
		do
				-- We don't compute the text length in order to get better performance.
			clear_rectangle (0, y, width, font_height)
			create l_string.make_from_separate (a_text.as_string_32)
			draw_text (x, y + font_height, l_string)
		end

feature {NONE} -- Implementation

	font_height: INTEGER
			-- Height of the font
		local
			l_font: EV_FONT
		once
			l_font := font
			Result := l_font.height_in_points
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
