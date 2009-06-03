note

	description:
		"Button drawn on screen with an arrow"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	ARROW_B_I 

inherit

	BUTTON_I
	
feature -- Status report

	down: BOOLEAN
			-- Is the arrow direction down ?
		deferred
		end;

	left: BOOLEAN
			-- Is the arrow direction left ?
		deferred
		end;

	right: BOOLEAN
			-- Is the arrow direction right ?
		deferred
		end;

	up: BOOLEAN
			-- Is the arrow direction up ?
		deferred
		end

feature -- Status setting

	set_down
			-- Set the arrow direction to down.
		deferred
		end;

	set_left
			-- Set the arrow direction to left.
		deferred
		end;

	set_right
			-- Set the arrow direction to right.
		deferred
		end;

	set_up
			-- Set the arrow direction to up.
		deferred
		end;

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




end -- class ARROW_B_I

