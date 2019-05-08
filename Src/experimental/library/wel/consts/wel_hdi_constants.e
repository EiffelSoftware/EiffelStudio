note
	description: "Mask flags that indicate which of the %
					 %structure members of WEL_HD_ITEM contain valid data."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDI_CONSTANTS

feature -- Access

	frozen Hdi_bitmap: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_BITMAP"
		ensure
			is_class: class
		end

	frozen Hdi_format: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_FORMAT"
		ensure
			is_class: class
		end

	frozen Hdi_height: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_HEIGHT"
		ensure
			is_class: class
		end

	frozen Hdi_lparam: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_LPARAM"
		ensure
			is_class: class
		end

	frozen Hdi_text: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_TEXT"
		ensure
			is_class: class
		end

	frozen Hdi_width: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_WIDTH"
		ensure
			is_class: class
		end

	frozen Hdi_image: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDI_IMAGE"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
