indexing
	description: "Contains information about a tree view notification %
		%message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_TREE_VIEW

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
			create Result.make_by_pointer (cwel_nm_treeview_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	action: INTEGER is
			-- Information about the notification-specific action flag.
			-- See class WEL_TVAF_CONSTANTS for the meaning of this parameter.
		do
			Result := cwel_nm_treeview_get_action (item)
		end

	new_item: WEL_TREE_VIEW_ITEM is
			-- Information about the new item state
		local
			tree: WEL_TREE_VIEW
		do
			create Result.make_by_pointer (cwel_nm_treeview_get_itemnew (item))
			tree ?= hdr.window_from
			if tree.has_item (Result) then
				Result := tree.get_item_with_data (Result)
			else
				Result := Void
			end
		end

	old_item: WEL_TREE_VIEW_ITEM is
			-- Information about the old item state
		local
			tree: WEL_TREE_VIEW
		do
			create Result.make_by_pointer (cwel_nm_treeview_get_itemold (item))
			tree ?= hdr.window_from
			if tree.has_item (Result) then
				Result := tree.get_item_with_data (Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	position: WEL_POINT is
			-- Mouse coordinates when notification occurred.
		do
			create Result.make_by_pointer (cwel_nm_treeview_get_ptdrag (item))
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
			"C [macro <nmtv.h>] (NM_TREEVIEW *): EIF_POINTER"
		end

	cwel_nm_treeview_get_action (ptr: POINTER): INTEGER is
		external
			"C [macro <nmtv.h>] (NM_TREEVIEW *): EIF_POINTER"
		end

	cwel_nm_treeview_get_itemnew (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>] (NM_TREEVIEW *): EIF_POINTER"
		end

	cwel_nm_treeview_get_itemold (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>] (NM_TREEVIEW *): EIF_POINTER"
		end

	cwel_nm_treeview_get_ptdrag (ptr: POINTER): POINTER is
		external
			"C [macro <nmtv.h>] (NM_TREEVIEW *): EIF_POINTER"
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




end -- class WEL_NM_TREE_VIEW

