indexing
	description:
		"Eiffel Vision key. Represents a virtual key code. `code' can be any%N%
		%of the constant values defined in EV_KEY_CONSTANTS."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY

inherit
	EV_KEY_CONSTANTS
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
		
feature -- Obsolete

	is_valid_accelerator: BOOLEAN is
			-- Is `code' accepted as accelerator key code?
		Obsolete
			"All current keys are valid accelerators."
		do
			Result := True
			--| All current key constants are valid.
		end

invariant
	code_valid: valid_key_code (code)

end -- class EV_KEY

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
