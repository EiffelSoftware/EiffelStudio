indexing
	description	: "Objects to retrieve WEL constants"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
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

	Wel_ht_constants: WEL_HT_CONSTANTS is
			-- Access to Ht_xxxconstnats
		once
			create Result
		end

end -- class WEL_CONSTANTS
