indexing
	description: "STRING_MANIPULATOR Implementation."

class
	STRING_MANIPULATOR

creation
	make

feature {NONE}  -- Initialization

	make is
			-- Creation
		do
			create local_string.make (0)
		end
												
feature -- Access

	string: STRING is
			-- Manipulated string
		require
			exists: string_exists
		do
			Result := local_string
		end

feature -- Basic Operations

	set_string (arg_1: STRING) is
			-- Set manipulated string with `arg_1'.
		do
			local_string := arg_1
		ensure
			string_set: local_string = arg_1
		end

	replace_substring (arg_1: STRING; arg_2: INTEGER; arg_3: INTEGER) is
			-- Copy the characters of `arg_1' to positions `arg_2' .. `arg_3'.
		require
			exists: string_exists
		do
			local_string.replace_substring (arg_1, arg_2, arg_3)
		end

	prune_all (arg_1: CHARACTER) is
			-- Remove all occurrences of `arg_1'.
		require
			exists: string_exists
		do
			local_string.prune_all (arg_1)
		ensure 
			pruned: not local_string.has (arg_1)
		end

feature -- Status report

	string_exists: BOOLEAN is
			-- String exists.
		do
			Result := local_string /= Void
		end

feature {NONE} -- Implementation

	local_string: STRING

end -- STRING_MANIPULATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-2001.
--| Modifications and extensions: copyright (C) ISE, 2001.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

