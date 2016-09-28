note
	description: "EiffelVision drawing area. Cocoa implementation."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		select
			copy
		end

	EV_DRAWABLE_IMP
		undefine
			old_make,
			is_flipped
		redefine
			interface,
			make,
			prepare_drawing,
			finish_drawing
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			make,
			dispose
		end

	NS_VIEW
		rename
			make as make_cocoa,
			make_with_drawing as make_with_drawing_cocoa,
			copy as copy_cocoa
		undefine
			key_down,
			key_up,
			is_equal
		redefine
			dispose,
			mouse_down,
			mouse_up,
			mouse_moved,
			accepts_first_responder,
			become_first_responder,
			resign_first_responder,
			draw_rect
		end

	EV_NS_RESPONDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			Precursor {EV_DRAWABLE_IMP}
			make_with_drawing_cocoa
			cocoa_view := current
			Precursor {EV_PRIMITIVE_IMP}
			disable_tabable_from
		end

feature -- Status setting

	redraw
			-- Redraw the entire area.
		do
			set_needs_display (True)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
			set_needs_display_in_rect (create {NS_RECT}.make_rect (a_x, a_y, a_width, a_height))
		end

	clear_and_redraw
			-- Clear `Current' and redraw.
		do
			clear
			redraw
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Clear the rectangle area defined by `a_x', `a_y', `a_width', `a_height' and then redraw it.
		do
			clear
			redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	flush
			-- Redraw the screen immediately, if change actions have been requested
		do
			display_if_needed
		end

	prepare_drawing
		local
			l_color: detachable EV_COLOR_IMP
--			trans: NS_AFFINE_TRANSFORM
		do
			if not lock_focus_if_can_draw then
				image.lock_focus
				is_drawing_buffered := True
			else
				is_drawing_buffered := False
			end
--				create trans.make
--				trans.translate_by_xy (0.0, height)
--				trans.scale_by_xy (1.0, -1.0)
--				trans.concat
			l_color ?= foreground_color.implementation
			check l_color /= void then end
			l_color.color.set
		end


	finish_drawing
		do
			if is_drawing_buffered then
				image.unlock_focus
			else
				unlock_focus
			end
		end

feature {NONE} -- Implementation

	mouse_down (a_event: NS_EVENT)
		local
			pointer_button_action: TUPLE [x: INTEGER; y: INTEGER; button: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			point: NS_POINT
			actions: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
		do
-- NOTE Should the pointer_button_press actions always be fired - even when a double click is coming up?
--      At the moment it is.
--
-- From the topic "detecting a double click ahead of time" on cocoa-dev:
--
--  The standard method is to run start a timer when you see the first
--  click, then if you don't get a double-click before the timer fires,
--  assume that there isn't going to be one.  Obviously you need to
--  remember to cancel the timer if you see a double click, and you will
--  also want to ignore double-clicks if they don't happen when you're
--  running the timer (otherwise a spurious double-click event could cause
--  a lot of trouble).
			if a_event.click_count = 1 then
				actions := pointer_button_press_actions_internal
			else -- if click_count >= 2
				actions := pointer_double_press_actions_internal
			end
			if attached actions and attached a_event.window as l_window then
				create pointer_button_action
				point := l_window.content_view.convert_point_to_view (a_event.location_in_window, cocoa_view)
				pointer_button_action.x := point.x.rounded
				pointer_button_action.y := point.y.rounded
				point := l_window.convert_base_to_screen_top_left (a_event.location_in_window)
				pointer_button_action.screen_x := point.x.rounded
				pointer_button_action.screen_y := point.y.rounded
				pointer_button_action.button :=	a_event.button_number + 1
				actions.call (pointer_button_action)
			end
		end

	mouse_up (a_event: NS_EVENT)
		local
			pointer_button_action: TUPLE [x: INTEGER; y: INTEGER; button: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			point: NS_POINT
		do
			if attached pointer_button_release_actions_internal as actions and attached a_event.window as l_window then
				create pointer_button_action
				point := l_window.content_view.convert_point_to_view (a_event.location_in_window, cocoa_view)
				pointer_button_action.x := point.x.rounded
				pointer_button_action.y := point.y.rounded
				point := l_window.convert_base_to_screen_top_left (a_event.location_in_window)
				pointer_button_action.screen_x := point.x.rounded
				pointer_button_action.screen_y := point.y.rounded
				pointer_button_action.button :=	a_event.button_number + 1
				actions.call (pointer_button_action)
			end
		end

	mouse_moved (a_event: NS_EVENT)
			-- Translate a Cocoa mouseMoved NS_EVENT to a pointer_motion_action call
		local
			pointer_motion_action: TUPLE [x: INTEGER; y: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			point: NS_POINT
		do
			if attached pointer_motion_actions_internal as actions and attached a_event.window as l_window then
				create pointer_motion_action
				point := l_window.content_view.convert_point_to_view (a_event.location_in_window, cocoa_view)
				pointer_motion_action.x := point.x.rounded
				pointer_motion_action.y := point.y.rounded
				point := l_window.convert_base_to_screen_top_left (a_event.location_in_window)
				pointer_motion_action.screen_x := point.x.rounded
				pointer_motion_action.screen_y := point.y.rounded
				actions.call (pointer_motion_action)
			end
		end

	accepts_first_responder: BOOLEAN
			-- Every (sensitive?) Vision2 widget must be able to accept key events
		do
			Result := is_sensitive
		end

	become_first_responder: BOOLEAN
			-- Call the focus_in actions
		do
			if attached focus_in_actions_internal as actions then
				actions.call ([])
			end
			Result := True -- always accept first responder status
		end

	resign_first_responder: BOOLEAN
			-- Call the focus_out actions
		do
			if attached focus_out_actions_internal as actions then
				actions.call ([])
			end
			Result := True -- always resign first responder status
		end

feature -- Implementation

	is_drawing_buffered: BOOLEAN

	update_if_needed
		do
--			set_needs_display (True) -- Not necessaey -> Will send a redraw event right again
		end

	draw_rect (a_dirty_rect: NS_RECT)
			-- Draw callback
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([
					a_dirty_rect.origin.x.rounded,
					a_dirty_rect.origin.y.rounded,
					a_dirty_rect.size.width.rounded,
					a_dirty_rect.size.height.rounded
					])
			end
		end

feature {EV_ANY_I} -- Implementation

	dispose
		do
			Precursor {NS_VIEW}
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWING_AREA note option: stable attribute end;

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
end -- class EV_DRAWING_AREA_IMP
