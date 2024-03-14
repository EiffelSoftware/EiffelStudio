note
	description: "Utilities class to make simpler to compress and uncompress a file with default buffer size of 2048 bytes."
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_UTILITIES

feature -- Access

	compress_file (a_file_location: PATH; a_compressed_file_location: PATH)
			-- Compress file `a_file_location` as file `a_compressed_file_location`.
		local
			l_file: RAW_FILE
			l_zlib: ZLIB
			l_gzfile: POINTER
			l_array: ARRAY [CHARACTER]
			l_index: INTEGER
			l_total_read: INTEGER
		do
			create l_zlib
			create l_file.make_with_path (a_file_location)
			if l_file.exists then
				l_file.open_read
				create l_array.make_filled (create {CHARACTER}, 1, 2_048)
				l_gzfile := l_zlib.gzopen (a_compressed_file_location.name, "wb")
				from
					l_file.read_character
					l_index := 1
					l_total_read := 1
				until
					l_file.end_of_file or l_file.exhausted
				loop
					if l_index <= l_array.capacity then
						l_array.force (l_file.last_character, l_index)
						l_file.read_character
						l_index := l_index + 1
						l_total_read := l_total_read + 1
					else
						l_zlib.gzwrite (l_gzfile, {UTIL_EXTERNALS}.character_array_to_external (l_array), l_array.count)
						l_array.clear_all
						l_index := 1
					end
				end
				if l_file.end_of_file and l_index > 1 then
					l_zlib.gzwrite (l_gzfile, {UTIL_EXTERNALS}.character_array_to_external (l_array), l_index)
					l_array.clear_all
				end
				l_file.close
				l_zlib.gzclose (l_gzfile)
			end
		ensure
			class
		end

	uncompress_file (a_compressed_file_location: PATH; a_uncompressed_file_location: PATH)
			-- Uncompress file `a_compressed_file_location` as file `a_uncompressed_file_location`.
		local
			l_file: RAW_FILE
			l_zlib: ZLIB
			l_gzfile: POINTER
			l_array: ARRAY [CHARACTER]
			l_index: INTEGER
		do
			create l_zlib
			create l_file.make_with_path (a_uncompressed_file_location)
			l_file.create_read_write

			create l_array.make_filled (create {CHARACTER}, 1, 2_048)
			l_gzfile := l_zlib.gzopen (a_compressed_file_location.name, "rb")
			from
				l_zlib.gzread (l_gzfile, {UTIL_EXTERNALS}.character_array_to_external (l_array), l_array.count)
			until
				l_zlib.last_operation < 0 or ( l_zlib.last_operation < l_array.count)
			loop
				across l_array as c loop
					l_file.put (c.item)
				end
				l_array.clear_all
				l_zlib.gzread (l_gzfile, {UTIL_EXTERNALS}.character_array_to_external (l_array), l_array.count)
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
		ensure
			class
		end
end
