indexing
	description: "This class represents a scroll bar for scales";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SCALE_SCROLL_BAR_WINDOWS

inherit

	WEL_SCROLL_BAR
		redefine
			parent,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_mouse_move
		end

creation

	make_vertical, 
	make_horizontal

feature -- Access

	parent: SCALE_IMP
			-- parent of current scroll bar

	on_left_button_down (keys, a_x, a_y: INTEGER) is
			-- Respond to a 'left button down message'.
		do
			parent.on_left_button_down (keys, a_x + x, a_y + y)
		end		

	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a 'left button up message'.
		do
			parent.on_left_button_up (keys, a_x + x, a_y + y)
		end		

	on_right_button_down (keys, a_x, a_y: INTEGER) is
			-- Respond to a `right button down message'.
		do
			parent.on_right_button_down (keys, a_x + x, a_y + y)
		end		

	on_right_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a `right button up message'.
		do
			parent.on_right_button_up (keys, a_x + x, a_y + y)
		end		

	on_mouse_move (keys, a_x, a_y: INTEGER) is
			-- Respond to a `mouse move message'.
		do
			parent.on_mouse_move (keys, a_x + x, a_y + y)
		end		

end -- class SCALE_SCROLLBAR_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

