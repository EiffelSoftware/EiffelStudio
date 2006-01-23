indexing
	description	: "Constants relative to scroll bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_SCROLL_BAR_CONSTANTS

inherit
	WEL_SBS_CONSTANTS
	WEL_SB_CONSTANTS

feature -- ScrollInfo

	valid_sif_constant (i: INTEGER): BOOLEAN is
			-- Is `i' a valid Sif constant?
		do
			Result := (i = 0) or else (i = Sif_all) or else
				(i = Sif_range) or else
				(i = Sif_page) or else
				(i = Sif_pos) or else
				(i = Sif_disablenoscroll) or else
				(i = Sif_trackpos)
		end
		
	valid_sif_mask (i: INTEGER): BOOLEAN is
			-- is `i' a valid sif mask?
		do
			Result := i = i & (Sif_range | Sif_page | Sif_pos | Sif_disablenoscroll | Sif_trackpos)
		end

	Sif_all: INTEGER is 23
		-- 	Combination of SIF_PAGE, SIF_POS, SIF_RANGE, and SIF_TRACKPOS.

	Sif_range: INTEGER is 1
			-- The nMin and nMax members contain the minimum and maximum
			-- values for the scrolling range.

	Sif_page: INTEGER is 2
			-- The nPage member contains the page size for a proportional scroll bar.

	Sif_pos: INTEGER is 4
			-- The nPos member contains the scroll box position, which is not
			-- updated while the user drags the scroll box.

	Sif_disablenoscroll: INTEGER is 8
			-- This value is used only when setting a scroll bar's parameters.
			-- If the scroll bar's new parameters make the scroll bar
			-- unnecessary, disable the scroll bar instead of removing it.

	Sif_trackpos: INTEGER is 16;
			-- The nTrackPos member contains the current position of the
			-- scroll box while the user is dragging it.

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




end -- class WEL_INPUT_CONSTANTS

