note
	description: "Helper class for WEX_TOOL_BAR, to parse the user-defined-resource-type TOOLBAR"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"
class WEX_TOOL_BAR_DATA
inherit
	WEL_RESOURCE
create
	make_by_id, make_by_name
feature -- Access

	version: INTEGER
		require
			exists: exists
		local
			i:INTEGER
		do
			Result := cwex_tool_bar_data_version (item)
		end	

	width: INTEGER
		require
			exists: exists
		do
			Result := cwex_tool_bar_data_width (item)
		end	

	height: INTEGER
		require
			exists: exists
		do
			Result := cwex_tool_bar_data_height (item)
		end	
	command_id_count: INTEGER
		require
			exists: exists
		do
			Result := cwex_tool_bar_data_item_count (item)
		end
	
	command_id_at (index: INTEGER): INTEGER
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < command_id_count
		do
			Result := cwex_tool_bar_data_items (item, index)
		end

feature {NONE}
	load_item (hinstance, a_id: POINTER)
		do
			item := cwin_lock_resource (cwin_load_resource (hinstance, 
									cwin_find_resource (hinstance, a_id, cwin_make_int_resource (241))))
		end
 destroy_item
			-- Destroy icon.
		do
			item := default_pointer
		end

	cwin_load_resource (hinstance: POINTER; a_id: POINTER): POINTER
				-- SDK LoadIcon
			external
				"C [macro <wel.h>] (HMODULE, HRSRC): EIF_POINTER"
			alias 
				"LoadResource"
			end;
	
	cwin_find_resource (hmodule, lpname, lptype: POINTER): POINTER
				-- SDK LoadIcon
			external
				"C [macro <wel.h>] (HMODULE, LPCSTR, LPCSTR): EIF_POINTER"
			alias 
				"FindResource"
			end;
	cwin_lock_resource (hresdata: POINTER): POINTER
				-- SDK LoadIcon
			external
				"C [macro <wel.h>] (HGLOBAL): EIF_POINTER"
			alias 
				"LockResource"
			end;
	
	cwex_tool_bar_data_version (a_item: POINTER): INTEGER
			external
				"C"
			end;
	cwex_tool_bar_data_width (a_item: POINTER): INTEGER
			external
				"C"
			end;
	cwex_tool_bar_data_height (a_item: POINTER): INTEGER
			external
				"C"
			end;
	cwex_tool_bar_data_item_count (a_item: POINTER): INTEGER
			external
				"C"
			end;
	cwex_tool_bar_data_items (a_item: POINTER; index: INTEGER): INTEGER
			external
				"C"
			end;
end

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