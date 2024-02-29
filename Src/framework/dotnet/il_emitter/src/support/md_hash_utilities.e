note
	description: "[
			Hash utilities.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_HASH_UTILITIES

feature -- Hash SHA1

	sha1_string_for_file (a_file: FILE): STRING_8
			-- Compute the SHA-1 hash of a file `a_file' and return it as a string.
		local
			sha: SHA1
			b: BOOLEAN
		do
			debug ("il_emitter")
				print ("sha1 of " + a_file.path.utf_8_name + " (count:"+ a_file.count.out +") -> %N")
				{MD_DBG_CHRONO}.start ("sha1_string_for_file")
			end
			b := {ISE_RUNTIME}.check_assert (False)
			create sha.make
			sha.update_from_io_medium (a_file)
			Result := sha.digest_as_string
			sha.reset
			b := {ISE_RUNTIME}.check_assert (b)
			debug ("il_emitter")
				{MD_DBG_CHRONO}.stop ("sha1_string_for_file")
				print ({MD_DBG_CHRONO}.report_line ("sha1_string_for_file"))
				{MD_DBG_CHRONO}.remove ("sha1_string_for_file")
			end
		ensure
			class
		end

	sha1_bytes_for_file (a_file: FILE): ARRAY [NATURAL_8]
			-- Compute the SHA-1 hash of a file `a_file' and return it as a bytes.
		local
			l_converter: BYTE_ARRAY_CONVERTER
		do
			create l_converter.make_from_string (sha1_string_for_file (a_file))
			Result := l_converter.to_natural_8_array
		ensure
			class
		end

	sha1_string_for_file_name (a_file_name: READABLE_STRING_GENERAL): STRING_8
			-- Compute the SHA-1 hash of a file `a_file_name' and return it as a string.
		local
			f: RAW_FILE
		do
			create f.make_open_read (a_file_name)
			Result := sha1_string_for_file (f)
			f.close
		ensure
			class
		end

	sha1_bytes_for_file_name (a_file_name: READABLE_STRING_GENERAL): ARRAY [NATURAL_8]
			-- Compute the SHA-1 hash of a file `a_file_name' and return it as a bytes.
		local
			f: RAW_FILE
		do
			create f.make_open_read (a_file_name)
			Result := sha1_bytes_for_file (f)
			f.close
		ensure
			class
		end

feature -- Hash SHA256

	sha256_string_for_file (a_file: FILE): STRING_8
			-- Compute the SHA-256 hash of a file `a_file' and return it as a string.
		local
			sha: SHA256
			b: BOOLEAN
		do
			debug ("il_emitter")
				print ("sha256 of " + a_file.path.utf_8_name + " (count:"+ a_file.count.out +") -> %N")
				{MD_DBG_CHRONO}.start ("sha256_string_for_file")
			end
			b := {ISE_RUNTIME}.check_assert (False)
			create sha.make
			sha.update_from_io_medium (a_file)
			Result := sha.digest_as_hexadecimal_string.as_lower
			sha.reset
			b := {ISE_RUNTIME}.check_assert (b)
			debug ("il_emitter")
				{MD_DBG_CHRONO}.stop ("sha256_string_for_file")
				print ({MD_DBG_CHRONO}.report_line ("sha256_string_for_file"))
				{MD_DBG_CHRONO}.remove ("sha256_string_for_file")
			end
		ensure
			class
		end

	sha256_bytes_for_file (a_file: FILE): ARRAY [NATURAL_8]
			-- Compute the SHA-256 hash of a file `a_file' and return it as a bytes.
		local
			l_converter: BYTE_ARRAY_CONVERTER
		do
			create l_converter.make_from_hex_string (sha256_string_for_file (a_file))
			Result := l_converter.to_natural_8_array
		ensure
			class
		end

	sha256_string_for_file_name (a_file_name: READABLE_STRING_GENERAL): STRING_8
			-- Compute the SHA-256 hash of a file `a_file_name' and return it as a string.
		local
			f: RAW_FILE
		do
			create f.make_open_read (a_file_name)
			Result := sha256_string_for_file (f)
			f.close
		ensure
			class
		end

	sha256_bytes_for_file_name (a_file_name: READABLE_STRING_GENERAL): ARRAY [NATURAL_8]
			-- Compute the SHA-256 hash of a file `a_file_name' and return it as a bytes.
		local
			f: RAW_FILE
		do
			create f.make_open_read (a_file_name)
			Result := sha256_bytes_for_file (f)
			f.close
		ensure
			class
		end

end
