indexing
	description: "Icon constants"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICON_CONSTANTS

feature -- Access

	Icon_small: INTEGER is
			-- Small icon
		external
			"C [macro %"windows.h%"]"
		alias
			"ICON_SMALL"
		end

	Icon_big: INTEGER is
			-- Large icon
		external
			"C [macro %"windows.h%"]"
		alias
			"ICON_BIG"
		end

end -- class WEL_ICON_CONSTANTS
