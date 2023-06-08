note
	description: "Summary description for {MD_STRONG_NAME}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

inherit
	MD_STRONG_NAME_I

	REFACTORING_HELPER

create
	make_with_version

feature {NONE} -- Initialization

	make_with_version (a_runtime_version: like runtime_version)
		do
			runtime_version := a_runtime_version
		end
feature -- Status report

	runtime_version: STRING_32
			-- Version for which we are signing.	

feature -- Access

	public_key (a_key_blob: MANAGED_POINTER): detachable MANAGED_POINTER
			-- Retrieve public portion of key pair `a_key_blob`.
		local
			l_buf: ARRAY [NATURAL_8]
			l_len: CELL [NATURAL_32]
			rsa_encoder: CIL_RSA_ENCODER
		do
			create l_buf.make_filled (0, 1, 16384)
			create l_len.put (0)
			create rsa_encoder.make
			rsa_encoder.get_public_key_data (l_buf, l_len)
			create Result.make_from_array (l_buf.subarray (1, l_len.item.to_integer_32))

				-- FIXME
				-- we need to access the metadata tables and upate the content.
				--	if attached {PE_ASSEMBLY_DEF_TABLE_ENTRY} tables [{PE_TABLES}.index_of ({PE_TABLES}.tassemblydef).to_integer_32].table [1] as l_table then
				--		l_table.public_key_index := (create {PE_BLOB}.make_with_index (hash_blob (l_buf, l_len.item)))
				--	end
				--	if attached {PE_ASSEMBLY_DEF_TABLE_ENTRY} tables [{PE_TABLES}.index_of ({PE_TABLES}.tassemblydef).to_integer_32].table [1] as l_table then
				--		l_table.flags := l_table.flags | {PE_ASSEMBLY_FLAGS}.publickey
				--	end

		end

	public_key_token (a_public_key_blob: MANAGED_POINTER): MANAGED_POINTER
			-- Retrieve public key token associated with `a_public_key_blob'.
		do
			debug ("refactor_fixme")
				to_implement (generator + ".public_key_token")
			end
			create Result.make (0)
		end

	hash_of_file (a_file_path: CLI_STRING): MANAGED_POINTER
			-- Compute hash of `a_file_path' using default algorithm.
		local
			l_file: RAW_FILE
			l_s: STRING_8
			l_converter: BYTE_ARRAY_CONVERTER
			b: BOOLEAN
			t1,t2: TIME
		do
			create l_file.make_open_read (a_file_path.string_32)

			print ("sha1 of " + l_file.path.utf_8_name + " (count:"+ l_file.count.out +") -> ")
			create t1.make_now
				-- Disable assertion checking, if any, otherwise `hash_from_file` may be way too slow.
			b := {ISE_RUNTIME}.check_assert (False)
			l_s := hash_from_file (l_file)
				-- Restore assertion checking to previous state
			b := {ISE_RUNTIME}.check_assert (b)
			create t2.make_now
			print (l_s + " (" + t2.relative_duration (t1).fine_seconds_count.out + " secs)%N")
			l_file.close
			create l_converter.make_from_string (l_s)
			create Result.make_from_array (l_converter.to_natural_8_array)
		end

feature -- Status report

	exists: BOOLEAN
		do
			debug ("refactor_fixme")
				to_implement (generator + ".exists")
			end
		end


feature {NONE} -- Implementation

	hash_from_file (a_file: FILE): STRING_8
			-- Compute the SHA-1 hash of a file `a_file' and return it as a string.
		local
			sha1: SHA1
		do
			create sha1.make
			sha1.update_from_io_medium (a_file)
			Result := sha1.digest_as_string
			sha1.reset
		end


end
