note
	description:
		"Eiffel Vision beep routines. Implementation interface."
	legal: "See notice at end of class."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_BEEP_I

inherit
	EV_ANY_I

feature -- Commands

	asterisk
			-- Asterisk beep.
		deferred
		end

	exclamation
			-- Exclamation beep.
		deferred
		end

	hand
			-- Hand beep.
		deferred
		end

	question
			-- Question beep.
		deferred
		end

	ok
			-- Ok beep.
			-- System default beep.
		deferred
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




end -- class EV_BEEP_I
