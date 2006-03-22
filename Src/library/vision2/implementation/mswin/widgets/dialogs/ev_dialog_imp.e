indexing
	description: "Eiffel Vision dialog. Mswindows implementation (hidden window)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			process_message,
			set_x_position,
			set_y_position,
			set_position,
			on_destroy
		end

create
	make,
	make_with_real_dialog

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			internal_class_name := new_class_name + "_AS_DIALOG"
			internal_icon_name := ""
			base_make (an_interface)
			make_top ("EV_DIALOG_WINDOW")
			create accel_list.make (10)
			apply_center_dialog := True
		end

	make_with_real_dialog (other_imp: like common_dialog_imp) is
			-- Create `Current' using attributes of `other_imp'.
		require
			other_imp_not_void: other_imp /= Void
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
			application_imp.add_root_window (Current)
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
			Result := Void
			-- `Result' is Void as `Current' cannot be shown modally or
			-- relative, otherwise its implementation would not be EV_DIALOG_IMP.
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

feature -- Element change

	set_x_position (a_x: INTEGER) is
			-- Set `x_position' with `a_x'
		do
			Precursor {EV_TITLED_WINDOW_IMP} (a_x)
			apply_center_dialog := False
		end

	set_y_position (a_y: INTEGER) is
			-- Set `y_position' with `a_y'
		do
			Precursor {EV_TITLED_WINDOW_IMP} (a_y)
			apply_center_dialog := False
		end

	set_position (new_x_position: INTEGER; new_y_position: INTEGER) is
			-- Put at horizontal position `new_x_position' and at
			-- vertical position `new_y_position' relative to parent.
		do
			Precursor {EV_TITLED_WINDOW_IMP} (new_x_position, new_y_position)
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
				end
				apply_center_dialog := False


					-- Set the focus to the `default_push_button' if any
				if default_push_button /= Void and then
					default_push_button.is_show_requested and then
					default_push_button.is_sensitive
				then
					button_imp ?= interface.default_push_button.implementation
					set_default_push_button (button_imp.interface)
					button_imp.set_focus
				end
				Precursor {EV_TITLED_WINDOW_IMP}
					-- Calling update style causes on_set_focus to be called
					-- before the children are correctly displayed in `Current'.
					-- This means that the `focus_in_actions' will be fired before
					-- the show actions are called in this case. Is there a way to avoid this?		
				if call_show_actions then
					if show_actions_internal /= Void then
						show_actions_internal.call (Void)
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

	destroy_implementation is
			-- Destroy `Current' but does not wipe out the children.
		do
			application_imp.remove_root_window (Current)

			set_is_destroyed (True)
			wel_destroy_window
		end

feature {NONE} -- Implementation

	on_destroy is
			-- WM_DESTROY
		do
			if parent_window /= Void then
				-- Parent Window has been destroyed therefore we don't need to destroy `Current'.
			else
				Precursor {EV_TITLED_WINDOW_IMP}
			end
		end

	move_children (other_imp: like common_dialog_imp) is
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

	copy_from_real_dialog (other_imp: like common_dialog_imp) is
			-- Fill current with `other_imp' content.
		local
			other_menu_bar: EV_MENU_BAR
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
			internal_default_cancel_button := other_imp.internal_default_cancel_button
			internal_default_push_button := other_imp.internal_default_push_button
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
			other_menu_bar := other_imp.menu_bar
				-- Now remove the menu bar from the old implementation.
				-- If we do not do this, then we will not be able to set
				-- it in `Current'.
			if other_menu_bar /= Void then
				other_imp.remove_menu_bar
				set_menu_bar (other_menu_bar)
			end
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
			shared := other_imp.shared
			show_actions_internal := other_imp.show_actions_internal
			user_can_resize := other_imp.user_can_resize
			user_interface_mode := other_imp.user_interface_mode
			apply_center_dialog := other_imp.apply_center_dialog
			call_show_actions := other_imp.call_show_actions
			scroller := other_imp.scroller
			set_position (other_imp.x_position, other_imp.y_position)

				-- Now copy contents of bars.
			create lower_bar
			copy_box_attributes (other_imp.lower_bar, lower_bar)
			create upper_bar
			copy_box_attributes (other_imp.upper_bar, upper_bar)
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- Process all message plus `WM_INITDIALOG'.
		do
			if msg = Wm_close then
					-- Simulate a click on the default_cancel_button
				process_standard_key_press (vk_escape)
					-- Do not actually close the window.
				if close_request_actions_internal /= Void then
					close_request_actions_internal.call (Void)
				end
				set_default_processing (False)
			else
				Result := Precursor {EV_TITLED_WINDOW_IMP} (hwnd, msg, wparam, lparam)
			end
		end

	common_dialog_imp: EV_DIALOG_IMP_COMMON is
			-- Dialog implementation type common to all descendents.
		do
		end

feature {EV_ANY, EV_ANY_I}

	interface: EV_DIALOG;
			-- Interface for `Current'

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




end -- class EV_DIALOG_IMP

