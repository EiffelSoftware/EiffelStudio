indexing
	description: "Format flags for feature format of class WEL_HD_ITEM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDF_CONSTANTS

feature -- Access

	frozen Hdf_center: INTEGER is
			-- Centers the contents of the item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_CENTER"
		end

	frozen Hdf_left: INTEGER is
			-- Left aligns the contents of the item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_LEFT"
		end

	frozen Hdf_right: INTEGER is
			-- Right aligns the contents of the item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_RIGHT"
		end

	frozen Hdf_justify_mask: INTEGER is
			-- You can use this mask to isolate the text justification 
			-- portion of the fmt member. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_JUSTIFYMASK"
		end

	frozen Hdf_owner_draw: INTEGER is
			-- The owner window of the header control draws the item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_OWNERDRAW"
		end

	frozen Hdf_bitmap: INTEGER is
			-- The item displays a bitmap.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_BITMAP"
		end

	frozen Hdf_string: INTEGER is
			-- The item displays a string. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_STRING"
		end
		
	frozen Hdf_image: INTEGER is
			-- The item displays an image from an image list. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_IMAGE"
		end

	frozen Hdf_rtl_reading: INTEGER is
			-- In addition, on Hebrew or Arabic systems you can specify this flag 
			-- to display text using right-to-left reading order. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_RTLREADING"
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




end -- class WEL_HDM_CONSTANTS

