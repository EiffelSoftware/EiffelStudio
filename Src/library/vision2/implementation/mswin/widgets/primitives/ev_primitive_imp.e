indexing

	description: 
		"EiffelVision primitive, mswin implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_PRIMITIVE_IMP
	
inherit
	EV_PRIMITIVE_I	

	EV_WIDGET_IMP
		
	EV_SIZEABLE_IMP

	WEL_CONTROL
		rename
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font
		undefine
				-- We undefine the features that are redefine by WEL objects
			width,
			height,
			set_text,
			text_length,
			default_ex_style,
			set_default_window_procedure,
			call_default_window_procedure,
			process_notification,
				-- We undefine what was redefine by EV_WIDGET_IMP
			set_height,
			set_width,
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		redefine
			destroy
		end		

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			{WEL_CONTROL} Precursor
		end

end -- class EV_PRIMITIVE_IMP

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
