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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

