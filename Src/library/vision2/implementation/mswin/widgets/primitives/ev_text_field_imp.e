note
	description:
		"EiffelVision text field. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I
		rename
			set_selection as text_component_imp_set_selection
		redefine
			interface,
			hide_border
		end

	EV_TEXT_COMPONENT_IMP
		rename
			internal_set_caret_position as wel_set_caret_position
		redefine
			on_key_down,
			interface,
			make,
			next_dlgtabitem
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			make,
			set_font
		end

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as is_displayed,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end,
			width as wel_width,
			height as wel_height,
			set_caret_position as wel_set_caret_position,
			caret_position as wel_caret_position,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			set_text as wel_set_text,
			has_capture as wel_has_capture,
			text_length as wel_text_length
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_key_up,
			on_char,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			select_all,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			on_key_down,
			on_en_change,
			default_style,
			enable,
			disable
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with inteface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			set_default_font
			Precursor {EV_TEXT_COMPONENT_IMP}
			enable_scroll_caret_at_selection
		end

feature -- Element Change

	set_text (a_text: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			wel_set_text (a_text)

				-- If `Es_multiline' is specified then we need to make sure that the change actions are fired explicitly
				-- as Windows does not fire `En_update' and `En_change' actions.
			if is_multiline then
					-- Explicitly fire En_change action to emulate single line behavior.
				{WEL_API}.send_message (default_parent.item, Wm_command, to_wparam (En_change |<< 16) , wel_item)
			end
		end

feature -- Access

	internal_caret_position: INTEGER
			-- <Precursor>
		local
			l_wel_point: WEL_POINT
			sel_start, sel_end: INTEGER_32
			l_success: BOOLEAN
		do
			{WEL_API}.send_message (wel_item, Em_getsel, $sel_start, $sel_end)
			Result := sel_end
			if sel_start /= sel_end then
					-- We may have a reverse selection so we need to retrieve the caret position from the control.
				create l_wel_point.make (0, 0)
				l_success := {WEL_API}.get_caret_pos (l_wel_point.item)
				if l_success then
					Result := {WEL_API}.send_message_result_integer (wel_item, {WEL_RICH_EDIT_MESSAGE_CONSTANTS}.Em_charfrompos, default_pointer, cwin_make_long (l_wel_point.x, l_wel_point.y))
					if Result /= sel_start and Result /= sel_end then
						Result := sel_end
					end
				end
			end
		end

feature -- Alignment

	text_alignment: INTEGER
			-- Current text alignment. Possible value are
			--	* Text_alignment_left
			--	* Text_alignment_right
			--	* Text_alignment_center		

	align_text_center
			-- Display text centered.
		do
			if text_alignment /= {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center then
				text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
				recreate_current
			end
		end

	align_text_right
			-- Display text right aligned.
		do
			if text_alignment /= {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right then
				text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
				recreate_current
			end
		end

	align_text_left
			-- Display text left aligned.
		do
			if text_alignment /= {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left then
				text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
				recreate_current
			end
		end

feature {EV_ANY_I} -- Status setting

	hide_border
			-- Ensure that `Current' is displayed with no border.
		do
			set_ex_style (0)
				-- The minimum size must now be reduced as there are no borders.
			ev_set_minimum_size (
				maximum_character_width * 4, internal_font_height, False)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER
			-- <Precursor>
		do
			Result := Ws_child | Ws_visible| Ws_tabstop
					| Ws_group | Es_autohscroll
					| Ws_clipchildren | Ws_clipsiblings | es_multiline

				-- We set es_multiline as this gives the correct caret behavior when setting the selection from right to left.
				-- The minimum height of the control is set so this emulates single line behavior with this control.

				-- Set proper style depending on alignment.
			inspect text_alignment
			when {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left  then
				Result := Result | es_left
			when {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right  then
				Result := Result | es_right
			when {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center  then
				Result := Result | es_center
			end
		end

	recreate_current
			-- Destroy the existing widget and recreate current using the new style.
		local
			par_imp: detachable WEL_WINDOW
			cur_x: INTEGER
			cur_y: INTEGER
			cur_width: INTEGER
			cur_height: INTEGER
			l_sensitive: like is_sensitive
			l_tooltip: like tooltip
			l_text: like text
			l_caret: like caret_position
			l_is_read_only: like read_only
		do

			l_text := text
			l_tooltip := tooltip
			l_sensitive := is_sensitive

			l_caret := internal_caret_position
			l_is_read_only := read_only
			set_tooltip ("")

				-- We keep some useful informations that will be
				-- destroyed when calling `wel_destroy'
			par_imp := wel_parent
				-- `Current' may not have been actually physically parented
				-- within windows yet.
			if par_imp = Void then
				par_imp := default_parent
			end
			cur_x := x_position
			cur_y := y_position
			cur_width := ev_width
			cur_height := ev_height

					-- We destroy the widget
			wel_destroy

				-- We create the new combo.
			wel_make (par_imp, "", cur_x, cur_y, cur_width, cur_height, 0)

				-- Restore the previous settings.
			if private_font /= Void then
				set_font (private_font)
			else
				set_default_font
			end
			if not l_sensitive then
				disable_sensitive
			end
			if foreground_color_imp /= Void then
				set_foreground_color (foreground_color)
			end
			set_tooltip (l_tooltip)
			wel_set_text (l_text)
			wel_set_caret_position (l_caret)
			if l_is_read_only then
				set_read_only
			end
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- We check if the enter key is pressed.
			-- 13 is the number of the return key.
		do
			process_navigation_key (virtual_key)
			Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return and then is_editable then
				wel_set_caret_position (0)
				if return_actions_internal /= Void then
					return_actions_internal.call (Void)
				end
			end
				--| EV_SPIN_BUTTON_IMP is composed of `Current'.
				--| Therefore if `Current' is parented in an EV_SPIN_BUTTON_IMP,
				--| we must propagate the key press event.
			if attached {EV_SPIN_BUTTON_IMP} wel_parent as l_spin_button then
				l_spin_button.on_key_down (virtual_key, key_data)
			end
		end

	is_multiline: BOOLEAN
			-- Does `Current' have multiline set?
		do
			Result := style & es_multiline /= 0
		end

	on_en_change
			-- The user has taken an action
			-- that may have altered the text.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call (Void)
			end
		end

	enable
			-- Enable mouse and keyboard input.
		do
			cwin_enable_window (wel_item, True)
		end

	disable
			-- Disable mouse and keyboard input
		do
			cwin_enable_window (wel_item, False)
		end

	set_font (ft: EV_FONT)
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			set_default_minimum_size
		end

feature {EV_SPIN_BUTTON_IMP} -- Implementation

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- Encapsulation of the SDK GetNextDlgTabItem.
			-- This has been redefined from EV_WIDGET_IMP as EV_SPIN_BUTTON
			-- uses an instance of EV_TEXT_FIELD internally.
		local
			l_widget: EV_WIDGET_IMP
			l_spin_button_imp: detachable EV_SPIN_BUTTON_IMP
			l_interface: EV_WIDGET
		do
				-- Reset the start widget searched flag.
			start_widget_searched_cell.put (-1)
			l_spin_button_imp ?= wel_parent
			if l_spin_button_imp /= Void then
				l_interface := l_spin_button_imp.attached_interface
			else
				l_interface := attached_interface
			end
			if not previous then
				l_widget := next_tabstop_widget (l_interface, 0, False)
			else
				l_widget := next_tabstop_widget (l_interface, 1, True)
			end
			Result := l_widget.wel_item
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT_FIELD note option: stable attribute end;

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

end -- class EV_TEXT_FIELD_IMP
