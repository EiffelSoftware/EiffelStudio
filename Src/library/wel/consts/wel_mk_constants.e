indexing
	description	: "Mouse and Key (MK) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_MK_CONSTANTS

feature -- Access

	Mk_control: INTEGER is 8
			-- Declared in Windows as MK_CONTROL

	Mk_lbutton: INTEGER is 1
			-- Declared in Windows as MK_LBUTTON

	Mk_mbutton: INTEGER is 16
			-- Declared in Windows as MK_MBUTTON

	Mk_rbutton: INTEGER is 2
			-- Declared in Windows as MK_RBUTTON

	Mk_shift: INTEGER is 4;
			-- Declared in Windows as MK_SHIFT

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




end -- class WEL_MK_CONSTANTS

