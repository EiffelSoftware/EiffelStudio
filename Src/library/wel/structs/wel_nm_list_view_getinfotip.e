indexing
	description: "Objects that contain information about a list view notification%
		%message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_LIST_VIEW_GETINFOTIP
	
inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer

feature -- access

	hdr: WEL_NMHDR is
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_nmlvinfotip_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end
		
	dwflags: INTEGER is
			-- Flags, either 0 or LVGIT_UNFOLDED.
		do
			Result := cwel_nmlvinfotip_get_dwflags (item)
		end

	psztext: POINTER is
			-- Address of text to be displayed.
		do
			Result := cwel_nmlvinfotip_get_psztext (item)
		ensure
			Result_not_default: Result /= default_pointer
		end

	cchtextmax: INTEGER is
			-- Size of buffer at `psztext'.
		do
			Result := cwel_nmlvinfotip_get_cchtextmax (item)
		ensure
			Result_not_void: Result >= 0
		end
		
	iitem: INTEGER is
			-- Zero-based index of the item to which this structure refers. 
		do
			Result := cwel_nmlvinfotip_get_iitem (item)
		ensure
			Result_not_negative: Result >= 0
		end
		
	lparam: INTEGER is
			-- Application defined data associated with `hitem'.
		do
			Result := cwel_nmlvinfotip_get_lparam (item)
		ensure
			Result_not_void: Result /= 0
		end

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_lvgetinfotip
		end

feature {NONE} -- Externals

	c_size_of_nm_lvgetinfotip: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (NMLVGETINFOTIP)"
		end

	cwel_nmlvinfotip_get_hdr (ptr: POINTER): POINTER is
		external
			"C [struct <windows.h>] (NMLVGETINFOTIP): EIF_POINTER"
		alias
			"&hdr"
		end
		
	cwel_nmlvinfotip_get_dwflags (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (NMLVGETINFOTIP): EIF_INTEGER"
		alias
			"dwFlags"
		end

	cwel_nmlvinfotip_get_psztext (ptr: POINTER): POINTER is
		external
			"C [struct <windows.h>] (NMLVGETINFOTIP): EIF_POINTER"
		alias
			"pszText"
		end

	cwel_nmlvinfotip_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (NMLVGETINFOTIP): EIF_INTEGER"
		alias
			"cchTextMax"
		end
		
	cwel_nmlvinfotip_get_iitem (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (NMLVGETINFOTIP): EIF_INTEGER"
		alias
			"iItem"
		end
		
	cwel_nmlvinfotip_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (NMLVGETINFOTIP): EIF_INTEGER"
		alias
			"lParam"
		end

end -- class WEL_NM_LIST_VIEW_GETINFOTIP


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


