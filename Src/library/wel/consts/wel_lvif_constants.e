indexing
	description: "List view item flag (LVIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVIF_CONSTANTS

feature -- Access

	Lvif_text: INTEGER is
			-- The pszText member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVIF_TEXT"
		end

	Lvif_image: INTEGER is
			-- The iImage member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVIF_IMAGE"
		end

	Lvif_param: INTEGER is
			-- The lParam member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"LVIF_PARAM"
		end

	Lvif_state: INTEGER is
			-- The state member is valid
		external
			"C [macro <cctrl.h>]"
		alias
			"LVIF_STATE"
		end

end -- class WEL_LVIF_CONSTANTS

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
--|----------------------------------------------------------------
