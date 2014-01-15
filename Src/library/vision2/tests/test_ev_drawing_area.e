note
	description: "Tests for EV_DRAWING_AREA."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_DRAWING_AREA

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

	TEST_CONSTANTS

feature -- Test routines

	drawing_area_draw_pixmap
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			drawing_area: EV_DRAWING_AREA
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			create drawing_area
			drawing_area.set_background_color (colors.red)
			drawing_area.clear

			drawing_area.expose_actions.extend (agent (x, y, w, h: INTEGER_32; a_drawing_area: EV_DRAWING_AREA; a_pixmap: EV_PIXMAP)
				do
					a_drawing_area.draw_pixmap (5, 5, a_pixmap)
				end (?, ?, ?, ?, drawing_area, pixmap))

			create window
			window.extend (drawing_area)
			window.show
			window.set_size (pixmap.width + 15, pixmap.height + 15 + 22)
		end

	drawing_area_draw_sub_pixmap
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			drawing_area: EV_DRAWING_AREA
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			create drawing_area
			drawing_area.set_background_color (colors.red)
			drawing_area.clear

			drawing_area.expose_actions.extend (agent (x, y, w, h: INTEGER_32; a_drawing_area: EV_DRAWING_AREA; a_pixmap: EV_PIXMAP)
				do
					a_drawing_area.draw_sub_pixmap (5, 5, a_pixmap, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					a_drawing_area.draw_pixmap (110, 5, a_pixmap.sub_pixmap (create {EV_RECTANGLE}.make (100, 100, 100, 100)))
				end (?, ?, ?, ?, drawing_area, pixmap))

			create window
			window.extend (drawing_area)
			window.show
			window.set_size (2*100 + 15, 100 + 15 + 22)
		end

	drawing_area_draw_text
		note
			testing: "execution/isolated"
		local
			drawing_area: EV_DRAWING_AREA
			window: EV_TITLED_WINDOW
		do
			create drawing_area
			drawing_area.clear

			drawing_area.expose_actions.extend (agent (x, y, w, h: INTEGER_32; a_drawing_area: EV_DRAWING_AREA)
				do
					a_drawing_area.set_foreground_color (colors.black)
					a_drawing_area.draw_text (10, 10, "black text")
					a_drawing_area.set_foreground_color (colors.red)
					a_drawing_area.draw_text (10, 30, "red text")
				end (?, ?, ?, ?, drawing_area))

			create window
			window.extend (drawing_area)
			window.show
			window.set_size (100, 100)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
