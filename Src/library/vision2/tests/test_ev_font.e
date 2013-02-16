note
	description: "Tests for EV_FONT."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_FONT

inherit
	VISION2_TEST_SET

feature -- Test routines

	font_metrics
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					pixmap: EV_PIXMAP
					window: EV_TITLED_WINDOW
					font: EV_FONT
					size: TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
				do
					create pixmap.make_with_size (700, 50)
					pixmap.clear

					create font
					font.set_height (30)
					pixmap.set_font (font)

					-- string_size in yellow
					size := font.string_size ("the quick brown fox jumps over the lazy dog")
					pixmap.set_foreground_color (colors.yellow)
					pixmap.fill_rectangle (10, 10, size.width, size.height)

					-- top-line in red
					pixmap.set_foreground_color (colors.red)
					pixmap.draw_segment (10, 10, pixmap.width-10, 10)

					-- base-line and (base-line + descent) in blue
					pixmap.set_foreground_color (colors.blue)
					pixmap.draw_segment (10, 10 + font.ascent, pixmap.width-10, 10 + font.ascent)
					pixmap.draw_segment (10, 10 + font.ascent + font.descent, pixmap.width-10, 10 + font.ascent + font.descent)

					pixmap.set_foreground_color (colors.black)
					pixmap.draw_text_top_left (10, 10, "the quick brown fox jumps over the lazy dog")

					create window
					window.extend (pixmap)
					window.show
				end
			)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
