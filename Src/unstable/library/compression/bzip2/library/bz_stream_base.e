note
    description:

        "base class for streams using the bzlib2"

    library:    "ELJ/base"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

class BZ_STREAM_BASE

inherit

	UTIL_EXTERNALS

feature -- Status Report

	has_error: BOOLEAN
		do
			Result := errno /= 0 or else (attached bz_file as l_bz_file and then l_bz_file.last_operation < 0)
		end

	last_error_message: STRING
		require
			has_error: has_error
		do
			if errno = 0 then
				if attached bz_file as l_bz_file then
					inspect l_bz_file.last_operation
					when -1 then
						Result := "sequence error"
					when -2 then
						Result := "param error"
					when -3 then
						Result := "memory error"
					when -4 then
						Result := "data error"
					when -5 then
						Result := "magic data error"
					when -6 then
						Result := "I/O error"
					when -7 then
						Result := "unexpected EOF"
					when -8 then
						Result := "output buffer full"
					when -9 then
						Result := "configuration error"
					else
						Result := "unknown error"
					end
				else
					Result := "bzfile is void"
				end
			else
				Result := string_from_external (strerror (errno))
			end
		end

feature {NONE} -- Implementation

	bz_file: detachable BZFILE

invariant

	has_bz_file: bz_file /= Void

end
