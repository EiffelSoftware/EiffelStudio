indexing
	description	: "List of images. The list is cached to avoid %
				  %multiplication of indexes for the same image"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_IMAGE_LIST_IMP

inherit
	WEL_IMAGE_LIST
		rename
			make as wel_make,
			last_position as wel_last_position
		end

create
	make_with_size

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create image list with all images 
			-- `a_width' by `a_height' pixels
		do
			wel_make (a_width, a_height, Ilc_color24, True)
			add_transparent_pixmap
			create image_list_info.make (4)
		end

	add_transparent_pixmap is
			-- Add `a_pixmap_imp' to the image list.
			-- The pixmap is resized if needed to fit into the 
			-- image list.
			--
			-- The position in the image list of the pixmap is 
			-- set to 0.
		local
			empty_mask: WEL_BITMAP
			empty_bitmap: WEL_BITMAP
			mem_dc: WEL_MEMORY_DC
			icon_info: WEL_ICON_INFO
			icon: WEL_ICON
		do
			create mem_dc.make
			create empty_mask.make_compatible (mem_dc, 16, 16)
			create empty_bitmap.make_compatible (mem_dc, 16, 16)

			mem_dc.select_bitmap (empty_mask)
			mem_dc.pat_blt (0, 0, 16, 16, raster_constants.Whiteness)
			mem_dc.unselect_bitmap

			create icon_info.make
			icon_info.set_color_bitmap (empty_bitmap)
			icon_info.set_mask_bitmap (empty_mask)
			icon_info.set_is_icon (True)
			create icon.make_by_icon_info (icon_info)
			add_icon (icon)
			check
				wel_last_position = 0
			end
		end

feature -- Access

	last_position: INTEGER

feature -- Element change
		
	add_pixmap (a_pixmap: EV_PIXMAP) is
			-- Add `a_pixmap' to the image list.
			-- The pixmap is resized if needed to fit into the 
			-- image list.
			--
			-- The position in the image list of the pixmap is 
			-- set to `last_position'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		local
			item_value		: INTEGER
			mask_bitmap		: WEL_BITMAP
			bitmap			: WEL_BITMAP
			graphres		: WEL_GRAPHICAL_RESOURCE
			loc_tuple		: TUPLE [INTEGER, INTEGER]
			info			: like image_list_info
			resized_pixmap	: EV_PIXMAP
			pixmap_imp		: EV_PIXMAP_IMP_STATE
		do
			pixmap_imp ?= a_pixmap.implementation
			info := image_list_info

				-- Try to get the icon
			graphres := pixmap_imp.icon
				
				-- If there is no icon, try a cursor
			if graphres = Void then
				graphres := pixmap_imp.cursor
			end

			if graphres /= Void then
					-- Assign `icon.item' to `item_value'
				item_value := cwel_pointer_to_integer (graphres.item)

				if not info.has (item_value) then
						-- Add the icon to image_list and set image_index.
					add_icon (graphres)
					last_position := wel_last_position
					info.put ([last_position, 1], item_value)
				else
						-- `icon' already in image list so set 
						-- `image_index' to this.
					loc_tuple := info.item (item_value)
					last_position := loc_tuple.integer_item (1)
				end
			else
				if (pixmap_imp.height /= bitmaps_height) or 
				   (pixmap_imp.width /= bitmaps_width)
				then
						-- We use a_pixmap as interface to access `ev_clone'
					resized_pixmap := a_pixmap.ev_clone (a_pixmap)
					resized_pixmap.stretch (
						bitmaps_width,
						bitmaps_height
						)
					pixmap_imp ?= resized_pixmap.implementation
				end

				bitmap := pixmap_imp.bitmap
				mask_bitmap := pixmap_imp.mask_bitmap
				if mask_bitmap /= Void then
					add_masked_bitmap(bitmap, mask_bitmap)
				else
					add_bitmap(bitmap)
				end
				last_position := wel_last_position
			end
		end

feature {NONE} -- Implementation

	image_list_info: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
			-- A list of all items in the image list and their positions.
			-- [[position in image list, number of items pointing to this
			-- image], windows pointer].

	raster_constants: WEL_RASTER_OPERATIONS_CONSTANTS is
		once
			Create Result
		end

end -- class EV_IMAGE_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
