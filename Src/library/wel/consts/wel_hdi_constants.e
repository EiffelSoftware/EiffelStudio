indexing
	description: "Mask flags that indicate which of the %
					 %structure members of WEL_HD_ITEM contain valid data."
	legal: "See notice at end of class."
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
		
	frozen Hdi_image: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_IMAGE"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_HDI_CONSTANTS

