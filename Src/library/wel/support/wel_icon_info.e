indexing
	description: "Objects that allow users access to the ICONINFO structure within Windows."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICON_INFO

inherit
	WEL_STRUCTURE

create
	make

feature -- Status Report

	fIcon: BOOLEAN is
			-- Specifies whether this structure defines and icon or a cursor.
			-- True specifies an icon; False specifies a cursor.
		do
			Result := fIcon_ext (item)
		end
	
	xHotspot: INTEGER is
			-- Specifies the x-coordinate of a cursor's hotspot.
			-- If this structure defines an icon, the hot spot is
			-- always in the center of the icon, and this member is ignored.
		do
			Result := xHotspot_ext (item)
		end
	
	yHotspot: INTEGER is
			-- Specifies the y-coordinate of a cursor's hotspot.
			-- If this structure defines an icon, the hot spot is
			-- always in the center of the icon, and this member is ignored.
		do
			Result := yHotspot_ext (item)
		end
	
	hbmMask: POINTER is
			-- Pointer to the icon bitmask bitmap.
		do
			Result := hbmMask_ext (item)
		end

	hbmColor: POINTER is
			-- Pointer to the icon color bitmap.
		do
			Result := hbmColor_ext (item)
		end

	set_fIcon (is_icon: BOOLEAN) is
			-- Assign `is_icon' to fIcon.
		do
			set_fIcon_ext (item, is_icon)
		end

feature -- Status Setting

	set_xHotspot (xvalue: INTEGER) is
			-- Assign `xvalue' to xHotspot.
		do
			set_xHotspot_ext (item, xvalue)
		end

	set_yHotspot (yvalue: INTEGER) is
			-- Assign `yvalue' to yHotspot.
		do
			set_yHotspot_ext (item, yvalue)
		end

	set_hbmMask (mask_pointer: POINTER) is
			-- Assign `mask_pointer' to hbmMask
		do
			set_hbmMask_ext (item, mask_pointer)
		end

	set_hbmColor (color_pointer: POINTER) is
			-- Assign `color_pointer' to hbmColor
		do
			set_hbmColor_ext (item, color_pointer)
		end

feature --  Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_iconinfo
		end

feature {NONE} -- Externals

	c_size_of_iconinfo: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"sizeof (ICONINFO)"
		end
	
	fIcon_ext (p: POINTER): BOOLEAN is
			-- Access field fIcon of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_BOOLEAN"
		alias
			"fIcon"
		end

	xHotspot_ext (p: POINTER): INTEGER is
			-- Access field xHotspot of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_INTEGER"
		alias
			"xHotspot"
		end

	yHotspot_ext (p: POINTER): INTEGER is
			-- Access field yHotspot of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_INTEGER"
		alias
			"yHotspot"
		end

	hbmMask_ext (p: POINTER): POINTER is
			-- Access field hbmMask of stuct pointer to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_POINTER"
		alias
			"hbmMask"
		end

	hbmColor_ext (p: POINTER): POINTER is
			-- Access field hbmColor of stuct pointer to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_POINTER"
		alias
			"hbmColor"
		end
	

	set_fIcon_ext (p: POINTER; value: BOOLEAN) is
			-- Set field fIcon of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, unsigned char)"
		alias
			"fIcon"
		end

	set_xHotspot_ext (p: POINTER; value: INTEGER) is
			-- Set field xHotspot of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, int)"
		alias
			"xHotspot"
		end

	set_yHotspot_ext (p: POINTER; value: INTEGER) is
			-- Set field yHotspot of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, int)"
		alias
			"yHotspot"
		end

	set_hbmMask_ext (p, value: POINTER) is
			-- Set field hbmMask of struct pointed to by `p' to `value'
		external
			"C [struct %"winuser.h%"] (ICONINFO, HBITMAP)"
		alias
			"hbmMask"
		end

	set_hbmColor_ext (p, value: POINTER) is
			-- Set field hbmColor of struct pointed to by `p' to `value'
		external
			"C [struct %"winuser.h%"] (ICONINFO, HBITMAP)"
		alias
			"hbmColor"
		end

end -- class WEL_ICON_INFO
