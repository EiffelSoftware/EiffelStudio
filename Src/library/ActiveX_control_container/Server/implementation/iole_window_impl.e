indexing
	description: "Implemented `IOleWindow' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_WINDOW_IMPL

inherit
	IOLE_WINDOW_INTERFACE

	WEL_FRAME_WINDOW
		rename
			class_name as wel_class_name,
			exists as wel_exists,
--			has_capture as wel_has_capture,
--			has_heavy_capture as wel_has_heavy_capture,
--			invalidate_rect as wel_invalidate_rect,
			item as wel_item,
--			release_capture as wel_release_capture,
--			set_capture as wel_set_capture,
--			set_focus as wel_set_focus,
			set_item as wel_set_item,
			set_menu as wel_set_menu
--			scroll as wel_scroll
		end
		
feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		do
			if not wel_exists then
				make_top (wel_class_name)
			end
			phwnd.put (wel_item)
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			-- No Implementation.
		end

end -- IOLE_WINDOW_IMPL

