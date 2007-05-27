indexing
	description:
		"Eiffel Vision pick and drop source, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_CARBON_WIDGET_IMP
		redefine
			interface
		end

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

feature -- Implementation

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		deferred
		end

feature {NONE} -- Implementation

	enable_capture is
			-- Grab all the mouse and keyboard events.
		do
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
		end

	has_capture: BOOLEAN is
			-- Does Current have the keyboard and mouse event capture?
		do
		end

feature -- Implementation

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
		ensure then
			is_transport_disabled: not is_transport_enabled
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		do
		end

	is_dockable: BOOLEAN is
			-- Is `Current' dockable?
		deferred
		end

	set_to_drag_and_drop: BOOLEAN is
			-- Set `Current' to drag and drop mode.
		do
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is `Current' able to initiate transport with `a_button'.
		do
		end

	on_mouse_button_event (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Handle mouse button events.
		do
		end

	start_transport (
			a_x, a_y, a_button: INTEGER; a_press: BOOLEAN
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		do
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
			-- Will `Current' display a menu with button `a_button'.
		do
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End a pick and drop transport.
		do
		end

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
		end

	draw_rubber_band is
			-- Draw a segment between initial pick point and `destination'.
		do
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
		end

	pnd_screen: EV_SCREEN is
			-- Screen object used for drawing PND transport line
		once
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		do
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create and initialize `drop_actions' for `Current'
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PICK_AND_DROPABLE;

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_PICK_AND_DROPABLE_IMP

