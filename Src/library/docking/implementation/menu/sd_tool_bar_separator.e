indexing
	description: "Tool bar seperator can show horizontal or vertically."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_SEPARATOR

inherit
	EV_DRAWING_AREA
		rename
			width as width_drawing_area
		export
			{NONE} all
			{ANY} set_background_color, background_color
		end
create
	make

feature {NONE} -- Initialization

	make (a_background_color: EV_COLOR; a_is_vertical: BOOLEAN; a_width: INTEGER) is
			-- Initialization
			-- Set `backgound_color' with `a_color'.
			-- Set `is_vertical' with `a_is_vertical'
		require
			a_background_colorr_attached: a_background_color /= Void
			a_width_not_negative: a_width >= 0
		do
			default_create
			expose_actions.extend (agent draw)
			set_background_color (a_background_color)
			is_vertical := a_is_vertical
			set_width (a_width)
		end

feature -- Status report

	is_vertical: BOOLEAN
			-- Is current drawn vertically?

	width: INTEGER is
			-- Width when `is_vertical'
			-- Height when not `is_vertical'
		do
			if not is_vertical then
				Result := height
			else
				Result := width_drawing_area
			end
		end

feature -- Status setting

	set_vertical (a_vertical: BOOLEAN) is
			-- Set `is_vertical' with `a_vertical'
		local
			l_int: INTEGER
		do
			if a_vertical /= is_vertical then
				l_int := minimum_height
				set_minimum_height (minimum_width)
				set_minimum_width (l_int)
				is_vertical := a_vertical
			end
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'.
		require
			a_width_not_negative: a_width >= 0
		do
			if is_vertical then
				set_minimum_width (a_width)
				set_minimum_height (0)
			else
				set_minimum_height (a_width)
				set_minimum_width (0)
			end
		end

feature {NONE} -- Implementation

	draw (a_x, a_y, a_width, a_height: INTEGER) is
			-- Draw.
		local
			l_drawing_off_set: INTEGER
			l_color, l_color_lighten: EV_COLOR
		do
			l_color := color_helper.build_color_with_lightness (background_color, -0.2)
			l_color_lighten := color_helper.build_color_with_lightness (background_color, 0.2)
			l_drawing_off_set := width // 2
			clear
			set_foreground_color (l_color)
			if is_vertical then
				draw_segment (l_drawing_off_set, indent, l_drawing_off_set, a_y + height - indent)
			else
				draw_segment (indent, l_drawing_off_set, width_drawing_area - indent, l_drawing_off_set)
			end
			set_foreground_color (l_color_lighten)
			if is_vertical then
				draw_segment (l_drawing_off_set + 1, indent, l_drawing_off_set + 1, a_y + height - indent)
			else
				draw_segment (indent, l_drawing_off_set + 1, width_drawing_area - indent, l_drawing_off_set + 1)
			end
		end

	color_helper: SD_COLOR_HELPER is
			-- Color helper.
		once
			create Result
		end

	indent: INTEGER is 3

end
