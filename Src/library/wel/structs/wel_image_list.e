indexing
	description	: "Object that holds a list of images (Bitmaps or Icons)"
	note		: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to be loaded to use this control."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_IMAGE_LIST

inherit
	WEL_ANY

	WEL_ILC_CONSTANTS
		export {NONE}
			all
		end

creation
	make, make_by_pointer

feature -- Initialization

	make (given_width: INTEGER; given_height: INTEGER; color_depth: INTEGER; masked_bitmap: BOOLEAN) is
			-- Initialization with an empty image list. Images located
			-- in this imageList must have the a width equal to `given_width'
			-- and a height equal to `given_height'. 
			--
			-- The flag `color_depth' determines the color depth of the bitmaps.
			-- (bitmaps with a different color depth than indicated in
			-- `image_type' will automatically be converted)
			-- See Ilc_colorXXXX in WEL_ILC_CONSTANTS for possible values
			--
			-- The flag `masked_bitmap' specify whether we are using Bitmaps with mask, or plain
			-- bitmaps.
		require
			valid_width: given_width > 0
			valid_height: given_height > 0
		local
			mask_flag: INTEGER
		do
				-- remember the width and the height for further check.
			bitmaps_width := given_width
			bitmaps_height := given_height

				-- Create the image list
			if masked_bitmap then
				mask_flag := Ilc_mask
				use_masked_bitmap := True
			end			
			item := cwel_imagelist_create(
						bitmaps_width, 
						bitmaps_height, 
						color_depth + mask_flag, 
						Initial_size, 
						Grow_parameter
					)
		end

feature  -- Removal

	destroy is
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		do
			destroy_item
		end


feature {NONE} -- Removal

	destroy_item is
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		do
				-- destroy the list.
			cwel_imagelist_destroy(item)
			item := Default_pointer
		end


feature -- Access

	last_position: INTEGER
			-- Position of last image inserted/deleted.
			-- updated by `add_image'.

	use_masked_bitmap: BOOLEAN
			-- Does the ImageList contains 'Bitmap+Mask' or
			-- only 'Bitmap'
			--
			-- Note: to use masked bitmap, create the ImageList
			--       using `Ilc_mask + Ilc_colorXXXX' as `image_type'

	count: INTEGER is
			-- Retrieves the number of images in the image list.
		do
			Result := cwel_imagelist_get_image_count(item)
		end


feature -- Basic operations

	add_bitmap (bitmap_to_add: WEL_BITMAP) is
			-- Add the bitmap `bitmap_to_add' into the image list.
		require
			bitmap_not_void: bitmap_to_add /= Void
			compatible_width_for_bitmap: bitmap_to_add.width = bitmaps_width
			compatible_height_for_bitmap: bitmap_to_add.height = bitmaps_height
			exists: exists
		do
			last_position := cwel_imagelist_add(item, bitmap_to_add.item, Default_pointer)
		end

	replace_bitmap (bitmap_to_add: WEL_BITMAP; index: INTEGER) is
			-- Replace the bitmap at position `index' in the imageList by
			-- `bitmap_to_add'.
		require
			bitmap_not_void: bitmap_to_add /= Void
			not_use_masked_bitmap: not use_masked_bitmap
			index_not_too_small: index >= 0
			index_not_too_big: index < count
			exists: exists
		do
			cwel_imagelist_replace(item, index, bitmap_to_add.item, Default_pointer)
		end

	add_masked_bitmap (bitmap_to_add: WEL_BITMAP; bitmap_mask: WEL_BITMAP) is
			-- Add the bitmap `bitmap_to_add' into the image list.
			-- `bitmap_mask' represents the mask for the bitmap.
		require
			bitmap_not_void: bitmap_to_add /= Void
			mask_not_void: bitmap_mask /= Void
			compatible_width_for_bitmap: bitmap_to_add.width = bitmaps_width
			compatible_height_for_bitmap: bitmap_to_add.height = bitmaps_height
			compatible_width_for_mask: bitmap_mask.width = bitmaps_width
			compatible_height_for_mask: bitmap_mask.height = bitmaps_height
			masked_bitmap_in_use: use_masked_bitmap
			exists: exists
		do
			last_position := cwel_imagelist_add(item, bitmap_to_add.item, bitmap_mask.item)
		end

	replace_masked_bitmap(bitmap_to_add: WEL_BITMAP; bitmap_mask: WEL_BITMAP; index: INTEGER) is
			-- Replace the bitmap at position `index' in the imageList by
			-- `bitmap_to_add'.
			-- `bitmap_mask' represents the mask for the bitmap.
		require
			bitmap_not_void: bitmap_to_add /= Void
			mask_not_void: bitmap_mask /= Void
			compatible_width_for_bitmap: bitmap_to_add.width = bitmaps_width
			compatible_height_for_bitmap: bitmap_to_add.height = bitmaps_height
			compatible_width_for_mask: bitmap_mask.width = bitmaps_width
			compatible_height_for_mask: bitmap_mask.height = bitmaps_height
			masked_bitmap_in_use: use_masked_bitmap
			index_not_too_small: index >= 0
			index_not_too_big: index < count
			exists: exists
		do
			cwel_imagelist_replace(item, index, bitmap_to_add.item, bitmap_mask.item)
		end

	add_color_masked_bitmap(bitmap_to_add: WEL_BITMAP; mask_color: WEL_COLOR_REF) is
			-- Add the bitmap `bitmap_to_add' into the image list.
			-- `mask_color' represents the color used to generate the mask. 
			-- Each pixel of this color in the specified bitmap is changed to black
			-- and the corresponding bit in the mask is set to 1.
			--
			-- Note: Bitmaps with color depth greater than 8bpp are not supported

		require
			bitmap_not_void: bitmap_to_add /= Void
			mask_color_not_void: mask_color /= Void
			compatible_width_for_bitmap: bitmap_to_add.width = bitmaps_width
			compatible_height_for_bitmap: bitmap_to_add.height = bitmaps_height
			exists: exists
		do
			last_position := cwel_imagelist_add_masked(item, bitmap_to_add.item, mask_color.item)
		end

	add_icon (icon_to_add: WEL_GRAPHICAL_RESOURCE) is
			-- Adds the icon or cursor `icon_to_add' to this image list
		require
			icon_not_void: icon_to_add /= Void
			exists: exists
		do
			last_position := cwel_imagelist_add_icon(item, icon_to_add.item)
		end

	replace_icon (icon_to_add: WEL_GRAPHICAL_RESOURCE; index: INTEGER) is
			-- Replace the bitmap at position `index' in the imageList by
			-- the cursor or icon `icon_to_add'.
		require
			icon_not_void: icon_to_add /= Void
			index_not_too_small: index >= 0
			index_not_too_big: index < count
			exists: exists
		do
			cwel_imagelist_replace_icon(item, index, icon_to_add.item)
		end

	get_icon (index, flags: INTEGER): WEL_ICON is
		require
			index_not_too_small: index >= 0
			index_not_too_big: index < count
			exists: exists
		do
			create Result.make_by_pointer (cwel_imagelist_get_icon (item, index, flags))
		end
		

	remove_image (index: INTEGER) is
			-- Remove the image at index `index' from the image list.
			--
			-- When an image is removed, the indexes of the remaining images are 
			-- adjusted so that the image indexes always range from zero to one
			-- less than the number of images in the image list. 
			-- For example, if you remove the image at index 0, then image 1 becomes 
			-- image 0, image 2 becomes image 1, and so on. 
		require
			index_not_too_small: index >= 0
			index_not_too_big: index < count
			exists: exists
		local
			success: INTEGER
		do
			success := cwel_imagelist_remove(item, index)
			check
				operation_successful: success /= 0
			end
		end

	remove_all_images (index: INTEGER) is
			-- Remove all images from the image list.
		require
			exists: exists
		local
			success: INTEGER
		do
			success := cwel_imagelist_remove_all(item)
			check
				operation_successful: success /= 0
			end
		end

	set_background_color(new_color: WEL_COLOR_REF) is
			-- Sets the background color for this image list.
		require
			new_color_not_void: new_color /= Void
			exists: exists
 		do
			cwel_imagelist_set_bkcolor (item, new_color.item)
		end

feature -- Status report
	
	bitmaps_width: INTEGER
			-- width of all bitmaps located in this imageList

	bitmaps_height: INTEGER
			-- height of all bitmaps located in this imageList

	get_background_color: WEL_COLOR_REF is
			-- Retrieves the current background color for this image list. 
		require
			exists: exists
		do
			create Result.make_by_color(cwel_imagelist_get_bkcolor(item))
		ensure
			Result_not_void: Result /= Void
		end


feature {NONE} -- Externals

	cwel_imagelist_get_icon (ptr: POINTER; index, flag: INTEGER): POINTER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, int, int): HICON"
		alias
			"ImageList_GetIcon"
		end

	cwel_imagelist_create (cx: INTEGER; cy: INTEGER; flag: INTEGER; c_initial: INTEGER; c_grow: INTEGER): POINTER is
		external
			"C [macro %"wel_image_list.h%"] (int, int, UINT, int, int): HIMAGELIST"
		alias
			"ImageList_Create"
		end

	cwel_imagelist_destroy (ptr: POINTER) is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST)"
		alias
			"ImageList_Destroy"
		end

	cwel_imagelist_add (ptr, bitmap_to_add, mask_bitmap_to_add: POINTER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, HBITMAP, HBITMAP): int"
		alias
			"ImageList_Add"
		end

	cwel_imagelist_replace (ptr: POINTER;  index: INTEGER; bitmap_to_add, mask_bitmap_to_add: POINTER) is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, int, HBITMAP, HBITMAP)"
		alias
			"ImageList_Replace"
		end

	cwel_imagelist_add_masked (ptr: POINTER; bitmap_to_add: POINTER; mask_color: INTEGER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, HBITMAP, COLORREF): int"
		alias
			"ImageList_AddMasked"
		end

	cwel_imagelist_add_icon (ptr: POINTER; icon_to_add: POINTER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, HICON): int"
		alias
			"ImageList_AddIcon"
		end

	cwel_imagelist_replace_icon (ptr: POINTER;  index: INTEGER; icon_to_add: POINTER) is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, int, HICON)"
		alias
			"ImageList_ReplaceIcon"
		end

	cwel_imagelist_get_bkcolor (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST): COLORREF"
		alias
			"ImageList_GetBkColor"
		end

	cwel_imagelist_set_bkcolor (ptr: POINTER; bkcolor: INTEGER) is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, COLORREF)"
		alias
			"ImageList_SetBkColor"
		end

	cwel_imagelist_get_image_count (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST): int"
		alias
			"ImageList_GetImageCount"
		end

	cwel_imagelist_remove (ptr: POINTER; index: INTEGER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST, int): BOOL"
		alias
			"ImageList_Remove"
		end

	cwel_imagelist_remove_all (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_image_list.h%"] (HIMAGELIST): BOOL"
		alias
			"ImageList_RemoveAll"
		end

feature {NONE} -- Private Constants

	Initial_size	: INTEGER is 1
		-- Number of images that the image list initially contains. 

	Grow_parameter	: INTEGER is 1
		-- Number of images by which the image list can grow when the
		-- system needs to make room for new images. This attribute 
		-- represents the number of new images that the resized image
		-- list can contain. 

end -- class WEL_IMAGE_LIST


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

