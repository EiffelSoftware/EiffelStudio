indexing
	description: "Eiffel Vision dialog. Mswindows implementation (hidden window)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP

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
		redefine
			interface,
			make,
			show,
			enable_modal,
			disable_modal,
			process_message,
			set_x_position,
			set_y_position,
			set_position,
			on_key_down
		end

create
	make,
	make_with_real_dialog

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			internal_class_name := new_class_name + "_AS_DIALOG"
			base_make (an_interface)
			make_top ("EV_DIALOG_WINDOW")
			create accel_list.make (10)
			apply_center_dialog := True
		end

	make_with_real_dialog (other_imp: EV_DIALOG_IMP_COMMON) is
			-- Create `Current' using attributes of `other_imp'.
		require
			other_imp_not_void: other_imp /= Void
		local
			app_imp: EV_APPLICATION_IMP
		do
			apply_center_dialog := False

			make (other_imp.interface)

				-- Copy the attributes from the dialog to the window
			copy_from_real_dialog (other_imp)

				-- Move the children
			move_children (other_imp)

				-- Destroy other.
			other_imp.destroy_implementation

				-- Add this dialog as root window.
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			app_imp.add_root_window (Current)
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is `Current' closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4).

feature -- Status Setting
	
	enable_modal is
			-- Set the dialog to be modal.
		do
			is_modal := True
		end

	disable_modal is
			-- Set the dialog not to be modal.
		do
			is_modal := False
		end

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
		
feature -- Element change

	set_x_position (a_x: INTEGER) is
			-- Set `x_position' with `a_x'
		do
			Precursor (a_x)
			apply_center_dialog := False
		end

	set_y_position (a_y: INTEGER) is
			-- Set `y_position' with `a_y'
		do
			Precursor (a_y)
			apply_center_dialog := False
		end

	set_position (new_x_position: INTEGER; new_y_position: INTEGER) is
			-- Put at horizontal position `new_x_position' and at
			-- vertical position `new_y_position' relative to parent.
		do
			Precursor (new_x_position, new_y_position)
			apply_center_dialog := False
		end		

feature -- Basic operations

	show_modal_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		do
			call_show_actions := True
			parent_window := a_parent_window
			promote_to_modal_dialog
			interface.implementation.show_modal_to_window (a_parent_window)
		end

	show_relative_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_parent_window'.
		do
			call_show_actions := True
			parent_window := a_parent_window
			promote_to_modeless_dialog
			interface.implementation.show_relative_to_window (a_parent_window)
		end

	show is
			-- Show `Current' if not already displayed.
		local
			button_imp: EV_BUTTON_IMP
		do
			if not is_displayed then
				set_text (internal_title)
				update_style
				if parent_window /= Void and then apply_center_dialog then
					center_dialog
					apply_center_dialog := False
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
				Precursor {EV_TITLED_WINDOW_IMP}
					-- Calling update style causes on_set_focus to be called
					-- before the children are correctly displayed in `Current'.
					-- This means that the `focus_in_actions' will be fired before
					-- the show actions are called in this case. Is there a way to avoid this?		
				if call_show_actions then
					if show_actions_internal /= Void then
						show_actions_internal.call ([])
					end
					call_show_actions := False
				end
			end
		end

feature {EV_DIALOG_I} -- Implementation

	apply_center_dialog: BOOLEAN
			-- Should `center_dialog' be called?

	parent_window: EV_WINDOW
			-- Parent window if any, Void otherwise

	interface: EV_DIALOG
			-- Interface for `Current'

	destroy_implementation is
			-- Destroy `Current' but does not wipe out the children.
		local
			app_imp: EV_APPLICATION_IMP
		do
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			check
				implementation_not_void: app_imp /= void
			end
			app_imp.remove_root_window (Current)

			wel_destroy_window
			is_destroyed := True
		end

feature {EV_BUTTON_IMP} -- Implementation

	on_dialog_key_down (virtual_key: INTEGER) is
			-- Executed when the Enter or Escape key is pressed.
		do
			if virtual_key = Vk_escape then
				call_default_button_action (False)
			elseif virtual_key = Vk_return then
				call_default_button_action (True)
			end
		end
	
feature {NONE} -- Implementation

	move_children (other_imp: EV_DIALOG_IMP_COMMON)is
			-- Move the children to the dialog or the window, depending
			-- on which is currently selected in `wel_item'.
		local
			loc_item_imp: EV_WIDGET_IMP
		do
			loc_item_imp ?= other_imp.item_imp
			if loc_item_imp /= Void then
				loc_item_imp.set_top_level_window_imp (Current)
				loc_item_imp.wel_set_parent (Current)
			end
		end

	update_style is
			-- Update the style of the window accordingly to the
			-- options set (`user_can_resize', `is_closeable', ...)
			-- and set the pixmap.
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
			new_style := bit_op.set_flag (new_style, Ws_minimizebox)
			new_style := bit_op.clear_flag (new_style, Ws_maximizebox)
			set_style (new_style)
		end

	center_dialog is
				-- Center the dialog relative to the parent window.
		require
			parent_window /= Void
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

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
		do
			on_dialog_key_down (virtual_key)
			Precursor (virtual_key, key_data)
		end

	promote_to_modal_dialog is
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODAL which allows modality
		local
			modal_dialog_imp: EV_DIALOG_IMP_MODAL
		do
			create modal_dialog_imp.make_with_dialog_window (Current)
			interface.replace_implementation (modal_dialog_imp)
		end

	promote_to_modeless_dialog is
			-- Promote the current implementation to
			-- EV_DIALOG_IMP_MODELESS which allows modality
		local
			modeless_dialog_imp: EV_DIALOG_IMP_MODELESS
		do
			create modeless_dialog_imp.make_with_dialog_window (Current)
			interface.replace_implementation (modeless_dialog_imp)
		end

	copy_from_real_dialog (other_imp: EV_DIALOG_IMP_COMMON) is
			-- Fill current with `other_imp' content.
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

			set_position (other_imp.x_position, other_imp.y_position)
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: INTEGER): INTEGER is
			-- Process all message plus `WM_INITDIALOG'.
		do
			if msg = Wm_close then
					-- Simulate a click on the default_cancel_button
				call_default_button_action (False)
			end
			Result := Precursor {EV_TITLED_WINDOW_IMP} (hwnd, msg, wparam, lparam)
		end

	call_default_button_action (use_push_button: BOOLEAN) is
			-- Call the action for the default push button if `a_push_button' is
			-- set, for the default cancel button otherwise.
		local
			button_actions: EV_NOTIFY_ACTION_SEQUENCE
			button: EV_BUTTON
		do
			if not interface.is_destroyed then
				if use_push_button then
					button := interface.default_push_button
				else
					button := interface.default_cancel_button
				end
				if button /= Void and then button.is_sensitive and then button.is_displayed then
					button_actions := button.select_actions
					if button_actions /= Void then
						button_actions.call ([])
					end
				end
			end
		end

end -- class EV_DIALOG_IMP

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
