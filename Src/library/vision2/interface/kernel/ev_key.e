indexing
	description:
		"Eiffel Vision key. Represents a virtual key code. `code' can be any%N%
		%of the constant values defined in EV_KEY_CONSTANTS."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY

inherit
	EV_KEY_CONSTANTS
		export
			{NONE} all
			{ANY} valid_key_code
		redefine
			default_create,
			out
		end
		
	ANY
		redefine
			default_create,
			out
		end

create
	default_create,
	make_with_code

feature {NONE} -- Initialization

	default_create is
			-- Initialize with `Key_enter'.
		do
			Precursor
			code := Key_enter
		end

	make_with_code (a_code: INTEGER) is
			-- Initialize with `a_code'.
		require
			a_code_valid: valid_key_code (a_code)
		do
			default_create
			set_code (a_code)
		end

feature -- Access

	code: INTEGER
			-- Code representing some key.

feature -- Element change

	set_code (a_code: INTEGER) is
			-- Assign `a_code' to `code'.
		require
			a_code_valid: valid_key_code (a_code)
		do
			code := a_code
		ensure
			code_assigned: code = a_code
		end

feature -- Status report

	is_alpha: BOOLEAN is
			-- Is `code' in ["a"-"z"]?
		do
			Result := code >= Key_a and then code <= Key_z
		end

	is_numpad: BOOLEAN is
			-- Is `code' a key on the numpad?
		do
			Result := code >= Key_numpad_0 and then code <= Key_numpad_decimal
		end

	is_number: BOOLEAN is
			-- Is `code' in ["0"-"9"]?
		do
			Result := code >= Key_0 and then code <= Key_9
		end

	is_function: BOOLEAN is
			-- Is `code' a function key?
		do
			Result := code >= Key_F1 and then code <= Key_F12
		end

	is_arrow: BOOLEAN is
			-- Is `code' an arrow key?
		do
			Result := code >= Key_up and then code <= Key_right
		end

feature -- Standard output

	out: STRING is
			-- Readable representation of `code'.
		do
			Result := key_strings @ code
		end

invariant
	code_valid: valid_key_code (code)

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




end -- class EV_KEY

