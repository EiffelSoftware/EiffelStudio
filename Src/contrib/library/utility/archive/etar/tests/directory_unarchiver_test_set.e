note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	DIRECTORY_UNARCHIVER_TEST_SET

inherit
	TAR_TEST_SET_BASE
	redefine
		on_prepare
	end

feature -- Test routines

	test_directory_unarchiver_easy
			-- Test DIRECTORY_UNARCHIVER with easy data
	local
			unit_under_test: DIRECTORY_UNARCHIVER
			l_file: FILE
		do
			create unit_under_test

			assert ("Can unarchive directory", unit_under_test.unarchivable (easy_header))

			unit_under_test.initialize (easy_header)
			assert ("No blocks processed", unit_under_test.unarchived_blocks = 0)
			assert ("Finished", unit_under_test.unarchiving_finished)

				-- TODO: compare metadata


				-- Compare file contents
			create {RAW_FILE} l_file.make_with_path (easy_header.filename)
			assert ("File unarchived and stored to disk", l_file.exists)
			assert ("Is directory", l_file.is_directory)
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

feature {NONE} -- Data - easy

	easy_header: TAR_HEADER
			-- Header for the easy test data
		once
			create Result
			Result.set_filename (create {PATH}.make_from_string ("test_files/unarchiver/easy_dir"))
			Result.set_mode (0c0755)
			Result.set_user_id (0c1750)
			Result.set_group_id (0c144)
			Result.set_mtime (0c12636054745) -- ~ Dec 21 20:58
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_directory)
			Result.set_user_name ("nicolas")
			Result.set_group_name ("users")
		end

end


