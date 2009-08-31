note
	description:
		" EiffelVision spin button, mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EV_FONTABLE_IMP
		redefine
			interface,
			set_font
		end

	EV_GAUGE_IMP
		redefine
			on_key_down,
			on_size,
			interface,
			make,
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
			key_press_actions,
			key_press_string_actions,
			key_release_actions,
			pointer_button_press_actions,
			pointer_button_release_actions,
			pointer_double_press_actions,
			pointer_enter_actions,
			pointer_leave_actions,
			pointer_motion_actions,
			resize_actions,
			tooltip_window,
			on_set_focus,
			set_tooltip,
			initialize_gauge_control
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
			has_capture as wel_has_capture,
			font as wel_font,
			set_font as wel_set_font
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
			on_char,
			on_mouse_move,
			on_mouse_wheel,
			on_set_cursor,
			set_width,
			set_height,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			text_length,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			on_wm_vscroll,
			class_name,
			on_erase_background,
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

	old_make (an_interface: like interface)
			-- Create `Current' with `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		local
			text_comp: EV_TEXT_FIELD
			l_internal_text_field: detachable like internal_text_field
		do
			create text_comp
			l_internal_text_field ?= text_comp.implementation
			check l_internal_text_field /= Void end
			internal_text_field := l_internal_text_field
			wel_make (default_parent, "")

			set_default_font
			Precursor {EV_GAUGE_IMP}
		ensure then
			text_field_not_void: internal_text_field /= Void
			arrows_not_void: internal_arrows_control /= Void
		end

	initialize_gauge_control
			-- Initialize gauge control.
		do
			create child_cell
			create internal_arrows_control.make
				(Current, 0, 0, default_spin_height, spin_width, -1)
			internal_text_field.wel_set_parent (Current)
			internal_arrows_control.set_buddy_window (internal_text_field)
			internal_arrows_control.set_range (0, 100)
			last_change_value := 0
			Precursor
		end

feature -- Alignment

	text_alignment: INTEGER
		do
			Result := internal_text_field.text_alignment
		end

	align_text_center
		do
			internal_text_field.align_text_center
		end

	align_text_right
		do
			internal_text_field.align_text_right
		end

	align_text_left
		do
			internal_text_field.align_text_left
		end

feature {EV_ANY_I} -- Access

	default_style: INTEGER
			-- Default style used to create `Current'.
		do
			Result := Precursor {WEL_CONTROL_WINDOW} + Ws_tabstop
		end

	leap: INTEGER
			-- Size of leap. Default: 10.

	value: INTEGER
			-- Current value.
		do
			check internal_arrows_control /= Void end
			Result := internal_arrows_control.position
		end

	step: INTEGER
			-- Step of the scrolling

	minimum: INTEGER
			-- Minimum value.
		do
			check internal_arrows_control /= Void end
			Result := internal_arrows_control.minimum
		end

	maximum: INTEGER
			-- Maximum value.
		do
			check internal_arrows_control /= Void end
			Result := internal_arrows_control.maximum
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	text: STRING_32
			-- Text of `Current'.
		do
			Result := internal_text_field.text
		end

feature -- Setting

	set_minimum_width (v: INTEGER)
			-- Make `value' the new `minimum_width' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		do
			Precursor {EV_GAUGE_IMP} (v)
			internal_text_field.set_minimum_width (v - spin_width)
		end

	set_minimum_size (mw, mh: INTEGER)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
		do
			set_minimum_width (mw)
			set_minimum_height (mh)
		end

	set_default_minimum_size
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			ev_set_minimum_size (internal_text_field.minimum_width + spin_width,
				internal_text_field.minimum_height.max (default_spin_height))
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			internal_text_field.set_top_level_window_imp (a_window)
		end

	set_focus
			-- Set focus to Current, ie its internal associated text field.
		do
			internal_text_field.set_focus
		end

	set_tooltip (a_tooltip: STRING_GENERAL)
		do
			Precursor {EV_GAUGE_IMP} (a_tooltip)
			check internal_arrows_control /= Void end
			internal_arrows_control.set_tooltip (a_tooltip)
		end

feature {NONE} -- Access

	internal_arrows_control: detachable EV_INTERNAL_UP_DOWN_CONTROL note option: stable attribute end
			-- Windows up down control used internally.

	internal_text_field: EV_TEXT_FIELD_IMP
			-- Text field next to up-down control.

feature {EV_ANY_I} -- Implementation

	enable_sensitive
			-- Make object sensitive to user input.
		do
			internal_text_field.enable_sensitive
			check internal_arrows_control /= Void end
			internal_arrows_control.enable
			Precursor {EV_GAUGE_IMP}
		end

	disable_sensitive
			-- Make object desensitive to user input.
		do
			internal_text_field.disable_sensitive
			check internal_arrows_control /= Void end
			internal_arrows_control.disable
			Precursor {EV_GAUGE_IMP}
		end

feature {EV_SPIN_BUTTON_I} -- Status setting.

	wel_set_leap (i :INTEGER)
			-- Assign `i' to `leap'.
		do
			leap := i
		end

	wel_set_step (i :INTEGER)
			-- Assign `i' to `step'.
		do
			step := i
		end

	wel_set_value (i :INTEGER)
			-- Assign `i`' to `value'.
		do
			check internal_arrows_control /= Void end
			internal_arrows_control.set_position (i)
				-- We must now store the value
			last_change_value := i
		end

	wel_set_range (i, j: INTEGER)
			-- Assign `i' and `j' as
			-- bounds of `Current'.
		do
				-- Adapt interval
			check internal_arrows_control /= Void end
			internal_arrows_control.set_range (i, j)

				-- Set value so that it is within bound [i..j].
			if value < i then
				wel_set_value (i)
			elseif value > j then
				wel_set_value (j)
			end

		end

	set_font (ft: EV_FONT)
			-- Make `ft' new font of `Current'.
		local
			local_font_windows: detachable EV_FONT_IMP
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			check private_font /= Void end
			local_font_windows ?= private_font.implementation
			check
				valid_font: local_font_windows /= Void
			end
			internal_text_field.wel_set_font (local_font_windows.wel_font)
				-- We don't need the WEL private font anymore since it is set by user.
			private_wel_font := Void
		end

feature -- action sequences

	--| Because this implementation uses an EV_TEXT_FIELD_IMP, we need
	--| to associate the action sequences with those from the text field.
	--| Before this change, none of the action_Sequences were ever called.
	--| One downside of this is that the events will only be recieved by the
	--| text part of the widget. No nice solution currently. Julian.	

	text_change_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			Result := internal_text_field.change_actions
		end

	create_text_change_actions:  EV_NOTIFY_ACTION_SEQUENCE
				-- Create a change action sequence.
		do
			Result := internal_text_field.create_change_actions
		end

	return_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			Result := internal_text_field.return_actions
		end

	create_return_actions:  EV_NOTIFY_ACTION_SEQUENCE
				-- Create a return action sequence.
		do
			Result := internal_text_field.create_return_actions
		end

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is gained.
		do
			Result := internal_text_field.focus_in_actions
		end

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is lost.
		do
			Result := internal_text_field.focus_out_actions
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := internal_text_field.key_press_actions
		end

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := internal_text_field.key_press_string_actions
		end

	key_release_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is released.
		do
			Result := internal_text_field.key_release_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.
		do
			Result := internal_text_field.pointer_button_press_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is released.
		do
			Result := internal_text_field.pointer_button_release_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.
		do
			Result := internal_text_field.pointer_double_press_actions
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer enters widget.
		do
			Result := internal_text_field.pointer_enter_actions
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer leaves widget.
		do
			Result := internal_text_field.pointer_leave_actions
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.
		do
			Result := internal_text_field.pointer_motion_actions
		end

	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when size changes.
		do
			Result := internal_text_field.resize_actions
		end

feature -- EV_TEXT_COMPONENT_I implementation

	capacity: INTEGER
			-- Maximum number of characters field can hold.
		do
			Result := internal_text_field.capacity
		end

	maximum_character_width: INTEGER
			-- Maximum width of a single character in `Current'.
		do
			Result := internal_text_field.maximum_character_width
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do
			Result := internal_text_field.clipboard_content
		end

	is_editable: BOOLEAN
			-- Is the text editable by the user?
		do
			Result := internal_text_field.is_editable
		end

	caret_position: INTEGER
			-- Current caret position.
		do
			Result := internal_text_field.caret_position
		end

	has_selection: BOOLEAN
			-- Does `Current' have a selection?
		do
			Result := internal_text_field.has_selection
		end

	selection_start: INTEGER
			-- Index of the first character selected.
		do
			Result := internal_text_field.selection_start
		end

	selection_end: INTEGER
			-- Index of the last character selected.
		do
			Result := internal_text_field.selection_end
		end

	set_capacity (a_capacity: INTEGER)
			-- Assign `a_capacity' to `capacity'.
		do
			internal_text_field.set_capacity (a_capacity)
		end

	set_editable (flag: BOOLEAN)
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		do
			internal_text_field.set_editable (flag)
		end

	set_caret_position (pos: INTEGER)
			-- set current insertion position
		do
			internal_text_field.set_caret_position (pos)
		end

	set_text (txt: STRING_GENERAL)
			-- Assign `txt' to text of `Current'.
		do
			internal_text_field.set_text (txt)
		end

	insert_text (txt: STRING_GENERAL)
			-- Insert `txt' at the current caret position.
		do
			internal_text_field.insert_text (txt)
		end

	append_text (txt: STRING_GENERAL)
			-- append 'txt' into `Current'.
		do
			internal_text_field.append_text (txt)
		end

	prepend_text (txt: STRING_GENERAL)
			-- prepend 'txt' into `Current'.
		do
			internal_text_field.prepend_text (txt)
		end

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		do
			internal_text_field.set_minimum_width_in_characters (nb)
		end

	select_region (start_pos, end_pos: INTEGER)
			-- Select (hilight) the text between
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		do
			internal_text_field.select_region (start_pos, end_pos)
		end

	deselect_all
			-- Unselect the current selection.
		do
			internal_text_field.deselect_all
		end

	delete_selection
			-- Delete the current selection.
		do
			internal_text_field.delete_selection
		end

	cut_selection
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		do
			internal_text_field.cut_selection
		end

	copy_selection
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		do
			internal_text_field.copy_selection
		end

	paste (index: INTEGER)
			-- Insert the contents of the clipboard
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing.
		do
			internal_text_field.paste (index)
		end

feature {EV_TEXT_FIELD_IMP} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER)
			-- A key has been pressed.
			-- If `virtual_key' is Return then we update `Current' accordingly.
		do
			Precursor {EV_GAUGE_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return then
				internal_text_field.set_caret_position (1)
				translate_text
				attached_interface.return_actions.call (Void)
				if last_change_value /= value then
					if change_actions_internal /= Void then
						last_change_value := value
						change_actions_internal.call ([value])
					end
				end
			end
		end

feature {NONE} -- Implementation

	on_set_focus
			-- Called when a `Wm_setfocus' message is recieved.
		do
				-- No need to call precursor because calling `set_focus'
				-- on the text will call the focus_in action sequence.
			internal_text_field.set_focus
		end

	translate_text
			-- Take a string and translate it to the corresponding
			-- integer value. If it is not in the range or if it
			-- not an integer value, it returns the minimum of the
			-- range.
		local
			txt: like text
			val: INTEGER
		do
			check internal_arrows_control /= Void end
			txt := text
			txt.prune_all (',')
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

	on_notify (control_id: INTEGER; info: WEL_NMHDR)
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

	on_wm_vscroll (wparam, lparam: POINTER)
			-- Wm_vscroll message.
			-- Here, we know it's a spin button.
		local
			up_down: detachable WEL_UP_DOWN_CONTROL
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
						up_down_has_buddy: up_down /= Void and then up_down.buddy_window /= Void
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

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER)
		do
			check internal_arrows_control /= Void end
			internal_arrows_control.move_and_resize
				(a_width - spin_width, 0, spin_width, a_height, True)
			internal_text_field.set_move_and_size
				(0, 0, a_width - spin_width, a_height)
		end

	ev_apply_new_size
		(a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			wel_move_and_resize (a_x, a_y, a_width, a_height, repaint)
			check internal_arrows_control /= Void end
			internal_arrows_control.move_and_resize
				(a_width - spin_width, 0, spin_width, a_height, repaint)
			internal_text_field.ev_apply_new_size
				(0, 0, a_width - spin_width, a_height, repaint)
		end

	tooltip_window: detachable WEL_WINDOW
			-- `Result' is WEL_WINDOW of `Current' used
			-- to trigger tooltip events.
		do
			Result := window_of_item (internal_text_field.wel_item)
		end

feature {NONE} -- Constants

	spin_width: INTEGER = 20
			-- Width of spin button.

	default_spin_height: INTEGER = 16
			-- Default height of spin button.

feature {NONE} -- Feature that should be directly implemented by externals

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := internal_text_field.next_dlgtabitem (hdlg, hctl, previous)
		end

	class_name: STRING_32
			-- Window class name to create
		do
			Result := generator
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SPIN_BUTTON note option: stable attribute end

invariant
	internal_text_field_not_void: internal_text_field /= Void
	internal_arrows_control_not_void:  is_initialized implies internal_arrows_control /= Void

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

end -- class EV_SPIN_BUTTON_IMP
