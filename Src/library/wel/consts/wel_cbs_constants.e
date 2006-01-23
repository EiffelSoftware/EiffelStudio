indexing
	description	: "ComboBox Style (CBS) messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBS_CONSTANTS

feature -- Access

	Cbs_simple: INTEGER is 1
			-- Declared in Windows as CBS_SIMPLE

	Cbs_dropdown: INTEGER is 2
			-- Declared in Windows as CBS_DROPDOWN

	Cbs_dropdownlist: INTEGER is 3
			-- Declared in Windows as CBS_DROPDOWNLIST

	Cbs_ownerdrawfixed: INTEGER is 16
			-- Declared in Windows as CBS_OWNERDRAWFIXED

	Cbs_ownerdrawvariable: INTEGER is 32
			-- Declared in Windows as CBS_OWNERDRAWVARIABLE

	Cbs_autohscroll: INTEGER is 64
			-- Declared in Windows as CBS_AUTOHSCROLL

	Cbs_oemconvert: INTEGER is 128
			-- Declared in Windows as CBS_OEMCONVERT

	Cbs_sort: INTEGER is 256
			-- Declared in Windows as CBS_SORT

	Cbs_hasstrings: INTEGER is 512
			-- Declared in Windows as CBS_HASSTRINGS

	Cbs_nointegralheight: INTEGER is 1024
			-- Declared in Windows as CBS_NOINTEGRALHEIGHT

	Cbs_disablenoscroll: INTEGER is 2048;
			-- Declared in Windows as CBS_DISABLENOSCROLL

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




end -- class WEL_CBS_CONSTANTS

