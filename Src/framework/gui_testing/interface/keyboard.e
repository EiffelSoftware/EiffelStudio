note
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

	THREAD_CONTROL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize object.
		do
			create {KEYBOARD_IMP}implementation
			typing_delay :=   50_000_000
			pressing_delay :=  5_000_000
			releasing_delay := 5_000_000
		end

feature -- Typing

	type (a_string: STRING)
			-- Type `a_string' into keyboard.
		require
			a_string_not_void: a_string /= Void
		do
			a_string.linear_representation.do_all (agent type_character)
		end

	type_character (a_character: CHARACTER)
			-- Type `a_character' into keyboard.
		do
			if a_character = ' ' then
				type_key (key_space)
			elseif a_character.is_upper then
				press_key (key_shift)
				type_key (key_code_from_key_string (a_character.out))
				release_key (key_shift)
			else
				type_key (key_code_from_key_string (a_character.out))
			end
		end

	type_key (a_key_code: INTEGER)
			-- Type key denoted by `a_key_code'.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			type_ev_key (create {EV_KEY}.make_with_code (a_key_code))
		end

	type_modified_key (a_modifier_mask, a_key_code: INTEGER)
			-- Type key denoted by `a_key_code' while using modifiers.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			press_modifiers (a_modifier_mask)
			type_key (a_key_code)
			release_modifiers (a_modifier_mask)
		end

	type_ev_key (a_key: EV_KEY)
			-- Type `a_key' into keyboard.
		require
			a_key_not_void: a_key /= Void
		do
			press_ev_key (a_key)
			release_ev_key (a_key)
			sleep (typing_delay)
		end

feature -- Pressing

	press_key (a_key_code: INTEGER)
			-- Press `a_key'.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			press_ev_key (create {EV_KEY}.make_with_code (a_key_code))
		end

	release_key (a_key_code: INTEGER)
			-- Release `a_key'.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			release_ev_key (create {EV_KEY}.make_with_code (a_key_code))
		end

	press_ev_key (a_key: EV_KEY)
			-- Press `a_key'.
		do
			implementation.press_key (a_key)
			sleep (pressing_delay)
		end

	release_ev_key (a_key: EV_KEY)
			-- Release `a_key'.
		do
			implementation.release_key (a_key)
			sleep (releasing_delay)
		end

	press_modifiers (a_modifier_mask: INTEGER)
			-- Press modifiers.
		do
			if a_modifier_mask.bit_and (shift) /= 0 then
 				press_key (key_shift)
			end
			if a_modifier_mask.bit_and (control) /= 0 then
 				press_key (key_ctrl)
			end
			if a_modifier_mask.bit_and (alt) /= 0 then
 				press_key (key_alt)
			end
		end

	release_modifiers (a_modifier_mask: INTEGER)
			-- Press modifiers.
		do
			if a_modifier_mask.bit_and (shift) /= 0 then
 				release_key (key_shift)
			end
			if a_modifier_mask.bit_and (control) /= 0 then
 				release_key (key_ctrl)
			end
			if a_modifier_mask.bit_and (alt) /= 0 then
 				release_key (key_alt)
			end
		end

feature -- Access

	typing_delay: INTEGER
			-- Delay in nanoseconds after a key is typed

	pressing_delay: INTEGER
			-- Delay in milliseconds after a key is pressed

	releasing_delay: INTEGER
			-- Delay in nanoseconds after a key is released

feature -- Element change

	set_typing_delay (a_value: INTEGER)
			-- Set `typing_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			typing_delay := a_value
		ensure
			typing_delay_set: typing_delay = a_value
		end

	set_pressing_delay (a_value: INTEGER)
			-- Set `pressing_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			pressing_delay := a_value
		ensure
			pressing_delay_set: pressing_delay = a_value
		end

	set_releasing_delay (a_value: INTEGER)
			-- Set `releasing_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			releasing_delay := a_value
		ensure
			releasing_delay_set: releasing_delay = a_value
		end

feature {NONE} -- Implementation

	implementation: KEYBOARD_I
			-- Implementation of keyboard interface

invariant

	implementation_not_void: implementation /= Void

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
