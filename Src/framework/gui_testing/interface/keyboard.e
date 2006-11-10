indexing
	description:
		"Interface to control keyboard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	KEYBOARD

inherit
	KEYS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			create {KEYBOARD_IMP}implementation
		end

feature -- Typing

	type (a_string: STRING) is
			-- Type `a_string' into keyboard.
		require
			a_string_not_void: a_string /= Void
		do
			a_string.linear_representation.do_all (agent type_character)
		end

	type_character (a_character: CHARACTER) is
			-- Type `a_character' into keyboard.
		local
			key: EV_KEY
		do
			type_ev_key (create {EV_KEY}.make_with_code (key_code_from_key_string (a_character.out)))
		end

	type_key (a_key_code: INTEGER) is
			-- Type key denoted by `a_key_code'.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			type_ev_key (create {EV_KEY}.make_with_code (a_key_code))
		end

	type_ev_key (a_key: EV_KEY) is
			-- Type `a_key' into keyboard.
		require
			a_key_not_void: a_key /= Void
		do
			press_key (a_key)
			release_key (a_key)
		end

feature -- Pressing

	press_key (a_key: EV_KEY) is
			-- Press `a_key'.
		do
			implementation.press_key (a_key)
		end

	release_key (a_key: EV_KEY) is
			-- Release `a_key'.
		do
			implementation.release_key (a_key)
		end

feature {NONE} -- Implementation

	implementation: KEYBOARD_I
			-- Implementation of keyboard interface

invariant

	implementation_not_void: implementation /= Void

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
