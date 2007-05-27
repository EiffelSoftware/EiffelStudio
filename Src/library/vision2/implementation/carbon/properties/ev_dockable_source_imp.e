indexing
	description: "Gtk implementation of dockable source."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_IMP

inherit
	EV_DOCKABLE_SOURCE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Status setting

	start_dragable_filter (
				a_type: INTEGER;
				a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER)
			is
				-- Filter out double click events.
			do
			end

	dawaiting_movement: BOOLEAN
	original_screen_x, original_screen_y: INTEGER

	dragable_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
		end

feature {NONE} -- Implementation

	internal_enable_dockable is
			-- Activate drag mechanism.
 		do
			-- Nothing to be done
		end

	internal_disable_dockable is
			-- Deactivate drag mechanism
		do
			-- Nothing to be done
		end

	drag_and_drop_starting_movement: INTEGER is 3

	start_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize the pick/drag and drop mechanism.
		do
		end

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		do
		end

	orig_cursor: EV_POINTER_STYLE

	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		do
		end

	enable_capture is
			--
		deferred
		end

	disable_capture is
			--
		deferred
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE) is
			-- Assign `a_cursor' to `pointer_style'
		deferred
		end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER) is
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		do
			-- For now do nothing until further investigation has taken place.
		end

feature {EV_ANY_I} -- Implementation

	pointer_style: EV_POINTER_STYLE is
			--
		deferred
		end

	interface: EV_DOCKABLE_SOURCE;

indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_DOCKABLE_IMP

