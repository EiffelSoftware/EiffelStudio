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

create

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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

