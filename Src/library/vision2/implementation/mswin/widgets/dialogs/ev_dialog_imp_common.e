indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DIALOG_IMP_COMMON

inherit
	EV_DIALOG_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update
		redefine
			interface,
			set_current_push_button
		end

	EV_TITLED_WINDOW_IMP
		undefine
			class_name,
			on_wm_control_id_command
		redefine
			interface, process_message,
			wel_move_and_resize,
			wel_destroy_window,
			on_wm_destroy, on_wm_command,
			forbid_resize, allow_resize
		select
			x_position,
			y_position,
			set_x_position,
			set_y_position,
			wel_destroy
		end

	WEL_DIALOG
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			set_width as wel_set_width,
			set_height as wel_set_height,
			item as wel_item,
			enabled as is_sensitive,
			set_x as wel_set_x,
			set_y as wel_set_y,
			width as wel_width,
			height as wel_height,
			maximize as wel_maximize,
			minimize as wel_minimize,
			x as wel_x,
			y as wel_y,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			has_capture as wel_has_capture,
			cwin_dialog_box_indirect as wel_cwin_dialog_box_indirect
		undefine
			has_focus, on_middle_button_up, show, on_right_button_down, 
			on_move, on_size, default_ex_style, on_sys_key_down, on_key_up,
			window_process_message, on_middle_button_down, on_kill_focus,
			on_right_button_up, on_accelerator_command, on_menu_command,
			on_middle_button_double_click, on_destroy, on_left_button_up,
			on_wm_hscroll, on_notify, on_desactivate, on_wm_vscroll, 
			default_style, on_color_control, on_wm_close, on_key_down, 
			on_draw_item, on_set_focus, background_brush, on_set_cursor, 
			default_process_message, on_right_button_double_click, hide,
			on_wm_menu_command, on_mouse_move, on_wm_window_pos_changing, 
			on_show, on_char, on_left_button_down,
			on_get_min_max_info, on_left_button_double_click, destroy,
			on_sys_key_up, on_wm_command, on_activate
		redefine
			setup_dialog,
			process_message,
			wel_move_and_resize,
			on_wm_destroy,
			register_current_window
		end
			
	WEL_ID_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_BN_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_with_dialog_window (a_other_imp: EV_DIALOG_IMP) is
			-- Create `Current' using attributes of `other_imp'.
		require
			other_imp_not_void: a_other_imp /= Void
		do
				-- Assign id of `a_other_imp' to `id'.
			id := a_other_imp.id
			other_imp := a_other_imp
			base_make (other_imp.interface)
			copy_attributes
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is `Current' closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4).

feature -- Status Setting

	enable_closeable is
			-- Set `Current' to be closeable by the user.
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4).
		do
			is_closeable := True
		end

	disable_closeable is
			-- Set `Current'to be non closeable by the user
		do
			is_closeable := False
		end

	forbid_resize is
			-- Forbid the resize of `Current'.
		do
			update_style_and_minimum_size
		end

	allow_resize is
			-- Allow the resize of `Current'.
		do
			update_style_and_minimum_size
		end

feature {EV_CONTAINER_IMP} -- Implementation

	modify_tab_order (widget: EV_WIDGET_IMP) is
			--
		local
			first, second: WEL_WINDOW
			container: EV_CONTAINER_IMP
			a_counter : INTEGER
			ordered_widgets: ARRAYED_LIST [WEL_WINDOW]
			widget_depths: ARRAYED_LIST [INTEGER]
			maximum_depth: INTEGER
		do
			container ?= widget
				-- Create the lists.
			create ordered_widgets.make (20)
			create widget_depths.make (20)
				--| Note that if the child of `Current' is not a container, there is no need to 
				--| adjust the tab order, as it will be the only child, and therefore the tab ordering
				--| will not be a problem.
			if container /= Void then
				container.adjust_tab_ordering (ordered_widgets, widget_depths, 1)
			end	
			check
				lists_equal_in_length: ordered_widgets.count = widget_depths.count
			end
				
				-- If we did reverse the tab orders then.
			if ordered_widgets.count > 0 then
					-- We now find the maximum_depth of the children of `Current'.
				from
					widget_depths.start
				until
					widget_depths.off
				loop
					if widget_depths.item > maximum_depth then
						maximum_depth := widget_depths.item
					end
					widget_depths.forth
				end
					-- For every depth of window in `Current'.
				from
					a_counter := 1
				until
					a_counter = maximum_depth + 1
				loop
					from
						widget_depths.start
						ordered_widgets.start
					until
						widget_depths.off
					loop
							-- If this window is of the correct depth
							-- Then we will re-order it as necessary.
						if widget_depths.item = a_counter then
							first := second
							second := ordered_widgets.item
							if first /= Void and second /= Void then
								second.insert_after (first)
							end
						end
						widget_depths.forth
						ordered_widgets.forth
					end	
					a_counter := a_counter + 1
				end
			end
		end

feature {EV_DIALOG_I} -- Implementation

	apply_center_dialog: BOOLEAN
			-- Should `center_dialog' be called?

	interface: EV_DIALOG
			-- Interface for `Current'.

	parent_window: EV_WINDOW
			-- Parent window if any, Void otherwise.

	other_imp: EV_DIALOG_IMP
			-- Previous Implementation if any, Void otherwise.

	destroy_implementation is
			-- Destroy `Current' but does not wipe out the children.
		local
			app_i: EV_APPLICATION_I
			app_imp: EV_APPLICATION_IMP
		do
			app_i := (create {EV_ENVIRONMENT}).application.implementation
			app_imp ?= app_i
			check
				implementation_not_void: app_imp /= void
			end
			app_imp.remove_root_window (Current)

			wel_destroy_window
			is_destroyed := True
		end

feature {NONE} -- Implementation

	update_style_and_minimum_size is
			-- Update the style and the minimum size after changing
			-- the `user_can_resize' flag.
		do
			update_style
			compute_minimum_size
			if is_displayed then
				hide
				show
			end
		end
		
	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		deferred
		end

	dlg_template: WEL_DLG_TEMPLATE is
			-- Empty dialog template
		once
			create Result.make_with_global_alloc
			Result.set_style (default_style)
		end

	promote_to_dialog_window is
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODAL which allows modality
		local
			dialog_window_imp: EV_DIALOG_IMP
		do
			create dialog_window_imp.make_with_real_dialog (Current)
			interface.replace_implementation (dialog_window_imp)
		end

	copy_attributes is
			-- Copy attributes from `other_imp' to `Current'
		require
			other_window_not_void: other_imp /= Void
		do
			accel_list := other_imp.accel_list
			accelerators := other_imp.accelerators
			accelerators_internal := other_imp.accelerators_internal
			accept_cursor := other_imp.accept_cursor
			actual_drop_target_agent := other_imp.actual_drop_target_agent
			awaiting_movement := other_imp.awaiting_movement
			background_color_imp := other_imp.background_color_imp
			background_pixmap_imp := other_imp.background_pixmap_imp
			base_make_called := other_imp.base_make_called
			child_cell := other_imp.child_cell
			close_request_actions_internal := other_imp.close_request_actions_internal
			commands := other_imp.commands
			conforming_pick_actions_internal := other_imp.conforming_pick_actions_internal
			cursor_pixmap := other_imp.cursor_pixmap
			deny_cursor := other_imp.deny_cursor
			drop_actions_internal := other_imp.drop_actions_internal
			focus_in_actions_internal := other_imp.focus_in_actions_internal
			focus_out_actions_internal := other_imp.focus_out_actions_internal
			foreground_color_imp := other_imp.foreground_color_imp
			has_heavy_capture := other_imp.has_heavy_capture
			help_enabled := other_imp.help_enabled
			id := other_imp.id
			internal_default_push_button := other_imp.internal_default_push_button
			internal_default_cancel_button := other_imp.internal_default_cancel_button
			internal_height := other_imp.internal_height
			internal_help_context := other_imp.internal_help_context
			internal_icon_name := other_imp.internal_icon_name
			internal_non_sensitive := other_imp.internal_non_sensitive
			internal_pebble_positioning_enabled := other_imp.internal_pebble_positioning_enabled
			internal_pick_x := other_imp.internal_pick_x
			internal_pick_y := other_imp.internal_pick_y
			internal_title := other_imp.internal_title
			internal_width := other_imp.internal_width
			is_closeable := other_imp.is_closeable
			is_destroyed := other_imp.is_destroyed
			is_dnd_in_transport := other_imp.is_dnd_in_transport
			is_in_min_height := other_imp.is_in_min_height
			is_in_min_width := other_imp.is_in_min_width
			is_minheight_recomputation_needed := other_imp.is_minheight_recomputation_needed
			is_minwidth_recomputation_needed := other_imp.is_minwidth_recomputation_needed
			is_modal := other_imp.is_modal
			is_notify_originator := other_imp.is_notify_originator
			is_pnd_in_transport := other_imp.is_pnd_in_transport
			is_transport_enabled := other_imp.is_transport_enabled
			item := other_imp.item
			key_press_actions_internal := other_imp.key_press_actions_internal
			key_press_string_actions_internal := other_imp.key_press_string_actions_internal
			key_release_actions_internal := other_imp.key_release_actions_internal
			last_pointed_target := other_imp.last_pointed_target
			lower_bar := other_imp.lower_bar
			maximum_height := other_imp.maximum_height
			maximum_width := other_imp.maximum_width
			move_actions_internal := other_imp.move_actions_internal
			new_item_actions_internal := other_imp.new_item_actions_internal
			pebble := other_imp.pebble
			pebble_function := other_imp.pebble_function
			pick_actions_internal := other_imp.pick_actions_internal
			pick_x := other_imp.pick_x
			pick_y := other_imp.pick_y
			pnd_stored_cursor := other_imp.pnd_stored_cursor
			pointer_button_press_actions_internal := other_imp.pointer_button_press_actions_internal
			pointer_button_release_actions_internal := other_imp.pointer_button_release_actions_internal
			pointer_double_press_actions_internal := other_imp.pointer_double_press_actions_internal
			pointer_enter_actions_internal := other_imp.pointer_enter_actions_internal
			pointer_leave_actions_internal := other_imp.pointer_leave_actions_internal
			pointer_motion_actions_internal := other_imp.pointer_motion_actions_internal
			pointer_x := other_imp.pointer_x
			pointer_y := other_imp.pointer_y
			press_action := other_imp.press_action
			show_actions_internal := other_imp.show_actions_internal
			radio_group := other_imp.radio_group
			release_action := other_imp.release_action
			remove_item_actions := other_imp.remove_item_actions
			resize_actions_internal := other_imp.resize_actions_internal
			rubber_band_is_drawn := other_imp.rubber_band_is_drawn
			scroller := other_imp.scroller
			shared := other_imp.shared
			upper_bar := other_imp.upper_bar
			user_can_resize := other_imp.user_can_resize
			user_interface_mode := other_imp.user_interface_mode
			apply_center_dialog := other_imp.apply_center_dialog
			call_show_actions := other_imp.call_show_actions
		end

	setup_dialog is
			-- May be redefined to setup the dialog and its
			-- children.
		local
			button_imp: EV_BUTTON_IMP
			app_imp: EV_APPLICATION_IMP
		do
				-- Copy the attributes from the window to the dialog
			copy_attributes
			set_text (internal_title)

				-- Move the children from the hidden window to the dialog.
			move_children

				-- Change the style of the window and the window icon.
			update_style
			set_icon_pixmap (other_imp.icon_pixmap)

				-- Center the dialog relative to the parent window.
			check
					-- Parent_window should not be void due to the precondition
					-- of `make_with_dialog_window_and_parent'.
				parent_window /= Void
			end
			if apply_center_dialog then
				center_dialog
				apply_center_dialog := false
			else
				set_position (other_imp.x_position, other_imp.y_position)
			end

				-- Set the focus to the `default_push_button' if any
			if default_push_button /= Void and then 
				default_push_button.is_show_requested and then
				default_push_button.is_sensitive
			then
				button_imp ?= interface.default_push_button.implementation
				button_imp.enable_default_push_button
				button_imp.set_focus
			end

				-- Destroy the Dialog-window implementation
			other_imp.destroy_implementation

				-- Add this dialog as root window.
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			app_imp.add_root_window (Current)
		end
	
	move_children is
			-- Move the children to the dialog or the window, depending
			-- on which is currently selected in `wel_item'.
		local
			loc_item_imp: EV_WIDGET_IMP
		do
			--| FIXME handle EV_SPLIT_AREA_IMP and EV_TABLE_IMP
			loc_item_imp ?= other_imp.item_imp
			if loc_item_imp /= Void then
				loc_item_imp.set_top_level_window_imp (Current)
				loc_item_imp.wel_set_parent (Current)
				modify_tab_order (loc_item_imp)
			end
		end

	wel_destroy_window is
			-- Destroy the window-widget
		do
				-- Destroy the dialog and unregister it
			terminate (Idcancel)
		end

	update_style is
			-- Update the style of the window accordingly to the
			-- options set (`user_can_resize', `is_closeable', ...)
			-- and set the pixmap.
		require
			other_imp_not_void: other_imp /= Void
		local
			new_style: INTEGER
			bit_op: WEL_BIT_OPERATIONS
		do
				-- Change the style of the window.
			create bit_op
			new_style := style
			if user_can_resize then
				new_style := bit_op.set_flag (new_style, Ws_thickframe)
			else
				new_style := bit_op.clear_flag (new_style, Ws_thickframe)
			end
			if is_closeable then
				new_style := bit_op.set_flag (new_style, Ws_sysmenu)
			else
				new_style := bit_op.clear_flag (new_style, Ws_sysmenu)
			end
			new_style := bit_op.clear_flag (new_style, Ws_minimizebox)
			new_style := bit_op.clear_flag (new_style, Ws_maximizebox)
			set_style (new_style)
		end

	center_dialog is
				-- Center the dialog relative to the parent window.
		require
			parent_not_void: parent_window /= Void
		local
			x_pos, y_pos: INTEGER
			a_screen: EV_SCREEN
			rescued: INTEGER
		do
			if rescued = 0 then
				x_pos := parent_window.x_position + (parent_window.width - width) // 2
				y_pos := parent_window.y_position + (parent_window.height - height) // 2
			end
			if (x_pos < 0 or y_pos < 0) or (rescued = 1) then
				create a_screen
				x_pos := (a_screen.width - width) // 2
				y_pos := (a_screen.height - height) // 2
			end
			if (rescued < 2) then
				set_position (x_pos, y_pos)
			end
		rescue
			rescued := rescued + 1
			retry
		end
		
	on_wm_command (wparam, lparam: INTEGER) is
			-- Wm_command message.
		local
			text_field_imp: EV_TEXT_FIELD_IMP
		do
				-- Escape has been pressed in `Current', so we 
				-- call the `select_actions' of the default_cancel_button.
				-- See "Dialog Box Keyboard Interface" in MSDN.
			if wparam = idcancel and lparam = 0 then
				if focus_on_widget.item /= Void then
					focus_on_widget.item.process_standard_key_press (Vk_escape)	
				end
			
				-- Enter has been pressed in `Current', so we 
				-- call the `select_actions' of the default_push_button.
				-- See "Dialog Box Keyboard Interface" in MSDN.
			elseif wparam = bn_clicked or (wparam = idok and lparam = 0) then
				if focus_on_widget.item /= Void then
						-- We must now call the `return_actions' on the text_field.
					text_field_imp ?= focus_on_widget.item
					if text_field_imp /= Void then
						text_field_imp.return_actions.call ([])
					end
					
					focus_on_widget.item.process_standard_key_press (Vk_return)
				end
			else
				Precursor {EV_TITLED_WINDOW_IMP} (wparam, lparam)
			end
		end
		
	process_message (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: INTEGER): INTEGER is
			-- Process all message plus `WM_INITDIALOG'.
		do
			if msg = Wm_initdialog then
				setup_dialog
			else
				Result := Precursor {EV_TITLED_WINDOW_IMP} (hwnd, msg, wparam, lparam)
			end
		end
		
	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			move_absolute (a_x, a_y)
			wel_resize (a_width, a_height)
			if repaint then
					-- We don't want the background to be erased (it's done by
					-- the dialog box)
				cwin_invalidate_rect (wel_item, default_pointer, False)
				cwin_update_window (wel_item)
			end
		end

	on_wm_destroy is
			-- Wm_destroy message.
			--| Redefined in order not to post a WM_QUIT message.
		do
			on_destroy
			destroy_item
		end

feature {EV_WIDGET_I} -- Implementation

	set_current_push_button (a_button: EV_BUTTON) is
			-- Set the push button to be `a_button'. `a_button' can
			-- be Void if there are no more current push button
		local
			widget_imp: EV_WIDGET_IMP
		do
			Precursor {EV_DIALOG_I} (a_button)
			if item /= Void then
				widget_imp ?= item.implementation
				widget_imp.redraw_current_push_button (a_button)
			end
		end
		
end -- class EV_DIALOG_IMP_COMMON

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
