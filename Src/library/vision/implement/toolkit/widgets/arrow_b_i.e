indexing

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

	down: BOOLEAN is
			-- Is the arrow direction down ?
		deferred
		end;

	left: BOOLEAN is
			-- Is the arrow direction left ?
		deferred
		end;

	right: BOOLEAN is
			-- Is the arrow direction right ?
		deferred
		end;

	up: BOOLEAN is
			-- Is the arrow direction up ?
		deferred
		end

feature -- Status setting

	set_down is
			-- Set the arrow direction to down.
		deferred
		end;

	set_left is
			-- Set the arrow direction to left.
		deferred
		end;

	set_right is
			-- Set the arrow direction to right.
		deferred
		end;

	set_up is
			-- Set the arrow direction to up.
		deferred
		end;

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




end -- class ARROW_B_I

