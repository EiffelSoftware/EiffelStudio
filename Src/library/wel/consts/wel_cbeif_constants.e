indexing
	description: "Combo-Box-Ex Item Flag (CBEIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBEIF_CONSTANTS

feature -- Access

	Cbeif_text: INTEGER is
			-- The `text' member is valid or must be filled in.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_TEXT"
		end

	Cbeif_image: INTEGER is
			-- The `image' member is valid or must be filled in.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_IMAGE"
		end

	Cbeif_selectedimage: INTEGER is
			-- The `selected_image' member is valid or must be
			-- filled in.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_SELECTEDIMAGE"
		end

	Cbeif_overlay: INTEGER is
			-- The `overlay' member is valid or must be filled in.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_OVERLAY"
		end

	Cbeif_indent: INTEGER is
			-- The `indent' member is valid or must be filled in.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_INDENT"
		end

	Cbeif_lparam: INTEGER is
			-- The `lparam' member is valid or must be filled in.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_LPARAM"
		end

	Cbeif_di_setitem: INTEGER is
			-- The control should store the item data and not ask
			-- for it again. This flag is used only with the
			-- CBEN_GETDISPINFO notification message.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEIF_DI_SETITEM"
		end

end -- class WEL_CBEIF_CONSTANTS

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
