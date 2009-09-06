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

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

	NS_VIEW
		rename
			make as make_cocoa,
			make_with_drawing as make_with_drawing_cocoa,
			copy as copy_cocoa
		undefine
			key_down,
			key_up
		redefine
			dispose,
			mouse_down,
			mouse_up,
			mouse_moved,
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
			initialize_events
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
			trans: NS_AFFINE_TRANSFORM
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
			check l_color /= void end
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
		do
			if attached pointer_button_press_actions_internal as actions then
				create pointer_button_action
				point := a_event.window.content_view.convert_point_to_view (a_event.location_in_window, cocoa_view)
				pointer_button_action.x := point.x
				pointer_button_action.y := point.y
				point := a_event.window.convert_base_to_screen_top_left (a_event.location_in_window)
				pointer_button_action.screen_x := point.x
				pointer_button_action.screen_y := point.y
				pointer_button_action.button :=	a_event.button_number + 1
				actions.call (pointer_button_action)
			end
		end

	mouse_up (a_event: NS_EVENT)
		local
			pointer_button_action: TUPLE [x: INTEGER; y: INTEGER; button: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			point: NS_POINT
		do
			if attached pointer_button_release_actions_internal as actions then
				create pointer_button_action
				point := a_event.window.content_view.convert_point_to_view (a_event.location_in_window, cocoa_view)
				pointer_button_action.x := point.x
				pointer_button_action.y := point.y
				point := a_event.window.convert_base_to_screen_top_left (a_event.location_in_window)
				pointer_button_action.screen_x := point.x
				pointer_button_action.screen_y := point.y
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
			if attached pointer_motion_actions_internal as actions then
				create pointer_motion_action
				point := a_event.window.content_view.convert_point_to_view (a_event.location_in_window, cocoa_view)
				pointer_motion_action.x := point.x
				pointer_motion_action.y := point.y
				point := a_event.window.convert_base_to_screen_top_left (a_event.location_in_window)
				pointer_motion_action.screen_x := point.x
				pointer_motion_action.screen_y := point.y
				actions.call (pointer_motion_action)
			end
		end

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
					a_dirty_rect.origin.x,
					a_dirty_rect.origin.y,
					a_dirty_rect.size.width,
					a_dirty_rect.size.height
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

end -- class EV_DRAWING_AREA_IMP
