indexing
	description: "Tree view action flag (TVAF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVAF_CONSTANTS

feature -- Access

	Tvc_bykeyboard: INTEGER is
			-- Used for the `Tvn_selchanged' and `Tvn_selchanging'
			-- notification messages.
			-- Action done by a key stroke.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVC_BYKEYBOARD"
		end

	Tvc_bymouse: INTEGER is
			-- Used for the `Tvn_selchanged' and `Tvn_selchanging'
			-- notification messages.
			-- Action done by a mouse click.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVC_BYMOUSE"
		end

	Tvc_unknown: INTEGER is
			-- Used for the `Tvn_selchanged' or `Tvn_selchanging'
			-- notification messages.
			-- Action done by unknown.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVC_UNKNOWN"
		end

	Tve_collapse: INTEGER is
			-- Used for the `Tvn_expand' or `Tvn_expanding'
			-- notification messages.
			-- Action done by collapsing the list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVE_COLLAPSE"
		end

	Tve_collapsereset: INTEGER is
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by collapsing the list and removing
			-- the child items.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVE_COLLAPSERESET"
		end

	Tve_expand: INTEGER is
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by expanding the list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVE_EXPAND"
		end

	Tve_toggle: INTEGER is
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by changing the list of the list 
			-- between collapse and expand.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVE_TOGGLE"
		end

end -- class WEL_TVAF_CONSTANTS

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
