note
	description: "Common abstraction for adding NSView functionality to Eiffel Vision."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_NS_VIEW

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Positions

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		do
			Result := attached_view.frame.origin.x
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		do
			if attached_view.superview.is_flipped then
				Result := attached_view.frame.origin.y
			else
				Result := parent_inner_height - attached_view.frame.size.height - attached_view.frame.origin.y
			end
		end

	screen_x: INTEGER
			-- Horizontal position of the client area on screen,
		do
			if attached {NS_WINDOW} attached_view.window as l_window then
				Result := l_window.convert_base_to_screen (
					attached_view.convert_point_to_view (create {NS_POINT}.make_point (0, 0), void)
				).x
			end
		end

	screen_y: INTEGER
			-- Horizontal position of the client area on screen,
		local
			screen_height: INTEGER
			position_in_window, position_on_screen: detachable NS_POINT
		do
			-- Translate the coordinate to a top-left coordinate system
			if attached attached_view.window as l_window and then attached l_window.screen as l_screen then
				screen_height := l_screen.frame.size.height
				if attached_view.is_flipped then
					position_in_window := attached_view.convert_point_to_view (create {NS_POINT}.make_point (0, 0), void)
				else
					position_in_window := attached_view.convert_point_to_view (create {NS_POINT}.make_point (0, attached_view.frame.size.height), void)
				end
				position_on_screen := l_window.convert_base_to_screen (position_in_window)
				Result :=  screen_height - position_on_screen.y
			end
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			Result := minimum_width.max (attached_view.frame.size.width)
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			Result := minimum_height.max (attached_view.frame.size.height)
		end

	minimum_width: INTEGER
		deferred
		end

	minimum_height: INTEGER
		deferred
		end

feature -- Measurement

	parent_inner_height: INTEGER
			-- FIXME: find a way to calculate the proper inner/client size of an nsview
		do
			if attached {EV_CONTAINER} parent as l_parent then
				if attached {EV_BOX_IMP} l_parent.implementation as l_box then
					Result := l_box.box.content_view.bounds.size.height
				elseif attached {EV_WINDOW_IMP} l_parent.implementation as l_window then
					Result := l_window.content_view.bounds.size.height
				else
					--io.put_string ("f: " + cocoa_view.superview.frame.size.height.out + " b; " + cocoa_view.superview.bounds.size.height.out + " c: " + l_parent.client_height.out + "%N")
					Result := l_parent.client_height
				end
			else
				Result := attached_view.superview.bounds.size.height
				io.error.put_string ("Failed to calculate parent's inner height%N")
			end
		end

	parent: detachable EV_ANY
		deferred
		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER)
		local
			y_cocoa: INTEGER
		do
			if attached_view.superview.is_flipped then
				-- cocoa coordinates = vision coordinates
				y_cocoa := a_y_position
			else
				if parent /= void then
					y_cocoa := parent_inner_height - a_height - a_y_position
				else
					io.put_string ("Warning: converting coordinates failed " + current.generating_type.out + "%N")
				end
			end
			attached_view.set_frame (create {NS_RECT}.make_rect (a_x_position, y_cocoa, a_width, a_height))
		end

	cocoa_move (a_x_position, a_y_position: INTEGER)
		local
			l_frame: NS_RECT
		do
			l_frame := attached_view.frame
			l_frame.origin.x := a_x_position
			l_frame.origin.y := a_y_position
			if not attached_view.superview.is_flipped then
				-- Recalculate y-coordinate with respect to parent view
				if parent /= void then
					l_frame.origin.y := parent_inner_height - l_frame.size.height - a_y_position
				else
					io.put_string ("Warning: converting coordinates failed%N")
				end
			end
			attached_view.set_frame (l_frame)
		end


feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		do
			internal_tooltip_string := a_tooltip.twin
			attached_view.set_tool_tip (create {NS_STRING}.make_with_string (a_tooltip))
		end

	tooltip: STRING_32
			-- Tooltip that has been set.
		do
			if attached internal_tooltip_string as l_tooltip then
				Result := l_tooltip.twin
			else
				create Result.make_empty
			end
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style'.
		local
			pointer_style_imp: detachable EV_POINTER_STYLE_IMP
		do
			pointer_style_imp ?= a_cursor.implementation
			check pointer_style_imp /= void end
			attached_view.discard_cursor_rects
			attached_view.add_cursor_rect (attached_view.visible_rect, pointer_style_imp.cursor)
		end

feature -- Implementation

	internal_tooltip_string: detachable STRING_32

	cocoa_view: detachable NS_VIEW
		note
			options: stable
		attribute
		end

	attached_view: NS_VIEW
		require
			cocoa_view /= void
		local
			l_result: detachable NS_VIEW
		do
			l_result := cocoa_view
			check l_result /= Void end
			Result := l_result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ANY note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end
