note

    description:

        "High level writing interface of libbzip2"

    library:    "ELJ/ifs"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

class BZFILE_WRITE

inherit
	BZFILE
feature

	total_bytes_in_low: INTEGER

	total_bytes_in_high: INTEGER

	total_bytes_out_low: INTEGER

	total_bytes_out_high: INTEGER

feature

	write_open_default
			-- uses default values
		require
			file_open: is_file_open
		do
			write_open (9, 0, 0)
		ensure
			stream_open_if_no_error: last_operation = Ok implies is_stream_open
		end

	write_open (a_block_size100k, a_verbosity, a_work_factor: INTEGER)
			-- adjusts the stream to use
			-- 'a_block_size100k' * 100_000 bytes sized blcoks
			-- 'a_verbosity' level of diagnostic messages
			-- 'a_work_factor' amount of effort the standard algorithm will expend
			-- before resorting to a fallback algorithm
		require
			file_open: is_file_open
			valid_block: a_block_size100k >= 1 and then a_block_size100k <= 9
			valid_verbosity: a_verbosity >= 0 and then a_verbosity <= 4
			valid_work_factor: a_work_factor >= 0 and then a_work_factor <= 250
		do
			bzip_handle := BZ2_bzWriteOpen ($last_operation, file_handle, a_block_size100k, a_verbosity, a_work_factor)
		ensure
			stream_open_if_no_error: last_operation = Ok implies is_stream_open
		end

	write (a_buffer: ARRAY[CHARACTER])
			-- compresses content of 'a_buffer' to the stream
		require
			stream_open: is_stream_open
			non_void_buffer: a_buffer /= Void
			data_available: a_buffer.count > 0
		do
			BZ2_bzWrite ($last_operation, bzip_handle, character_array_to_external (a_buffer), a_buffer.count)
		end

	write_raw (a_buffer: POINTER; a_length: INTEGER)
			-- compresses 'a_length' bytes from 'a_buffer' to the stream
		require
			stream_open: is_stream_open
			non_null_buffer: a_buffer /= default_pointer
			data_available: a_length > 0
		do
			BZ2_bzWrite ($last_operation, bzip_handle, a_buffer, a_length)
		end

	write_close (a_abandon: BOOLEAN)
			-- finish compression and flushes all data if
			-- 1) no previous error has been recorded
			-- 2) 'a_abandon' is False
		require
			stream_open: is_stream_open
		do
			BZ2_bzWriteClose64 ($last_operation, bzip_handle, a_abandon.to_integer, $total_bytes_in_low, $total_bytes_in_high, $total_bytes_out_low, $total_bytes_out_high)

			if last_operation = Ok then
				bzip_handle := default_pointer
			end
		ensure
			stream_closed_if_no_error: last_operation = Ok implies not is_stream_open
		end

feature {NONE}

	open_file (a_name: STRING): POINTER
		do
			Result := fopen (string_to_external (a_name), string_to_external ("wb"))
		end

end
