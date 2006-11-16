indexing
	description: "[
		Constants for use by and with pointer handling actions.
		
		It's used for identify pointer buttons.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, primitives, drawing, line, point, ellipse"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_CONSTANTS

feature -- Constants

	left: INTEGER is 1
			-- Left pointer button.

	middle: INTEGER is 2
			-- Middl pointer button.

	right: INTEGER is 3
			-- Right pointer button.

feature -- Contract support

	valid (a_button: INTEGER): BOOLEAN is
			-- If `a_button' vaild?
		do
			Result := a_button = left or
					a_button = middle or
					a_button = right
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


end
