note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PAX_HEADER_TEST_SET

inherit
	TAR_TEST_SET_BASE

feature -- Internal tests

	test_template_length
			-- Check whether all templates have the correct length
		do
			assert ("correct easy template size", easy_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct link template size", link_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct devnode template size", devnode_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct split template size", split_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct long filename template size", long_filename_header_blob.count = {TAR_CONST}.tar_block_size * 3)
		end

feature -- Test writing

	test_pax_write_ustar
			-- Run pax header writer with ustar examples
		local
			unit_under_test: PAX_HEADER_WRITER
			output: SPECIAL[CHARACTER_8]
		do
				-- easy
			create unit_under_test
			unit_under_test.set_active_header (easy_header)

			assert ("can write valid header (easy)", unit_under_test.writable (easy_header))
			assert ("has correct size (easy)", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length (easy)", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content (easy)", compare_special (easy_header_blob, output))

				-- link
			unit_under_test.set_active_header (link_header)

			assert ("can write valid header (link)", unit_under_test.writable (link_header))
			assert ("has correct size (link)", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length (link)", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content (link)", compare_special (link_header_blob, output))

				-- devnode
			unit_under_test.set_active_header (devnode_header)

			assert ("can write valid header (devnode)", unit_under_test.writable (devnode_header))
			assert ("has correct size (devnode)", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length (devnode)", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content (devnode)", compare_special (devnode_header_blob, output))

				-- split
			unit_under_test.set_active_header (split_header)

			assert ("can write valid header (split)", unit_under_test.writable (split_header))
			assert ("has correct size (split)", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length (split)", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content (split)", compare_special (split_header_blob, output))
		end

	test_pax_write_long_filename
			-- Test pax header with too long filename
		local
			unit_under_test: PAX_HEADER_WRITER
			output: SPECIAL[CHARACTER_8]
		do
			create unit_under_test

			unit_under_test.set_active_header (long_filename_header)

			assert ("can write valid header", unit_under_test.writable (long_filename_header))
			assert ("has correct size", unit_under_test.required_blocks = 3)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, 3 * {TAR_CONST}.tar_block_size)

			assert ("correct output length", output.count = 3 * {TAR_CONST}.tar_block_size)
			assert ("correct output content", compare_special (long_filename_header_blob, output))
		end

feature -- Test parsing

	test_pax_parser_ustar
			-- Test pax parsing with ustar examples
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test

				-- easy
			create p.make_from_pointer (easy_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block (easy)", unit_under_test.parsing_finished)
			assert ("parsing successfull (easy)", unit_under_test.parsed_header /= Void)
			assert ("headers match (easy)", unit_under_test.parsed_header ~ easy_header)

				-- link
			create p.make_from_pointer (link_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block (link)", unit_under_test.parsing_finished)
			assert ("parsing successfull (link)", unit_under_test.parsed_header /= Void)
			assert ("headers match (link)", unit_under_test.parsed_header ~ link_header)

				-- devnode
			create p.make_from_pointer (devnode_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block (devnode)", unit_under_test.parsing_finished)
			assert ("parsing successfull (devnode)", unit_under_test.parsed_header /= Void)
			assert ("headers match (devnode)", unit_under_test.parsed_header ~ devnode_header)

				-- split
			create p.make_from_pointer (split_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block (split)", unit_under_test.parsing_finished)
			assert ("parsing successfull (split)", unit_under_test.parsed_header /= Void)
			assert ("headers match (split)", unit_under_test.parsed_header ~ split_header)
		end

	test_pax_parser_long_filename
			-- Test pax header parser with too long filename
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test

			create p.make_from_pointer (long_filename_header_blob.base_address, 3 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 2)
			assert ("Finished after 3 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ long_filename_header)
		end

	test_pax_parser_global_header
			-- Test pax header parser with global header
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (global_pax_header_blob.base_address, 3 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 2)
			assert ("Finished after 3 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ global_pax_header)
		end

	test_pax_parser_global_long_filename_header
			-- Test pax header parser with global + extended header
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (global_long_filename_header_blob.base_address, 5 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 2 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 3", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 3 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 4", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 4)
			assert ("Finished after 5 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ global_long_filename_header)
		end

	test_pax_parser_global_override_header
			-- Test pax header parser with global + global header
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (global_pax_header_override_blob.base_address, 5 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 2 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 3", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 3 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 4", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 4)
			assert ("Finished after 5 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ global_pax_override_header)
		end

	test_pax_parser_extended_global_override_header
			-- Test pax header parser with global + extended header (override)
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (global_extended_override_header_blob.base_address, 5 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 2 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 3", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 3 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 4", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 4)
			assert ("Finished after 5 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ global_extended_override_header)
		end

	test_pax_parser_extended_global_union_header
			-- Test pax header parser with global + global header (union)
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (global_pax_header_union_blob.base_address, 5 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 2 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 3", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 3 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 4", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 4)
			assert ("Finished after 5 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ global_pax_union_header)
		end

	test_pax_parser_global_reset
			-- Test pax header parser with global + extended header, where extended header resets (-> global value ignored) a value
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (global_extended_reset_header_blob.base_address, 5 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 2 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 3", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 3 * {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 4", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size * 4)
			assert ("Finished after 5 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ global_extended_reset_header)
		end

	test_pax_parser_double_header
			-- Test pax header parser with double header testset, testing whether extended header values are applied only to a single header
		local
			unit_under_test: PAX_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (double_header_blob.base_address, 4 * {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)
			assert ("Not finished yet", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, {TAR_CONST}.tar_block_size)
			assert ("Not finished yet 2", not unit_under_test.parsing_finished)

			unit_under_test.parse_block (p, 2 * {TAR_CONST}.tar_block_size)
			assert ("Finished after 3 blocks", unit_under_test.parsing_finished)
			assert ("parsing successfull 1", unit_under_test.parsed_header /= Void)
			assert ("headers match 1", unit_under_test.parsed_header ~ double_header_1)

			unit_under_test.parse_block (p, 3 * {TAR_CONST}.tar_block_size)
			assert ("Finished after block 4", unit_under_test.parsing_finished)
			assert ("parsing successfull 2", unit_under_test.parsed_header /= Void)
			assert ("headers match 2", unit_under_test.parsed_header ~ double_header_2)
		end

feature {NONE} -- Data (ustar) - easy

	easy_header_blob: SPECIAL[CHARACTER_8]
			-- Return blob for easy_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			Result := header_template.area
			Result.remove_tail (1)
		end

	easy_header: TAR_HEADER
			-- Header corresponding to testset easy
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (0c12615214330)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

feature {NONE} -- Data (ustar) - link


	link_header_blob: SPECIAL[CHARACTER_8]
			-- Return blob for link_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := ".zshrc$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000777$0001750$0000144$00000000000$12525702750$0016552$2dotfiles/zsh/zshrc$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			Result := header_template.area
			Result.remove_tail (1)
		end

	link_header: TAR_HEADER
			-- Header corresponding to testset link
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string (".zshrc"))
			Result.set_mode (0c0777)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_mtime (0c12525702750)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_symlink)
			Result.set_linkname (create {PATH}.make_from_string ("dotfiles/zsh/zshrc"))
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

feature {NONE} -- Data (ustar) - Device node

	devnode_header_blob: SPECIAL[CHARACTER_8]
			-- Return blob for devnode_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "dev/sda1$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000660$0000000$0000006$00000000000$12631223040$0012345$4$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00root$$$$$$$$$$$$$$$$$$$$$$$$$$$$disk$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000010$0000001$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			Result := header_template.area
			Result.remove_tail (1)
		end

	devnode_header: TAR_HEADER
			-- Header corresponding to testset devnode
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("dev/sda1"))
			Result.set_mode (0c0660)
			Result.set_user_id (0c0)
			Result.set_group_id (0c6)
			Result.set_mtime (0c12631223040)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_block_special)
			Result.set_user_name ("root")
			Result.set_group_name ("disk")
			Result.set_device_major (0c10)
			Result.set_device_minor (0c1)
		end

feature {NONE} -- Data (ustar) - split

	split_header_blob: SPECIAL[CHARACTER_8]
			-- Return blob for split_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "a_not_so_looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_filename0000644$0001750$0000144$00000000000$12637742055$0100624$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_directory$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			Result := header_template.area
			Result.remove_tail (1)
		end

	split_header: TAR_HEADER
			-- Header corresponding to testset split
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_directory/a_not_so_looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_filename"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_mtime (0c12637742055)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
			Result.set_device_major (0c0)
			Result.set_device_minor (0c0)
		end


feature {NONE} -- Data - long filename

	long_filename_header_blob: SPECIAL[CHARACTER_8]
			-- Return blob for long_filename_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000430$00000000000$0011233$x$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
							   %280 path=test_files/a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_directory/a_not_so_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_filename^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
							   %test_files/a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo0000644$0001750$0000144$00000000000$00000000000$0037205$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	long_filename_header: TAR_HEADER
			-- Header corresponding to testset long filename
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("test_files/a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_directory/a_not_so_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_filename"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_mtime (0c0)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
			Result.set_device_major (0c0)
			Result.set_device_minor (0c0)
		end

feature {NONE} -- Data - global header

	global_pax_header_blob: SPECIAL [CHARACTER_8]
			-- Return blob for global_pax_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	global_pax_header: TAR_HEADER
			-- Header corresponding to testset global pax header
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (1450708269)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end


feature {NONE} -- Data - global header long filename

	global_long_filename_header_blob: SPECIAL [CHARACTER_8]
			-- Return blob for global_long_filename_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000430$00000000000$0011233$x$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
							   %280 path=test_files/a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_directory/a_not_so_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_filename^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
							   %test_files/a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo0000644$0001750$0000144$00000000000$00000000000$0037205$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	global_long_filename_header: TAR_HEADER
			-- Header corresponding to testset long filename + global header
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("test_files/a_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_directory/a_not_so_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong_filename"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_mtime (1450708269)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
			Result.set_device_major (0c0)
			Result.set_device_minor (0c0)
		end

feature {NONE} -- Data - global header override

	global_pax_header_override_blob: SPECIAL [CHARACTER_8]
			-- Return blob for global_pax_override_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450701253.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	global_pax_override_header: TAR_HEADER
			-- Header corresponding to testset with global header overrides
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (1450701253)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

feature {NONE} -- Data - extended override global

	global_extended_override_header_blob: SPECIAL [CHARACTER_8]
			-- Return blob for global_extended_override_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011234$x$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450712645.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	global_extended_override_header: TAR_HEADER
			-- Header corresponding to testset long filename + global header
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (1450712645)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

feature {NONE} -- Data - global header union

	global_pax_header_union_blob: SPECIAL [CHARACTER_8]
			-- Return blob for global_pax_union_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1450708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000023$00000000000$0011210$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %19 size=1450701253^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	global_pax_union_header: TAR_HEADER
			-- Header corresponding to testset with global header union
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (1450701253)
			Result.set_mtime (1450708269)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

feature {NONE} -- Data - resetting fields

	global_extended_reset_header_blob: SPECIAL [CHARACTER_8]
			-- Return blob for global_extended_reset_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011213$g$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1250708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000011$00000000000$0011226$x$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %9 mtime=^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	global_extended_reset_header: TAR_HEADER
			-- Header corresponding to testset global header reset in extended header
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (0c12615214330)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

feature {NONE} -- Data - non-propagation of extended headers


	double_header_blob: SPECIAL [CHARACTER_8]
			-- Return blob for double_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "./PaxHeader$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0000000$0000000$00000000035$00000000000$0011234$x$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %29 mtime=1250708269.16920698^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
			                   %home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$0000644$0001750$0000144$00001215414$12615214330$0015465$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$0000000$0000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	double_header_1: TAR_HEADER
			-- Header corresponding to testset double header #1
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (1250708269)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end


	double_header_2: TAR_HEADER
			-- Header corresponding to testset double header #2
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("home/nicolas/out.ps"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c1215414)
			Result.set_mtime (0c12615214330)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

end


