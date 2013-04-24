note
	description: "Pen style (PS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PS_CONSTANTS

feature -- Access (Basic style constants)

	Ps_solid: INTEGER = 		0x00000000
	Ps_dash: INTEGER = 			0x00000001
	Ps_dot: INTEGER = 			0x00000002
	Ps_dashdot: INTEGER = 		0x00000003
	Ps_dashdotdot: INTEGER = 	0x00000004
	Ps_null: INTEGER = 			0x00000005
	Ps_insideframe: INTEGER = 	0x00000006
		-- Mutually exclusive pen style constants.

feature -- Access (Extended Style constants for use in conjunction with {WEL_PEN}.make_from_brush)

	Ps_userstyle: INTEGER = 	0x00000007
	Ps_alternate: INTEGER = 	0x00000008
		-- Mutually exclusive pen style constants.

	Ps_cosmetic: INTEGER = 		0x00000000
	Ps_geometric: INTEGER = 	0x00010000
		-- Brush type style constants

	Ps_join_round: INTEGER = 	0x00000000
	Ps_join_bevel: INTEGER = 	0x00001000
	Ps_join_miter: INTEGER = 	0x00002000
	Ps_endcap_round: INTEGER = 	0x00000000
	Ps_endcap_square: INTEGER = 0x00000100
	Ps_endcap_flat: INTEGER = 	0x00000200
		-- Ps_geometric style constants.

feature -- Contract Support

	valid_pen_style_constant (c: INTEGER): BOOLEAN
 			-- Is `c' a valid pen style constant?
 			-- Only valid for non-extended pen creation.
 		do
			Result := c >= Ps_solid or c <= Ps_insideframe
		end

	valid_extended_pen_style (c: INTEGER): BOOLEAN
			-- Is `c' a valid style constant when used in conjunction with a WEL_LOG_BRUSH.
		do
			Result := c & 0x1330F = c
		end

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




end -- class WEL_PS_CONSTANTS

