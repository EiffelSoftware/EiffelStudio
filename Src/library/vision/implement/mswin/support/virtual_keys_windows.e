indexing
	description: "This class represents the MS WINDOWS virtual keys."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	VIRTUAL_KEYS_WINDOWS

inherit
	WEL_VK_CONSTANTS

feature

	virtual_keys: ARRAY [STRING] is
		local
			i : INTEGER
		once
			!! Result.make (0,255)
			from
				i := 0
			variant
				256 - i
			until
				i > 255
			loop
				Result.put ("", i)
				i := i + 1
			end
			Result.put ("LBUTTON", Vk_lbutton) 
			Result.put ("RBUTTON", Vk_rbutton) 
			Result.put ("CANCEL", Vk_cancel) 
			Result.put ("MBUTTON", Vk_mbutton) 
			Result.put ("BACK", Vk_back)
			Result.put ("TAB", Vk_tab)
			Result.put ("CLEAR", Vk_clear)
			Result.put ("RETURN", Vk_return)
			Result.put ("SHIFT", Vk_shift)
			Result.put ("CONTROL", Vk_control)
			Result.put ("MENU", Vk_menu)
			Result.put ("PAUSE", Vk_pause)
			Result.put ("CAPITAL", Vk_capital)
			Result.put ("ESCAPE", Vk_escape)
			Result.put ("SPACE", Vk_space)
			Result.put ("PRIOR", Vk_prior)
			Result.put ("NEXT", Vk_next)
			Result.put ("END", Vk_end)
			Result.put ("HOME", Vk_home)
			Result.put ("LEFT", Vk_left)
			Result.put ("UP", Vk_up)
			Result.put ("RIGHT", Vk_right)
			Result.put ("DOWN", Vk_down)
			Result.put ("SELECT", Vk_select)
			Result.put ("PRINT", Vk_print)
			Result.put ("EXECUTE", Vk_execute)
			Result.put ("SNAPSHOT", Vk_snapshot)
			Result.put ("INSERT", Vk_insert)
			Result.put ("DELETE", Vk_delete)
			Result.put ("HELP", Vk_help)

			Result.put ("0", 48)
			Result.put ("1", 49)
			Result.put ("2", 50)
			Result.put ("3", 51)
			Result.put ("4", 52)
			Result.put ("5", 53)
			Result.put ("6", 54)
			Result.put ("7", 55)
			Result.put ("8", 56)
			Result.put ("9", 57)
			Result.put ("A", 65)
			Result.put ("B", 66)
			Result.put ("C", 67)
			Result.put ("D", 68)
			Result.put ("E", 69)
			Result.put ("F", 70)
			Result.put ("G", 71)
			Result.put ("H", 72)
			Result.put ("I", 73)
			Result.put ("J", 74)
			Result.put ("K", 75)
			Result.put ("L", 76)
			Result.put ("M", 77)
			Result.put ("N", 78)
			Result.put ("O", 79)
			Result.put ("P", 80)
			Result.put ("Q", 81)
			Result.put ("R", 82)
			Result.put ("S", 83)
			Result.put ("T", 84)
			Result.put ("U", 85)
			Result.put ("V", 86)
			Result.put ("W", 87)
			Result.put ("X", 88)
			Result.put ("Y", 89)
			Result.put ("Z", 90)

			Result.put ("NUMPAD0", Vk_numpad0)
			Result.put ("NUMPAD1", Vk_numpad1)
			Result.put ("NUMPAD2", Vk_numpad2)
			Result.put ("NUMPAD3", Vk_numpad3)
			Result.put ("NUMPAD4", Vk_numpad4)
			Result.put ("NUMPAD5", Vk_numpad5)
			Result.put ("NUMPAD6", Vk_numpad6)
			Result.put ("NUMPAD7", Vk_numpad7)
			Result.put ("NUMPAD8", Vk_numpad8)
			Result.put ("NUMPAD9", Vk_numpad9)
			Result.put ("MULTIPLY", Vk_multiply)
			Result.put ("ADD", Vk_add)
			Result.put ("SEPARATOR", Vk_separator)
			Result.put ("SUBTRACT", Vk_subtract)
			Result.put ("DECIMAL", Vk_decimal)
			Result.put ("DIVIDE", Vk_divide)
			Result.put ("F1", Vk_f1)
			Result.put ("F2", Vk_f2)
			Result.put ("F3", Vk_f3)
			Result.put ("F4", Vk_f4)
			Result.put ("F5", Vk_f5)
			Result.put ("F6", Vk_f6)
			Result.put ("F7", Vk_f7)
			Result.put ("F8", Vk_f8)
			Result.put ("F9", Vk_f9)
			Result.put ("F10", Vk_f10)
			Result.put ("F11", Vk_f11)
			Result.put ("F12", Vk_f12)
			Result.put ("F13", Vk_f13)
			Result.put ("F14", Vk_f14)
			Result.put ("F15", Vk_f15)
			Result.put ("F16", Vk_f16)
			Result.put ("F17", Vk_f17)
			Result.put ("F18", Vk_f18)
			Result.put ("F19", Vk_f19)
			Result.put ("F20", Vk_f20)
			Result.put ("F21", Vk_f21)
			Result.put ("F22", Vk_f22)
			Result.put ("F23", Vk_f23)
			Result.put ("F24", Vk_f24)
			Result.put ("NUMLOCK", Vk_numlock)
			Result.put ("SCROLL", Vk_scroll)
		end


end -- class VIRTUAL_KEYS_WINDOWS


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

