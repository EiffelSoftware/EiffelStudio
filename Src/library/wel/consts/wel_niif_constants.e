indexing
	description: "[
		NIIF constants to control WEL_NOTIFY_ICON_DATA structure.
		Note: Version 5.0. Flags that can be set to add an icon to a balloon ToolTip.
		It is placed to the left of the title. If the szInfoTitle member is zero-length,
		the icon is not shown.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NIIF_CONSTANTS

feature -- Access

	niif_none: INTEGER is 0x0
			-- No icon.

	niif_info: INTEGER is 0x1
			-- An information icon.

	niif_warning: INTEGER is 0x2
			-- A warning icon.

	niif_error: INTEGER is 0x3
			-- An error icon.

	niif_user: INTEGER is 0x4
			-- Windows XP Service Pack 2 (SP2) and later.
			-- Use the icon identified in hIcon as the notification balloon's title icon.

	niif_icon_mask: INTEGER is 0xF
			-- Version 6.0. Reserved.

	niif_nosound: INTEGER is 0x10;
			-- Version 6.0. Do not play the associated sound. Applies only to balloon ToolTips.

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
