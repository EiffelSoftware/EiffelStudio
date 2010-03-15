note
	description: "[
		Constants for use by and with pointer handling actions.
		
		It's used to identify pointer buttons.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, primitives, drawing, line, point, ellipse"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_CONSTANTS

feature -- Constants

	left: INTEGER = 1
			-- Left pointer button.

	middle: INTEGER = 2
			-- Middle pointer button.

	right: INTEGER = 3
			-- Right pointer button.

feature -- Contract support

	valid_button (a_button: INTEGER): BOOLEAN
			-- If `a_button' valid?
		do
			Result := a_button = left or
					a_button = middle or
					a_button = right
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


end
