indexing
	description: "This class represents a structure that contains%
					 %information about a hit test for a WEL_HEADER_CONTROL"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	WEL_HD_HIT_TEST_INFO

inherit
	WEL_STRUCTURE
	WEL_BIT_OPERATIONS

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

feature -- Access

	point: WEL_POINT is
			-- Points to test, in client coordinates 	
		require
			exists: exists
		do
			create Result.make (cwel_hd_hit_test_info_get_pt_x (item), cwel_hd_hit_test_info_get_pt_y (item))
		end

	flags: INTEGER is
			-- Variable that receives information about the results of a hit test. 
			-- This member can be one or more of the values defined in WEL_HHT_CONSTANTS 		
		require
			exists: exists
		do
			Result := cwel_hd_hit_test_info_get_flags (item)
		end		

	index: INTEGER is
			-- Retrieves the index of the item at `point' if any
		require
			exists: exists
		do
			Result := cwel_hd_hit_test_info_get_i_item (item)
		ensure
			positive_result: Result >= 0
		end
		
feature -- Element change

	set_point (a_point: WEL_POINT) is
			-- Sets the point to test, in client coordinates
		require
			exists: exists
			point_exists: a_point /= Void and then a_point.exists
		do
			cwel_hd_hit_test_info_set_pt_x (item, a_point.x)
			cwel_hd_hit_test_info_set_pt_y (item, a_point.y)
		end

	set_flags (value: INTEGER) is
			-- Sets variable that receives information about the results of a hit test. 
			-- This member can be one or more of the values defined in WEL_HHT_CONSTANTS 		
			-- (Usually set by the OS)
		require
			exists: exists
		do
			cwel_hd_hit_test_info_set_flags (item, value)
		end		

	set_index (value: INTEGER) is
			-- Sets the index of the item at `point' if any
			-- (Usually set by the OS)
		require
			exists: exists
			positive_value: value >= 0
		do
			cwel_hd_hit_test_info_set_i_item (item, value)
		end
				
		
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_hd_hit_test_info
		end

feature {NONE} -- Externals

	c_size_of_hd_hit_test_info: INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (HD_HITTESTINFO)"
		end

	cwel_hd_hit_test_info_get_pt_x (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*): EIF_INTEGER"
		end

	cwel_hd_hit_test_info_set_pt_x (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*, LONG)"
		end

	cwel_hd_hit_test_info_get_pt_y (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*): EIF_INTEGER"
		end

	cwel_hd_hit_test_info_set_pt_y (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*, LONG)"
		end

	cwel_hd_hit_test_info_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*): EIF_INTEGER"
		end

	cwel_hd_hit_test_info_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*, UINT)"
		end

	cwel_hd_hit_test_info_get_i_item (ptr: POINTER): INTEGER is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*): EIF_INTEGER"
		end

	cwel_hd_hit_test_info_set_i_item (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"hd_hit_test_info.h%"] (HD_HITTESTINFO*, int)"
		end

end -- class WEL_HD_HIT_TEST_INFO


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

