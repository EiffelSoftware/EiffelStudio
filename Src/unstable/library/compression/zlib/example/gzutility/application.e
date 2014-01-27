note
	description: "Example showing how to use utility functions, gzread, gzwrite, gzclose, gzopen."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

	UTIL_EXTERNALS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			compress_file
			decompress_file
		end

	compress_file
		local
			l_file: RAW_FILE
			l_zlib: ZLIB
			l_gzfile: POINTER
			l_array: ARRAY [CHARACTER]
			l_index: INTEGER
			l_total_read: INTEGER
		do
			create l_zlib
			create l_file.make_open_read (original_file)
			create l_array.make_filled (create {CHARACTER}, 1, Buffer_size)
			l_gzfile := l_zlib.gzopen (compressed_file, "wb")
			from
				l_file.read_character
				l_index := 1
				l_total_read := 1
			until
				l_file.end_of_file
			loop
				if l_index <= l_array.capacity then
					l_array.force (l_file.last_character, l_index)
					l_file.read_character
					l_index := l_index + 1
					l_total_read := l_total_read + 1
				else
					l_zlib.gzwrite (l_gzfile, character_array_to_external (l_array), l_array.count)
					l_array.clear_all
					l_index := 1
				end
			end
			if l_file.end_of_file and l_index > 1 then
				l_zlib.gzwrite (l_gzfile, character_array_to_external (l_array), l_index)
				l_array.clear_all
			end
			l_file.close
			l_zlib.gzclose (l_gzfile)
		end

	decompress_file
		local
			l_file: RAW_FILE
			l_zlib: ZLIB
			l_gzfile: POINTER
			l_array: ARRAY [CHARACTER]
			l_index: INTEGER
		do
			create l_zlib
			create l_file.make_open_write (uncompressed_file)
			create l_array.make_filled (create {CHARACTER}, 1, Buffer_size)
			l_gzfile := l_zlib.gzopen (compressed_file, "rb")
			from
				l_zlib.gzread (l_gzfile, character_array_to_external (l_array), l_array.count)
			until
				l_zlib.last_operation < 0 or ( l_zlib.last_operation < l_array.count)
			loop
				across l_array as c loop
					l_file.put (c.item)
				end
				l_array.clear_all
				l_zlib.gzread (l_gzfile, character_array_to_external (l_array), l_array.count)
			end
			if l_zlib.last_operation > 0 then
				from
					l_index := 1
				until
					l_index >= l_zlib.last_operation
				loop
					l_file.put (l_array[l_index])
					l_index := l_index + 1
				end
			end
			l_zlib.gzclose (l_gzfile)
			l_file.close

		end

feature -- Implementation

	Original_file: STRING = "index.html"
		-- The original uncompressed file.

	Compressed_file: STRING = "index.z"
		-- New compressed file

	Uncompressed_file : STRING = "new_index.html"
		-- Uncompressed version of Compressed file.

	Buffer_size: INTEGER = 2048
		-- Internal buffer.

end
