indexing
	description: "Pen style (PS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PS_CONSTANTS

feature -- Access

	Ps_solid: INTEGER is 0

	Ps_dash: INTEGER is 1

	Ps_dot: INTEGER is 2

	Ps_dashdot: INTEGER is 3

	Ps_dashdotdot: INTEGER is 4

	Ps_null: INTEGER is 5

	Ps_insideframe: INTEGER is 6

feature -- Status report

	valid_pen_style_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid pen style constant?
		do
			Result := c = Ps_solid or else
				c = Ps_dash or else
				c = Ps_dot or else
				c = Ps_dashdot or else
				c = Ps_dashdotdot or else
				c = Ps_null or else
				c = Ps_insideframe
		end

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




end -- class WEL_PS_CONSTANTS

