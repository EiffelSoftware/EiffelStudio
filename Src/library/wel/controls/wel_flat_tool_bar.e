note
	description: "[
		Enhancement of the toolbar. This toolbar appears flat
		and use imagelist to store bitmaps - when available.
		
		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) 
		needs to be loaded to use this control.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FLAT_TOOL_BAR

inherit
	WEL_TOOL_BAR
		redefine
			make,
			default_style,
			set_bitmap_size,
			add_bitmaps
		end

	WEL_ILC_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_VERSION

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; an_id: INTEGER)
			-- Create a toolbar with `a_parent' as parent and
			-- `an_id' as id.
		do
			Precursor{WEL_TOOL_BAR} (a_parent, an_id)
			bitmaps_width := 16		-- Default value
			bitmaps_height := 15	-- Default value
			if use_image_list_supported then
				use_image_list := True -- Default state
			end
		end

feature -- Access

	bitmaps_width: INTEGER
			-- 16 by default

	bitmaps_height: INTEGER
			-- 15 by default

	buttons_width: INTEGER
			-- Width of the buttons in the toolbar.
		do
			if comctl32_version >= version_470 then
				Result := get_button_width
			else
					-- No API available, so we guess...
				Result := bitmaps_width + 8
			end
		end

	buttons_height: INTEGER
			-- Height of the buttons in the toolbar.
		do
			if comctl32_version >= version_470 then
				Result := get_button_height
			else
					-- No API available, so we guess...
				Result := bitmaps_height + 7
			end
		end

	use_image_list: BOOLEAN
			-- Are we using ImageList for the toolbar?

	use_disabled_image_list: BOOLEAN
			-- Are we using disabled ImageList for the toolbar?
		do
			Result := (disabled_image_list /= Void)
		end

	use_hot_image_list: BOOLEAN
			-- Are we using hot ImageList for the toolbar?
		do
			Result := (hot_image_list /= Void)
		end

	last_disabled_bitmap_index: INTEGER

	last_hot_bitmap_index: INTEGER

	default_image_list: detachable WEL_IMAGE_LIST
			-- ImageList associated with the toolbar
			-- Note: only used in the "Win95+IE3" version

	disabled_image_list: detachable WEL_IMAGE_LIST
			-- ImageList associated with the toolbar for disabled
			-- buttons
			-- Note: only used in the "Win95+IE3" version

	hot_image_list: detachable WEL_IMAGE_LIST
			-- ImageList associated with the toolbar for hot buttons
			-- Note: only used in the "Win95+IE3" version

feature -- Status report

	use_image_list_supported: BOOLEAN
			-- Are ImageList in toolbars supported in the current
			-- version of Windows?
		once
			Result := comctl32_version >= version_470
		end

	find_button (a_x, a_y: INTEGER): INTEGER
			-- Determines where a point lies in a toolbar control.
			--
			-- Returns an integer value. If the return value is zero or a positive value,
			-- it is the zero-based index of the nonseparator item in which the point lies.
			-- If the return value is negative, the point does not lie within a button.
			-- The absolute value of the return value is the index of a separator item
			-- or the nearest nonseparator item.
		local
			coordinates: WEL_POINT
		do
			create coordinates.make (a_x, a_y)
			Result := {WEL_API}.send_message_result_integer (item, Tb_hittest, to_wparam (0), coordinates.item)
		end

	get_max_width: INTEGER
			-- Retrieves the total width of all of the visible buttons and separators in the toolbar.
		require
			function_supported: comctl32_version >= version_471
		do
			Result := get_max_size.width
		end

	get_max_height: INTEGER
			-- Retrieves the common height of all of the visible buttons and separators in the toolbar.
		require
			function_supported: comctl32_version >= version_471
		do
			Result := get_max_size.height
		end

	get_max_size: WEL_SIZE
			-- Retrieves the total size of all of the visible buttons and separators in the toolbar
		require
			function_supported: comctl32_version >= version_471
		local
			error_code: POINTER
		do
			create Result
			error_code := {WEL_API}.send_message_result (item, Tb_getmaxsize, to_wparam (0), Result.item)
			check
				no_error: error_code /= default_pointer
			end
		end

feature -- Status setting

	enable_use_image_list
			-- Set the toolbar to use image lists.
			-- Note: Require Win95+IE3 or above
		require
			no_bitmap_present: not has_bitmap
			feature_supported: use_image_list_supported
		do
			use_image_list := True
		ensure
			image_list_in_use: use_image_list
		end

	disable_use_image_list
			-- Set the toolbar not to use image lists.
			-- Note: This is the Default.
		require
			no_bitmap_present: not has_bitmap
		do
			use_image_list := False
		ensure
			image_list_not_used: not use_image_list
		end

feature -- Element change

	add_icon (a_icon: WEL_GRAPHICAL_RESOURCE)
			-- Add an icon to the list of currently used images.
			--
			-- Note: The function will work with Comctrl32.dll version less
			-- than 4.70 but will not display the icon correctly: the background
			-- of the icons will always be set in black.
			-- With Comctrl32.dll >= 4.70 everything will run smoothly.
			-- Note2: Comctrl32.dll version 4.70 <=> Win95 + IE3
		require
			exists: exists
			icon_not_void: a_icon /= Void
			icon_exists: a_icon.exists
		local
			l_bitmap: WEL_BITMAP
			l_info: detachable WEL_ICON_INFO
			l_toolbar_bitmap: WEL_TOOL_BAR_BITMAP
			l_default_image_list: like default_image_list
		do
			has_bitmap := True

			if use_image_list then
					-- Create the ImageList if not already created
				setup_image_list (False)

					-- Insert the bitmap into the image list.
				l_default_image_list := default_image_list
					-- Per poscondition of `setup_image_list'.
				check l_default_image_list_attached: l_default_image_list /= Void then end
				l_default_image_list.add_icon (a_icon)

				last_bitmap_index := l_default_image_list.last_position
			else
					-- We retrieve the bitmap from the icon.
				l_info := a_icon.get_icon_info
				if l_info /= Void then
					l_bitmap := l_info.color_bitmap
					create l_toolbar_bitmap.make_from_bitmap (l_bitmap)
					last_bitmap_index := {WEL_API}.send_message_result_integer (item, Tb_addbitmap,
						to_wparam (1), l_toolbar_bitmap.item)
				end
			end
		end

	add_disabled_icon (an_icon: WEL_GRAPHICAL_RESOURCE)
			-- Add an icon to the disabled image list.
			--
			-- The feature is only supported under Windows95+IE3
			-- If such a configuration is not available, the function will
			-- do nothing.
		require
			icon_not_void: an_icon /= Void
			icon_exists: an_icon.exists
		local
			l_disabled_image_list: like disabled_image_list
		do
			if use_image_list then
					-- Create the ImageLists if not already created
				setup_disabled_image_list (False)

					-- Insert the bitmap into the image lists.
				l_disabled_image_list := disabled_image_list
					-- Per poscondition of `setup_disabled_image_list'.
				check l_disabled_image_list_attached: l_disabled_image_list /= Void then end
				l_disabled_image_list.add_icon (an_icon)

					-- Update the position
				last_disabled_bitmap_index := l_disabled_image_list.last_position
			else
				-- Not supported... do nothing.
			end
		end

	add_hot_icon (an_icon: WEL_GRAPHICAL_RESOURCE)
			-- Add an icon to the hot image list.
			--
			-- The feature is only supported under Windows95+IE3
			-- If such a configuration is not available, the function will
			-- do nothing.
		require
			icon_not_void: an_icon /= Void
			icon_exists: an_icon.exists
		local
			l_hot_image_list: like hot_image_list
		do
			if use_image_list then
					-- Create the ImageLists if not already created
				setup_hot_image_list (False)

					-- Insert the bitmap into the image lists.
				l_hot_image_list := hot_image_list
					-- Per poscondition of `setup_image_list'.
				check l_hot_image_list_attached: l_hot_image_list /= Void then end
				l_hot_image_list.add_icon (an_icon)

					-- Update the position
				last_hot_bitmap_index := l_hot_image_list.last_position
			else
				-- Not supported... do nothing.
			end
		end

	add_bitmap (a_bitmap: WEL_BITMAP)
			-- Add a bitmap to the list of currently used images.
		require
			exists: exists
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
		local
			a_toolbar_bitmap: WEL_TOOL_BAR_BITMAP
			l_default_image_list: like default_image_list
		do
			has_bitmap := True

			if use_image_list then
					-- Create the ImageList if not already created
				setup_image_list (False)

					-- Insert the bitmap into the image list.
				l_default_image_list := default_image_list
					-- Per poscondition of `setup_image_list'.
				check l_default_image_list_attached: l_default_image_list /= Void then end
				l_default_image_list.add_bitmap (a_bitmap)

				last_bitmap_index := l_default_image_list.last_position
			else
					-- We build a "toolbar bitmap".
				create a_toolbar_bitmap.make_from_bitmap (a_bitmap)
				last_bitmap_index := {WEL_API}.send_message_result_integer (item, Tb_addbitmap,
					to_wparam (1), a_toolbar_bitmap.item)
			end
		end

	add_disabled_bitmap (a_bitmap: WEL_BITMAP)
			-- Add a bitmap to the disabled image list.
			--
			-- The feature is only supported under Windows95+IE3
			-- If such a configuration is not available, the function will
			-- do nothing.
		require
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
		local
			l_disabled_image_list: like disabled_image_list
		do
			if use_image_list then
					-- Create the ImageLists if not already created
				setup_disabled_image_list (False)

					-- Insert the bitmap into the image lists.
				l_disabled_image_list := disabled_image_list
					-- Per poscondition of `setup_disabled_image_list'.
				check l_disabled_image_list_attached: l_disabled_image_list /= Void then end
				l_disabled_image_list.add_bitmap (a_bitmap)

					-- Update the position
				last_disabled_bitmap_index := l_disabled_image_list.last_position
			else
				-- Not supported... do nothing.
			end
		end

	add_hot_bitmap (a_bitmap: WEL_BITMAP)
			-- Add a bitmap to the hot image list.
			--
			-- The feature is only supported under Windows95+IE3
			-- If such a configuration is not available, the function will
			-- do nothing.
		require
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
		local
			l_hot_image_list: like hot_image_list
		do
			if use_image_list then
					-- Create the ImageLists if not already created
				setup_hot_image_list (False)

					-- Insert the bitmap into the image lists.
				l_hot_image_list := hot_image_list
					-- Per poscondition of `setup_image_list'.
				check l_hot_image_list_attached: l_hot_image_list /= Void then end
				l_hot_image_list.add_bitmap (a_bitmap)

					-- Update the position
				last_hot_bitmap_index := l_hot_image_list.last_position
			else
				-- Not supported... do nothing.
			end
		end

	add_masked_bitmap (a_bitmap: WEL_BITMAP; a_mask_bitmap: WEL_BITMAP)
			-- Add a masked bitmap to the list of currently used images.
		require
			exists: exists
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
			mask_not_void: a_mask_bitmap /= Void
			mask_exists: a_mask_bitmap.exists
			compatible_width_for_bitmaps: a_bitmap.width = a_mask_bitmap.width
			compatible_height_for_bitmaps: a_bitmap.height = a_mask_bitmap.height
			--| FIXME ARNAUD: Ensure that the mask is a monochrome bitmap
		local
			a_toolbar_bitmap: WEL_TOOL_BAR_BITMAP
			l_default_image_list: like default_image_list
		do
			has_bitmap := True

			if use_image_list then
					-- Create the ImageList if not already created
				setup_image_list (False)

					-- Insert the bitmap into the image list.
				l_default_image_list := default_image_list
					-- Per poscondition of `setup_image_list'.
				check l_default_image_list_attached: l_default_image_list /= Void then end
				l_default_image_list.add_masked_bitmap (a_bitmap, a_mask_bitmap)

				last_bitmap_index := l_default_image_list.last_position
			else
					-- We build a "toolbar bitmap".
				create a_toolbar_bitmap.make_from_bitmap (a_bitmap)
				last_bitmap_index := {WEL_API}.send_message_result_integer (item, Tb_addbitmap,
					to_wparam (1), a_toolbar_bitmap.item)
			end
		end

	add_disabled_masked_bitmap (a_bitmap: WEL_BITMAP; a_mask_bitmap: WEL_BITMAP)
			-- Add a masked bitmap to the disabled image list.
		require
			exists: exists
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
			mask_not_void: a_mask_bitmap /= Void
			mask_exists: a_mask_bitmap.exists
			compatible_width_for_bitmaps: a_bitmap.width = a_mask_bitmap.width
			compatible_height_for_bitmaps: a_bitmap.height = a_mask_bitmap.height
			--| FIXME ARNAUD: Ensure that the mask is a monochrome bitmap
		local
			l_disabled_image_list: like disabled_image_list
		do
			if use_image_list then
					-- Create the ImageList if not already created
				setup_disabled_image_list (False)

					-- Insert the bitmap into the image list.
				l_disabled_image_list := disabled_image_list
					-- Per poscondition of `setup_disabled_image_list'.
				check l_disabled_image_list_attached: l_disabled_image_list /= Void then end
				l_disabled_image_list.add_masked_bitmap (a_bitmap, a_mask_bitmap)

				last_disabled_bitmap_index := l_disabled_image_list.last_position
			else
				-- Not supported... do nothing.
			end
		end

	add_hot_masked_bitmap (a_bitmap: WEL_BITMAP; a_mask_bitmap: WEL_BITMAP)
			-- Add a masked bitmap to the hot image list.
		require
			exists: exists
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
			mask_not_void: a_mask_bitmap /= Void
			mask_exists: a_mask_bitmap.exists
			compatible_width_for_bitmaps: a_bitmap.width = a_mask_bitmap.width
			compatible_height_for_bitmaps: a_bitmap.height = a_mask_bitmap.height
			--| FIXME ARNAUD: Ensure that the mask is a monochrome bitmap
		local
			l_hot_image_list: like hot_image_list
		do
			if use_image_list then
					-- Create the ImageList if not already created
				setup_hot_image_list (False)

					-- Insert the bitmap into the image list.
				l_hot_image_list := hot_image_list
					-- Per poscondition of `setup_image_list'.
				check l_hot_image_list_attached: l_hot_image_list /= Void then end
				l_hot_image_list.add_masked_bitmap (a_bitmap, a_mask_bitmap)

				last_hot_bitmap_index := l_hot_image_list.last_position
			else
				-- Not supported... do nothing.
			end
		end

feature -- Resizing

	set_bitmap_size (a_width, a_height: INTEGER)
			-- Sets the size of the bitmapped images to be added to
			-- the toolbar.
			-- The size can be set only before adding any
			-- bitmaps to the toolbar otherwise all added bitmap
			-- are erased.
			--
			-- If an application does not explicitly set the bitmap
			-- size, the default size is 16 by 15 pixels.
		do
			bitmaps_width := a_width
			bitmaps_height := a_height

			if use_image_list then
					-- ImageList version
				setup_image_list (True)
				setup_hot_image_list (True)
				setup_disabled_image_list (True)
			else
					-- Plain Win95 version
				{WEL_API}.send_message (item, Tb_setbitmapsize, to_wparam (0), cwin_make_long (a_width, a_height))
			end
		end

	get_button_width: INTEGER
			-- Get the width of the buttons.
		require
			function_supported: comctl32_version >= version_470
		do
			Result := cwin_lo_word ({WEL_API}.send_message_result (item, Tb_getbuttonsize,
				to_wparam (0), to_lparam (0)))
		end

	get_button_height: INTEGER
			-- Get the height of the buttons.
		require
			function_supported: comctl32_version >= version_470
		do
			Result := cwin_hi_word ({WEL_API}.send_message_result (item, Tb_getbuttonsize,
				to_wparam (0), to_lparam (0)))
		end

feature -- Obsolete

	add_bitmaps (tb_bitmap: WEL_TOOL_BAR_BITMAP; bitmap_count: INTEGER)
			-- Add bitmaps.
		obsolete
			"use add_bitmap instead"
		local
			l_bitmap: detachable WEL_BITMAP
			l_default_image_list: like default_image_list
		do
			has_bitmap := True

			if use_image_list then
					-- ImageList version
				check
					-- This is not compatible with ImageLists
					no_predefined_bitmap: not tb_bitmap.predefined_id
					no_disabled_bitmaps: not use_disabled_image_list
					no_hot_bitmaps: not use_hot_image_list
				end

					-- Create the ImageList if not already created
				setup_image_list (False)

					-- Insert the bitmap into the image list.
				l_bitmap := tb_bitmap.internal_bitmap
				if l_bitmap = Void then
					fixme ("Should it be `bitmap_id' or `internal_bitmap_id'?")
					create l_bitmap.make_by_id (tb_bitmap.bitmap_id)
				end
				l_default_image_list := default_image_list
					-- Per poscondition of `setup_image_list'.
				check l_default_image_list_attached: l_default_image_list /= Void then end
				l_default_image_list.add_bitmap (l_bitmap)

				last_bitmap_index := l_default_image_list.last_position
			else
					-- Plain Win95 version
				last_bitmap_index := {WEL_API}.send_message_result_integer (item, Tb_addbitmap,
					to_wparam (bitmap_count), tb_bitmap.item)
			end
		end

feature {NONE} -- Implementation

	setup_image_list (overwrite: BOOLEAN)
			-- if `overwrite' is set, create the image list only if it existed.
			-- if `overwrite' is not set, create the image list only if it did not exist.
		local
			l_default_image_list: like default_image_list
		do
			l_default_image_list := default_image_list
			if (overwrite and l_default_image_list /= Void) or ((not overwrite) and l_default_image_list = Void) then
				create l_default_image_list.make (bitmaps_width, bitmaps_height, Ilc_colorddb, True)
				default_image_list := l_default_image_list
				{WEL_API}.send_message (item, Tb_setimagelist, to_wparam (0), l_default_image_list.item)
			end
		end

	setup_disabled_image_list (overwrite: BOOLEAN)
			-- if `overwrite' is set, create the image list only if it existed.
			-- if `overwrite' is not set, create the image list only if it did not exist.
		local
			l_disabled_image_list: like disabled_image_list
		do
			l_disabled_image_list := disabled_image_list
			if (overwrite and l_disabled_image_list /= Void) or ((not overwrite) and l_disabled_image_list = Void) then
				create l_disabled_image_list.make (bitmaps_width, bitmaps_height, Ilc_colorddb, True)
				disabled_image_list := l_disabled_image_list
				{WEL_API}.send_message (item, Tb_setdisabledimagelist, to_wparam (0), l_disabled_image_list.item)
			end
		end

	setup_hot_image_list (overwrite: BOOLEAN)
			-- if `overwrite' is set, create the image list only if it existed.
			-- if `overwrite' is not set, create the image list only if it did not exist.
		local
			l_hot_image_list: like hot_image_list
		do
			l_hot_image_list := hot_image_list
			if (overwrite and l_hot_image_list /= Void) or ((not overwrite) and l_hot_image_list = Void) then
				create l_hot_image_list.make (bitmaps_width, bitmaps_height, Ilc_colorddb, True)
				hot_image_list := l_hot_image_list
				{WEL_API}.send_message (item, Tb_sethotimagelist, to_wparam (0), l_hot_image_list.item)
			end
		ensure
			hot_image_list_attached: hot_image_list /= Void
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Tbstyle_tooltips

				-- Add the flat style if available.
			if comctl32_version >= version_470 then
				Result := Result + Tbstyle_flat
			end
		end

invariant
	image_list_used_when_available: use_image_list implies use_image_list_supported
	disabled_image_list_only_when_bitmap: use_disabled_image_list implies has_bitmap
	hot_image_list_only_when_bitmap: use_hot_image_list implies has_bitmap

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_FLAT_TOOL_BAR

