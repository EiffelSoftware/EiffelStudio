indexing
	description:
		"Eiffel Vision constants. Each constant defined here %N%
		%corresponds to a possible value of {EV_KEY}.code"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY_CONSTANTS

feature -- Contract support

	valid_key_code (a_code: INTEGER): BOOLEAN is
			-- Is `a_code' a valid key code?
		do
			Result := a_code >= Key_0 and then a_code <= Key_z
		end

feature -- Constants
--| Please do not get the bright idea of separating these constants in
--| separate feature clauses. See ETL's section about the unique keyword.
--| Also, do not change the order. New key codes can be added at the end of the
--| feature clause.

	Key_0: INTEGER is unique
			-- Code representing "0". 

	Key_1: INTEGER is unique
			-- Code representing "1". 

	Key_2: INTEGER is unique
			-- Code representing "2". 

	Key_3: INTEGER is unique
			-- Code representing "3". 

	Key_4: INTEGER is unique
			-- Code representing "4". 

	Key_5: INTEGER is unique
			-- Code representing "5". 

	Key_6: INTEGER is unique
			-- Code representing "6". 

	Key_7: INTEGER is unique
			-- Code representing "7". 

	Key_8: INTEGER is unique
			-- Code representing "8". 

	Key_9: INTEGER is unique
			-- Code representing "9". 

	Key_numpad0: INTEGER is unique
			-- Code representing numeric keypad "0".

	Key_numpad1: INTEGER is unique
			-- Code representing numeric keypad "1". 

	Key_numpad2: INTEGER is unique
			-- Code representing numeric keypad "2". 

	Key_numpad3: INTEGER is unique
			-- Code representing numeric keypad "3". 

	Key_numpad4: INTEGER is unique
			-- Code representing numeric keypad "4". 

	Key_numpad5: INTEGER is unique
			-- Code representing numeric keypad "5". 

	Key_numpad6: INTEGER is unique
			-- Code representing numeric keypad "6". 

	Key_numpad7: INTEGER is unique
			-- Code representing numeric keypad "7". 

	Key_numpad8: INTEGER is unique
			-- Code representing numeric keypad "8". 

	Key_numpad9: INTEGER is unique
			-- Code representing numeric keypad "9". 

	Key_num_add: INTEGER is unique
			-- Code representing numeric keypad "+". 

	Key_num_divide: INTEGER is unique
			-- Code representing numeric keypad "/". 

	Key_num_multiply: INTEGER is unique
			-- Code representing numeric keypad "*". 

	Key_num_lock: INTEGER is unique
			-- Code representing Num Lock.

	Key_num_subtract: INTEGER is unique
			-- Code representing numeric keypad "-". 

	Key_num_decimal: INTEGER is unique
			-- Code representing numeric keypad ".". 

	Key_F1: INTEGER is unique
			-- Code representing F1.

	Key_F2: INTEGER is unique
			-- Code representing F2.

	Key_F3: INTEGER is unique
			-- Code representing F3.

	Key_F4: INTEGER is unique
			-- Code representing F4.

	Key_F5: INTEGER is unique
			-- Code representing F5.

	Key_F6: INTEGER is unique
			-- Code representing F6.

	Key_F7: INTEGER is unique
			-- Code representing F7.

	Key_F8: INTEGER is unique
			-- Code representing F8.

	Key_F9: INTEGER is unique
			-- Code representing F9.

	Key_F10: INTEGER is unique
			-- Code representing F10.

	Key_F11: INTEGER is unique
			-- Code representing F11.

	Key_F12: INTEGER is unique
			-- Code representing F12.

	Key_shift: INTEGER is unique
			-- Code representing Shift. Not for accelerators.

	Key_left_shift: INTEGER is unique
			-- Code representing Left Shift. Not for accelerators.

	Key_right_shift: INTEGER is unique
			-- Code representing Right Shift. Not for accelerators.

	Key_control: INTEGER is unique
			-- Code representing Ctrl. Not for accelerators.

	Key_left_control: INTEGER is unique
			-- Code representing Left Ctrl. Not for accelerators.

	Key_right_control: INTEGER is unique
			-- Code representing Right Ctrl. Not for accelerators.

	Key_meta: INTEGER is unique
			-- Code representing Application. Not for accelerators.

	Key_left_meta: INTEGER is unique
			-- Code representing Left Application. Not for accelerators.

	Key_right_meta: INTEGER is unique
			-- Code representing Right Application. Not for accelerators.

	Key_space: INTEGER is unique
			-- Code representing Space.

	Key_back_space: INTEGER is unique
			-- Code representing Back Space. 

	Key_enter: INTEGER is unique
			-- Code representing Enter. 

	Key_escape: INTEGER is unique
			-- Code representing Esc.

	Key_tab: INTEGER is unique
			-- Code representing Tab.

	Key_pause: INTEGER is unique 
			-- Code representing Pause / Break. 

	Key_printscreen: INTEGER is unique
			-- Code representing Print Screen / Sys Rq. Not for accelerators.

	Key_caps_lock: INTEGER is unique
			-- Code representing Caps Lock.

	Key_scroll_lock: INTEGER is unique
			-- Code representing Scroll Lock. 

	Key_comma: INTEGER is unique
			-- Code representing ",". 

	Key_equals: INTEGER is unique
			-- Code representing "=". 
	
	Key_period: INTEGER is unique
			-- Code representing ".".

	Key_semicolon: INTEGER is unique
			-- Code representing ";". 

	Key_open_bracket: INTEGER is unique
			-- Code representing "[". 

	Key_close_bracket: INTEGER is unique
			-- Code representing "]". 

	Key_slash: INTEGER is unique
			-- Code representing "/". 

	Key_back_slash: INTEGER is unique
			-- Code representing "\". 

	Key_quote: INTEGER is unique
			-- Code representing """. 

	Key_back_quote: INTEGER is unique
			-- Code representing "`". 

	Key_dash: INTEGER is unique
			-- Code representing "-".

	Key_up: INTEGER is unique 
			-- Code representing up-arrow. 

	Key_down: INTEGER is unique 
			-- Code representing down-arrow. 

	Key_left: INTEGER is unique 
			-- Code representing left-arrow. 

	Key_right: INTEGER is unique 
			-- Code representing right-arrow. 

	Key_page_up: INTEGER is unique 
			-- Code representing Page Up. 

	Key_page_down: INTEGER is unique 
			-- Code representing Page Down. 

	Key_home: INTEGER is unique 
			-- Code representing Home.

	Key_end: INTEGER is unique 
			-- Code representing End. 

	Key_insert: INTEGER is unique 
			-- Code representing Insert. 

	Key_delete: INTEGER is unique 
			-- Code representing Delete. 

	Key_a: INTEGER is unique
			-- Code representing "a".

	Key_b: INTEGER is unique 
			-- Code representing "b". 

	Key_c: INTEGER is unique 
			-- Code representing "c". 

	Key_d: INTEGER is unique 
			-- Code representing "d". 

	Key_e: INTEGER is unique 
			-- Code representing "e". 

	Key_f: INTEGER is unique 
			-- Code representing "f". 

	Key_g: INTEGER is unique 
			-- Code representing "g". 

	Key_h: INTEGER is unique 
			-- Code representing "h". 

	Key_i: INTEGER is unique 
			-- Code representing "i". 

	Key_j: INTEGER is unique 
			-- Code representing "j". 

	Key_k: INTEGER is unique 
			-- Code representing "k". 

	Key_l: INTEGER is unique 
			-- Code representing "l". 

	Key_m: INTEGER is unique 
			-- Code representing "m". 

	Key_n: INTEGER is unique 
			-- Code representing "n". 

	Key_o: INTEGER is unique 
			-- Code representing "o". 

	Key_p: INTEGER is unique 
			-- Code representing "p". 
 
	Key_q: INTEGER is unique 
			-- Code representing "q". 

	Key_r: INTEGER is unique 
			-- Code representing "r". 

	Key_s: INTEGER is unique 
			-- Code representing "s". 

	Key_t: INTEGER is unique 
			-- Code representing "t". 

	Key_u: INTEGER is unique 
			-- Code representing "u". 

	Key_v: INTEGER is unique 
			-- Code representing "v". 

	Key_w: INTEGER is unique 
			-- Code representing "w". 

	Key_x: INTEGER is unique 
			-- Code representing "x". 

	Key_y: INTEGER is unique 
			-- Code representing "y". 

	Key_z: INTEGER is unique 
			-- Code representing "z". 

end -- class EV_KEY_CONSTANTS

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/03/15 19:37:57  brendel
--| Added feature `valid_key_code'.
--| Improved comments.
--|
--| Revision 1.1  2000/03/15 18:49:18  brendel
--| Constants for {EV_KEY}.code.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

