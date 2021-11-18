note
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

feature -- Status setting

	start_dragable_filter (
				a_type: INTEGER;
				a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER)

				-- Filter out duplicate events.
			do
				if not awaiting_movement then
					orig_cursor := pointer_style
					original_x_offset := a_x.to_integer_16
					original_y_offset := a_y.to_integer_16
					original_screen_x := a_screen_x.to_integer_16
					original_screen_y := a_screen_y.to_integer_16
					awaiting_movement := True
				end
			end

	awaiting_movement: BOOLEAN
	original_screen_x, original_screen_y: INTEGER_16

	dragable_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if awaiting_movement then
				if (original_screen_x - a_screen_x).abs > drag_and_drop_starting_movement or
					(original_screen_y - a_screen_y).abs > drag_and_drop_starting_movement
					then
						awaiting_movement := False
						start_dragable (
								a_x,
								a_y,
								1,
								a_x_tilt,
								a_y_tilt,
								a_pressure,
								a_screen_x,
								a_screen_y
							)
						real_start_dragging (original_x_offset, original_y_offset, 1,
							0.0, 0.0, 0.0,
							a_screen_x + (original_x_offset - a_x), a_screen_y +
							(original_y_offset - a_y))

				end
			else
				execute_dragging (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
			end
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Implementation

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
			enable_capture
			App_implementation.docking_source := Current
			initialize_transport (a_screen_x, a_screen_y, attached_interface)
		end

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Actually start the pick/drag and drop mechanism.
		do
			set_pointer_style (Drag_cursor)
		end

	orig_cursor: detachable EV_POINTER_STYLE

	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Terminate the pick and drop mechanism.
		do
			if is_dock_executing then
				if attached orig_cursor as l_orig_cursor then
						-- Restore the cursor style of `Current' if necessary.
					internal_set_pointer_style (l_orig_cursor)
				else
					internal_set_pointer_style (default_pixmaps.standard_cursor)
				end
				disable_capture
				App_implementation.docking_source := Void
				complete_dock
			end
			reset_drag_data
		end

	reset_drag_data
			-- Reset initial drag data.
		do
			awaiting_movement := False
			original_x_offset := -1
			original_y_offset := -1
			original_screen_x := -1
			original_screen_y := -1
			orig_cursor := Void
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

	internal_set_pointer_style (a_cursor: detachable EV_POINTER_STYLE)
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

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

	pointer_style: detachable EV_POINTER_STYLE
			--
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DOCKABLE_SOURCE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_IMP











