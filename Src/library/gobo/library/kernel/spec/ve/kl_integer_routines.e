indexing

	description:

		"Routines that ought to be in class INTEGER"

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_INTEGER_ROUTINES

inherit

	KL_SHARED_PLATFORM

feature -- Conversion

	to_character (an_int: INTEGER): CHARACTER is
			-- Character whose ASCII code is `an_int'
		require
			a_int_large_enough: an_int >= Platform.Minimum_character_code
			a_int_small_enough: an_int <= Platform.Maximum_character_code
		do
			Result.from_integer (an_int)
		ensure
			valid_character_code: Result.code = an_int
		end

end -- class KL_INTEGER_ROUTINES
