indexing
	description: "List view item styles (LVIS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVIS_CONSTANTS

feature -- Access

	Lvis_cut: INTEGER is
		-- The item is marked for a cut and paste operation.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVIS_CUT"
		end

	Lvis_drophilited: INTEGER is
		-- The item is highlighted as a drag-and-dop target.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVIS_DROPHILITED"
		end

	Lvis_focused: INTEGER is
		-- The item has the focus.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVIS_FOCUSED"
		end

	Lvis_selected: INTEGER is
		-- The item is selected.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVIS_SELECTED"
		end

feature -- Status report

	valid_lvis_constants (value: INTEGER): BOOLEAN is
			-- Is `value' a valid constant?
		do
			Result := value = Lvis_cut or else
				value = Lvis_drophilited or else
				value = Lvis_focused or else
				value = Lvis_selected
		end 

end -- class WEL_LVIS_CONSTANTS

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

