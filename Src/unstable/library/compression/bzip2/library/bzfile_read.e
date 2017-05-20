note
    description: "High level reading interface of libbzip2"
    library:    "ELJ/ifs"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002-2017, Uwe Sander, Eiffel Software and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

class BZFILE_READ

inherit
	BZFILE
	UTIL_EXTERNALS
feature

	read_open_default (a_unused: POINTER; a_nunused: INTEGER)
			-- use default vaiues and provide 'a_nunused' unused data at 'a_unused'
			-- from a previous run (or 'default_pointer', '0')
		require
			file_open: is_file_open
		do
			read_open (0, False, a_unused, a_nunused)
		ensure
			stream_open_if_no_error: last_operation = Ok implies is_stream_open
		end

	read_open (a_verbosity: INTEGER; a_small: BOOLEAN; a_unused: POINTER; a_nunused: INTEGER)
			-- use certain params and provide 'a_nunused' unused data at 'a_unused'
			-- from a previous run (or 'default_pointer', '0')
		require
			file_open: is_file_open
		do
			bzip_handle := BZ2_bzReadOpen ($last_operation, file_handle, a_verbosity, a_small.to_integer, a_unused, a_nunused)
		ensure
			stream_open_if_no_error: last_operation = Ok implies is_stream_open
		end

	read_close
			-- close and discard all pending data
		require
			stream_open: is_stream_open
		do
			BZ2_bzReadClose ($last_operation, bzip_handle)

			if last_operation >= Ok then
				bzip_handle := default_pointer
			end
		end

	read_get_unused: TUPLE[INTEGER,POINTER]
			-- get the read but not used data block and its size
		require
			stream_open: is_stream_open
			end_of_stream: last_operation = Stream_end
		local
			mem: CMEM_32
			len: CMEM_32
		do
			BZ2_bzReadGetUnused ($last_operation, bzip_handle, mem.to_external, len.to_external)

			Result := [len.to_integer, mem.as_pointer]
		end

	read (a_buffer: ARRAY[CHARACTER])
			-- uncompress data into 'a_buffer'
			-- reading stops if either 'a_buffer' is full or no more data is
			-- available
			-- 'a_buffer's upper limit will be adjusted to reflect the amount
			-- of data read
		require
			stream_open: is_stream_open
			not_end_of_stream: last_operation /= Stream_end
			non_void_buffer: a_buffer /= Void
			space_available: a_buffer.count > 0
		local
			len: INTEGER
			buf: ARRAY[CHARACTER]
		do
			len := BZ2_bzRead ($last_operation, bzip_handle, character_array_to_external (a_buffer), a_buffer.count)

			if last_operation >= Ok and then len < a_buffer.count then
				buf := a_buffer.subarray (a_buffer.lower, a_buffer.lower + len - 1)
				a_buffer.make_filled ('%U', buf.lower, buf.upper)
				a_buffer.copy (buf)
			end
		end

feature {NONE}

	open_file (a_name: STRING): POINTER
		do
			Result := fopen (string_to_external (a_name), string_to_external ("rb"))
		end

end
