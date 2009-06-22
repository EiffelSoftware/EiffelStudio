note
	description: "Common abstraction for adding NSView functionality to Eiffel Vision."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_NS_VIEW

inherit
	EV_ANY_I

feature -- Positions

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		do
			Result := cocoa_view.frame.origin.x
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		do
			if cocoa_view.superview.is_flipped then
				Result := cocoa_view.frame.origin.y
			else
				Result := parent_inner_height - cocoa_view.frame.size.height - cocoa_view.frame.origin.y
			end
		end

	screen_x: INTEGER
			-- Horizontal position of the client area on screen,
		do
			if attached {NS_WINDOW} cocoa_view.window as l_window then
				Result := l_window.convert_base_to_screen (
					cocoa_view.convert_point_to_view (create {NS_POINT}.make_point (0, 0), void)
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
			if attached cocoa_view.window as l_window and then attached l_window.screen as l_screen then
				screen_height := l_screen.frame.size.height
				if cocoa_view.is_flipped then
					position_in_window := cocoa_view.convert_point_to_view (create {NS_POINT}.make_point (0, 0), void)
				else
					position_in_window := cocoa_view.convert_point_to_view (create {NS_POINT}.make_point (0, cocoa_view.frame.size.height), void)
				end
				position_on_screen := l_window.convert_base_to_screen (position_in_window)
				Result :=  screen_height - position_on_screen.y
			end
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			Result := minimum_width.max (cocoa_view.frame.size.width)
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			Result := minimum_height.max (cocoa_view.frame.size.height)
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
					Result := l_window.window.content_view.bounds.size.height
				else
					--io.put_string ("f: " + cocoa_view.superview.frame.size.height.out + " b; " + cocoa_view.superview.bounds.size.height.out + " c: " + l_parent.client_height.out + "%N")
					Result := l_parent.client_height
				end
			else
				Result := cocoa_view.superview.bounds.size.height
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
			if cocoa_view.superview.is_flipped then
				-- cocoa coordinates = vision coordinates
				y_cocoa := a_y_position
			else
				if parent /= void then
					y_cocoa := parent_inner_height - a_height - a_y_position
				else
					io.put_string ("Warning: converting coordinates failed " + current.generating_type.out + "%N")
				end
			end
			cocoa_view.set_frame (create {NS_RECT}.make_rect (a_x_position, y_cocoa, a_width, a_height))
		end

	cocoa_move (a_x_position, a_y_position: INTEGER)
		local
			l_frame: NS_RECT
		do
			l_frame := cocoa_view.frame
			l_frame.origin.x := a_x_position
			l_frame.origin.y := a_y_position
			if not cocoa_view.superview.is_flipped then
				-- Recalculate y-coordinate with respect to parent view
				if parent /= void then
					l_frame.origin.y := parent_inner_height - l_frame.size.height - a_y_position
				else
					io.put_string ("Warning: converting coordinates failed%N")
				end
			end
			cocoa_view.set_frame (l_frame)
		end

feature -- Implementation

	cocoa_view: NS_VIEW
		local
			l_result: detachable NS_VIEW
		do
			l_result ?= cocoa_item
			check
				l_result /= Void
			end
			Result := l_result
		end

	cocoa_item: NS_OBJECT
		deferred
		end

end
