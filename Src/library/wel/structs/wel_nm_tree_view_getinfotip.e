indexing
	description: "Contains information about a tree view notification%
		%message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_TREE_VIEW_GETINFOTIP

inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer

feature -- access

	hdr: WEL_NMHDR is
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_nmtvinfotip_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	psztext: POINTER is
			-- Address of text to be displayed.
		do
			Result := cwel_nmtvinfotip_get_psztext (item)
		ensure
			Result_not_default: Result /= default_pointer
		end

	cchtextmax: INTEGER is
			-- Size of buffer at `psztext'.
		do
			Result := cwel_nmtvinfotip_get_cchtextmax (item)
		ensure
			Result_not_void: Result >= 0
		end

	hitem: POINTER is
			-- Handle to item for which the tooltip is displayed.
		do
			Result := cwel_nmtvinfotip_get_hitem (item)
		ensure
			Result_not_default: Result /= default_pointer
		end

	lparam: INTEGER is
			-- Application defined data associated with `hitem'.
		do
			Result := cwel_nmtvinfotip_get_lparam (item)
		ensure
			Result_not_void: Result /= 0
		end

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_tvgetinfotip
		end

feature {NONE} -- Externals

	c_size_of_nm_tvgetinfotip: INTEGER is
		external
			"C [macro <commctrl.h>]"
		alias
			"sizeof (NMTVGETINFOTIP)"
		end

	cwel_nmtvinfotip_get_hdr (ptr: POINTER): POINTER is
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_POINTER"
		alias
			"&hdr"
		end

	cwel_nmtvinfotip_get_psztext (ptr: POINTER): POINTER is
			-- (export status {NONE})
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_POINTER"
		alias
			"pszText"
		end
		
	cwel_nmtvinfotip_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_INTEGER"
		alias
			"cchTextMax"
		end

	cwel_nmtvinfotip_get_hitem (ptr: POINTER): POINTER is
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_INTEGER"
		alias
			"hItem"
		end

	cwel_nmtvinfotip_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_INTEGER"
		alias
			"lParam"
		end


end -- class WEL_NM_TREE_VIEW_GETINFOTIP

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

