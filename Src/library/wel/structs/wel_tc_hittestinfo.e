indexing
	description: "Contains information about a tab control hittestinfo notification%
			% message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TC_HITTESTINFO

inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer,
	make_with_point

feature {NONE} -- Initialization

	make_with_point (pt: WEL_POINT) is
			-- Create a structure with `pt'.
		do
			make
			set_point (pt)
		end

feature -- Access

	point: WEL_POINT is
			-- Client coordinates of the point to test.
		do
			create Result.make_by_pointer (cwel_tv_hittestinfo_get_pt (item))
		end

	flags: INTEGER is
			-- Variable that receives information about the result of
			-- a hit test. See WEL_TVHT_CONSTANTS for values.
		do
			Result := cwel_tc_hittestinfo_get_flags (item)
		end

feature -- Element change

	set_point (pt: WEL_POINT) is
			-- Set `point' with `pt'.
		do
			cwel_tv_hittestinfo_set_pt (item, pt.item)
		ensure
			point_set: point.is_equal (pt)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tv_hittestinfo
		end

feature {NONE} -- externals

	c_size_of_tv_hittestinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (TCHITTESTINFO)"
		end
		
	cwel_tc_hittestinfo_get_flags (ptr: POINTER): INTEGER is
		external
			"C [struct %"commctrl.h%"] (TCHITTESTINFO): EIF_INTEGER"
		alias
			"flags"
		end
		
	cwel_tc_hittestinfo_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"commctrl.h%"] (TCHITTESTINFO, EIF_INTEGER)"
		alias
			"flags"
		end

	cwel_tv_hittestinfo_set_pt (ptr, pt: POINTER) is
		external
			"C inline use <commctrl.h>"
		alias
			"((TCHITTESTINFO*) $ptr)->pt = *(POINT *) $pt"
		end

	cwel_tv_hittestinfo_get_pt (ptr: POINTER): POINTER is
		external
			"C [struct %"commctrl.h%"] (TCHITTESTINFO): EIF_POINTER"
		alias
			"&pt"
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




end -- class WEL_Tc_HITTESTINFO

