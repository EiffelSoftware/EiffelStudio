indexing
	description: "The TV_DISPINFO structure retrieves and sets%
				% information about a tree-view item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TV_DISPINFO

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
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_tv_dispinfo_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	tree_item: WEL_TREE_VIEW_ITEM is
			-- Virtual key number.
		do
			create Result.make_by_pointer (cwel_tv_dispinfo_get_item (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tv_dispinfo
		end

feature {NONE} -- Externals

	c_size_of_tv_dispinfo: INTEGER is
		external
			"C [macro <tvdispinfo.h>]"
		alias
			"sizeof (TV_DISPINFO)"
		end

	cwel_tv_dispinfo_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro <tvdispinfo.h>] (TV_DISPINFO*): EIF_POINTER"
		end

	cwel_tv_dispinfo_get_item (ptr: POINTER): POINTER is
		external
			"C [macro <tvdispinfo.h>] (TV_DISPINFO*): EIF_POINTER"
		end

end -- class WEL_TV_DISPINFO


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

