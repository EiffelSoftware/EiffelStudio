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
