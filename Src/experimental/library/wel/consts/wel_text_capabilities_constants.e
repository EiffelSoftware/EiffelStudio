note
	description: "Text capabilities (TC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TEXT_CAPABILITIES_CONSTANTS

feature -- Access

	Tc_op_character: INTEGER = 1
			-- Declared in Windows as TC_OP_CHARACTER

	Tc_op_stroke: INTEGER = 2
			-- Declared in Windows as TC_OP_STROKE

	Tc_cp_stroke: INTEGER = 4
			-- Declared in Windows as TC_CP_STROKE

	Tc_cr_90: INTEGER = 8
			-- Declared in Windows as TC_CR_90

	Tc_cr_any: INTEGER = 16
			-- Declared in Windows as TC_CR_ANY

	Tc_sf_x_yindep: INTEGER = 32
			-- Declared in Windows as TC_SF_X_YINDEP

	Tc_sa_double: INTEGER = 64
			-- Declared in Windows as TC_SA_DOUBLE

	Tc_sa_integer: INTEGER = 128
			-- Declared in Windows as TC_SA_INTEGER

	Tc_sa_contin: INTEGER = 256
			-- Declared in Windows as TC_SA_CONTIN

	Tc_ea_double: INTEGER = 512
			-- Declared in Windows as TC_EA_DOUBLE

	Tc_ia_able: INTEGER = 1024
			-- Declared in Windows as TC_IA_ABLE

	Tc_ua_able: INTEGER = 2048
			-- Declared in Windows as TC_UA_ABLE

	Tc_so_able: INTEGER = 4096
			-- Declared in Windows as TC_SO_ABLE

	Tc_ra_able: INTEGER = 8192
			-- Declared in Windows as TC_RA_ABLE

	Tc_va_able: INTEGER = 16384
			-- Declared in Windows as TC_VA_ABLE

	Tc_reserved: INTEGER = 32768;
			-- Declared in Windows as TC_RESERVED

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




end -- class WEL_TEXT_CAPABILITIES_CONSTANTS

