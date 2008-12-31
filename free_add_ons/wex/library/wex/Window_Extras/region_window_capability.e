note
	description: "Capability to transform the visible %
		%part of a window into any valid region"
	author: "Robin van Ommeren"
	revision: "$Revison $"
	date: "$Date$"

deferred class
	WEX_REGION_WINDOW_CAPABILITY

feature -- Access

	window_region: WEL_REGION
		do 
			create Result.make_empty
			cwin_get_window_region (item, Result.item)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	set_window_region (a_region: WEL_REGION; redraw_flag: BOOLEAN)
			-- Set `a_region' to be the region of the window.
		require
			a_region_not_void: a_region /= Void
			a_region_exists: a_region.exists
		do
			last_region := a_region
			cwin_set_window_region (item, a_region.item,
				redraw_flag)
		end

feature {NONE} -- Implementation

	item: POINTER
		deferred
		end

	last_region: WEL_REGION
			-- Keep a reference to the last set region to prevent
			-- it from being collected by the GC.

feature {NONE} -- External

	cwin_set_window_region (window_handle: POINTER; region_handle: POINTER;
			redraw_flag: BOOLEAN)
		external
			"C [macro <windows.h>] (HWND, HRGN, BOOL)"
		alias
			"SetWindowRgn"
		end

	cwin_get_window_region (window_handle: POINTER; region_handle: POINTER)
		external
			"C [macro <windows.h>] (HWND, HRGN)"
		alias
			"GetWindowRgn"
		end

end -- class WEX_REGION_WINDOW_CAPABILITY

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
