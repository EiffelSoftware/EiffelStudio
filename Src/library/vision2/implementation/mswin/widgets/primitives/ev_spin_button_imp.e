indexing
	description:
		" EiffelVision spin button, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		redefine
			interface,
			text_change_actions,
			return_actions,
			focus_in_actions,
			focus_out_actions,
			key_press_actions,
			key_press_string_actions,
			key_release_actions,
			pointer_button_press_actions,
			pointer_button_release_actions,
			pointer_double_press_actions,
			pointer_enter_actions,
			pointer_leave_actions,
			pointer_motion_actions,
			resize_actions
		end

	EV_GAUGE_IMP
		redefine
			on_key_down,
			on_char,
			on_size,
			interface,
			initialize,
			ev_apply_new_size,
			top_level_window_imp,
			set_top_level_window_imp,
			set_default_minimum_size,
			set_minimum_width,
			set_minimum_size,
			disable_sensitive,
			enable_sensitive,
			focus_in_actions,
			focus_out_actions,
			create_focus_in_actions,
			create_focus_out_actions,
			key_press_actions,
			create_key_press_actions,
			key_press_string_actions,
			create_key_press_string_actions,
			key_release_actions,
			create_key_release_actions,
			pointer_button_press_actions,
			create_pointer_button_press_actions,
			pointer_button_release_actions,
			create_pointer_button_release_actions,
			pointer_double_press_actions,
			create_pointer_double_press_actions,
			pointer_enter_actions,
			create_pointer_enter_actions,
			pointer_leave_actions,
			create_pointer_leave_actions,
			pointer_motion_actions,
			create_pointer_motion_actions,
			resize_actions,
			create_resize_actions
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			set_text as wel_set_text,
			text as wel_text,
			has_capture as wel_has_capture
		undefine
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			show,
			hide,
			x_position,
			y_position,
			on_size,
			on_desactivate,
			on_kill_focus,
			on_set_focus,
			on_key_up,
			on_key_down,
			on_mouse_move,
			on_set_cursor,
			set_width,
			set_height,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			on_char,
			on_wm_vscroll,
			class_name,
			on_erase_background,
			text_length,
			set_focus,
			default_style,
			on_notify
		end

	WEL_UDS_CONSTANTS
		export
			{NONE} all
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_UDN_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with `an_interface'.
		local
			text_comp: EV_TEXT_FIELD
		do
			base_make (an_interface)
			create text_comp
			internal_text_field ?= text_comp.implementation
			wel_make (default_parent, "")
		end

	initialize is
			-- Initialize `Current'.
		do
			create internal_arrows_control.make
				(Current, 0, 0, default_spin_height, spin_width, -1)
			internal_text_field.wel_set_parent (Current)
			internal_arrows_control.set_buddy_window (internal_text_field)
			internal_arrows_control.set_range (0, 100)
			Precursor {EV_GAUGE_IMP}
			last_change_value := 0
		ensure then
			text_field_not_void: internal_text_field /= Void
			arrows_not_void: internal_arrows_control /= Void
		end

feature {EV_ANY_I} -- Access

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := Precursor {WEL_CONTROL_WINDOW} + Ws_tabstop
		end

	leap: INTEGER
			-- Size of leap. Default: 10.

	value: INTEGER is 
			-- Current value.
		do
			Result := internal_arrows_control.position
		end

	step: INTEGER
			-- Step of the scrolling

	minimum: INTEGER is
			-- Minimum value.
		do
			Result := internal_arrows_control.minimum
		end

	maximum: INTEGER is
			-- Maximum value.
		do
			Result := internal_arrows_control.maximum
		end

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	text_length: INTEGER is
			-- Number of characters contained in `text'.
		do
			Result := internal_text_field.text_length
		end

	text: STRING is
			-- Text of `Current'.
		do
			Result := internal_text_field.text
		end
	
feature -- Setting

	set_minimum_width (v: INTEGER) is
			-- Make `value' the new `minimum_width' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		do
			Precursor {EV_GAUGE_IMP} (v)
			internal_text_field.set_minimum_width (v - spin_width)
		end

	set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
		do
			set_minimum_width (mw)
			set_minimum_height (mh)
		end

	set_default_minimum_size is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			ev_set_minimum_size (internal_text_field.minimum_width + spin_width,
				internal_text_field.minimum_height.max (default_spin_height))
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			internal_text_field.set_top_level_window_imp (a_window)
		end

	set_focus is
			-- Set focus to Current, ie its internal associated text field.
		do
			internal_text_field.set_focus
		end

feature {EV_INTERNAL_SPIN_BUTTON_IMP} -- Access

	internal_arrows_control: EV_INTERNAL_UP_DOWN_CONTROL
			-- Windows up down control used internally.

	internal_text_field: EV_TEXT_FIELD_IMP
			-- Text field next to up-down control.

feature {EV_ANY_I} -- Implementation

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			internal_text_field.enable_sensitive
			internal_arrows_control.enable
			Precursor {EV_GAUGE_IMP}
		end

	disable_sensitive is
			-- Make object desensitive to user input.
		do
			internal_text_field.disable_sensitive
			internal_arrows_control.disable
			Precursor {EV_GAUGE_IMP}
		end

feature {EV_SPIN_BUTTON_I} -- Status setting.

	wel_set_leap (i :INTEGER) is
			-- Assign `i' to `leap'.
		do
			leap := i
		end
		
	wel_set_step (i :INTEGER) is
			-- Assign `i' to `step'.
		do
			step := i
		end

	wel_set_value (i :INTEGER) is
			-- Assign `i`' to `value'. 
		do
			internal_arrows_control.set_position (i)
				-- We must now store the value
			last_change_value := i
		end

	wel_set_range (i, j: INTEGER) is
			-- Assign `i' and `j' as
			-- bounds of `Current'. 
		do
				-- Set value so that it is within bound [i..j].
			if value < i then
				wel_set_value (i)
			elseif value > j then
				wel_set_value (j)
			end

				-- Adapt interval
			internal_arrows_control.set_range (i, j)
		end

feature -- action sequences

	--| Because this implementation uses an EV_TEXT_FIELD_IMP, we need
	--| to associate the action sequences with those from the text field.
	--| Before this change, none of the action_Sequences were ever called.
	--| One downside of this is that the events will only be recieved by the
	--| text part of the widget. No nice solution currently. Julian.	

	text_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.change_actions
		end

	create_text_change_actions:  EV_NOTIFY_ACTION_SEQUENCE is
				-- Create a change action sequence.
		do
			Result := internal_text_field.create_change_actions
		end

	return_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.return_actions
		end

	create_return_actions:  EV_NOTIFY_ACTION_SEQUENCE is
				-- Create a return action sequence.
		do
			Result := internal_text_field.create_return_actions
		end

	focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is gained.
		do
			Result := internal_text_field.focus_in_actions
		end

	create_focus_in_actions:  EV_FOCUS_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_focus_in_actions
		end

	focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is lost.
		do
			Result := internal_text_field.focus_out_actions
		end

	create_focus_out_actions:  EV_FOCUS_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_focus_out_actions
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := internal_text_field.key_press_actions
		end

	create_key_press_actions: EV_KEY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_key_press_actions
		end

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := internal_text_field.key_press_string_actions
		end

	create_key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_key_press_string_actions
		end

	key_release_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is released.
		do
			Result := internal_text_field.key_release_actions
		end

	create_key_release_actions: EV_KEY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_key_release_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is pressed.
		do
			Result := internal_text_field.pointer_button_press_actions
		end

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_pointer_button_press_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is released.
		do
			Result := internal_text_field.pointer_button_release_actions
		end

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_pointer_button_release_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is double clicked.
		do
			Result := internal_text_field.pointer_double_press_actions
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_pointer_double_press_actions
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			Result := internal_text_field.pointer_enter_actions
		end

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_pointer_enter_actions
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			Result := internal_text_field.pointer_leave_actions
		end

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_pointer_leave_actions
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		do
			Result := internal_text_field.pointer_motion_actions
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_pointer_motion_actions
		end
		
	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when size changes.
		do
			Result := internal_text_field.resize_actions
		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
		do
			Result := internal_text_field.create_resize_actions
		end

feature -- EV_TEXT_COMPONENT_I implementation

	capacity: INTEGER is
			-- Maximum number of characters field can hold.
		do
			Result := internal_text_field.capacity
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
			Result := internal_text_field.maximum_character_width
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		do
			Result := internal_text_field.clipboard_content
		end

	is_editable: BOOLEAN is
			-- Is the text editable by the user?
		do
			Result := internal_text_field.is_editable
		end

	caret_position: INTEGER is
			-- Current caret position.
		do
			Result := internal_text_field.caret_position
		end

	has_selection: BOOLEAN is
			-- Does `Current' have a selection?
		do
			Result := internal_text_field.has_selection
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		do
			Result := internal_text_field.selection_start
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		do
			Result := internal_text_field.selection_end
		end

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		do
			internal_text_field.set_capacity (a_capacity)
		end

	set_editable (flag: BOOLEAN) is
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		do
			internal_text_field.set_editable (flag)
		end

	set_caret_position (pos: INTEGER) is
			-- set current insertion position
		do
			internal_text_field.set_caret_position (pos)
		end

	set_text (txt: STRING) is
			-- Assign `txt' to text of `Current'.
		do
			internal_text_field.set_text (txt)
		end

	insert_text (txt: STRING) is
			-- Insert `txt' at the current caret position.
		do
			internal_text_field.insert_text (txt)
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into `Current'.
		do
			internal_text_field.append_text (txt)
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into `Current'.
		do
			internal_text_field.prepend_text (txt)
		end

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		do
			internal_text_field.set_minimum_width_in_characters (nb)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		do
			internal_text_field.select_region (start_pos, end_pos)
		end	

	deselect_all is
			-- Unselect the current selection.
		do
			internal_text_field.deselect_all
		end

	delete_selection is
			-- Delete the current selection.
		do
			internal_text_field.delete_selection
		end

	cut_selection is
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		do
			internal_text_field.cut_selection
		end

	copy_selection is
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		do
			internal_text_field.copy_selection
		end

	paste (index: INTEGER) is
			-- Insert the contents of the clipboard 
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing. 
		do
			internal_text_field.paste (index)
		end

feature {EV_TEXT_FIELD_IMP} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
			-- If `virtual_key' is Return then we update `Current' accordingly.
		do
			Precursor {EV_GAUGE_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return then
				internal_text_field.set_caret_position (1)
				translate_text
				interface.return_actions.call ([])
				if last_change_value /= value then
					if change_actions_internal /= Void then
						last_change_value := value
						change_actions_internal.call ([value])	
					end
				end
			end
		end
		
feature {NONE} -- Implementation

	translate_text is
			-- Take a string and translate it to the corresponding
			-- integer value. If it is not in the range or if it
			-- not an integer value, it returns the minimum of the
			-- range.
		local
			txt: STRING
			val: INTEGER
		do
			txt := text
			if txt.is_integer then
				val := txt.to_integer
				if val < internal_arrows_control.minimum then
					set_text (internal_arrows_control.minimum.out)
				elseif val > internal_arrows_control.maximum then
					set_text (internal_arrows_control.maximum.out)
				else
					internal_arrows_control.set_position (val)
				end
			else
				set_text (internal_arrows_control.minimum.out)
			end
		end
		
	on_notify (control_id: INTEGER; info: WEL_NMHDR) is
			-- A `wm_notify' message has been received by `Current'
		local
			up_down: WEL_NM_UP_DOWN_CONTROL
		do
				-- If `Udn_deltapos', we must assign the stepping distance
				-- ourselves.
			if info.code = Udn_deltapos then
				create up_down.make_by_pointer (info.item)
				if up_down.delta < 0 then
							-- Adjust value of `Current' by `step'.
						up_down.set_delta (-step)
					else
							-- Adjust value of `Current' by `step'.
						up_down.set_delta (step)
				end
			end
		end

	last_change_value: INTEGER
		-- Holds the last `value' of `Current' as seen from the interface.
		-- We need this as windows sends `on_wm_vscroll' even if the value is
		-- not changing, ie reached its maximum. We only want to call the
		-- change actions when the value really does change.

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `bip' when the user
			-- tab to another control.
		do
			Precursor {EV_GAUGE_IMP} (character_code, key_data)
			if not has_focus then
				disable_default_processing
			end
		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
			-- Wm_vscroll message.
			-- Here, we know it's a spin button.
		local
			up_down: WEL_UP_DOWN_CONTROL
			p: POINTER
		do
				-- To avoid the commands to be call two times, we check that
				-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
				p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
				if p /= default_pointer then
						-- The message comes from a spin button
					up_down ?= window_of_item (p)
					check
						up_down_has_buddy: up_down.buddy_window /= Void
					end
					if last_change_value /= value then
						if change_actions_internal /= Void then
							last_change_value := value
							change_actions_internal.call ([value])
						end
					end
				end
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			internal_arrows_control.move_and_resize
				(a_width - spin_width, 0, spin_width, a_height, True)
			internal_text_field.set_move_and_size
				(0, 0, a_width - spin_width, a_height)
		end

	ev_apply_new_size
		(a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			internal_arrows_control.move_and_resize
				(a_width - spin_width, 0, spin_width, a_height, repaint)
			internal_text_field.ev_apply_new_size
				(0, 0, a_width - spin_width, a_height, repaint)
		end

feature {NONE} -- Constants

	spin_width: INTEGER is 20
			-- Width of spin button.

	default_spin_height: INTEGER is 16
			-- Default height of spin button.

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := internal_text_field.next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := internal_text_field.next_dlggroupitem (hdlg, hctl,
				previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

	class_name: STRING is
			-- Window class name to create
		do
			Result := generator
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
