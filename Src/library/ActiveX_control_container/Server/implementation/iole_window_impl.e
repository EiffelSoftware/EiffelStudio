indexing
	description: "Implemented `IOleWindow' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			item as wel_item,
			set_item as wel_set_item,
			set_menu as wel_set_menu
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




end -- IOLE_WINDOW_IMPL

