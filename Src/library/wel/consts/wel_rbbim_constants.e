indexing
	description: "Rebar Band Mask (RBBIM) messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RBBIM_CONSTANTS

feature -- Access

	Rbbim_style: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_STYLE"
		end

	Rbbim_colors: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_COLORS"
		end

	Rbbim_text: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_TEXT"
		end

	Rbbim_image: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_IMAGE"
		end

	Rbbim_child: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_CHILD"
		end

	Rbbim_childsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_CHILDSIZE"
		end

	Rbbim_size: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_SIZE"
		end

	Rbbim_background: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_BACKGROUND"
		end

	Rbbim_id: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBIM_ID"
		end

end -- class WEL_RBBIM_CONSTANTS


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

