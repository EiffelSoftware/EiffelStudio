indexing
	description: "Implementation of a pick and drop source."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_PICK_AND_DROPABLE_I

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

	EV_SHARED_TRANSPORT_IMP

	WEL_WINDOWS_ROUTINES

feature {NONE} -- Initialization

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
			Result := Precursor
			interface.init_drop_actions (Result)
		end

feature -- Access

	capture_enabled: BOOLEAN is
			-- Is the mouse currently captured?
			-- See constants Capture_xxxx at the end of the class.
		do
			Result := internal_capture_status.item
		end

	transport_executing: BOOLEAN is
			-- Is a pick and drop or drag and drop currently
			-- being executed?
		do
			Result := is_pnd_in_transport or is_dnd_in_transport
		end

feature -- Status setting

	enable_transport is
            -- Activate pick/drag and drop mechanism.
		do
			check
				release_not_connected: release_action = Ev_pnd_disabled
			end
			press_action := Ev_pnd_start_transport
			is_transport_enabled := True
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			release_action := Ev_pnd_disabled
			press_action := Ev_pnd_disabled
			motion_action := Ev_pnd_disabled
			is_transport_enabled := False
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
				start_transport
					(a_x, a_y, a_button, True, 0, 0, 0.5, a_screen_x, a_screen_y, False)
			when
				Ev_pnd_end_transport
			then
				end_transport
					(a_x, a_y, a_button, 0, 0, 0, a_screen_x, a_screen_y)
			else
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	check_drag_and_drop_release (a_x, a_y: INTEGER) is
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
			--| Only called when the left button is released after
			--| initial drag and drop execution is started, possibly before
			--| movement thresh hold has been passed.
		do
			if mode_is_drag_and_drop then
				application_imp.end_awaiting_movement
				if press_action = Ev_pnd_end_transport then
					end_transport (a_x, a_y, 1, 0, 0, 0, 0, 0)
					-- If Current has drag and drop, but we are waiting for the
					-- mouse movement then we raise the window containing `Current'
					-- to the foreground.
				elseif awaiting_movement then
						top_level_window_imp.move_to_foreground
				end
				original_x := -1
				original_y := -1
				awaiting_movement := False
			end
		end

	pnd_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if awaiting_movement then
				if (original_x - a_x).abs > drag_and_drop_starting_movement or
					(original_y - a_y).abs > drag_and_drop_starting_movement
					then real_start_transport (pebble, original_x, original_y, 1,
						original_x_tilt, original_y_tilt, original_pressure,
						a_screen_x + (original_x - a_x), a_screen_y +
						(original_y - a_y))
					awaiting_movement := False
				end
			else
				inspect
					motion_action
				when
					Ev_pnd_execute
				then
					execute (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
				else
					check
						disabled: motion_action = Ev_pnd_disabled
					end
				end
			end
		end

	escape_pnd is
			-- Escape the pick and drop.
		do
			application_imp.clear_transport_just_ended
				-- If we are executing a pick and drop
			if application_imp.pick_and_drop_source /= Void then
					-- We use default values which cause pick and drop to end.
				application_imp.pick_and_drop_source.end_transport (0, 0, 2, 0, 0, 0,
					0, 0)
			end
		ensure
			not_in_transport: not transport_executing
		end


feature {EV_ANY_I} -- Implementation

	start_transport (a_x, a_y, a_button: INTEGER; a_press: BOOLEAN a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN) is
			-- Initialize the pick/drag and drop mechanism.
		local
			l_configure_agent: PROCEDURE [ANY, TUPLE]
			l_pebble: like pebble
		do
			application_imp.clear_transport_just_ended
			if mode_is_pick_and_drop and a_button /= 3 then
			else
				if pebble_function /= Void then
					call_pebble_function (a_x, a_y, a_screen_x, a_screen_y)
				end
				l_pebble := pebble
				reset_pebble_function
				if not application_imp.drop_actions_executing then
					-- Note that we check there is not a pick and drop source currently executing.
					-- If you drop on to a widget that is also a source and call `process_events' from the
					-- `drop_actions', this causes the transport to start. The above check prevents this
					-- from occurring.
					if (mode_is_target_menu or mode_is_configurable_target_menu) and a_button = 3 then
						if l_pebble /= Void and then mode_is_configurable_target_menu then
							l_configure_agent := agent real_start_transport (l_pebble, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
						end
						application_imp.create_target_menu (a_x, a_y, a_screen_x, a_screen_y, interface, l_pebble, l_configure_agent, a_menu_only)
					elseif l_pebble /= Void and then mode_is_pick_and_drop and a_button = 3 then
							real_start_transport (l_pebble, a_x, a_y, a_button, a_x_tilt,
								a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					elseif l_pebble /= Void and then mode_is_drag_and_drop and a_button = 1 then
						pebble := l_pebble
						if not awaiting_movement then
								-- Store arguments so they can be passed to
								-- real_start_transport.
							original_x := a_x
							original_y := a_y
							original_x_tilt := a_x_tilt
							original_y_tilt := a_y_tilt
							original_pressure := a_pressure
							awaiting_movement := True
							application_imp.start_awaiting_movement
						end
					end
				end
			end
		end

	real_start_transport (a_pebble: like pebble; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		require
			not_already_transporting: not is_pnd_in_transport and
				not is_dnd_in_transport and
				application_imp.pick_and_drop_source = Void
			original_window_void: original_top_level_window_imp = Void
		local
			pt, win_pt: WEL_POINT
			env: EV_ENVIRONMENT
			l_win: WEL_WINDOW
		do
			if
				(mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3) or
				(mode_is_target_menu and a_button = 3)
				-- Check that transport can be started.
				--| Drag and drop is always started with the left button press.
				--| Pick and drop is always started with the right button press.
			then
					-- Set the pebble.
				pebble := a_pebble

					-- We need to store `top_level_window_imp' for use later if `Current'
					-- is unparented during the pick and drop execution.
				original_top_level_window_imp := top_level_window_imp

					-- We now create the screen at the start of every pick.
					-- See `pnd_screen' comment for explanation.

				interface.pointer_motion_actions.block
					-- Block `pointer_motion_actions'.

					-- Update `application_imp' with pick_and_drop info.
				application_imp.transport_started (Current)

				modify_widget_appearance (True)

				create env

					-- Execute pick_actions for the application.
				env.application.pick_actions.call ([pebble])

					-- Execute pick_actions for `Current'.
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
				if mode_is_pick_and_drop then
					is_pnd_in_transport := True
						-- Assign `True' to `is_pnd_in_transport'
				else
					is_dnd_in_transport := True
						-- Assign `True' to `is_dnd_in_transport'
				end
				pointer_x := a_screen_x.to_integer_16
				pointer_y := a_screen_y.to_integer_16
				if pebble_positioning_enabled then
					create pt.make (pick_x, pick_y)
					create win_pt.make (a_screen_x, a_screen_y)
						-- Do we really need `window_at', isn't Current the
						-- window we should use to do the computation?
					l_win := win_pt.window_at
					if l_win /= Void then
						pt.client_to_screen (l_win)
					else
						l_win ?= Current
						check
							l_win_not_void: l_win /= Void
						end
						pt.client_to_screen (l_win)
					end
					application_imp.set_x_y_origin (pt.x, pt.y)
				else
					application_imp.set_x_y_origin (a_screen_x, a_screen_y)
				end
				press_action := Ev_pnd_end_transport
				motion_action := Ev_pnd_execute
					-- Store the previous cursor of `Current'.
				pnd_stored_cursor := cursor_pixmap
				application_imp.set_capture_type ({EV_APPLICATION_IMP}.Capture_heavy)

					-- Assign correct pointer for transport.
				update_pointer_style (pointed_target)

					-- Start the capture (as late as possible because
					-- we can't debug when the capture is enabled)
				internal_enable_capture
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			abstract_pick_and_dropable: EV_ABSTRACT_PICK_AND_DROPABLE
			text_component: EV_TEXT_COMPONENT_IMP
			l_pebble: like pebble
			l_original: like original_top_level_window_imp
		do
			check
				original_top_level_window_imp_not_void: original_top_level_window_imp /= Void
			end
			l_original := original_top_level_window_imp
			modify_widget_appearance (False)
				-- Remove the capture (as soon as possible because we can't
				-- debug when the capture is enabled)
			disable_capture
				-- Return capture type to capture_normal.
				--| normal capture only works on the current windows thread.
			application_imp.set_capture_type ({EV_APPLICATION_IMP}.Capture_normal)

			release_action := Ev_pnd_disabled
			motion_action := Ev_pnd_disabled

				-- Remove the line drawn from source position to Pointer.
			erase_rubber_band

			text_component ?= Current
				-- Restore the cursor.
			if pnd_stored_cursor /= Void then
					-- Restore the cursor style of `Current' if necessary.
				internal_set_pointer_style (pnd_stored_cursor)
			else
					-- Restore standard cursor style.
				if text_component /= Void then
					internal_set_pointer_style (Default_pixmaps.Ibeam_cursor)
				else
					internal_set_pointer_style (Default_pixmaps.Standard_cursor)
				end
			end
				-- We must now stop the context menu from appearing, as a result of this click.
			if text_component /= Void then
				text_component.disable_context_menu
			end

			application_imp.transport_ended
			application_imp.set_transport_just_ended

			create env
			l_pebble := pebble
			if
				(a_button = 3 and is_pnd_in_transport) or
				(a_button = 1 and is_dnd_in_transport)
				-- Check that transport can be ended.
				--| Drag and drop is always ended with the left button release.+
				--| Pick and drop is always ended with the right button press.
				--| Drop actions only need to be called if the transport
				--| has actually ended correctly.
			then
				target := pointed_target
					-- Retrieve `target'.
				if target /= Void then
					if target.drop_actions.accepts_pebble (l_pebble) then
						application_imp.enable_drop_actions_executing
						target.drop_actions.call ([l_pebble])
							-- If there is a target then execute the drop
							-- actions for `target'.

						env.application.drop_actions.call ([l_pebble])
							-- Execute drop_actions for the application.
						application_imp.disable_drop_actions_executing
					else
						call_cancel_actions (l_pebble)
					end
				else
					call_cancel_actions (l_pebble)
				end
			else
				call_cancel_actions (l_pebble)
			end

			abstract_pick_and_dropable ?= target
			check
				abstract_pick_and_dropable_correct: target /= Void implies abstract_pick_and_dropable /= Void
			end
			pick_ended_actions.call ([abstract_pick_and_dropable])
			enable_transport
				-- Return state ready for next drag/pick and drop.

			interface.pointer_motion_actions.resume
				-- Resume `pointer_motion_actions'.

			l_original.allow_movement
			original_top_level_window_imp := Void

				-- Reset internal attributes.
			is_dnd_in_transport := False
			is_pnd_in_transport := False
				-- Assign `Void' to `last_pointed_target'.
			press_action := Ev_pnd_start_transport
			if pebble_function /= Void then
				pebble_function.clear_last_result
				pebble := Void
			end
		ensure then
			original_window_void: original_top_level_window_imp = Void
			press_action_Reset: press_action = Ev_pnd_start_transport
			not_has_capture: internal_capture_status.item = False
		end

	call_cancel_actions (a_pebble: ANY) is
			-- Call `cancel_actions' of application with `a_pebble' as
			-- event data if the cancel actions exist (i.e. used via interface)
		require
			pebble_not_void: a_pebble /= Void
		do
			if application_imp.cancel_actions_internal /= Void then
				application_imp.cancel_actions_internal.call ([a_pebble])
			end
		end


	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			wel_point: WEL_POINT
			current_target: EV_ABSTRACT_PICK_AND_DROPABLE
			widget_imp_at_cursor_position: EV_WIDGET_IMP
			wel_window_at_cursor_position: WEL_WINDOW
			current_target_object_id: INTEGER
			item_list_imp: EV_ITEM_LIST_IMP [EV_ITEM, EV_ITEM_IMP]
			item_imp: EV_ITEM_IMP
			sensitive: EV_SENSITIVE
			combo_box: EV_INTERNAL_COMBO_BOX_IMP
			combo_field: EV_INTERNAL_COMBO_FIELD_IMP
			composite_window: WEL_COMPOSITE_WINDOW
			ptr, null: POINTER
			client_coordinate_point: WEL_POINT
			win: WEL_WINDOW
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window_at_cursor_position := wel_point.window_at
				-- Retrieve WEL_WINDOW at cursor position

			if wel_window_at_cursor_position /= Void then
					-- If the cursor is currently over a WEL_WINDOW

				widget_imp_at_cursor_position ?= wel_window_at_cursor_position
					-- Retrieve the implementation of the Vision2 Widget at
					-- Cursor position and check it is not Void.


					-- We must now perform special processing for widgets that have an HTTRANSPARENT
					-- part. In this situation, the widget returned by "wel_point.window_at' may be the
					-- parent of the widget that is pointed to. For example, if you place a notebook in a box
					-- and point to the are to the right of the tabs, the widget returned is the box. Julian.
				composite_window ?= wel_window_at_cursor_position
				if composite_window /= Void and (widget_imp_at_cursor_position = Void or else widget_imp_at_cursor_position.parent /= Void) then
						-- If we are pointing to a window that has children.
					if widget_imp_at_cursor_position /= Void then
						create client_coordinate_point.make (wel_point.x - widget_imp_at_cursor_position.screen_x,
							wel_point.y - widget_imp_at_cursor_position.screen_y)
					else
						create client_coordinate_point.make (wel_point.x - composite_window.absolute_x, wel_point.y - composite_window.absolute_y)
					end
						-- Convert the coordinates so that they are relative to the parent window.
					ptr := composite_window.child_window_from_point (client_coordinate_point)
						-- Return the child window that is currently pointed to (ignores HTTRANSPARENT).
						-- May be null if we are not over a HTTRANSPARENT area.
					if ptr /= null then
						win := window_of_item (ptr)
							-- Retrieve the window that is actuall pointed to withing `composite_window'.
							-- This may be null if it is not a window that we have created.
						if win /= Void then
							widget_imp_at_cursor_position ?= win
								-- Return the actual pointed wiget for use as the real target.
						end
					end
				end

				if widget_imp_at_cursor_position = Void then
						-- We must now check for an internal combo field, and
						-- use its parent as the widget.
					combo_box ?= wel_window_at_cursor_position
					if combo_box /= Void then
						widget_imp_at_cursor_position := combo_box.parent
					else
						combo_field ?= wel_window_at_cursor_position
						if combo_field /= Void then
							widget_imp_at_cursor_position := combo_field.parent
						end
					end
				end

				if widget_imp_at_cursor_position /= Void then
					current_target := widget_imp_at_cursor_position.interface
						-- Current pick and drop target is the interface of

					current_target_object_id := current_target.object_id
							-- The current_target_object_id is set to the
							-- widget.
							-- If a widget holds items, we now need to check
							-- that the correct target is in fact one of its
							-- children.


					item_list_imp ?= widget_imp_at_cursor_position
					if item_list_imp /= Void then
						item_imp ?= item_list_imp.find_item_at_position (wel_point.x
							- item_list_imp.screen_x, wel_point.y - item_list_imp.screen_y)
						if item_imp /= Void then
						if not item_imp.interface.drop_actions.is_empty then
								-- If the cursor is over an item and the item is a
								-- pick and drop target then we set the target id to that of the
								-- item, as the items are conceptually 'above' the list and so
								-- if a list and one of its items are pnd targets then the
								-- item should recieve.
							sensitive ?= item_imp.interface
								-- If an item is not `sensitive' then it cannot be dropped on.
							if sensitive = Void or (sensitive /= Void and then sensitive.is_sensitive) then
								Current_target_object_id := item_imp.interface.object_id
							end
						end
						end
					end
				end

				if current_target_object_id /= 0 and then global_pnd_targets.has (current_target_object_id) then
					Result ?= interface.id_object (current_target_object_id)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	is_pnd_in_transport: BOOLEAN
		-- Is `Current' executing pick and drop?

	is_dnd_in_transport: BOOLEAN
		-- Is `Current' executing drag and drop?

	press_action: NATURAL_8
		-- State which is used to decide action on pick/drag and drop press.

	release_action: NATURAL_8
		-- State which is used to describe action on pick/drag and drop release.

	motion_action: NATURAL_8
		-- State which is used to describe action on pick/drab and drop
		-- pointer motion.

	Ev_pnd_disabled: NATURAL_8 is 0
	Ev_pnd_start_transport: NATURAL_8 is 1
	Ev_pnd_end_transport: NATURAL_8 is 2
	Ev_pnd_execute: NATURAL_8 is 3
		-- Allowable states for use with `press_action', release_action' and
		-- `motion_action'.

	pnd_stored_cursor: EV_POINTER_STYLE
			-- Cursor used on the widget before PND started.

	set_pointer_style (new_cursor: EV_POINTER_STYLE) is
			-- Assign `new_cursor' to cursor used on `Current'.
			-- Can be called through `interface'.
		do
				-- PND overrides the cursor of `Current' so
				-- if we are currently executing PND then we must store
				-- `new_cursor' in `pnd_stored_cursor' which holds the cursor
				-- that is restored when the PND ends.
			if not transport_executing then
				internal_set_pointer_style (new_cursor)
			end
			pnd_stored_cursor := new_cursor
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- Cursor of `Current'.
		deferred
		end

	draw_rubber_band  is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			application_imp.draw_rubber_band
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		do
			application_imp.erase_rubber_band
		end

	enable_capture is
			-- Enable capture.
			--| Accessible through the interface of widget.
		do
			internal_enable_capture
		end

	internal_enable_capture is
			-- Grab all user events.
			--| Not accessible through the interface of widget.
		local
			l_arguments: ARGUMENTS
			l_path: STRING
		do
			inspect application_imp.capture_type
			when {EV_APPLICATION_IMP}.Capture_heavy then
				set_heavy_capture
				if not has_heavy_capture then
						-- If wel_hook.dll is not available the we fallback to an application wide capture.
						-- We need to print out an error message
					create l_arguments
					l_path := l_arguments.argument (0);
					l_path.keep_head (l_arguments.argument (0).count - l_arguments.argument (0).split ('\').last.count);
					io.error.put_string ("'wel_hook.dll' is not present, please copy it over from '%%ISE_EIFFEL%%\studio\spec\%%ISE_PLATFORM%%\bin' to '" + l_path + "'.%N")
					set_capture
				end
			when {EV_APPLICATION_IMP}.Capture_normal then
				set_capture
			end
		end

	disable_capture is
			-- Release all user events.
		do
			inspect application_imp.capture_type
			when {EV_APPLICATION_IMP}.Capture_heavy then
				if has_heavy_capture then
					release_heavy_capture
				else
					release_capture
				end
			when {EV_APPLICATION_IMP}.Capture_normal then
				release_capture
			end
		end

	top_level_window_imp: EV_WINDOW_IMP is
			-- Top level window that contains `Current'.
		deferred
		end

	original_top_level_window_imp: EV_WINDOW_IMP
			-- Top level window of `Current' at start of transport.
			-- We need this, as `Current' may be removed from its parent
			-- during the transport, therefore making it impossible for us
			-- to call `top_level_window_imp' after this has occurred as it
			-- recursively checks the parents of `Currents'.

	set_heavy_capture is
		deferred
		end

	has_heavy_capture: BOOLEAN is
		deferred
		end

	release_heavy_capture is
		deferred
		end

	set_capture is
		deferred
		end

	release_capture is
		deferred
		end

	internal_capture_status: CELL [BOOLEAN] is
			-- System wide once, in order to always get the
			-- same value.
			-- True if there is the mouse is currently captured.
		once
			create Result.put (False)
		ensure
			internal_capture_status_not_void: Result /= Void
		end

feature {EV_ANY_I, WEL_WINDOW} -- Implementation

	application_imp: EV_APPLICATION_IMP is
			-- `Result' is implementation of application from environment.
		once
			Result ?= environment.application.implementation
		ensure
			Result_not_void: Result /= Void
		end

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

end -- class EV_PICK_AND_DROPABLE_IMP

