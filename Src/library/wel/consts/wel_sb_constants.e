indexing
	description: "ScrollBar (SB) messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SB_CONSTANTS

feature -- Access

	Sb_lineup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_LINEUP"
		end

	Sb_lineleft: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_LINELEFT"
		end

	Sb_linedown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_LINEDOWN"
		end

	Sb_lineright: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_LINERIGHT"
		end

	Sb_pageup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_PAGEUP"
		end

	Sb_pageleft: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_PAGELEFT"
		end

	Sb_pagedown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_PAGEDOWN"
		end

	Sb_pageright: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_PAGERIGHT"
		end

	Sb_thumbposition: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_THUMBPOSITION"
		end

	Sb_thumbtrack: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_THUMBTRACK"
		end

	Sb_top: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_TOP"
		end

	Sb_left: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_LEFT"
		end

	Sb_bottom: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_BOTTOM"
		end

	Sb_right: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_RIGHT"
		end

	Sb_endscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_ENDSCROLL"
		end

	Sb_horz: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_HORZ"
		end

	Sb_vert: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_VERT"
		end

	Sb_ctl: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_CTL"
		end

	Sb_both: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SB_BOTH"
		end

end -- class WEL_SB_CONSTANTS

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

