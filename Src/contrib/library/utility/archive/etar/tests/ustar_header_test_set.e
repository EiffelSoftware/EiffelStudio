note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	USTAR_HEADER_TEST_SET

inherit
	TAR_TEST_SET_BASE

feature -- Internal checks

	test_template_length
			-- Check whether all templates have the correct length
		do
			assert ("correct easy template size", easy_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct link template size", link_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct devnode template size", devnode_header_blob.count = {TAR_CONST}.tar_block_size)
			assert ("correct split template size", split_header_blob.count = {TAR_CONST}.tar_block_size)
		end

feature -- Test writing methods

	test_easy_header_write
			-- Test whether USTAR_HEADER_WRITER generates correct ustar headers for a pretty standard file
		note
			testing:  "covers/{USTAR_HEADER_WRITER}"
		local
			unit_under_test: USTAR_HEADER_WRITER
			output: SPECIAL[CHARACTER_8]
		do
			create unit_under_test

			unit_under_test.set_active_header (easy_header)

			assert ("can write valid header", unit_under_test.writable (easy_header))
			assert ("has correct size", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content", compare_special (easy_header_blob, output))
		end

	test_link_header_write
			-- Test whether USTAR_HEADER_WRITER generates correct ustar headers for symlinks
		note
			testing:  "covers/{USTAR_HEADER_WRITER}"
		local
			unit_under_test: USTAR_HEADER_WRITER
			output: SPECIAL[CHARACTER_8]
		do
			create unit_under_test

			unit_under_test.set_active_header (link_header)

			assert ("can write valid header", unit_under_test.writable (link_header))
			assert ("has correct size", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content", compare_special (link_header_blob, output))
		end

	test_devnode_header_write
			-- Test whether USTAR_HEADER_WRITER generates correct ustar headers for device nodes
		note
			testing:  "covers/{USTAR_HEADER_WRITER}"
		local
			unit_under_test: USTAR_HEADER_WRITER
			output: SPECIAL[CHARACTER_8]
		do
			create unit_under_test

			unit_under_test.set_active_header (devnode_header)

			assert ("can write valid header", unit_under_test.writable (devnode_header))
			assert ("has correct size", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content", compare_special (devnode_header_blob, output))
		end

	test_split_header_write
			-- Test whether USTAR_HEADER_WRITER generates correct ustar headers for split filenames
		note
			testing:  "covers/{USTAR_HEADER_WRITER}"
		local
			unit_under_test: USTAR_HEADER_WRITER
			output: SPECIAL[CHARACTER_8]
		do
			create unit_under_test

			unit_under_test.set_active_header (split_header)

			assert ("can write valid header", unit_under_test.writable (split_header))
			assert ("has correct size", unit_under_test.required_blocks = 1)

			output := write_header_to_new_managed_poitner (unit_under_test).read_special_character_8 (0, {TAR_CONST}.tar_block_size)

			assert ("correct output length", output.count = {TAR_CONST}.tar_block_size)
			assert ("correct output content", compare_special (split_header_blob, output))
		end

feature -- Test parsing methods

	test_easy_header_parse
			-- Test whether USTAR_HEADER_PARSER parses the easy blob correctly
		note
			testing:  "covers/{USTAR_HEADER_PARSER}"
		local
			unit_under_test: USTAR_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (easy_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ easy_header)
		end

	test_link_header_parse
			-- Test whether USTAR_HEADER_PARSER parses the link blob correctly
		note
			testing:  "covers/{USTAR_HEADER_PARSER}"
		local
			unit_under_test: USTAR_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (link_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ link_header)
		end

	test_devnode_header_parse
			-- Test whether USTAR_HEADER_PARSER parses the devnode blob correctly
		note
			testing:  "covers/{USTAR_HEADER_PARSER}"
		local
			unit_under_test: USTAR_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (devnode_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ devnode_header)
		end

	test_split_header_parse
			-- Test whether USTAR_HEADER_PARSER parses the split blob correctly
		note
			testing:  "covers/{USTAR_HEADER_PARSER}"
		local
			unit_under_test: USTAR_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (split_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ split_header)
		end

	test_space_header_parse
			-- Test whether USTAR_HEADER_PARSER parses the spaces blob correctly
		note
			testing: "covers/{USTAR_HEADER_PARSER}"
		local
			unit_under_test: USTAR_HEADER_PARSER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (spaces_header_blob.base_address, {TAR_CONST}.tar_block_size)

			unit_under_test.parse_block (p, 0)

			assert ("finished parsing after singe block", unit_under_test.parsing_finished)
			assert ("parsing successfull", unit_under_test.parsed_header /= Void)
			assert ("headers match", unit_under_test.parsed_header ~ spaces_header)
		end

feature {NONE} -- Data - easy

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

feature {NONE} -- Data - link


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

feature {NONE} -- Data - Device node

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

feature {NONE} -- Data - split

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

feature {NONE} -- Data - spaces

	spaces_header_blob: SPECIAL[CHARACTER_8]
			-- Return blob for spaces_header
		local
			header_template: STRING_8
		once
			-- Templates use $ instead of %U (because like this all characters are the same width)
			--                   Filename                                                                                            Mode    uid     gid     size        mtime       chksum T Linkname                                                                                            mag  Ve username                        groupname                       dmajor  dminor  prefix                                                                                                                                                     unused
			--                  |                                                                                                  ||      ||      ||      ||          ||          ||      |||                                                                                                  ||    ||||                              ||                              ||      ||      ||                                                                                                                                                         ||           |
			--         Offset:  0       8      16      24      32      40      48      56      64      72      80      88      96     104     112     120     128     136     144     152     160     168     176     184     192     200     208     216     224     232     240     248     256     264     272     280     288     296     304     312     320     328     336     344     352     360     368     376     384     392     400     408     416     424     432     440     448     456     464     472     480     488     496     504     512
			--                  |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |
			header_template := "home/nicolas/out.ps$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 000644$ 001750$ 000144$ 0001215414$12615214330$ 015305$0$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ustar$00nicolas$$$$$$$$$$$$$$$$$$$$$$$$$users$$$$$$$$$$$$$$$$$$$$$$$$$$$  00000$ 000000$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			Result := header_template.area
			Result.remove_tail (1)
		end

	spaces_header: TAR_HEADER
			-- Header corresponding to testset spaces
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


