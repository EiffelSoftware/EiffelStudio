indexing
	description	: "Button message (BM_...) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_BM_CONSTANTS

feature -- Access

	Bm_getcheck: INTEGER is 240
			-- An application sends a BM_GETCHECK message to retrieve the 
			-- check state of a radio button or check box. 

	Bm_getimage: INTEGER is 246
			-- An application sends a BM_GETIMAGE message to retrieve a 
			-- handle to the image (icon or bitmap) associated with the button.

	Bm_getstate: INTEGER is 242
			-- An application sends a BM_GETSTATE message to determine the 
			-- state of a button or check box. 

	Bm_setcheck: INTEGER is 241
			-- An application sends a BM_SETCHECK message to set the check 
			-- state of a radio button or check box. 

	Bm_setimage: INTEGER is 247
			-- An application sends a BM_SETIMAGE message to associate a new 
			-- image (icon or bitmap) with the button.

	Bm_setstate: INTEGER is 243
			-- An application sends a BM_SETSTATE message to change the highlight 
			-- state of a button. The highlight state indicates whether the button 
			-- is highlighted as if the user had pushed it.

	Bm_setstyle: INTEGER is 244
			-- An application sends a BM_SETSTYLE message to change the style 
			-- of a button. 

	Bm_click: INTEGER is 245
			-- An application sends a BM_CLICK message to simulate the user clicking 
			-- a button. This message causes the button to receive the WM_LBUTTONDOWN 
			-- and WM_LBUTTONUP messages, and the button's parent window to receive 
			-- a BN_CLICKED notification message.

end -- class WEL_BM_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

