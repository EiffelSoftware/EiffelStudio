indexing
	description: "Contains information about a tree view hittestinfo notification%
			% message."
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
			Result := cwel_tv_hittestinfo_get_flags (item)
		end

	hitem: POINTER is
			-- Handle of the item that occupies the point
		do
			Result := cwel_tv_hittestinfo_get_hitem (item)
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
			"sizeof (TVHITTESTINFO)"
		end

	cwel_tv_hittestinfo_set_pt (ptr, pt: POINTER) is
		external
			"C [macro %"tvhittestinfo.h%"]"
		end

	cwel_tv_hittestinfo_get_pt (ptr: POINTER): POINTER is
		external
			"C [macro %"tvhittestinfo.h%"]: EIF_POINTER"
		end

	cwel_tv_hittestinfo_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro %"tvhittestinfo.h%"]: EIF_INTEGER"
		end

	cwel_tv_hittestinfo_get_hitem (ptr: POINTER): POINTER is
		external
			"C [macro %"tvhittestinfo.h%"]: EIF_POINTER"
		end

end -- class WEL_TV_HITTESTINFO

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

