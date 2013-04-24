note
	description: "System beep rountines."
	legal: "See notice at end of class."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_BEEP

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Commands

	asterisk
			-- Asterisk beep.
		do
			implementation.asterisk
		end

	exclamation
			-- Exclamation beep.
		do
			implementation.exclamation
		end

	hand
			-- Hand beep.
		do
			implementation.hand
		end

	question
			-- Question beep.
		do
			implementation.question
		end

	ok
			-- Ok beep.
			-- System default beep.
		do
			implementation.ok
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_BEEP_I
			-- Responsible for interaction with native APIs.			

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_BEEP_IMP} implementation.make
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




end -- class EV_BEEP
