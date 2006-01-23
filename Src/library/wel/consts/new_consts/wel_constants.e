indexing
	description	: "Objects to retrieve WEL constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CONSTANTS

create
	default_create

feature -- Access

	Wel_window_constants: WEL_WINDOW_CONSTANTS is
			-- Window managment constants:
			-- Include constants:
			--   WM_xxxx
			--   ...
		once
			create Result
		end

	Wel_list_view_constants: WEL_LIST_VIEW_CONSTANTS is
			-- ListView Control Constants
			-- Include constants:
			--   LVM_xxxx
			--   LVS_xxxx
			--   LVN_xxxx
			--   ...
		once
			create Result
		end

	Wel_input_constants: WEL_INPUT_CONSTANTS is
			-- Mouse Constants
			-- Include constants:
			--   MA_xxxx
			--   ...
		once
			create Result
		end

	Wel_color_constants: WEL_COLOR_CONSTANTS is
			-- Access to COLOR_xxx constants.
		once
			create Result
		end

	Wel_drawing_constants: WEL_DRAWING_CONSTANTS is
			-- Drawing Constants
			-- Include constants:
			--   DI_xxxx
			--   DT_xxxx
			--   ...
		once
			create Result
		end

	Wel_ownerdraw_constants: WEL_ODS_CONSTANTS is
			-- Owner Drawing Constants
			-- Include constants:
			--   ODS_xxxx
			--   ...
		once
			create Result
		end

	Wel_ht_constants: WEL_HT_CONSTANTS is
			-- Access to Ht_xxxconstnats
		once
			create Result
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




end -- class WEL_CONSTANTS

