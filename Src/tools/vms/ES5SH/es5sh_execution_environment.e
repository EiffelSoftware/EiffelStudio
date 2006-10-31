indexing
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	archive: "$Archive: $"

class
	ES5SH_EXECUTION_ENVIRONMENT

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	get_native (s: STRING): STRING is
			-- Value of `s' if it is an environment variable and has been set;
			-- void otherwise.
		require
			s_exists: s /= Void
			not_has_null_character: not s.has ('%U')
		local
			ext: ANY
			c_string: POINTER
			void_pointer: POINTER
		do
			ext := s.to_c
			c_string := eif_getenv_native ($ext)
			if c_string /= void_pointer then
				create Result.make_from_c (c_string)
			end
		end

feature -- Basic operations

feature {NONE} -- Implementation

	eif_getenv_native (s: POINTER): POINTER is
			-- Value of environment variable `s'
		external
			"C use %"eif_misc.h%""
-- VMS:
--		alias "eif_getenv_native"
-- Others (until eif_getenv_native is added to C/run-time/misc.c):
		alias "eif_getenv"
		end


end
