indexing
	description: "VMS-specific extension to EXECUTION_ENVIRONMENT for ES5SH"
	author: "David Schwartz $"
	Date: "$Date$"
	Revision: "$Revision$"
	ID:		"$ID: $"

class ES5SH_EXECUTION_ENVIRONMENT

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	get_native (k: STRING): STRING is
			-- Value of `k' if it is an environment variable and has been set;
			-- void otherwise.
		require
			k_exists: k /= Void
			not_has_null_character: not k.has ('%U')
		local
			ext: ANY
			c_string: POINTER
			void_pointer: POINTER
		do
			ext := k.to_c
			c_string := eif_getenv_native ($ext)
			if c_string /= void_pointer then
				create Result.make_from_c (c_string)
			end
		end

feature -- Basic operations

feature {NONE} -- Implementation

	eif_getenv_native (k: POINTER): POINTER is
			-- Value of environment variable `k'

-- VMS:
--		external "C use %"eif_misc.h%""
--		alias    "eif_getenv_native"

-- non-VMS (until eif_getenv_native is added to C/run-time/misc.c):
--		external "C use %"eif_misc.h%""
--		alias    "eif_getenv"		-- non-VMS (until eif_getenv_native is added to C/run-time/misc.c)

-- If building with Eiffel 5.7 or later:
		external "C inline use %"eif_misc.h%""
		alias
			"[
				#ifdef EIF_VMS
					return eifrt_vms_getenv_native ($k)
				#else
					return getenv ($k)
				#endif
			]"

		end -- eif_getenv_native

end -- class ES5SH_EXECUTION_ENVIORONMENT
