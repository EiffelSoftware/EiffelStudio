indexing
	description: "NIF constants used for the WEL_NOTIFY_ICON_DATA structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	nif_guid: INTEGER is 0x20;
			-- Reserved.

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




end
