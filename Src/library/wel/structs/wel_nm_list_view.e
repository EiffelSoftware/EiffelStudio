indexing
	description: "Contains information about a list view notification %
				%message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_LIST_VIEW

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
			create Result.make_by_pointer (cwel_nm_listview_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	iitem: INTEGER is
			-- Information about the list view item or -1 if
			-- not used.
		do
			Result := cwel_nm_listview_get_iitem (item)
		end

	isubitem: INTEGER is
			-- Information about the subitem or 0 if none.
		do
			Result := cwel_nm_listview_get_isubitem (item)
		end

	unewstate: INTEGER is
			-- Information about the new item state or 0 if
			-- not used.
			-- See class WEL_LVIS_CONSTANTS.
		do
			Result := cwel_nm_listview_get_unewstate (item)
		end

	uoldstate: INTEGER is
			-- Information about the old item state or 0 if
			-- not used.		
		do
			Result := cwel_nm_listview_get_uoldstate (item)
		end

	uchanged: INTEGER is
			-- Information about the item attributes that
			-- has changed.
		do
			Result := cwel_nm_listview_get_uchanged (item)
		end

	position: WEL_POINT is
			-- Location at which the event occurred.
			-- valid argument only for the Lvn_begindrag and
			-- Lvn_beginrdrag notification messages.
		do
			create Result.make_by_pointer (cwel_nm_listview_get_ptaction (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_listview
		end

feature {NONE} -- Externals

	c_size_of_nm_listview: INTEGER is
		external
			"C [macro %"nmlv.h%"]"
		alias
			"sizeof (NM_LISTVIEW)"
		end

	cwel_nm_listview_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro %"nmlv.h%"] (NM_LISTVIEW*): EIF_POINTER"
		end

	cwel_nm_listview_get_iitem (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmlv.h%"]"
		end

	cwel_nm_listview_get_isubitem (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmlv.h%"]"
		end

	cwel_nm_listview_get_unewstate (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmlv.h%"]"
		end

	cwel_nm_listview_get_uoldstate (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmlv.h%"]"
		end

	cwel_nm_listview_get_uchanged (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmlv.h%"]"
		end

	cwel_nm_listview_get_ptaction (ptr: POINTER): POINTER is
		external
			"C [macro %"nmlv.h%"] (NM_LISTVIEW*): EIF_POINTER"
		end

	cwel_nm_listview_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro %"nmlv.h%"]"
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

end
