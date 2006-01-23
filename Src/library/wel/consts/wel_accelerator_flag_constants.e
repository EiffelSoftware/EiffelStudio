indexing
	description	: "Constants for defining accelerator keys %
				  %in WEL_ACCELERATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_ACCELERATOR_FLAG_CONSTANTS

feature -- Access

	Fcontrol: INTEGER is 8
			-- The CTRL key must be held down when the accelerator
			-- key is pressed.
			--
			-- Declared in Windows as FCONTROL

	Fnoinvert: INTEGER is 2
			-- Specifies that no top-level menu item is highlighted
			-- when the accelerator is used. If this flag is not
			-- specified, a top-level menu item will be
			-- highlighted, if possible, when the accelerator is
			-- used.
			--
			-- Declared in Windows as FNOINVERT

	Fshift: INTEGER is 4
			-- The SHIFT key must be held down when the accelerator
			-- key is pressed.
			--
			-- Declared in Windows as FSHIFT

	Fvirtkey: INTEGER is 1
			-- The key member specifies a virtual-key code. If this
			-- flag is not specified, key is assumed to specify an
			-- ASCII character code.
			--
			-- Declared in Windows as FVIRTKEY

	Falt: INTEGER is 16;
			-- The ALT key must be held down when the accelerator
			-- key is pressed.
			--
			-- Declared in Windows as FALT

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




end -- class WEL_ACCELERATOR_FLAG_CONSTANTS

