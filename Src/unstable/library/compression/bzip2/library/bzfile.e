note

    description:

        "Ancestor of wrappers to libbzip2 high level interface"

    library:    "ELJ/ifs"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

deferred class BZFILE

inherit
	BZLIB
	UTIL_EXTERNALS

feature

	close
		require
			file_open: is_file_open
			stream_closed: not is_stream_open
		do
			if fclose (file_handle) = 0 then
				file_handle := default_pointer
			end -- if
		ensure
			file_closed_is_no_error: errno = 0 implies not is_file_open
		end -- close

	open (a_name: STRING)
		require
			non_void_name: a_name /= Void
			non_empty_name: not a_name.is_empty
		do
			file_handle := open_file (a_name)

			if file_handle /= default_pointer then
			-- under Linux we get an annoying error code, even if everything went
			-- fine, just because the binary indicator is not needed, so we set
			-- errno to 0
				reset_errno
			end -- if
		ensure
			file_open_if_no_error: errno = 0 implies is_file_open
		end -- open_read

feature

	is_stream_open: BOOLEAN
		do
			Result := bzip_handle /= default_pointer
		end -- is_stream_open

	is_file_open: BOOLEAN
		do
			Result := file_handle /= default_pointer
		end -- is_file_open

feature {NONE}

	file_handle: POINTER

	bzip_handle: POINTER

	open_file (a_name: STRING): POINTER
		deferred
		end -- open_file

	fopen (a_name, a_mode: POINTER): POINTER
		external "C use <stdio.h>"
		end -- c_open_file

	fclose (a_handle: POINTER): INTEGER
		external "C use <stdio.h>"
		end -- close_file

invariant

	operates_on_file: is_stream_open implies is_file_open

end -- deferred class BZFILE
