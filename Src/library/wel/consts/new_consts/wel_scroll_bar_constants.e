indexing
	description	: "Constants relative to scroll bar"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_SCROLL_BAR_CONSTANTS

inherit
	WEL_SBS_CONSTANTS
	WEL_SB_CONSTANTS

feature -- ScrollInfo

	valid_sif_constant (i: INTEGER): BOOLEAN is
			-- Is `i' a good combination of Sif constants?
		local
			op: WEL_BIT_OPERATIONS
		do
			create op
			Result := op.flag_set (i, 1) or else op.flag_set (i, 2) or else
				op.flag_set (i, 3) or else op.flag_set (i, 4) or else op.flag_set (i, 5)
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

	Sif_trackpos: INTEGER is 16
			-- The nTrackPos member contains the current position of the
			-- scroll box while the user is dragging it.

end -- class WEL_INPUT_CONSTANTS
