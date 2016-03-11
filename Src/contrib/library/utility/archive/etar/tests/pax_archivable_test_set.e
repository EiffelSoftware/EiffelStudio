note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PAX_ARCHIVABLE_TEST_SET

inherit
	TAR_TEST_SET_BASE

feature -- Test routines

	test_simple_payload
			-- Test PAX_ARCHIVABLE with simple, single-block payload
		local
			unit_under_test: PAX_ARCHIVABLE
			p: MANAGED_POINTER
		do
			create unit_under_test.make_empty
			unit_under_test.put ("mtime", "1451293316.085474313")
			p := write_archivable_to_new_managed_pointer (unit_under_test)

			assert ("Single block", p.count = {TAR_CONST}.tar_block_size and unit_under_test.required_blocks = 1)
			assert ("Correct size", unit_under_test.header.size = 30)
			assert ("Correct payload", compare_special (simple_payload_blob, p.read_special_character_8 (0, {TAR_CONST}.tar_block_size)))
		end

	test_long_payload
			-- Test PAX_ARCHIVABLE with longer payload (2 blocks)
		local
			unit_under_test: PAX_ARCHIVABLE
			p: MANAGED_POINTER
		do
			create unit_under_test.make_from_payload (long_payload_string)
			p := write_archivable_to_new_managed_pointer (unit_under_test)

			assert ("Double block", p.count = {TAR_CONST}.tar_block_size * 2 and unit_under_test.required_blocks = 2)
			assert ("Correct size", unit_under_test.header.size = ({TAR_CONST}.tar_block_size * 1 +  {TAR_CONST}.tar_block_size // 2).as_natural_64)
			assert ("Correct payload", compare_special (long_payload_blob, p.read_special_character_8 (0, 2 * {TAR_CONST}.tar_block_size)))
		end

	test_block_size_payload
			-- Test PAX_ARCHIVABLE with payload of exactly block size
		local
			unit_under_test: PAX_ARCHIVABLE
			p: MANAGED_POINTER
		do
			create unit_under_test.make_from_payload (blocksize_payload_string)
			p := write_archivable_to_new_managed_pointer (unit_under_test)

			assert ("Single block", p.count = {TAR_CONST}.tar_block_size and unit_under_test.required_blocks = 1)
			assert ("Correct size", unit_under_test.header.size = ({TAR_CONST}.tar_block_size * 1).as_natural_64)
			assert ("Correct payload", compare_special (blocksize_payload_blob, p.read_special_character_8 (0, {TAR_CONST}.tar_block_size)))
		end

	test_length_overflow_payload
			-- Test PAX_ARCHIVABLE with payload with length field that has to be calculated multiple times
		local
			unit_under_test: PAX_ARCHIVABLE
			p: MANAGED_POINTER
		do
			create unit_under_test.make_empty
			unit_under_test.put ("key", "000")
				-- This entry should first have length 9, then length 10 and finally length 11

			p := write_archivable_to_new_managed_pointer (unit_under_test)

			assert ("Single block", p.count = {TAR_CONST}.tar_block_size and unit_under_test.required_blocks = 1)
			assert ("Correct size", unit_under_test.header.size = 11)
			assert ("Correct payload", compare_special (overflow_payload_blob, p.read_special_character_8 (0, {TAR_CONST}.tar_block_size)))

		end

feature {NONE} -- Data - simple payload

	simple_payload_blob: SPECIAL[CHARACTER_8]
			-- Return blob for simple_payload test
		local
			template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--  Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--           |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			template := "30 mtime=1451293316.085474313^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			template.replace_substring_all ("$", "%U")
			template.replace_substring_all ("^", "%N")
			Result := template.area
			Result.remove_tail (1)
		end

feature {NONE} -- Data - long payload

	long_payload_string: STRING_8
			-- String for long payload writing
		once
			create Result.make_filled ('0', {TAR_CONST}.tar_block_size * 1 +  {TAR_CONST}.tar_block_size // 2)
		end

	long_payload_blob: SPECIAL [CHARACTER_8]
			-- Return blob for long_payload test
		once
			create Result.make_filled ('%U', {TAR_CONST}.tar_block_size * 2)
			Result.fill_with ('0', 0, {TAR_CONST}.tar_block_size * 1 +  {TAR_CONST}.tar_block_size // 2 - 1)
		end

feature {NONE} -- Data - blocksize payload

	blocksize_payload_string: STRING_8
			-- String for blocksize payload writing
		once
			create Result.make_filled ('0', {TAR_CONST}.tar_block_size)
		end

	blocksize_payload_blob: SPECIAL [CHARACTER_8]
			-- Return blob for blocksize_payload test
		do
			Result := blocksize_payload_string.area.twin
			Result.remove_tail (1)
		end

feature {NONE} -- Data - overflow payload

	overflow_payload_blob: SPECIAL[CHARACTER_8]
			-- Return blob for simple_payload test
		local
			template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--  Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--           |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			template := "11 key=000^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			template.replace_substring_all ("$", "%U")
			template.replace_substring_all ("^", "%N")
			Result := template.area
			Result.remove_tail (1)
		end

end


