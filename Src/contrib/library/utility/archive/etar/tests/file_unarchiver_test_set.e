note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	FILE_UNARCHIVER_TEST_SET

inherit
	TAR_TEST_SET_BASE
		redefine
			on_prepare
		end

feature -- Test routines

	test_easy_file_unarchiver
			-- Test FILE_UNARCHIVER with easy text-only file
		local
			unit_under_test: FILE_UNARCHIVER
			p: MANAGED_POINTER
			l_file: FILE
		do
			create unit_under_test
			create p.make (easy_payload_blob.count)
			p.put_special_character_8 (easy_payload_blob, 0, 0, easy_payload_blob.count)

			assert ("Correct payload size", p.count = {TAR_CONST}.tar_block_size)

			assert ("Can unarchive regular file", unit_under_test.unarchivable (easy_header))

			unit_under_test.initialize (easy_header)

			assert ("Not finished", not unit_under_test.unarchiving_finished)
			assert ("No blocks processed", unit_under_test.unarchived_blocks = 0)

			unit_under_test.unarchive_block (p, 0)

			assert ("Finished", unit_under_test.unarchiving_finished)
			assert ("One block unarchived", unit_under_test.unarchived_blocks = 1)

				-- TODO: compare file metadata


				-- Compare file contents
			create {RAW_FILE} l_file.make_with_path (easy_header.filename)
			assert ("File unarchived and stored to disk", l_file.exists)

			l_file.open_read
			assert ("Contents match", same_content (l_file, easy_payload_blob, easy_header.size.as_integer_32))
		end

	test_root_file_unarchiver
			-- Test FILE_UNARCHIVER with easy text-only file
		local
			unit_under_test: FILE_UNARCHIVER
			p: MANAGED_POINTER
			l_file: FILE
		do
			create unit_under_test
			create p.make (root_payload_blob.count)
			p.put_special_character_8 (root_payload_blob, 0, 0, root_payload_blob.count)

			assert ("Correct payload size", p.count = {TAR_CONST}.tar_block_size)

			assert ("Can unarchive regular file", unit_under_test.unarchivable (root_header))

			unit_under_test.initialize (root_header)

			assert ("Not finished", not unit_under_test.unarchiving_finished)
			assert ("No blocks processed", unit_under_test.unarchived_blocks = 0)

			unit_under_test.unarchive_block (p, 0)

			assert ("Finished", unit_under_test.unarchiving_finished)
			assert ("One block unarchived", unit_under_test.unarchived_blocks = 1)

				-- TODO: compare file metadata


				-- Compare file contents
			create {RAW_FILE} l_file.make_with_path (root_header.filename)
			assert ("File unarchived and stored to disk", l_file.exists)

			l_file.open_read
			assert ("Contents match", same_content (l_file, root_payload_blob, root_header.size.as_integer_32))
		end



feature {NONE} -- Events

	on_prepare
			-- Create necessary output directory
		local
			d: DIRECTORY
		do
			create d.make_with_name ("test_files/unarchiver")
			if not d.exists then
				d.create_dir
			end
		end

feature {NONE} -- Utilites

	same_content (a_file: FILE; a_template: SPECIAL[CHARACTER_8]; n: INTEGER): BOOLEAN
			-- Compare whether contents in a_special (up to `n'-th character or file end)
		require
			file_open_for_reading: a_file.is_open_read and not a_file.is_open_append
			template_large_enough: a_template.count >= n
		local
			i: INTEGER
		do
			from
				Result := True
				i := 0
				if a_file.readable then
					a_file.read_character
				end
			until
				i >= n or not a_file.readable
			loop
				if (a_file.last_character /= a_template[i]) then
					Result := False
					print ("Different contents at character ")
					print (i)
					print (". File: ")
					print (a_file.last_character)
					print (". Template: ")
					print (a_template[i])
				end
				i := i + 1
				if a_file.readable then
					a_file.read_character
				end
			end
			Result := Result and (not a_file.readable implies a_template[i] = '%U')
		end

feature {NONE} -- Data - easy

	easy_header: TAR_HEADER
			-- Header for the easy test data
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("test_files/unarchiver/root.txt"))
			Result.set_mode (0c0644)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_size (0c60)
			Result.set_mtime (0c12636054745) -- ~ Dec 21 20:58
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

	easy_payload_blob: SPECIAL[CHARACTER_8]
			-- Payload blob for easy test data
		local
			header_template: STRING_8
		once
			header_template := "# ETAR^Eiffel compression library based on tar.^$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			header_template.replace_substring_all ("$", "%U")
			header_template.replace_substring_all ("^", "%N")
			Result := header_template.area
			Result.remove_tail (1)
		end

	root_header: TAR_HEADER
			-- Header for dataset with file that has owner root
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("test_files/unarchiver/easy.txt"))
			Result.set_mode (0c0644)
			Result.set_user_id (0)
			Result.set_group_id (0)
			Result.set_size (0c60)
			Result.set_mtime (0c12636054745) -- ~ Dec 21 20:58
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name ("root")
			Result.set_group_name ("root")
		end

	root_payload_blob: SPECIAL [CHARACTER_8]
			-- Payload blob for root test data
		once
			Result := easy_payload_blob
		end
end


