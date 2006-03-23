indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			interface
		end

	EV_TITLED_WINDOW_IMP
		undefine
			class_name,
			on_wm_control_id_command,
			on_wm_nc_destroy
		redefine
			interface, process_message,
			wel_move_and_resize,
			wel_destroy_window,
			on_wm_command,
			forbid_resize, allow_resize,
			window_on_wm_activate
		select
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
			on_mouse_wheel,
			on_draw_item, on_set_focus, background_brush, on_set_cursor,
			default_process_message, on_right_button_double_click, hide,
			on_wm_menu_command, on_mouse_move, on_wm_window_pos_changing,
			on_show, on_char, on_left_button_down,
			on_get_min_max_info, on_left_button_double_click, destroy,
			on_sys_key_up, on_wm_command, on_activate, on_wm_setting_change,
			is_displayed
		redefine
			setup_dialog,
			process_message,
			wel_move_and_resize
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

	make_with_dialog_window (a_other_imp: like other_imp) is
			-- Create `Current' using attributes of `other_imp'.
		require
			other_imp_not_void: a_other_imp /= Void
		do
			create post_creation_update_actions
				-- Assign id of `a_other_imp' to `id'.
			id := a_other_imp.id
			other_imp := a_other_imp
			base_make (other_imp.interface)
			copy_attributes
				-- Now remove the menu from `a_other_imp'.
				-- If we do not do this, then we are unable
				-- to set the menu in `Current'.
			a_other_imp.interface.remove_menu_bar
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is `Current' closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4).

	is_modal: BOOLEAN is
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?
		do
			Result := False
		end

	is_relative: BOOLEAN is
			-- Is `Current' shown relative to another window?
		do
			Result := False
		end

	blocking_window: EV_WINDOW is
			-- `Result' is window `Current' is shown to if
			-- `is_modal' or `is_relative'.
		do
			if is_show_requested then
				Result := parent_window
			end
		end

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

feature {EV_DIALOG_I} -- Implementation

	apply_center_dialog: BOOLEAN
			-- Should `center_dialog' be called?

	parent_window: EV_WINDOW
			-- Parent window if any, Void otherwise.

	other_imp: EV_DIALOG_IMP
			-- Previous Implementation if any, Void otherwise.

	destroy_implementation is
			-- Destroy `Current' but does not wipe out the children.
		do
			application_imp.remove_root_window (Current)

			wel_destroy_window
			set_is_destroyed (True)
		end

feature {NONE} -- Implementation

	update_style_and_minimum_size is
			-- Update the style and the minimum size after changing
			-- the `user_can_resize' flag.
		do
			update_style
			notify_change (2 + 1, Current)
			if is_displayed then
				invalidate
			end
		end

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER; a_name: STRING_GENERAL) is
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
			set_base_make_called (other_imp.base_make_called)
			child_cell := other_imp.child_cell
			close_request_actions_internal := other_imp.close_request_actions_internal
			commands := other_imp.commands
			conforming_pick_actions_internal := other_imp.conforming_pick_actions_internal
			cursor_pixmap := other_imp.cursor_pixmap
			set_icon_pixmap (other_imp.icon_pixmap)
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
			set_is_destroyed (other_imp.is_destroyed)
			is_dnd_in_transport := other_imp.is_dnd_in_transport
			is_in_min_height := other_imp.is_in_min_height
			is_in_min_width := other_imp.is_in_min_width
			is_minheight_recomputation_needed := other_imp.is_minheight_recomputation_needed
			is_minwidth_recomputation_needed := other_imp.is_minwidth_recomputation_needed
			is_notify_originator := other_imp.is_notify_originator
			is_pnd_in_transport := other_imp.is_pnd_in_transport
			is_transport_enabled := other_imp.is_transport_enabled
			item := other_imp.item
			key_press_actions_internal := other_imp.key_press_actions_internal
			key_press_string_actions_internal := other_imp.key_press_string_actions_internal
			key_release_actions_internal := other_imp.key_release_actions_internal
			last_pointed_target := other_imp.last_pointed_target
			maximum_height := other_imp.maximum_height
			maximum_width := other_imp.maximum_width
			menu_bar := other_imp.menu_bar
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
			user_can_resize := other_imp.user_can_resize
			user_interface_mode := other_imp.user_interface_mode
			apply_center_dialog := other_imp.apply_center_dialog
			call_show_actions := other_imp.call_show_actions
			fixme (once "[
				The `post_creation_update_actions are only here to enable the use of upper and lower bars
				in the implementation of dialogs. Without this, upgrading the dialog's implementation
				whith items in the bars caused problems internally.
				]")
			if post_creation_update_actions.is_empty then
				create upper_bar
				post_creation_update_actions.extend (agent copy_box_attributes (other_imp.upper_bar, upper_bar))
				create lower_bar
				post_creation_update_actions.extend (agent copy_box_attributes (other_imp.lower_bar, lower_bar))
			end
		end

	post_creation_update_actions: ACTION_SEQUENCE [TUPLE []]
		-- Action sequence to be fired after dialog is created and during initialization from
		-- within `setup_dialog'. When we create a dialog, Windows calls us back with the
		-- handle to the new dialog and upon receiving this, we call `setup_dialog'.
		-- This action sequence is wiped out each time it is called so its contents should
		-- only be used to defer execution until the dialog is created and be rebuilt each time
		-- as required.

	setup_dialog is
			-- May be redefined to setup the dialog and its
			-- children.
		local
			button_imp: EV_BUTTON_IMP
		do
				-- Copy the attributes from the window to the dialog
			copy_attributes
			post_creation_update_actions.call (Void)
			post_creation_update_actions.wipe_out
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
				apply_center_dialog := False
			else
				set_position (other_imp.x_position, other_imp.y_position)
			end

				-- Set the focus to the `default_push_button' if any
			if default_push_button /= Void and then
				default_push_button.is_show_requested and then
				default_push_button.is_sensitive
			then
				button_imp ?= interface.default_push_button.implementation
				set_default_push_button (button_imp.interface)
				button_imp.set_focus
			end

				-- Destroy the Dialog-window implementation
			other_imp.destroy_implementation

				-- Add this dialog as root window.
			application_imp.add_root_window (Current)
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
			l_screen: EV_SCREEN
		do
			if parent_window /= Void and then parent_window.is_displayed then
				x_pos := parent_window.x_position + (parent_window.width - width) // 2
				y_pos := parent_window.y_position + (parent_window.height - height) // 2
			else
				create l_screen
				x_pos := (l_screen.width - width) // 2
				y_pos := (l_screen.height - height) // 2
			end
			set_position (x_pos, y_pos)
		end

	on_wm_command (wparam, lparam: POINTER) is
			-- Wm_command message.
		local
			text_field_imp: EV_TEXT_FIELD_IMP
			original_top_window: EV_WINDOW_IMP
		do
				-- Escape has been pressed in `Current', so we
				-- call the `select_actions' of the default_cancel_button.
				-- See "Dialog Box Keyboard Interface" in MSDN.
			if cwin_lo_word (wparam) = idcancel and lparam = default_pointer then
				if focus_on_widget.item /= Void then
					focus_on_widget.item.process_standard_key_press (Vk_escape)
				end

				-- Enter has been pressed in `Current', so we
				-- call the `select_actions' of the default_push_button.
				-- See "Dialog Box Keyboard Interface" in MSDN.
			elseif
				cwin_hi_word (wparam) = bn_clicked or
				(cwin_lo_word (wparam) = idok and lparam = default_pointer)
			then
				if focus_on_widget.item /= Void then
					original_top_window := Focus_on_widget.item.top_level_window_imp
						-- We must now call the `return_actions' on the text_field.
					text_field_imp ?= focus_on_widget.item
					if text_field_imp /= Void then
						text_field_imp.return_actions.call (Void)
					end
						-- If something in the text field return actions has caused the
						-- dialog to close, we do not process the standard key press.
						-- If you display a dialog modally to another dialog, and destroy
						-- the top dialog from the return actions of a text field, the default
						-- push button of the lower dialog would be fired.
					if focus_on_widget.item.top_level_window_imp = original_top_window then
						focus_on_widget.item.process_standard_key_press (Vk_return)
					end
				end
			else
				Precursor {EV_TITLED_WINDOW_IMP} (wparam, lparam)
			end
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- Process all message plus `WM_INITDIALOG'.
		do
			if msg = Wm_initdialog then
				setup_dialog
			elseif msg = wm_ctlcolordialog then
				on_wm_ctlcolordialog (wparam, lparam)
			else
				Result := Precursor {EV_TITLED_WINDOW_IMP} (hwnd, msg, wparam, lparam)
			end
		end

	on_wm_ctlcolordialog (wparam, lparam: POINTER) is
			-- Wm_ctlcolordialog message received.
		local
			paint_dc: WEL_PAINT_DC
		do
			create paint_dc.make_by_pointer (Current, wparam)
			paint_dc.set_background_color (wel_background_color)
			paint_dc.set_text_color (wel_foreground_color)
			set_message_return_value (background_brush.item)
			--| FIXME Julian should we really delete this brush here?
			--| doesn't seem to make much difference to GDI count, is it necessary?
			--| If it is determined that it is required, uncomment.
			---background_brush.delete
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

	on_wm_ncdestroy is
			-- Wm_nc_destroy message.
			--| Redefined in order not to post a WM_QUIT message.
		do
			on_destroy
		end

	window_on_wm_activate (wparam, lparam: POINTER) is
			-- `Wm_activate' message recieved form Windows by `Current'.
		do
			Precursor {EV_TITLED_WINDOW_IMP} (wparam, lparam)
			if cwin_lo_word (wparam) = Wel_window_constants.Wa_inactive then
					-- The Wm_killfocus message is sent correctly when a
					-- dialog is empty but not otherwise. I think that this is
					-- because when a dialog has a child, one of the children automatically
					-- has the focus. Anyway, in the case where we have a child,
					-- we need to connect the focus out actions to `on_wm_activate'.
					-- Julian 07/11/02
				if not interface.is_empty then
					if focus_out_actions_internal /= Void then
						focus_out_actions_internal.call (Void)
					end
				end
			end
		end

	common_dialog_imp: EV_DIALOG_IMP_COMMON is
			-- Dialog implementation type common to all descendents.
		do
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_DIALOG;
			-- Interface for `Current'.

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




end -- class EV_DIALOG_IMP_COMMON

