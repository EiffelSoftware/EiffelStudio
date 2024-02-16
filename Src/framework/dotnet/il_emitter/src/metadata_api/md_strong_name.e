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
			v: ARRAY [NATURAL_8]
		do
			v := {MD_HASH_UTILITIES}.sha1_bytes_for_file_name (a_file_path.string_32)
			create Result.make_from_array (v)
		ensure then
			class
		end

feature -- Status report

	exists: BOOLEAN
		do
			debug ("refactor_fixme")
				to_implement (generator + ".exists")
			end
		end


end
