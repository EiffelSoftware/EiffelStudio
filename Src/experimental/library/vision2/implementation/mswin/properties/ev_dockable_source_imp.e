note
	description: "Windows implementation of dockable source."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_IMP

inherit
	EV_DOCKABLE_SOURCE_I

	EV_SHARED_TRANSPORT_IMP

feature -- Status setting

	release_capture
			-- Release a capture on `Current'.
		deferred
		end

	set_capture
			-- Start a capture on `Current'.
		deferred
		end

	wel_has_capture: BOOLEAN
			-- Is a WEL capture currently set on `Current'?
		deferred
		end

	dragable_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER)
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			if a_button = 1 then
				start_docking
					(a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y, attached_interface)
			end
		end

	dragable_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if awaiting_movement then
				if (original_x - a_x).abs > drag_and_drop_starting_movement or
					(original_y - a_y).abs > drag_and_drop_starting_movement
					then real_start_dragging (original_x, original_y, 1,
						original_x_tilt, original_y_tilt, original_pressure,
						a_screen_x + (original_x - a_x), a_screen_y +
						(original_y - a_y))
					awaiting_movement := False
				end
			else
					-- We now check to see if the left mouse button is not down.
					-- Although we should never be in this state, it appears that
					-- lists and trees loose the WM_LBUTTONUP message if you click on an item.
					-- This means that without this special processing, if you click on the item
					-- of a dockable tree, then the docking mechanism will start, and never finish
					-- until you click again. Julian.
				if not application_imp.key_pressed (application_imp.Vk_lbutton) then
					check_dragable_release (a_x, a_y)
				end
				execute_dragging (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
			end
		end

	check_dragable_release (a_x, a_y: INTEGER)
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
			--| Only called when the left button is released after
			--| initial drag and drop execution is started, possibly before
			--| movement thresh hold has been passed.
		do
			if is_dock_executing then
				application_imp.end_awaiting_movement
				end_dragable (a_x, a_y, 1, 0, 0, 0, 0, 0)
				original_x := -1
				original_y := -1
				awaiting_movement := False
			elseif awaiting_movement then
				awaiting_movement := False
			end
		end

feature {EV_ANY_I} -- Implementation

	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Terminate the pick and drop mechanism.
		local
			text_component: detachable EV_TEXT_COMPONENT_IMP
		do
			awaiting_movement := False
				-- As this may be called when cancelling awaiting the movement of
				-- the mouse before really starting the transport, we must
				-- only complete the transport if we are really dragging.
			if is_dock_executing then
				if attached orig_cursor as l_orig_cursor then
						-- Restore the cursor style of `Current' if necessary.
					internal_set_pointer_style (l_orig_cursor)
				else
						-- Restore standard cursor style.
					if text_component /= Void then
						internal_set_pointer_style (Default_pixmaps.Ibeam_cursor)
					else
						internal_set_pointer_style (Default_pixmaps.Standard_cursor)
					end
				end

				if wel_has_capture then
					disable_capture
				end
					-- Return capture type to capture_normal.
					--| normal capture only works on the current windows thread.
				application_imp.set_capture_type ({EV_APPLICATION_IMP}.Capture_normal)

				application_imp.dock_ended
				complete_dock
			end
		end

feature {NONE} -- Implementation

	internal_enable_dockable, internal_disable_dockable
			-- Enable or disable dockable.
			-- This has no implementation on Windows, as we do not need it.
			-- On Gtk, this is necessary, so that the necessary signal
			-- connections may be performed.
		do
		end

	start_docking (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; source: EV_DOCKABLE_SOURCE)
			-- Initialize the docking mechanism.
		local
			source_imp: detachable EV_DOCKABLE_SOURCE_IMP
		do
			if not awaiting_movement then
					-- Store arguments so they can be passed to
					-- real_start_transport.
				original_x := a_x
				original_y := a_y
				original_x_offset := a_x.to_integer_16
				original_y_offset := a_y.to_integer_16
				original_x_tilt := a_x_tilt
				original_y_tilt := a_y_tilt
				original_pressure := a_pressure
				awaiting_movement := True
				application_imp.start_awaiting_movement
				actual_source := source
				source_imp ?= source.implementation
				check
					source_valid: source_imp /= Void
				end
				application_imp.dock_started (source_imp)
			end
		end

	actual_source: detachable EV_DOCKABLE_SOURCE
		-- The actual source which started the transport. We need
		-- this, as the current source may not be

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Actually start the pick/drag and drop mechanism.
		local
			l_actual_source: detachable like actual_source
		do
			if not is_dock_executing then
				--interface.pointer_motion_actions.block
						-- Block `pointer_motion_actions'.
				l_actual_source := actual_source
				check l_actual_source /= Void end
				initialize_transport (a_screen_x, a_screen_y, l_actual_source)

				application_imp.set_capture_type ({EV_APPLICATION_IMP}.Capture_normal)

								--	if widget_imp_at_cursor_position /= Void then
				orig_cursor := pointer_style
				set_pointer_style (drag_cursor)
				if not wel_has_capture then
					internal_enable_capture
				end
			end
		end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER)
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		local
			tool_bar: detachable EV_TOOL_BAR_IMP
			button: detachable EV_TOOL_BAR_ITEM_IMP
			counter: INTEGER
		do
			from
				counter := start_index
			until
				counter > end_index
			loop
				tool_bar ?= a_parent.implementation
				check
					tool_bar_not_void: tool_bar /= Void
				end
				button ?= a_parent.i_th (counter).implementation
				check button /= Void end
				tool_bar.internal_reset_button (button)
				counter := counter + 1
			end
		end

	orig_cursor: detachable EV_POINTER_STYLE
		-- Cursor originally used on `Current'.

	application_imp: EV_APPLICATION_IMP
			-- Access to current EV_APPLICATION.
		deferred
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style'.
		deferred
		end

	pointer_style: detachable EV_POINTER_STYLE
			-- Cursor used on `Current'.
		deferred
		end

	internal_enable_capture
			-- Internal enable capture.
		deferred
		end

	disable_capture
			-- Remove any capture from `Current'.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_SOURCE_IMP











