indexing
	description: "NIS constants to control state in WEL_NOTIFY_ICON_DATA structure."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NIS_CONSTANTS

feature -- Access

	nis_hidden: INTEGER is 0x1
			-- The icon is hidden.

	nis_sharedicon: INTEGER is 0x2
			-- The icon is shared.

end
