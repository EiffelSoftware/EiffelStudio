indexing
	description: "EiffelVision text component. %
				  % Mswindows implementation"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_TEXT_COMPONENT_IMP

inherit

	EV_TEXT_COMPONENT_I

	EV_PRIMITIVE_IMP

	WEL_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font
		undefine
			-- We undefine the features that are redefine by WEL objects
			height,
			process_notification,
			unselect,
			text_length,
			class_name,
			default_ex_style,
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
			remove_command,
			set_width,
			set_height,
			destroy,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		end

feature -- Access

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := caret_position
		end

feature -- Status setting

	insert_text (txt: STRING) is
			-- Add `txt' to the left of `position' 
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.insert (txt, position)
			set_text (temp_text)		
		end

	append_text (txt:STRING) is
			-- append 'txt' into component
		local
			temp_text: STRING
		do
			temp_text := text
			temp_text.append_string (txt)
			set_text (temp_text)
		end

	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		do
			set_position (1)
			insert_text (txt)	
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			set_caret_position (pos)
		end

	set_maximum_line_lenght (lenght: INTEGER) is
			-- Maximum number of charachters on line
		do
			check
				not_yet_implemented: False
			end
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			set_selection (start_pos, end_pos)
		end

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		do
			check
				not_yet_implemented: False
			end
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			check
				not_yet_implemented: False
			end
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			check
				not_yet_implemented: False
			end
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		do
			check
				not_yet_implemented: False
			end
		end

end -- class EV_TEXT_COMPONENT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
