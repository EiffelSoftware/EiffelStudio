indexing
	description	: "List View State Image List (TVSIL) constants."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVSIL_CONSTANTS

feature -- Access

	Lvsil_normal: INTEGER is
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the large icons.
		external
			"C [macro %"commctrl.h%"]"
		alias
			"LVSIL_NORMAL"
		end

	Lvsil_small: INTEGER is
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the small icons.
		external
			"C [macro %"commctrl.h%"]"
		alias
			"LVSIL_SMALL"
		end

	Lvsil_state: INTEGER is
			-- Indicates the state image list. You can use state 
			-- images to indicate application-defined item states. 
			-- A state image is displayed to the left of an item's
			-- selected or nonselected image.
		external
			"C [macro %"commctrl.h%"]"
		alias
			"LVSIL_STATE"
		end

end -- class WEL_LVSIL_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2000 Interactive Software Engineering Inc.
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

