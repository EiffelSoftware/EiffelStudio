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
			destroy,
			needs_event_box
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

	dragable_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
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
			enable_capture
			App_implementation.docking_source := Current
			initialize_transport (a_screen_x, a_screen_y, interface)
		end

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		do
			set_pointer_style (Drag_cursor)
		end

	orig_cursor: EV_POINTER_STYLE

	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		do
			awaiting_movement := False
			if is_dock_executing then
				disable_capture
				App_implementation.docking_source := Void
				if orig_cursor /= Void then
						-- Restore the cursor style of `Current' if necessary.
					set_pointer_style (orig_cursor)
					orig_cursor := Void
				end
				complete_dock
				original_x_offset := -1
				original_y_offset := -1
				original_screen_x := -1
				original_screen_y := -1
			end
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_IMP

