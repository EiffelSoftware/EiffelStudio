note
	description: "Contains information about a tree view notification%
		%message."
	legal: "See notice at end of class."
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

	hdr: WEL_NMHDR
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_nmtvinfotip_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	psztext: POINTER
			-- Address of text to be displayed.
		do
			Result := cwel_nmtvinfotip_get_psztext (item)
		ensure
			Result_not_default: Result /= default_pointer
		end

	cchtextmax: INTEGER
			-- Size of buffer at `psztext'.
		do
			Result := cwel_nmtvinfotip_get_cchtextmax (item)
		ensure
			Result_not_void: Result >= 0
		end

	hitem: POINTER
			-- Handle to item for which the tooltip is displayed.
		do
			Result := cwel_nmtvinfotip_get_hitem (item)
		ensure
			Result_not_default: Result /= default_pointer
		end

	lparam: INTEGER
			-- Application defined data associated with `hitem'.
		do
			Result := cwel_nmtvinfotip_get_lparam (item)
		ensure
			Result_not_void: Result /= 0
		end

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_tvgetinfotip
		end

feature {NONE} -- Externals

	c_size_of_nm_tvgetinfotip: INTEGER
		external
			"C [macro <commctrl.h>]"
		alias
			"sizeof (NMTVGETINFOTIP)"
		end

	cwel_nmtvinfotip_get_hdr (ptr: POINTER): POINTER
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_POINTER"
		alias
			"&hdr"
		end

	cwel_nmtvinfotip_get_psztext (ptr: POINTER): POINTER
			-- (export status {NONE})
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_POINTER"
		alias
			"pszText"
		end
		
	cwel_nmtvinfotip_get_cchtextmax (ptr: POINTER): INTEGER
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_INTEGER"
		alias
			"cchTextMax"
		end

	cwel_nmtvinfotip_get_hitem (ptr: POINTER): POINTER
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_INTEGER"
		alias
			"hItem"
		end

	cwel_nmtvinfotip_get_lparam (ptr: POINTER): INTEGER
		external
			"C [struct <commctrl.h>] (NMTVGETINFOTIP): EIF_INTEGER"
		alias
			"lParam"
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
