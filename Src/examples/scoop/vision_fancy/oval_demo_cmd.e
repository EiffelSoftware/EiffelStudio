note
	description: "Draw ovals in a specified window."
	date: "$Date$"
	revision: "$Revision$"

class
	OVAL_DEMO_CMD

inherit
	DEMO_CMD

create
	make_in

feature -- Basic operations

	draw (a_drawing_area: like drawing_area)
			-- Draw Ovals.
		local
			r_left, r_top, r_right, r_bottom: INTEGER
			color: EV_COLOR
			l_rect: EV_RECTANGLE
		do
				-- Initialize
			r_left := next_number (a_drawing_area.width)
			r_top := next_number (a_drawing_area.height)
			r_right := next_number (a_drawing_area.width)
			r_bottom := next_number (a_drawing_area.height)
			color := std_colors @ (next_number (std_colors.count))
			create l_rect.make (1, 1, a_drawing_area.width, 30)

				-- Drawing part
			a_drawing_area.set_separate_foreground_color (color)
			a_drawing_area.fill_ellipse (r_left, r_top, r_right, r_bottom)
			a_drawing_area.draw_text_from_separate (0, 0, count.out.as_string_32)

				-- Update
			count := count + 1
		end

	count: INTEGER
			-- Number of time where `draw' has been called.

invariant
	count_nonnegative: count >= 0

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
