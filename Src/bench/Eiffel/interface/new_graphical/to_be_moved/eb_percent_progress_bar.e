indexing
	description	: "Smooth progress bar with the percentage written in the middle"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PERCENT_PROGRESS_BAR

inherit
	EV_PIXMAP
		rename
			foreground_color as pixmap_foreground_color,
			background_color as pixmap_background_color,
			set_foreground_color as set_pixmap_foreground_color,
			set_background_color as set_pixmap_background_color
		export
			{NONE} all
		redefine
			initialize,
			enable_sensitive,
			disable_sensitive
		end

create
	default_create,
	make_with_size

feature {NONE} -- Initialization

	initialize is
		do
			Precursor {EV_PIXMAP}
			minimum := 0
			maximum := 100
			foreground_color := Default_colors.dark_blue
			background_color := Default_colors.Color_3d_face
			set_value (0)

				-- Switch to "widget" implementation.
			enable_sensitive
			resize_actions.extend (~on_size)
		end

feature -- Access

	value: INTEGER
			-- Current percentage. Default: 0

	step: INTEGER is 1
			-- Size of change made by `step_forward' or `step_backward'.

	maximum: INTEGER
			-- Top of `range'.

	minimum: INTEGER
			-- Bottom of `range'.

	range: INTEGER_INTERVAL is
			-- Allowed values of `value'.
		do
			Result := minimum |..| maximum
		end

	proportion: REAL is
			-- Relative position of `value' in `range'. Range: [0, 1].
		do
			if maximum > minimum then
				Result := (value - minimum) / (maximum - minimum)
			end
		end

	foreground_color: EV_COLOR
			-- Color used to paint the part of the progress bar
			-- representing the amount of work done.
			-- Default: dark_blue

	background_color: EV_COLOR
			-- Color used to paint the part of the progress bar
			-- representing the amount of remaining work.
			-- Default: Color_3d_face

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if within `range'.
		do
			set_value (maximum.min (value + step))
		ensure
			incremented: value = maximum.min (old value + step)
		end

	step_backward is
			-- Decrement `value' by `step' if within `range'.
		do
			set_value (minimum.max (value - step))
		ensure
			decremented: value = minimum.max (old value - step)
		end

	enable_sensitive is
			-- Set `is_sensitive' to `True'.
		do
			Precursor
			redraw_progress_bar
		end

	disable_sensitive is
			-- Set `is_sensitive' to `False'.
		do
			Precursor
			redraw_progress_bar
		end

feature -- Element change

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Assign `a_range' to `range'.
			-- Set `value' to `a_range'.lower.
		require
			a_range_not_void: a_range /= Void
			a_range_not_empty: not a_range.is_empty
		do
			minimum := a_range.lower
			maximum := a_range.upper
			value := minimum
			redraw_progress_bar
		ensure
			a_range_assigned: range.is_equal (a_range)
			value_assigned: value = a_range.lower
			minimum_consistent: minimum = a_range.lower
			maximum_consistent: maximum = a_range.upper
		end

	set_value (a_value: INTEGER) is
			-- Assign `a_value' to `value'.
		require
			a_value_within_bounds: range.has (a_value)
		do
			value := a_value
			redraw_progress_bar
		ensure
			a_value_assigned: value = a_value
		end

	redraw_progress_bar is
		local
			real_value: INTEGER
			x_value: INTEGER
			clip_rect: EV_RECTANGLE
			percent_string_width: INTEGER
			percent_string_height: INTEGER
			percent_string: STRING
			curr_font: EV_FONT
			x_percent: INTEGER
			y_percent: INTEGER
			loc_width, loc_height: INTEGER
			bar_width, bar_height: INTEGER
		do
			loc_width := width - 1
			loc_height := height - 1

			if is_sensitive and then is_displayed and then 
				loc_width >= 2 and then loc_height >= 2
			then
					-- Cache values
				real_value := percent_value
				bar_width := loc_width - 1
				bar_height := loc_height - 1

					-- Compute positions.
				x_value := (real_value * bar_width) // 100 + 1
				curr_font := create {EV_FONT}
				set_font (curr_font)
				percent_string := real_value.out + "%%"
				percent_string_width := curr_font.string_width (percent_string)
				percent_string_height := curr_font.height
				x_percent := (bar_width - percent_string_width) // 2
				y_percent := (bar_height - percent_string_height) // 2
				
					-- Draw "Done" part ( 0% --> x% )
				create clip_rect.make (1, 1, x_value - 1, loc_height - 1)
				set_clip_area (clip_rect)
				set_pixmap_foreground_color (foreground_color)
				fill_rectangle (1, 1, x_value - 1, loc_height - 1)
				set_pixmap_foreground_color (background_color)
				set_pixmap_background_color (foreground_color)
				draw_text_top_left (x_percent, y_percent, percent_string)
				
					-- Draw "Remaining" part ( x% --> 100% )
				create clip_rect.make (x_value, 1, loc_width - x_value, loc_height - 1)
				set_clip_area (clip_rect)
				set_pixmap_foreground_color (background_color)
				fill_rectangle (x_value, 1, loc_width - x_value, loc_height - 1)
				set_pixmap_foreground_color (foreground_color)
				set_pixmap_background_color (background_color)
				draw_text_top_left (x_percent, y_percent, percent_string)
				remove_clip_area
			end

				-- Draw the 3D borders
			if loc_width >= 0 and loc_height >= 0 then
				set_pixmap_foreground_color (Default_colors.Color_3d_shadow)
				draw_segment (0, 0, loc_width, 0)
				draw_segment (0, 0, 0, loc_height)
				set_pixmap_foreground_color (Default_colors.Color_3d_highlight)
				draw_segment (loc_width, 0, loc_width, loc_height)
				draw_segment (0, loc_height, loc_width, loc_height)
				flush
			end
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' to `a_color'
		do
			foreground_color := a_color
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' to `a_color'
		do
			background_color := a_color
		end

feature -- Resizing

	on_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- The control has been resized
		do
				-- So we resize the progress bar as well
			set_size (a_width.max(1), a_height.max(1))

				-- And we redraw it.
			redraw_progress_bar
		end

feature {NONE} -- Implementation

	percent_value: INTEGER is
			-- Percentage * 100.
		do
			if minimum = 0 and maximum = 100 then
				Result := value
			else
				Result := (proportion * 100).truncated_to_integer
			end
		end

	Default_colors: EV_STOCK_COLORS is
		once
			create Result
		end

end -- class EB_PERCENT_PROGRESS_BAR
