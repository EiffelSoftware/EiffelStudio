indexing
	description: "Contains information about a tree view notification %
		%message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_TREE_VIEW

inherit
	WEL_STRUCTURE

creation
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
			!! Result.make_by_pointer (cwel_nm_treeview_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	new_item: WEL_TREE_VIEW_ITEM is
			-- Information about the new item state
		do
			!! Result.make_by_pointer (cwel_nm_treeview_get_itemnew (item))
		ensure
			result_not_void: Result /= Void
		end

	old_item: WEL_TREE_VIEW_ITEM is
			-- Information about the old item state
		do
			!! Result.make_by_pointer (cwel_nm_treeview_get_itemold (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_treeview
		end

feature {NONE} -- Externals

	c_size_of_nm_treeview: INTEGER is
		external
			"C [macro <nmtv.h>]"
		alias
			"sizeof (NM_TREEVIEW)"
		end

	cwel_nm_treeview_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>]"
		end

	cwel_nm_treeview_get_action (ptr: POINTER): INTEGER is
		external
			"C [macro <nmtv.h>]"
		end

	cwel_nm_treeview_get_itemnew (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>]"
		end

	cwel_nm_treeview_get_itemold (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>]"
		end

	cwel_nm_treeview_get_ptdrag (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>]"
		end

end -- class WEL_NM_TREE_VIEW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
