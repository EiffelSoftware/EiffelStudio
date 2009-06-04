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
		redefine
			interface,
			hide_border
		end

	EV_TEXT_COMPONENT_IMP
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
			set_caret_position as internal_set_caret_position,
			caret_position as internal_caret_position,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
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
		end

feature {EV_ANY_I} -- Status report

	text: STRING_32
			-- Text of `Current'
		do
			Result := wel_text
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
			if text_alignment /= {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center  then
				text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
				recreate_current
			end
		end

	align_text_right
			-- Display text right aligned.
		do
			if text_alignment /= {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right  then
				text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
				recreate_current
			end
		end

	align_text_left
			-- Display text left aligned.
		do
			if text_alignment /= {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left  then
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
				maximum_character_width * 4, internal_font_height)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER
			-- We specify the Es_autovscroll style otherwise
			-- the system beeps when we press the return key.
		do
			Result := Ws_child | Ws_visible| Ws_tabstop
					| Ws_group | Es_autohscroll
					| Ws_clipchildren | Ws_clipsiblings
				-- Set proper style depending on alignment.
			inspect text_alignment
			when {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left  then
				Result := Result | es_left
			when {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right  then
				Result := Result | es_right
			when {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center  then
				Result := Result | es_center
			else
				check False end
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
			l_sensitive := is_sensitive
			l_tooltip := tooltip
			l_text := text
			l_caret := caret_position
			l_is_read_only := read_only
			set_tooltip ("")

				-- We keep some useful informations that will be
				-- destroyed when calling `wel_destroy'
			par_imp ?= parent_imp
				-- `Current' may not have been actually phsically parented
				-- within windows yet.
			if par_imp = Void then
				par_imp ?= default_parent
			end
			check par_imp /= Void end
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
			set_text (l_text)
			set_caret_position (l_caret)
			if l_is_read_only then
				set_read_only
			end
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- We check if the enter key is pressed.
			-- 13 is the number of the return key.
		local
			spin_button: detachable EV_SPIN_BUTTON_IMP
		do
			process_navigation_key (virtual_key)
			Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return and is_editable then
				set_caret_position (1)
				attached_interface.return_actions.call (Void)
			end
				--| EV_SPIN_BUTTON_IMP is composed of `Current'.
				--| Therefore if `Current' is parented in an EV_SPIN_BUTTON_IMP,
				--| we must propagate the key press event.
			spin_button ?= wel_parent
			if spin_button /= Void then
				spin_button.on_key_down (virtual_key, key_data)
			end
		end

	on_en_change
			-- The user has taken an action
			-- that may have altered the text.
		do
			attached_interface.change_actions.call (Void)
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

feature {NONE} -- Implementation

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











