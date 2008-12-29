note
	description: "Contains information about a tree view hittestinfo notification%
			% message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TV_HITTESTINFO

inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer,
	make_with_point

feature {NONE} -- Initialization

	make_with_point (pt: WEL_POINT)
			-- Create a structure with `pt'.
		do
			make
			set_point (pt)
		end

feature -- Access

	point: WEL_POINT
			-- Client coordinates of the point to test.
		do
			create Result.make_by_pointer (cwel_tv_hittestinfo_get_pt (item))
		end

	flags: INTEGER
			-- Variable that receives information about the result of
			-- a hit test. See WEL_TVHT_CONSTANTS for values.
		do
			Result := cwel_tv_hittestinfo_get_flags (item)
		end

	hitem: POINTER
			-- Handle of the item that occupies the point
		do
			Result := cwel_tv_hittestinfo_get_hitem (item)
		end

feature -- Element change

	set_point (pt: WEL_POINT)
			-- Set `point' with `pt'.
		do
			cwel_tv_hittestinfo_set_pt (item, pt.item)
		ensure
			point_set: point.is_equal (pt)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tv_hittestinfo
		end

feature {NONE} -- externals

	c_size_of_tv_hittestinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (TVHITTESTINFO)"
		end

	cwel_tv_hittestinfo_set_pt (ptr, pt: POINTER)
		external
			"C [macro %"tvhittestinfo.h%"]"
		end

	cwel_tv_hittestinfo_get_pt (ptr: POINTER): POINTER
		external
			"C [macro %"tvhittestinfo.h%"]: EIF_POINTER"
		end

	cwel_tv_hittestinfo_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro %"tvhittestinfo.h%"]: EIF_INTEGER"
		end

	cwel_tv_hittestinfo_get_hitem (ptr: POINTER): POINTER
		external
			"C [macro %"tvhittestinfo.h%"]: EIF_POINTER"
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

end
