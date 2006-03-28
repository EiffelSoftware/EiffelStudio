indexing
	description: "Objects with responsibility for draw a dot on dragging area."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DOT_DRAWER
-- FIXIT: move this to subcluster of "toolbar"
--        maybe new cluster name is: support
create
	make

feature {NONE} -- Initlization
	make (a_color: EV_COLOR) is
			-- Creation method.
		require
			not_void: a_color /= Void
		do
			background_color_internal := a_color
			create bar_dot
		ensure
			set: background_color_internal = a_color
		end

feature -- Command

	draw (a_pixmap: EV_PIXMAP) is
			-- Draw dot on a_pixmap.
		require
			not_void: a_pixmap /= Void
		do
			bar_dot := a_pixmap
			init_a_dot
		ensure
			set: bar_dot = a_pixmap
		end

feature {NONE} -- Drawing.

	background_color_internal: EV_COLOR
			-- Background color base on which to draw.

	bar_dot: EV_PIXMAP
			-- bar dot which current draw.

	init_a_dot is
			-- Init colors of a shadowed dot.
		local
			l_color: EV_COLOR
			l_red, l_blue, l_green: REAL
		do
			l_red := background_color_internal.red * 0.95
			l_green := background_color_internal.green * 0.95
			l_blue := background_color_internal.blue * 0.95
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (0, 0)

			l_red := background_color_internal.red * 0.83
			l_green := background_color_internal.green * 0.83
			l_blue := background_color_internal.blue * 0.83
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (0, 1)

			l_red := background_color_internal.red * 0.94
			l_green := background_color_internal.green * 0.94
			l_blue := background_color_internal.blue * 0.94
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (0, 2)

			l_red := background_color_internal.red * 0.80
			l_green := background_color_internal.green * 0.80
			l_blue := background_color_internal.blue * 0.80
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (1, 0)

			l_red := 1 - background_color_internal.red * 0.45
			l_green := 1 - background_color_internal.green * 0.45
			l_blue := 1 - background_color_internal.blue * 0.45
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (1, 1)

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (1, 2)

			l_red := background_color_internal.red * 0.97
			l_green := background_color_internal.green * 0.97
			l_blue := background_color_internal.blue * 0.96
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (2, 0)

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (2, 1)

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (2, 2)
		end

end
