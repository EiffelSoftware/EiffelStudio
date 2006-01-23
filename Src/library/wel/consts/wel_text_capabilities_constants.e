indexing
	description: "Text capabilities (TC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TEXT_CAPABILITIES_CONSTANTS

feature -- Access

	Tc_op_character: INTEGER is 1
			-- Declared in Windows as TC_OP_CHARACTER

	Tc_op_stroke: INTEGER is 2
			-- Declared in Windows as TC_OP_STROKE

	Tc_cp_stroke: INTEGER is 4
			-- Declared in Windows as TC_CP_STROKE

	Tc_cr_90: INTEGER is 8
			-- Declared in Windows as TC_CR_90

	Tc_cr_any: INTEGER is 16
			-- Declared in Windows as TC_CR_ANY

	Tc_sf_x_yindep: INTEGER is 32
			-- Declared in Windows as TC_SF_X_YINDEP

	Tc_sa_double: INTEGER is 64
			-- Declared in Windows as TC_SA_DOUBLE

	Tc_sa_integer: INTEGER is 128
			-- Declared in Windows as TC_SA_INTEGER

	Tc_sa_contin: INTEGER is 256
			-- Declared in Windows as TC_SA_CONTIN

	Tc_ea_double: INTEGER is 512
			-- Declared in Windows as TC_EA_DOUBLE

	Tc_ia_able: INTEGER is 1024
			-- Declared in Windows as TC_IA_ABLE

	Tc_ua_able: INTEGER is 2048
			-- Declared in Windows as TC_UA_ABLE

	Tc_so_able: INTEGER is 4096
			-- Declared in Windows as TC_SO_ABLE

	Tc_ra_able: INTEGER is 8192
			-- Declared in Windows as TC_RA_ABLE

	Tc_va_able: INTEGER is 16384
			-- Declared in Windows as TC_VA_ABLE

	Tc_reserved: INTEGER is 32768;
			-- Declared in Windows as TC_RESERVED

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




end -- class WEL_TEXT_CAPABILITIES_CONSTANTS

