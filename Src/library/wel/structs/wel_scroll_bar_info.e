note
	description: "The TV_DISPINFO structure retrieves and sets%
				% information about a scroll bar item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCROLL_BAR_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_SCROLL_BAR_CONSTANTS
		export
			{ANY} valid_sif_mask
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create SCROLLINFO struct
		do
			structure_make
			cwel_set_cb_size (item, structure_size)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_scroll_info_size
		end

feature -- Access

	mask: INTEGER
			-- `fmask' associated with Current
		require
			exists: exists
		do
			Result := cwel_get_fmask (item)
		ensure
			valid_mask: valid_sif_mask (Result)
		end

	position: INTEGER
			-- `nPos' associated with Current
		require
			exists: exists
		do
			Result := cwel_get_npos (item)
		end

	track_position: INTEGER
			-- `nTrackPos' associated with Current
		require
			exists: exists
		do
			Result := cwel_get_ntrackpos (item)
		end

	minimum: INTEGER
			-- `nMin' associated with Current
		require
			exists: exists
		do
			Result := cwel_get_nmin (item)
		end

	maximum: INTEGER
			-- `nMax' associated with Current
		require
			exists: exists
		do
			Result := cwel_get_nmax (item)
		end

	page: INTEGER
			-- `nMax' associated with Current
		require
			exists: exists
		do
			Result := cwel_get_npage (item)
		end

feature -- Setting
		
	set_mask (i: INTEGER)
			-- Assign `i' to `fmask' field of Current.
		require
			exists: exists
			valid_mask: valid_sif_mask (i)
		do
			cwel_set_fmask (item, i) 
		end

	set_position (i: INTEGER)
			-- `nPos' associated with Current
		require
			exists: exists
		do
			cwel_set_npos (item, i)
		end

	set_track_position (i: INTEGER)
			-- `nTrackPos' associated with Current
		require
			exists: exists
		do
			cwel_set_ntrackpos (item, i)
		end

	set_minimum (i: INTEGER)
			-- `nMin' associated with Current
		require
			exists: exists
		do
			cwel_set_nmin (item, i)
		end

	set_maximum (i: INTEGER)
			-- `nMax' associated with Current
		require
			exists: exists
		do
			cwel_set_nmax (item, i)
		end

	set_page (i: INTEGER)
			-- `npage' associated with Current
		require
			exists: exists
		do
			cwel_set_npage (item, i)
		end

feature {NONE} -- Externals

	c_scroll_info_size: INTEGER
			-- Size of SCROLLINFO struct
		external
			"C [macro <windows.h>]"
		alias
			"sizeof(SCROLLINFO)"
		end

	cwel_set_cb_size (p: POINTER; v: INTEGER)
			-- Set `cbSize' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, UINT)"
		alias
			"cbSize"
		end

	cwel_set_fmask (p: POINTER; v: INTEGER)
			-- Set `fMask' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, UINT)"
		alias
			"fMask"
		end

	cwel_set_nmin (p: POINTER; v: INTEGER)
			-- Set `nMin' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, int)"
		alias
			"nMin"
		end

	cwel_set_nmax (p: POINTER; v: INTEGER)
			-- Set `nMax' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, int)"
		alias
			"nMax"
		end

	cwel_set_npage (p: POINTER; v: INTEGER)
			-- Set `nPage' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, UINT)"
		alias
			"nPage"
		end

	cwel_set_npos (p: POINTER; v: INTEGER)
			-- Set `nPage' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, int)"
		alias
			"nPos"
		end

	cwel_set_nTrackPos (p: POINTER; v: INTEGER)
			-- Set `nPage' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO, int)"
		alias
			"nTrackPos"
		end

	cwel_get_cb_size (p: POINTER): INTEGER
			-- Get `cbSize' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"cbSize"
		end

	cwel_get_fmask (p: POINTER): INTEGER
			-- Set `fMask' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"fMask"
		end

	cwel_get_nmin (p: POINTER): INTEGER
			-- Set `nMin' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"nMin"
		end

	cwel_get_nmax (p: POINTER): INTEGER
			-- Set `nMax' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"nMax"
		end

	cwel_get_npage (p: POINTER): INTEGER
			-- Set `nPage' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"nPage"
		end

	cwel_get_npos (p: POINTER): INTEGER
			-- Set `nPage' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"nPos"
		end

	cwel_get_nTrackPos (p: POINTER): INTEGER
			-- Set `nPage' field of SCROLLINFO
		external
			"C [struct <windows.h>] (SCROLLINFO): EIF_INTEGER"
		alias
			"nTrackPos"
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
