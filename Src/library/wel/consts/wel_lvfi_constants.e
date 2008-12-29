note
	description	: "[
		Flags defining search in a list view.
		Used in WEL_LIST_VIEW_SEARCH_INFO.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVFI_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Acess

	Lvfi_param: INTEGER = 1
			-- Search item with corresponding lparam attribute
			--
			-- Declared in Windows as LVFI_PARAM

	Lvfi_partial: INTEGER = 8
			-- Search item including given string
			--
			-- Declared in Windows as LVFI_PARTIAL

	Lvfi_string: INTEGER = 2
			-- Search item with exact corresponding string
			--
			-- Declared in Windows as LVFI_STRING

	Lvfi_wrap: INTEGER = 32
			-- Start search from start when end of list view is reached
			--
			-- Declared in Windows as LVFI_WRAP

	Lvfi_nearestxy: INTEGER = 64
			-- Search item nearest specified position in specified direction
			--
			-- Declared in Windows as LVFI_NEARESTXY

feature -- Validation

	is_valid_list_view_flag (a_flag: INTEGER): BOOLEAN
			-- Is `a_flag' a valid list view search flag?
		do
			Result := a_flag = Lvfi_param or a_flag = Lvfi_partial
						or a_flag = Lvfi_string or a_flag = Lvfi_wrap
						or a_flag = Lvfi_nearestxy
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




end -- class WEL_LVFI_CONSTANTS

