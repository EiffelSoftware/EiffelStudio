note
	description	: "Information about an icon or a cursor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_ICON_INFO

inherit
	WEL_STRUCTURE
		redefine
			destroy_item
		end

	IDENTIFIED_ROUTINES
		undefine
			copy, is_equal
		end

create
	make

feature {WEL_GRAPHICAL_RESOURCE}-- Initialization

	initialize_bitmaps
			-- Initialize the bitmaps from the structure.
		require
			not_yet_initialized: not is_initialized
		local
			l_bitmap: WEL_BITMAP
		do
				-- Create the mask
			create l_bitmap.make_by_pointer (hbmMask_ext (item))
			internal_mask_bitmap := l_bitmap
			l_bitmap.set_unshared

				-- Create the bitmap (if any)
			if has_color_bitmap then
				create l_bitmap.make_by_pointer(hbmColor_ext (item))
				internal_color_bitmap := l_bitmap
				l_bitmap.set_unshared
			end

			is_initialized := True
		end

feature -- Access

	mask_bitmap: WEL_BITMAP
			-- bitmap representing the mask.
			--
			-- Specifies the icon bitmask bitmap. If this structure defines a black
			-- and white icon, this bitmask is formatted so that the upper half is
			-- the icon AND bitmask and the lower half is the icon XOR bitmask.
			-- Under this condition, the height should be an even multiple of two.
			-- If this structure defines a color icon, this mask only defines the
			-- AND bitmask of the icon.
		require
			initialized: is_initialized
		local
			l_bitmap: detachable WEL_BITMAP
		do
			l_bitmap := internal_mask_bitmap
				-- Per precondition.
			check l_bitmap_attached: l_bitmap /= Void end
			Result := l_bitmap
		ensure
			Result_not_void: Result /= Void
			Result_exists: Result.exists
		end

	color_bitmap: WEL_BITMAP
			-- bitmap representing the image (as opposed to the mask)
			--
			-- Handle to the icon color bitmap. This member can be optional if
			-- this structure defines a black and white icon. The AND bitmask of
			-- hbmMask is applied with the SRCAND flag to the destination;
			-- subsequently, the color bitmap is applied (using XOR) to the
			-- destination by using the SRCINVERT flag.
		require
			initialized: is_initialized
			has_color_bitmap: has_color_bitmap
		local
			l_bitmap: detachable WEL_BITMAP
		do
			l_bitmap := internal_color_bitmap
				-- Per precondition.
			check l_bitmap_attached: l_bitmap /= Void end
			Result := l_bitmap
		ensure
			Result_not_void: Result /= Void
			Result_exists: Result.exists
		end

feature -- Status Report

	is_initialized: BOOLEAN
			-- Is the structure initialized (i.e. filled)?

	is_icon: BOOLEAN
			-- Specifies whether this structure defines and icon or a cursor.
			-- True specifies an icon; False specifies a cursor.
		do
			Result := fIcon_ext (item)
		end

	has_color_bitmap: BOOLEAN
			-- Is `color_bitmap' valid?
			--
			-- In the case of a black & white icon/cursor, `mask_bitmap' is
			-- formatted so that the upper half is the icon AND bitmask and
			-- the lower half is the icon XOR bitmask. In this case,
			-- `color_bitmap' is not defined.
		do
			Result := (hbmColor_ext (item) /= Default_pointer)
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hotspot.
			-- If this structure defines an icon, the hot spot is
			-- always in the center of the icon, and this member is ignored.
		do
			Result := xHotspot_ext (item)
		end

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hotspot.
			-- If this structure defines an icon, the hot spot is
			-- always in the center of the icon, and this member is ignored.
		do
			Result := yHotspot_ext (item)
		end

	width: INTEGER
			-- Width of icon.
		do
			if not has_color_bitmap then
				Result := mask_bitmap.width
			else
				Result := color_bitmap.width
			end
		end

	height: INTEGER
			-- Width of icon.
		do
			if not has_color_bitmap then
					-- We have here a black & white icon.
					-- `mask_bitmap' is formatted so that the upper half is the
					-- icon AND bitmask and the lower half is the icon XOR
					-- bitmask. Under this condition, the height should be
					-- an even multiple of two.
				Result := mask_bitmap.height // 2
			else
				Result := color_bitmap.height
			end
		end

feature -- Status Setting

	enable_reference_tracking_on_bitmaps
			-- Enable the tracking of references on `mask_bitmap' and
			-- `color_bitmap'.
			--
			-- When `Current' will be disposed, the reference number of
			-- `mask_bitmap' and `color_bitmap' will be decreased.
		require
			initialized: is_initialized
		local
			l_bitmap: detachable WEL_BITMAP
		do
			l_bitmap := internal_mask_bitmap
			check l_bitmap_attached: l_bitmap /= Void end
			l_bitmap.enable_reference_tracking
			internal_mask_bitmap_object_id := l_bitmap.object_id

			if has_color_bitmap then
				l_bitmap := internal_color_bitmap
				check l_bitmap_attached: l_bitmap /= Void end
				l_bitmap.enable_reference_tracking
				internal_color_bitmap_object_id := l_bitmap.object_id
			end
		end

	set_x_hotspot (xvalue: INTEGER)
			-- Assign `xvalue' to xHotspot.
		do
			set_xHotspot_ext (item, xvalue)
		end

	set_y_hotspot (yvalue: INTEGER)
			-- Assign `yvalue' to yHotspot.
		do
			set_yHotspot_ext (item, yvalue)
		end

	set_mask_bitmap (a_mask_bitmap: WEL_BITMAP)
			-- Assign `a_mask_bitmap' to hbmMask
		require
			a_mask_bitmap_attached: a_mask_bitmap /= Void
			a_mask_bitmap_exists: a_mask_bitmap.exists
		local
			l_bitmap: detachable WEL_BITMAP
		do
				-- Remove the existing mask bitmap if any.
			l_bitmap := internal_mask_bitmap
			if l_bitmap /= Void and then l_bitmap.reference_tracked then
				l_bitmap.decrement_reference
			end

				-- Set the new mask bitmap.
			set_hbmMask_ext (item, a_mask_bitmap.item)

			internal_mask_bitmap := a_mask_bitmap
			internal_mask_bitmap_object_id := a_mask_bitmap.object_id
			if a_mask_bitmap.reference_tracked then
				a_mask_bitmap.increment_reference
			end

			is_initialized := True
		end

	set_color_bitmap (a_color_bitmap: WEL_BITMAP)
			-- Assign `a_color_bitmap' to hbmColor
		require
			a_color_bitmap_attached: a_color_bitmap /= Void
			a_color_bitmap_exists: a_color_bitmap.exists
		local
			l_bitmap: detachable WEL_BITMAP
		do
				-- Remove the existing bitmap if any.
			l_bitmap := internal_color_bitmap
			if l_bitmap /= Void and then l_bitmap.reference_tracked then
				l_bitmap.decrement_reference
			end

				-- Set the new color bitmap.
			set_hbmColor_ext (item, a_color_bitmap.item)

			internal_color_bitmap := a_color_bitmap
			internal_color_bitmap_object_id := a_color_bitmap.object_id
			if a_color_bitmap.reference_tracked then
				a_color_bitmap.increment_reference
			end

			is_initialized := True
		end

	set_is_icon (a_is_icon: BOOLEAN)
			-- Assign `a_is_icon' to fIcon.
		do
			set_fIcon_ext (item, a_is_icon)
		end

feature --  Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_iconinfo
		end

feature -- Obsolete

	fIcon: BOOLEAN
		obsolete "use `is_icon' instead"
		do
			Result := is_icon
		end

	xHotspot: INTEGER
		obsolete "use `x_hotspot' instead"
		do
			Result := x_hotspot
		end

	yHotspot: INTEGER
		obsolete "use `y_hotspot' instead"
		do
			Result := y_hotspot
		end

	set_xHotspot (xvalue: INTEGER)
		obsolete "use `set_x_hotspot' instead"
		do
			set_x_hotspot (xvalue)
		end

	set_yHotspot (yvalue: INTEGER)
		obsolete "use `set_y_hotspot' instead"
		do
			set_y_hotspot (yvalue)
		end

	set_fIcon (a_is_icon: BOOLEAN)
		obsolete "use `set_is_icon' instead"
		do
			set_is_icon (a_is_icon)
		end

feature -- Removal

	delete
			-- Free allocated C memory and GDI objects.
		require
			not_shared: not shared
		do
			if exists then
				destroy_item
			end
		end

feature {NONE} -- Removal

	destroy_item
			-- Free allocated C memory and GDI objects.
		do
			Precursor {WEL_STRUCTURE}

			if attached {WEL_BITMAP} eif_id_object (internal_mask_bitmap_object_id) as l_mask and then l_mask.reference_tracked then
				l_mask.decrement_reference
			end

			if attached {WEL_BITMAP} eif_id_object (internal_color_bitmap_object_id) as l_bitmap and then l_bitmap.reference_tracked then
				l_bitmap.decrement_reference
			end
		end

feature {NONE} -- Implementation

	internal_mask_bitmap: detachable WEL_BITMAP
			-- Mask bitmap build from the hbmMask pointer.

	internal_mask_bitmap_object_id: INTEGER
			-- Object id of `internal_mask_bitmap'

	internal_color_bitmap: detachable WEL_BITMAP
			-- Mask bitmap build from the hbmColor pointer.

	internal_color_bitmap_object_id: INTEGER
			-- Object id of `internal_color_bitmap'

feature {NONE} -- Externals

	c_size_of_iconinfo: INTEGER
		external
			"C [macro <winuser.h>]"
		alias
			"sizeof (ICONINFO)"
		end

	fIcon_ext (p: POINTER): BOOLEAN
			-- Access field fIcon of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_BOOLEAN"
		alias
			"fIcon"
		end

	xHotspot_ext (p: POINTER): INTEGER
			-- Access field xHotspot of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_INTEGER"
		alias
			"xHotspot"
		end

	yHotspot_ext (p: POINTER): INTEGER
			-- Access field yHotspot of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_INTEGER"
		alias
			"yHotspot"
		end

	hbmMask_ext (p: POINTER): POINTER
			-- Access field hbmMask of stuct pointer to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_POINTER"
		alias
			"hbmMask"
		end

	hbmColor_ext (p: POINTER): POINTER
			-- Access field hbmColor of stuct pointer to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_POINTER"
		alias
			"hbmColor"
		end


	set_fIcon_ext (p: POINTER; value: BOOLEAN)
			-- Set field fIcon of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, unsigned char)"
		alias
			"fIcon"
		end

	set_xHotspot_ext (p: POINTER; value: INTEGER)
			-- Set field xHotspot of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, int)"
		alias
			"xHotspot"
		end

	set_yHotspot_ext (p: POINTER; value: INTEGER)
			-- Set field yHotspot of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, int)"
		alias
			"yHotspot"
		end

	set_hbmMask_ext (p, value: POINTER)
			-- Set field hbmMask of struct pointed to by `p' to `value'
		external
			"C [struct %"winuser.h%"] (ICONINFO, HBITMAP)"
		alias
			"hbmMask"
		end

	set_hbmColor_ext (p, value: POINTER)
			-- Set field hbmColor of struct pointed to by `p' to `value'
		external
			"C [struct %"winuser.h%"] (ICONINFO, HBITMAP)"
		alias
			"hbmColor"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_ICON_INFO

