note
	description: "Cocoa implementation of dockable source."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_IMP

inherit
	EV_DOCKABLE_SOURCE_I

feature -- Status setting

	start_dragable_filter (
				a_type: INTEGER;
				a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER)

				-- Filter out double click events.
			do
			end

	dawaiting_movement: BOOLEAN
	original_screen_x, original_screen_y: INTEGER

	dragable_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
		end

feature {NONE} -- Implementation

	internal_enable_dockable
			-- Activate drag mechanism.
 		do
			-- Nothing to be done
		end

	internal_disable_dockable
			-- Deactivate drag mechanism
		do
			-- Nothing to be done
		end

	drag_and_drop_starting_movement: INTEGER = 3

	start_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Initialize the pick/drag and drop mechanism.
		do
		end

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Actually start the pick/drag and drop mechanism.
		do
		end

	orig_cursor: EV_POINTER_STYLE
		do
			create Result
		end

	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Terminate the pick and drop mechanism.
		do
		end

	enable_capture
			--
		deferred
		end

	disable_capture
			--
		deferred
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style'
		deferred
		end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER)
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		do
			-- For now do nothing until further investigation has taken place.
		end

feature {EV_ANY_I} -- Implementation

	pointer_style: EV_POINTER_STYLE
			--
		deferred
		end

end -- class EV_DOCKABLE_IMP

