indexing 
	description:
		" EiffelVision text. A text area that contains%
		% a rich text."
	note: "It doesn't inherit from EV_TEXT_IMP because%
		% it is different from the WEL hierarchy."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP

inherit
	EV_RICH_TEXT_I
		undefine
			selected_text
		end

	EV_TEXT_IMP
		rename
			wel_make as multiple_line_edit_make
		export
			{NONE} add_change_command, remove_change_commands
		undefine
			text,
			set_text,
			class_name,
			default_style,
			default_ex_style,
			set_tab_stops,
			set_default_tab_stops,
			set_tab_stops_array,
			selected_text,
			wel_selection_end,
			wel_selection_start,
			set_selection,
			has_selection,
			set_text_limit,
			insert_text
		redefine
			search,
			set_background_color,
			set_position
		end

	WEL_RICH_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			set_background_color as wel_set_background_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end
		undefine
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_set_focus,
			on_kill_focus,
			on_key_up,
			on_key_down,
			wel_background_color,
			wel_foreground_color,
			on_en_change
		end

creation
	make,
	make_with_text

feature -- Access

	character_format: EV_CHARACTER_FORMAT is
			-- Current character format.
		local
			wel: WEL_CHARACTER_FORMAT		
		do
			!! Result.make
			wel?= Result.implementation
			wel.set_all_masks
			cwin_send_message (item, Em_getcharformat, 1,
				wel.to_integer)
		end

feature -- Status setting

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		local
			tt: EV_RICH_TEXT
		do
			tt ?= interface
			format.apply (tt)
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		local
			format: EV_CHARACTER_FORMAT
		do
			format := character_format
			set_caret_position (pos)
			set_character_format (format)
		end

feature -- Element change

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			{EV_TEXT_IMP} Precursor (color)
			wel_set_background_color (background_color_imp)
		end

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		local
			wel: WEL_CHARACTER_FORMAT
		do
			wel ?= format.implementation
			set_character_format_selection (wel)
		end

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		do
			Result := find (str, True, 0) + 1
		end

	index_from_position (value_x, value_y: INTEGER): INTEGER is
			-- One-based character index of the character which is
			-- the nearest to `a_x' and `a_y' position in the client
			-- area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area. The coordinates are truncated
			-- to integer values and are in screen units relative
			-- to the upper-left corner of the client area of the
			-- control.
		do
			Result := character_index_from_position (value_x, value_y) + 1
		end

	position_from_index (value: INTEGER): EV_COORDINATES is
			-- Coordinates of a character at `value' in
			-- the client area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area.
			-- The coordinates are truncated to integer values and
			-- are in screen units relative to the upper-left
			-- corner of the client area of the control.
		local
			wel: WEL_POINT
		do
			wel := position_from_character_index (value - 1)
			!! Result.set (wel.x, wel.y)
		end

end -- class EV_RICH_TEXT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
