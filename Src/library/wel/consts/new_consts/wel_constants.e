indexing
	description	: "Objects to retrieve WEL constants"
	status		: "See notice at end of class."
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

end -- class WEL_CONSTANTS

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

