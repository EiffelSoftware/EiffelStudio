indexing
	description: "Tree view item flag (TVIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVIF_CONSTANTS

feature -- Access

	Tvif_children: INTEGER is
			-- The cChildren member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_CHILDREN"
		end

	Tvif_image: INTEGER is
			-- The iImage member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_IMAGE"
		end

	Tvif_param: INTEGER is
			-- The lParam member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_PARAM"
		end

	Tvif_selectedimage: INTEGER is
			-- The iSelectedImage member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_SELECTEDIMAGE"
		end

	Tvif_state: INTEGER is
			-- The state and stateMask members are valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_STATE"
		end

	Tvif_text: INTEGER is
			-- The pszText and cchTextMax members are valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_TEXT"
		end

	Tvif_handle: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIF_HANDLE"
		end

end -- class WEL_TVIF_CONSTANTS

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

