indexing
	description: 
		"EiffelVision menu bar. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_MENU_BAR_IMP

--inherit
--	EV_MENU_BAR_I

--	EV_MENU_ITEM_HOLDER_IMP
--		rename
--			make as wel_make
--		end
	
--	EV_WIDGET_IMP
--		rename
--			exists as widget_exists
--		end

--	WEL_MENU
--		rename
--			make as wel_make
--		select
--			exists
--		end

--	WEL_TOOL_BAR
--		rename
--			make as wel_make,
--			parent as wel_parent,
--			font as wel_font,
--			set_font as wel_set_font
--		undefine
--			-- We undefine the features redefined by EV_WIDGET_IMP,
--			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
--			remove_command,
--			set_width,
--			set_height,
--			destroy,
--			set_text,
--			on_left_button_down,
--			on_right_button_down,
--			on_left_button_up,
--			on_right_button_up,
--			on_left_button_double_click,
--			on_right_button_double_click,
--			on_mouse_move,
--			on_char,
--			on_key_up
--		end

--creation
--	make
	
end -- class EV_WEL_MENU_BAR_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
