indexing 
	description:
		" EiffelVision text. A text area that contains%
		% a rich text."
	note: "It doesn't inherit from EV_TEXT_AREA_IMP because%
		% it is different from the WEL hierarchy."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I

	EV_TEXT_AREA_IMP
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
			selection_end,
			selection_start,
			set_selection,
			has_selection,
			set_text_limit
		redefine
			set_background_color
		end

	WEL_RICH_EDIT
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			set_background_color as wel_set_background_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all
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
			wel_background_color,
			wel_foreground_color,
			on_en_change
		end

creation
	make,
	make_with_text

feature -- Element change

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			{EV_TEXT_AREA_IMP} Precursor (color)
			wel_set_background_color (background_color_imp)
		end

end -- class EV_TEXT

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
