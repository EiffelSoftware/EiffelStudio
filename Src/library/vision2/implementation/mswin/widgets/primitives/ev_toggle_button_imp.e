indexing
	description: "EiffelVision Toggle button.%
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		undefine
			build
		end

	EV_BUTTON_IMP
		undefine
			default_style
		end

	WEL_SELECTABLE_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
			remove_command,
			set_width,
			set_height,
			destroy,
			set_text,
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

feature -- Status report
	
	pressed: BOOLEAN is
			-- Is toggle pressed
		do
			Result := checked
		end 

feature -- Status setting

	set_pressed (button_pressed: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if button_pressed then
				set_checked
			else
				set_unchecked
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_pressed (not pressed)
		end

feature -- Event - command association
	
	add_toggle_command (a_command: EV_COMMAND; 
			    arguments: EV_ARGUMENTS) is	
		do
			
		end	

end -- class EV_TOGGLE_BUTTON_IMP

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
