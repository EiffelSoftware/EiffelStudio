indexing
	description: "Tree view item state (TVIS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVIS_CONSTANTS

feature -- Access

	Tvis_bold: INTEGER is
			-- The cChildren member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_BOLD"
		end

	Tvis_cut: INTEGER is
			-- The iImage member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_CUT"
		end

	Tvis_drophilited: INTEGER is
			-- The lParam member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_DROPHILITED"
		end

	Tvis_expanded: INTEGER is
			-- The iSelectedImage member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_EXPANDED"
		end

	Tvis_expandedonce: INTEGER is
			-- The state and stateMask members are valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_EXPANDEDONCE"
		end

	Tvis_overlaymask: INTEGER is
			-- The pszText and cchTextMax members are valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_OVERLAYMASK"
		end

	Tvis_selected: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_SELECTED"
		end

	Tvis_stateimagemask: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_STATEIMAGEMASK"
		end

	Tvis_usermask: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVIS_USERMASK"
		end

feature -- Status report

	valid_tvis_constants (value: INTEGER): BOOLEAN is
			-- Is `value' a valid constant?
		do
			Result := value = Tvis_cut or else
					value = Tvis_drophilited or else
					value = Tvis_expanded or else
					value = Tvis_expandedonce or else
					value = Tvis_overlaymask or else
					value = Tvis_selected or else
					value = Tvis_stateimagemask or else
					value = Tvis_usermask
		end 

end -- class WEL_TVIS_CONSTANTS

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
