indexing
	description: "NIM constants used for notification to the taskbar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NIM_CONSTANTS

feature -- Access

	nim_add: INTEGER is 0
			-- Adds an icon to the status area. The hWnd and uID members of the
			-- NOTIFYICONDATA structure pointed to by lpdata will be used to
			-- identify the icon in later calls to Shell_NotifyIcon.

	nim_modify: INTEGER is 1
			-- Modifies an icon in the status area. Use the hWnd and uID members
			-- of the NOTIFYICONDATA structure pointed to by lpdata to identify
			-- the icon to be modified.

	nim_delete: INTEGER is 2
			-- Deletes an icon from the status area. Use the hWnd and uID members
			-- of the NOTIFYICONDATA structure pointed to by lpdata to identify
			-- the icon to be deleted.

	nim_setfocus: INTEGER is 3
			-- Version 5.0. Returns focus to the taskbar notification area. Taskbar
			-- icons should use this message when they have completed their user
			-- interface operation. For example, if the taskbar icon displays a
			-- shortcut menu, but the user presses ESC to cancel it, use NIM_SETFOCUS
			-- to return focus to the taskbar notification area.

	nim_setversion: INTEGER is 4;
			-- Version 5.0. Instructs the taskbar to behave according to the version
			-- number specified in the uVersion member of the structure pointed to
			-- by lpdata. This message allows you to specify whether you want the
			-- version 5.0 behavior found on Microsoft Windows 2000 systems, or
			-- that found with earlier Shell versions. The default value for uVersion
			-- is zero, indicating that the original Windows 95 notify icon behavior
			-- should be used. For details, see the Remarks section.

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
