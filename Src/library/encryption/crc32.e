indexing
	description: "Perform CRC32 checksum using zlib."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CRC32

create
	make_on_file, make_on_buffer

feature {NONE} -- Initialization

	make_on_file (f: FILE) is
			-- Initialize computation of checksum on file 'f'.
		require
			f_not_void: f /= Void
			f_open_read: f.is_open_read
		do
			file := f
			checksum_on_file := True
		ensure
			file_set: file = f
			checksum_on_file_set: checksum_on_file
			not_checksum_on_buffer_set: not checksum_on_buffer
		end
			
	make_on_buffer (b: POINTER; n: INTEGER) is
			-- Initialize computation of checksum on buffer 'b' of
			-- length `n'.
		require
			b_not_null: b /= default_pointer
			n_positive: n > 0
		do
			buffer := b
			count := n
			checksum_on_buffer := True
		ensure
			buffer_set: buffer = b
			not_checksum_on_file_set: not checksum_on_file
			checksum_on_buffer_set: checksum_on_buffer
		end
			
feature -- Status

	checksum_on_file: BOOLEAN
			-- Perform a checksum on `file'.

	checksum_on_buffer: BOOLEAN
			-- Perform checksum on `buffer'.

feature -- Access

	buffer: POINTER
			-- Buffer on which checksum is performed.
	
	count: INTEGER
			-- Size of `buffer'.

	file: FILE
			-- File on which checksum is performed.
	
	checksum: INTEGER is
			-- Compute checksum
		local
			a: ANY
		do
			Result := crc32 (0, default_pointer, 0)
			
			if checksum_on_file then
				file.read_stream (file.count)
				a := file.last_string.to_c
				Result := crc32 (Result, $a, file.last_string.count) 
			else
				Result := crc32 (Result, buffer, count)
			end
		end

feature {NONE} -- Externals

	crc32 (crc: INTEGER; buf: POINTER; len: INTEGER): INTEGER is
			-- Update a running crc with the bytes buf[0..len-1]
			-- and return the updated crc. If buf is NULL, this
			-- function returns the required initial value for
			-- the crc. Pre- and post-conditioning (one's complement)
			-- is performed within this function so it shouldn't be
			-- done by the application.
		external
			"C signature (uLong, Bytef *, uInt): EIF_INTEGER use %"zlib.h%""
		end 

invariant
	checksum_on_file: checksum_on_file implies (file /= Void and buffer = Void)
	checksum_on_buffer: checksum_on_buffer implies (file = Void and buffer /= Void)
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CRC32


