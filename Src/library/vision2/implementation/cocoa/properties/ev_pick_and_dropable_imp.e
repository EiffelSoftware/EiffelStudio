note
	description:
		"Eiffel Vision pick and drop source, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_PICK_AND_DROPABLE_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				execute
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	screen_x: INTEGER
			-- Horizontal position of the client area on screen,
		do
			Result := top_level_window_imp.window.convert_base_to_screen (
				cocoa_view.convert_point_to_view (create {NS_POINT}.make_point (0, 0), void)
			).x
		end

	screen_y: INTEGER
			-- Vertical position of the client area on screen,
		local
			l_window: NS_WINDOW
			screen_height: INTEGER
			position_in_window, position_on_screen: NS_POINT
		do
			-- Translate the coordinate to a top-left coordinate system
			l_window := top_level_window_imp.window
			screen_height := l_window.screen.frame.size.height
			if cocoa_view.is_flipped then
				position_in_window := cocoa_view.convert_point_to_view (create {NS_POINT}.make_point (0, 0), void)
			else
				position_in_window := cocoa_view.convert_point_to_view (create {NS_POINT}.make_point (0, cocoa_view.frame.size.height), void)
			end
			position_on_screen := l_window.convert_base_to_screen (position_in_window)
			Result :=  screen_height - position_on_screen.y
		end

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
			Result := cocoa_view.frame.origin.y
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES,  LAYOUT_INSPECTOR} -- Implementation

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.
		do
			check
				implement_in_subclass: false
			end
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		do
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style'.
		do
		end

	set_focus
			-- Grab keyboard focus.
		do
		end

	internal_set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style', used for PND
		do
		end

	pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval.

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		do
			Result := cocoa_view.frame.size.width
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		do
			Result := cocoa_view.frame.size.height
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
		end

feature -- Status report

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
		do
			Result := True
		end

feature -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

		do
		end

feature {NONE} -- Implementation

	enable_capture
			-- Grab all the mouse and keyboard events.
		do
		end

	disable_capture
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
		end

	has_capture: BOOLEAN
			-- Does Current have the keyboard and mouse event capture?
		do
		end

feature -- Implementation

	enable_transport
			-- Activate pick/drag and drop mechanism.
 		do
		end

	disable_transport
			-- Deactivate pick/drag and drop mechanism.
		do
		ensure then
			is_transport_disabled: not is_transport_enabled
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		do
		end

	is_dockable: BOOLEAN
			-- Is `Current' dockable?
		deferred
		end

	set_to_drag_and_drop: BOOLEAN
			-- Set `Current' to drag and drop mode.
		do
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is `Current' able to initiate transport with `a_button'.
		do
		end

	on_mouse_button_event (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Handle mouse button events.
		do
		end

	start_transport (
			a_x, a_y, a_button: INTEGER; a_press: BOOLEAN
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)

			-- Initialize a pick and drop transport.
		do
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN
			-- Will `Current' display a menu with button `a_button'.
		do
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- End a pick and drop transport.
		do
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
		end

	draw_rubber_band
			-- Draw a segment between initial pick point and `destination'.
		do
		end

	erase_rubber_band
			-- Erase previously drawn rubber band.
		do
		end

	pnd_screen: EV_SCREEN
			-- Screen object used for drawing PND transport line
		once
		end

	real_pointed_target: EV_PICK_AND_DROPABLE
			-- Hole at mouse position
		do
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Create and initialize `drop_actions' for `Current'
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PICK_AND_DROPABLE;

	cocoa_item: NS_OBJECT
		deferred
		end

	cocoa_view: NS_VIEW
		do
			Result ?= cocoa_item
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_PICK_AND_DROPABLE_IMP

