indexing
	description: "Represents structure that is sent to the OS to add,%
					 %modify, inspect, ... items of a WEL_HEADER_CONTROL"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HD_ITEM

inherit
	WEL_STRUCTURE
	
	WEL_BIT_OPERATIONS
		undefine
			copy, is_equal
		end
		
	WEL_HDF_CONSTANTS
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

feature -- Access

	mask: INTEGER is
			-- Mask flags that indicate which of the other structure
			-- members contain valid data.
			-- Constants may be combined.
			-- The valid constants can be found in class WEL_HDI_CONSTANTS
		require
			exists: exists
		do
			Result := cwel_hd_item_get_mask (item)
		end	

	text: STRING is
			-- Text of the button associated with the notification.
		require
			exists: exists
		do
			create Result.make (0)
			Result.from_c (cwel_hd_item_get_psz_text (item))
		end

	text_count: INTEGER is
			-- Count of characters in the button text.
		require
			exists: exists
		do
			Result := cwel_hd_item_get_cch_text_max (item)
		ensure
			positive_result: Result >= 0
		end

	width: INTEGER is
			-- Width of item (Only available when mask contains `Hdi_width'
		require
			exists: exists
			good_mask: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_width)
		do
			Result := cwel_hd_item_get_cxy (item)
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER is
			-- Height of item (Only available when mask contains `Hdi_height'
		require
			exists: exists
			good_mask: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_height)
		do
			Result := cwel_hd_item_get_cxy (item)
		ensure
			positive_result: Result >= 0
		end
		
	format: INTEGER is
			-- A set of bit flags that specify the item's format. 
			-- Constants are defined in class WEL_HDF_CONSTANTS.
			-- Constants may be combined.
		require
			exists: exists
			good_mask: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_format)
		do
			Result := cwel_hd_item_get_fmt (item)
		end
		
	bitmap_handle: POINTER is
			-- Handle to item bitmap. 
		require
			exists: exists
			good_mask: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_bitmap)
		do
			Result := cwel_hd_item_get_hbm (item)
		end
	
	custom_data: INTEGER is
			-- Application-defined item data. 
		require
			exists: exists
			good_mask: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_lparam)
		do
			Result := cwel_hd_item_get_l_param (item)
		end

	iimage: INTEGER is
			-- Zero-based index of an image within the image list.
		require
			exists: exists
		do
			Result := cwel_hditem_get_iimage (item)
		end

feature -- Element change

	set_mask (value: INTEGER) is
			-- Sets mask flags that indicate which of the other structure
			-- members contain valid data.
			-- Constants may be combined.
			-- The valid constants can be found in class WEL_HDI_CONSTANTS
		require
			exists: exists
		do
			cwel_hd_item_set_mask (item, value)
		end	

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
			-- Also Updates `text_count' and `mask'
		require
			text_not_void: a_text /= Void
		local
			str_text: WEL_STRING
		do
			create str_text.make (a_text)
			cwel_hd_item_set_psz_text (item, str_text.item)
			cwel_hd_item_set_cch_text_max (item, str_text.length)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.Hdi_text))
			set_format (clear_flag (format, hdf_bitmap))
			set_format (set_flag (format, hdf_string))
		ensure
			text_set: text.is_equal (a_text)
			text_count_set: a_text.count = text_count
			mask_set: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_text)
		end

	set_width (value: INTEGER) is
			-- Sets width of item with `value'
			-- Also updates `mask'
			-- Note: You can only specify either the width or the height
		require
			exists: exists
			positive_value: value >= 0
		do
			cwel_hd_item_set_cxy (item, value)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.Hdi_height))
		ensure
			mask_set: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_width)
		end

	set_height (value: INTEGER) is
			-- Sets height of item with `value'
			-- Also updates `mask'
			-- Note: You can only specify either the width or the height
		require
			exists: exists
			positive_value: value >= 0
		do
			cwel_hd_item_set_cxy (item, value)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.Hdi_width))
		ensure
			mask_set: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_height)
		end


	set_format (value: INTEGER) is
			-- Sets a set of bit flags that specify the item's format. 
			-- Constants are defined in class WEL_HDF_CONSTANTS.
			-- Constants may be combined.
			-- Also updates `mask'
		require
			exists: exists
		do
			cwel_hd_item_set_fmt (item, value)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.Hdi_format))
		ensure
			mask_set: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_format)
		end
		
	set_bitmap (a_bitmap: WEL_BITMAP) is
			-- Sets item bitmap. 
			-- Also updates `mask'
		require
			exists: exists
			bitmap_exsits: a_bitmap.exists
		do
			cwel_hd_item_set_hbm (item, a_bitmap.item)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.Hdi_bitmap))
		ensure
			mask_set: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_bitmap)
		end

	set_custom_data (value: INTEGER) is
			-- Sets application-defined item data. 
			-- Also updates `mask'
		require
			exists: exists
		do
			cwel_hd_item_set_l_param (item, value)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.Hdi_lparam))
		ensure
			mask_set: flag_set (mask, feature {WEL_HDI_CONSTANTS}.Hdi_lparam)
		end
		
	set_iimage (an_index: INTEGER) is
			-- Zero-based index of an image within the image list.
		require
			exists: exists
			an_index_positive: an_index >= 0
		do
			cwel_hditem_set_iimage (item, an_index)
			set_mask (set_flag (mask, feature {WEL_HDI_CONSTANTS}.hdi_image))
			set_format (set_flag (format, feature {WEL_HDF_CONSTANTS}.hdf_image))
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_hd_item
		end

feature {NONE} -- Externals

	c_size_of_hd_item: INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (HDITEM)"
		end

	cwel_hd_item_get_mask (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_INTEGER"
		end

	cwel_hd_item_set_mask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, UINT)"
		end

	cwel_hd_item_get_cxy (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_INTEGER"
		end

	cwel_hd_item_set_cxy (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, int)"
		end

	cwel_hd_item_get_psz_text (ptr: POINTER): POINTER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_POINTER"
		end

	cwel_hd_item_set_psz_text (ptr: POINTER; value: POINTER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, LPTSTR)"
		end

	cwel_hd_item_get_hbm (ptr: POINTER): POINTER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_POINTER"
		end

	cwel_hd_item_set_hbm (ptr: POINTER; value: POINTER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, HBITMAP)"
		end

	cwel_hd_item_get_cch_text_max (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_INTEGER"
		end

	cwel_hd_item_set_cch_text_max (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, int)"
		end

	cwel_hd_item_get_fmt (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_INTEGER"
		end

	cwel_hd_item_set_fmt (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, int)"
		end

	cwel_hd_item_get_l_param (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_item.h%"] (HDITEM*): EIF_INTEGER"
		end

	cwel_hd_item_set_l_param (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_item.h%"] (HDITEM*, LPARAM)"
		end
		
	cwel_hditem_get_iimage (ptr: POINTER): INTEGER is
		external
			"C [struct %"commctrl.h%"] (HDITEM): EIF_INTEGER"
		alias
			"iImage"
		end
		
	cwel_hditem_set_iimage (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"commctrl.h%"] (HDITEM, EIF_INTEGER)"
		alias
			"iImage"
		end

end -- class WEL_HDI_ITEM

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

