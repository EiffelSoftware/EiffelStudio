note
	description: "Status window text constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SBT_CONSTANTS

feature -- Access

	Sbt_borders: INTEGER = 0
			-- The text is drawn with a border to appear
			-- lower than the plane of the window.

	Sbt_noborders: INTEGER
			-- The text is drawn without borders.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SBT_NOBORDERS"
		end

	Sbt_ownerdraw: INTEGER
			-- The text is drawn by the parent window.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SBT_OWNERDRAW"
		end

	Sbt_popout: INTEGER
			-- The text is drawn with a border to appear
			-- higher than the plane of the window.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SBT_POPOUT"
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




end -- class WEL_SBT_CONSTANTS

