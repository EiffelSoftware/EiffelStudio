note
	description: "Summary description for {TEST_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_I

feature -- Factory

	new_emitter: MD_EMIT
		local
			md_dispenser: MD_DISPENSER
		do
			create md_dispenser.make
			Result := md_dispenser.emit (create {MD_UI})
		end

	tables (md_emit: MD_EMIT): SPECIAL [MD_TABLE]
		do
			Result := md_emit.pe_writer.tables
		end

	md_table (md_emit: MD_EMIT; a_tb_id: NATURAL_32): MD_TABLE
		do
			Result := md_emit.pe_writer.md_table (a_tb_id)
		end

	hash_blob (md_emit: MD_EMIT; a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_32): NATURAL_32
		do
			Result := md_emit.pe_writer.hash_blob (a_blob_data, a_blob_len)
		end

feature -- Helper UserStrings

	retrieve_user_string (md: MD_EMIT; a_token: INTEGER): STRING_32
			-- Retrieve the user string for `token'.
		require
			valid_user_string_token: is_user_string_token (md, a_token)
		local
			l_index: INTEGER_32
			l_length: INTEGER_32
			l_bytes: STRING_8
			i: INTEGER_32
			j: INTEGER_32
			us_heap: SPECIAL [NATURAL_8]
		do
				-- <<0, 1, 58, 0, 36, 0, ..... >>
				--      ^   - -
				-- Copy the Userstring heap,
				-- the underlying String needs to be retrieved as UTF-16
				-- TODO check if we have an efficient algorithm to
				-- convert an array of bytes to utf-16.

			us_heap := md.pe_writer.us.base

				-- Compute the index.
			l_index := a_token - 0x7000_0000 -- 0x70 table type: UserString heap

				-- Get the length of the string, reading the next byte.
				-- Per character we use two bytes and it ends with a null character.
			l_length := us_heap [l_index] -- 0-based container

			i := l_index
			if us_heap [i] < 128 then -- 0x80 = 1000 0000
				l_length := us_heap [i]
				i := i + 1
			elseif us_heap [i] < 192 then -- 0xC0 = 1100 0000
				-- 256 = 0x100 = 1 0000 0000
				l_length := (us_heap [i] - 128) * 256 + us_heap [i + 1]
				i := i + 2
			else
				-- 16777216 = 0x100_0000 = 1 00000000 00000000 00000000
				-- 65536 	=   0x1_0000 =          1 00000000 00000000
				-- 256 		=      0x100 =                   1 00000000
				l_length := (us_heap [i] - 192) * 0x100_0000
							  + us_heap [i + 1] * 0x1_0000
							  + us_heap [i + 2] * 0x100
							  + us_heap [i + 3]
				i := i + 4
			end

			create l_bytes.make (l_length - 1)
			from
				j := 0
			until
				j > l_length - 1 --| Do not load the final flag 0 or 1
			loop
				l_bytes.append_character (us_heap[i + j].to_character_8)
				j := j + 1
			end

			Result := {UTF_CONVERTER}.utf_16le_string_8_to_string_32 (l_bytes)
		end

	is_user_string_token (md: MD_EMIT; a_token: INTEGER_32): BOOLEAN
			-- Checks if the given integer value `a_token` corresponds to a valid user string token.
		do
			Result := (a_token >= 0x7000_0000) and (a_token < (0x7000_0000 + md.pe_writer.us.size.to_integer_32))
		end

end
