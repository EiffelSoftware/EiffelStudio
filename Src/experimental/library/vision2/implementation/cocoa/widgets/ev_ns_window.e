note
	description: "Summary description for {EV_NS_WINDOW}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_NS_WINDOW

inherit

	NS_WINDOW
		rename
			set_background_color as cocoa_set_background_color,
			background_color as cocoa_background_color,
			make as cocoa_make,
			item as window_item,
			title as cocoa_title,
			set_title as cocoa_set_title,
			copy as cocoa_copy
		end

feature -- Window Title

	set_title (a_title: STRING_GENERAL)
			-- <Precursor>
		do
			cocoa_set_title (create {NS_STRING}.make_with_string (a_title))
			internal_title := a_title.as_string_32
		end

	title: STRING_32
			-- <Precursor>-
		do
			if attached internal_title as l_title then
				Result := l_title.twin
			else
				create Result.make_empty
			end
		end

	internal_title: detachable STRING_32


feature -- Measurement

	x_position, screen_x: INTEGER
			-- X coordinate of `Current'
		do
			Result := frame.origin.x.rounded
		end

	y_position, screen_y: INTEGER
			-- Y coordinate of `Current'
		local
			l_frame: NS_RECT
		do
			l_frame := frame
			Result := (zero_screen.frame.size.height - l_frame.origin.y - l_frame.size.height).rounded
		end

	set_x_position (a_x: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER)
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER)
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			set_frame_top_left_point_flipped (create {NS_POINT}.make_point (a_x, a_y))
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			Result := frame.size.width.rounded
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			Result := frame.size.height.rounded
		end

	set_width (a_width: INTEGER)
			-- Set the horizontal size to `a_width'.
		do
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER)
			-- Set the vertical size to `a_height'.
		do
			set_size (width, a_height)
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			set_frame (create {NS_RECT}.make_rect (x_position, zero_screen.frame.size.height.rounded - y_position - a_height, a_width, a_height), True)
		end

	forbid_resize
			-- Forbid the resize of `Current'.
		local
			l_button: detachable NS_BUTTON
		do
			set_shows_resize_indicator (False)
			l_button := standard_window_button ({NS_WINDOW}.window_zoom_button)
			if attached l_button then
				l_button.set_enabled (False)
			end
		end

	allow_resize
			-- Allow the resize of `Current'.
		local
			l_button: detachable NS_BUTTON
		do
			set_shows_resize_indicator (True)
			l_button := standard_window_button ({NS_WINDOW}.window_zoom_button)
			if attached l_button then
				l_button.set_enabled (True)
			end
		end

end
