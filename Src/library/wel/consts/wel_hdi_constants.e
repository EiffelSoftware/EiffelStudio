indexing
	description: "Mask flags that indicate which of the %
					 %structure members of WEL_HD_ITEM contain valid data."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDI_CONSTANTS

feature -- Access

	frozen Hdi_bitmap: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_BITMAP"
		end

	frozen Hdi_format: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_FORMAT"
		end

	frozen Hdi_height: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_HEIGHT"
		end

	frozen Hdi_lparam: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_LPARAM"
		end

	frozen Hdi_text: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_TEXT"
		end

	frozen Hdi_width: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_WIDTH"
		end

end -- class WEL_HDI_CONSTANTS

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

