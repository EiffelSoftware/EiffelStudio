indexing
	description: "EiffelVision radio button.%
			% Mswindows implementation"
	author: ""
	date: "$$"
	revision: "$$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		undefine
			build
		end
		
	EV_CHECK_BUTTON_IMP
		undefine
			default_style
		end

	WEL_RADIO_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			set_text as wel_set_text,
			destroy as wel_destroy
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
			remove_command,
			set_width,
			set_height,
--			destroy,
--			set_text,
			on_bn_clicked,
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
		
creation
	make, make_with_text

end -- class EV_RADIO_BUTTON_IMP

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
