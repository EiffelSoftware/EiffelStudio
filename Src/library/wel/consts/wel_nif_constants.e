indexing
	description: "NIF constants used for the WEL_NOTIFY_ICON_DATA structure."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NIF_CONSTANTS

feature -- Access

	nif_icon: INTEGER is 0x2
			-- The hIcon member is valid.

	nif_message: INTEGER is 0x1
			-- The uCallbackMessage member is valid.

	nif_tip: INTEGER is 0x4
			-- The szTip member is valid.

	nif_state: INTEGER is 0x8
			-- The dwState and dwStateMask members are valid.

	nif_info: INTEGER is 0x10
			-- Use a balloon ToolTip instead of a standard ToolTip.
			-- The szInfo, uTimeout, szInfoTitle, and dwInfoFlags members are valid.

	nif_guid: INTEGER is 0x20
			-- Reserved.

end
