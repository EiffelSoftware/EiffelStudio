indexing
	description: "Objects that represent a Windows NMCUSTOMDRAW structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_CUSTOM_DRAW
	
inherit
	WEL_STRUCTURE
	
create
	make,
	make_by_nmhdr,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR) is
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	hdr: WEL_NMHDR is
			-- NMHDR structure that contains information about this notification message.
		local
			p: POINTER
		do
			p := cwel_nm_customdraw_get_hdr (item)
			create Result.make_by_pointer (p)
		end
		
	dwdrawstage: INTEGER is
			-- Current drawing stage. See WEL_CDDS_CONSTANTS for values.
		do
			Result := cwel_nm_customdraw_get_dwdrawstage (item)
		end

	hdc: WEL_CLIENT_DC is
			-- Handle to the control's device context.
		local
			p: POINTER
		do
			p := cwel_nm_customdraw_get_hdc (item)
			create Result.make_by_pointer (p)
		end
		
	rc: WEL_RECT is
			-- WEL_RECT that describes the bounding rectangle of the area being drawn.
		local
			p: POINTER
		do
			p := cwel_nm_customdraw_get_rc (item)
			create Result.make_by_pointer (p)
		end
		
	dwitemspec: POINTER is
			-- Item number.
		do
			Result := cwel_nm_customdraw_get_dwitemspec (item)
		end
		
	uitemstate: INTEGER is
			-- Current item state.
		do
			Result := cwel_nm_customdraw_get_uitemstate (item)
		end
		
	litemlparam: POINTER is
			-- Application-defined item data.
		do
			Result := cwel_nm_customdraw_get_litemlparam (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_customdraw
		end

feature {NONE} -- Implementation

	c_size_of_nm_customdraw: INTEGER is
		external
			"C macro use <commctrl.h>"
		alias
			"sizeof (NMCUSTOMDRAW)"
		end
		
	cwel_nm_customdraw_get_hdr (ptr: POINTER): POINTER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_POINTER"
		alias
			"&hdr"
		end
		
	cwel_nm_customdraw_get_dwdrawstage (ptr: POINTER): INTEGER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_INTEGER"
		alias
			"dwDrawStage"
		end

	cwel_nm_customdraw_get_hdc	(ptr: POINTER): POINTER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_POINTER"
		alias
			"hdc"
		end

	cwel_nm_customdraw_get_rc (ptr: POINTER): POINTER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_POINTER"
		alias
			"&rc"
		end

	cwel_nm_customdraw_get_dwitemspec (ptr: POINTER): POINTER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_POINTER"
		alias
			"dwItemSpec"
		end
	
	cwel_nm_customdraw_get_uitemstate (ptr: POINTER): INTEGER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_INTEGER"
		alias
			"uItemState"
		end
		
	cwel_nm_customdraw_get_litemlparam (ptr: POINTER): POINTER is
		external
			"C [struct %"commctrl.h%"] (NMCUSTOMDRAW): EIF_POINTER"
		alias
			"lItemlParam"
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




end -- class WEL_NM_CUSTOM_DRAW

