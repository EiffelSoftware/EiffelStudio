note
	description: "Class Style (CS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CS_CONSTANTS

feature -- Access

	Cs_vredraw: INTEGER = 1

	Cs_hredraw: INTEGER = 2

	Cs_keycvtwindow: INTEGER = 4
			-- Not defined any more for some
			-- C compilers, returns old defined value

	Cs_dblclks: INTEGER = 8

	Cs_owndc: INTEGER = 32

	Cs_classdc: INTEGER = 64

	Cs_parentdc: INTEGER = 128

	Cs_noclose: INTEGER = 512

	Cs_savebits: INTEGER = 2048

	Cs_bytealignclient: INTEGER = 4096

	Cs_bytealignwindow: INTEGER = 8192

	Cs_globalclass: INTEGER = 16384

	Cs_nokeycvt: INTEGER = 256
			-- Not defined any more for some
			-- C compilers, returns old defined value

	Cs_ime: INTEGER = 65536
			-- Input Method Editor

	Cs_dropshadow: INTEGER = 0x00020000;
			-- Drop shadow effect
			-- This value is not supported until Windows XP.

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




end -- class WEL_CS_CONSTANTS

