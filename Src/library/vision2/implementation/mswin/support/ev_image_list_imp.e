indexing
	description	: "List of images. The list is cached to avoid %
				  %multiplication of indexes for the same image"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_IMAGE_LIST_IMP

inherit
	WEL_IMAGE_LIST
		undefine
			dispose
		end

	EV_ANY_HANDLER

	WEL_REFERENCE_TRACKABLE

create
	make_with_size

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create image list with all images
			-- `a_width' by `a_height' pixels
		do
			make (a_width, a_height, Ilc_color24, True)
			add_transparent_pixmap -- First image is transparent.
			create image_list_info.make (4)
			create filenames_index.make (4)
			create bitmap_ids_index.make (4)
			create image_id_to_bitmap_id_index.make (4)
		end

	add_transparent_pixmap is
			-- Add a transparent pixmap to the image list.
			--
			-- `last_position' is updated.
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

				-- Let's do the laundry!
			icon_info.delete
			empty_mask.delete
			empty_bitmap.delete
			mem_dc.delete
		end

feature -- Status report

	pixmap_position (a_pixmap: EV_PIXMAP) is
			-- Update `last_position' with the position of `a_pixmap'
			-- in the image list. Set `last_position' to -1 if `a_pixmap'
			-- is not present in the image list.
		require
			a_pixmap_not_void: a_pixmap /= Void
		local
			pixmap_imp: EV_PIXMAP_IMP
			pixmap_filename: STRING
		do
				-- Initialize `last_position' to "not found".
			last_position := -1

				-- Try to find the cached version of the pixmap with its name.
			pixmap_imp ?= a_pixmap.implementation
			if pixmap_imp /= Void then
				pixmap_filename := pixmap_imp.pixmap_filename
				if pixmap_filename /= Void and then
				   filenames_index.has (pixmap_filename)
				then
					last_position := filenames_index.item (pixmap_filename)
				elseif pixmap_imp.private_bitmap_id >= 0 and then
					bitmap_ids_index.has (pixmap_imp.private_bitmap_id)
				then
					last_position := bitmap_ids_index.item (pixmap_imp.private_bitmap_id)
				end
			end

				-- Try to find the cached version of the pixmap with its
				-- graphical object.
			if last_position = -1 then
				internal_pixmap_position (a_pixmap)
			end
		end

feature -- Element change

	add_pixmap (a_pixmap: EV_PIXMAP) is
			-- Add the pixmap `a_pixmap' into the image list.
			--
			-- `last_position' is updated.
		local
			pixmap_imp: EV_PIXMAP_IMP
			pixmap_filename: STRING
			l_id: INTEGER
		do
			pixmap_imp ?= a_pixmap.implementation
			if pixmap_imp /= Void then
				pixmap_filename := pixmap_imp.pixmap_filename
				if pixmap_filename /= Void then
					if filenames_index.has (pixmap_filename) then
						last_position := filenames_index.item (pixmap_filename)
					elseif pixmap_imp.private_bitmap /= Void then
						l_id := pixmap_imp.private_bitmap.object_id
						if bitmap_ids_index.has (l_id) then
							last_position := bitmap_ids_index.item (l_id)
						else
							internal_add_pixmap (a_pixmap)
							bitmap_ids_index.put (last_position, l_id)
							image_id_to_bitmap_id_index.put (l_id, last_position)
							filenames_index.put (last_position, pixmap_filename)
						end
					else
						internal_add_pixmap (a_pixmap)
						filenames_index.put (last_position, pixmap_filename)
					end
				elseif pixmap_imp.private_bitmap_id >= 0 then
					l_id := pixmap_imp.private_bitmap_id
					if bitmap_ids_index.has (l_id) then
						last_position := bitmap_ids_index.item (l_id)
					else
						internal_add_pixmap (a_pixmap)
						bitmap_ids_index.put (last_position, l_id)
						image_id_to_bitmap_id_index.put (l_id, last_position)
					end
				else
					internal_add_pixmap (a_pixmap)
				end
			else
				internal_add_pixmap (a_pixmap)
			end
		end

	extend_pixmap (a_pixmap: EV_PIXMAP) is
			-- Add the pixmap `a_pixmap' at the end of the image list.
			-- Do not test for possible cached version.
			--
			-- `last_position' is updated.
		local
			pixmap_imp: EV_PIXMAP_IMP
			pixmap_filename: STRING
		do
			pixmap_imp ?= a_pixmap.implementation
			if pixmap_imp /= Void then
				pixmap_filename := pixmap_imp.pixmap_filename
			end

			internal_extend_pixmap (a_pixmap)

			if pixmap_filename /= Void then
				filenames_index.put (last_position, pixmap_filename)
			elseif pixmap_imp /= Void and then pixmap_imp.private_bitmap /= Void then
				bitmap_ids_index.put (last_position, pixmap_imp.private_bitmap.object_id)
				image_id_to_bitmap_id_index.put (pixmap_imp.private_bitmap.object_id, last_position)
			end
		end

feature {NONE} -- Implementation (Private features)

	internal_add_pixmap (a_pixmap: EV_PIXMAP) is
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
			graphres		: WEL_GRAPHICAL_RESOURCE
			loc_tuple		: TUPLE [position: INTEGER; number: INTEGER]
			info			: like image_list_info
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

			if graphres = Void then
				graphres := pixmap_imp.build_icon
				graphres.enable_reference_tracking
			else
				graphres.increment_reference
			end

				-- Assign `icon.item' to `item_value'
			item_value := graphres.object_id

			if item_value = 0 or not info.has (item_value) then
					-- Add the icon to image_list and set image_index.
				add_icon (graphres)
				info.put ([last_position, 1], item_value)
			else
					-- `icon' already in image list so set
					-- `image_index' to this.
				loc_tuple := info.item (item_value)
				last_position := loc_tuple.position
			end

			graphres.decrement_reference
		end

	internal_pixmap_position (a_pixmap: EV_PIXMAP) is
			-- Update `last_position' with the position of `a_pixmap'
			-- in the image list. Set `last_position' to -1 if `a_pixmap'
			-- is not present in the image list.
		require
			a_pixmap_not_void: a_pixmap /= Void
		local
			item_value		: INTEGER
			graphres		: WEL_GRAPHICAL_RESOURCE
			loc_tuple		: TUPLE [position: INTEGER; number: INTEGER]
			info			: like image_list_info
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
					-- Assign `graphres.object_id' to `item_value'
				item_value := graphres.object_id

				if item_value /= 0 and then info.has (item_value) then
						-- `icon' already in image list so set `image_index' to this.
					loc_tuple := info.item (item_value)
					last_position := loc_tuple.position
				end
			end
		end

	internal_extend_pixmap (a_pixmap: EV_PIXMAP) is
			-- Add the pixmap `a_pixmap' at the end of the image list.
			-- Do not test for possible cached version.
			--
			-- `last_position' is updated.
		require
			a_pixmap_not_void: a_pixmap /= Void
		local
			item_value		: INTEGER
			graphres		: WEL_GRAPHICAL_RESOURCE
			info			: like image_list_info
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
					-- Assign `graphres.object_id' to `item_value'.
				item_value := graphres.object_id

					-- Add the icon to image_list and set image_index.
				add_icon (graphres)
				info.put ([last_position, 1], item_value)
			else
				add_pixmap_bitmap (a_pixmap)
			end
		end

	add_pixmap_bitmap (a_pixmap: EV_PIXMAP) is
			-- Add the pixmap `a_pixmap' internally holding a HBITMAP
			-- at the end of the image list.
			-- Do not test for possible cached version.
			--
			-- `last_position' is updated.
		local
			resized_pixmap	: EV_PIXMAP
			pixmap_imp		: EV_PIXMAP_IMP_STATE
			bitmap			: WEL_BITMAP
			mask_bitmap		: WEL_BITMAP
			l_mask_bitmap_dc: WEL_MEMORY_DC
			l_converted_bitmap: WEL_BITMAP
			l_converted_bitmap_dc: WEL_MEMORY_DC
		do
			pixmap_imp ?= a_pixmap.implementation
			if (pixmap_imp.height /= bitmaps_height) or
			   (pixmap_imp.width /= bitmaps_width)
			then
				create resized_pixmap
				resized_pixmap.copy (a_pixmap)
				resized_pixmap.stretch (
					bitmaps_width,
					bitmaps_height
					)
				pixmap_imp ?= resized_pixmap.implementation
			end

			bitmap := pixmap_imp.get_bitmap
			if pixmap_imp.has_mask then
				mask_bitmap := pixmap_imp.get_mask_bitmap
				create l_mask_bitmap_dc.make
				l_mask_bitmap_dc.select_bitmap (mask_bitmap)
				create l_converted_bitmap_dc.make_by_dc (l_mask_bitmap_dc)
				create l_converted_bitmap.make_compatible (l_converted_bitmap_dc, mask_bitmap.width, mask_bitmap.height)
				l_converted_bitmap.enable_reference_tracking
				l_converted_bitmap_dc.select_bitmap (l_converted_bitmap)
				l_converted_bitmap_dc.pat_blt (0, 0, mask_bitmap.width, mask_bitmap.height, {WEL_RASTER_OPERATIONS_CONSTANTS}.whiteness)
				l_converted_bitmap_dc.bit_blt (0, 0, mask_bitmap.width, mask_bitmap.height, l_mask_bitmap_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srcinvert)
				l_mask_bitmap_dc.unselect_bitmap
				l_mask_bitmap_dc.delete
				l_converted_bitmap_dc.unselect_bitmap
				l_converted_bitmap_dc.delete
				add_masked_bitmap (bitmap, l_converted_bitmap)
				l_converted_bitmap.decrement_reference
				mask_bitmap.decrement_reference
				mask_bitmap := Void
			else
				add_bitmap (bitmap)
			end
			bitmap.decrement_reference
			bitmap := Void

			if resized_pixmap /= Void then
				resized_pixmap.destroy
				resized_pixmap := Void
			end
		end

feature {EV_ANY_I} -- Implementation

	filenames_index: HASH_TABLE [INTEGER, STRING]
			-- Table indexing image indexes in imagelist with the image name.

	bitmap_ids_index: HASH_TABLE [INTEGER, INTEGER]
			-- Table indexing image indexes in images list to bitmap object id

	image_id_to_bitmap_id_index: HASH_TABLE [INTEGER, INTEGER]
			-- Table indexing image bitmap object ids to indexes in images list.

feature {NONE} -- Implementation (Attributes, Constants, ...)

	image_list_info: HASH_TABLE [TUPLE [position: INTEGER; number: INTEGER], INTEGER]
			-- A list of all items in the image list and their positions.
			-- [[position in image list, number of items pointing to this
			-- image], windows pointer].

	raster_constants: WEL_RASTER_OPERATIONS_CONSTANTS is
			-- Raster operations constants.
		once
			Create Result
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




end -- class EV_IMAGE_LIST_IMP

