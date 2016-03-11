note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TAR_HEADER_TEST_SET

inherit
	TAR_TEST_SET_BASE

feature -- Test routines

	test_filename
			-- Test filename setting/reading
		local
			unit_under_test: TAR_HEADER
			l_path: PATH
		do
			create unit_under_test

			-- Relative path
			create l_path.make_from_string ("test_files")
			unit_under_test.set_filename (l_path)
			assert ("Relative path set", unit_under_test.filename ~ l_path)

			-- Absolute path
			create l_path.make_from_string ("/home/nicolas")
			unit_under_test.set_filename (l_path)
			assert ("Absolute path set", unit_under_test.filename ~ l_path)
		end

	test_mode
			-- Test mode setting/reading
		local
			unit_under_test: TAR_HEADER
			l_mode: NATURAL_16
		do
			create unit_under_test

				-- Simple setting
			l_mode := 0c777
			unit_under_test.set_mode (l_mode)
			assert ("Simple mode set", unit_under_test.mode = l_mode)

				-- With masking
			l_mode := 0c12755
			unit_under_test.set_mode (l_mode)
			assert ("Mode masked", unit_under_test.mode = (l_mode & 0c7777))

				-- Single bit setting
				-- setuid
			unit_under_test.set_mode (0)
			unit_under_test.set_setuid (True)
			assert ("Setuid enabled", unit_under_test.is_setuid and unit_under_test.mode = 0c4000)
			unit_under_test.set_setuid (False)
			assert ("Setuid disabled", not unit_under_test.is_setuid and unit_under_test.mode = 0)
				-- setgid
			unit_under_test.set_mode (0)
			unit_under_test.set_setgid (True)
			assert ("Setgid enabled", unit_under_test.is_setgid and unit_under_test.mode = 0c2000)
			unit_under_test.set_setgid (False)
			assert ("Setgid disabled", not unit_under_test.is_setgid and unit_under_test.mode = 0)
				-- user
					-- read
			unit_under_test.set_mode (0)
			unit_under_test.set_user_readable (True)
			assert ("User readable enabled", unit_under_test.is_user_readable and unit_under_test.mode = 0c400)
			unit_under_test.set_user_readable (False)
			assert ("User readable disabled", not unit_under_test.is_user_readable and unit_under_test.mode = 0)
					-- write
			unit_under_test.set_mode (0)
			unit_under_test.set_user_writable (True)
			assert ("User writable enabled", unit_under_test.is_user_writable and unit_under_test.mode = 0c200)
			unit_under_test.set_user_writable (False)
			assert ("User writable disabled", not unit_under_test.is_user_writable and unit_under_test.mode = 0)
					-- execute
			unit_under_test.set_mode (0)
			unit_under_test.set_user_executable (True)
			assert ("User executable enabled", unit_under_test.is_user_executable and unit_under_test.mode = 0c100)
			unit_under_test.set_user_executable (False)
			assert ("User executable disabled", not unit_under_test.is_user_executable and unit_under_test.mode = 0)
				-- group
					-- read
			unit_under_test.set_mode (0)
			unit_under_test.set_group_readable (True)
			assert ("Group readable enabled", unit_under_test.is_group_readable and unit_under_test.mode = 0c40)
			unit_under_test.set_group_readable (False)
			assert ("Group readable disabled", not unit_under_test.is_group_readable and unit_under_test.mode = 0)
					-- write
			unit_under_test.set_mode (0)
			unit_under_test.set_group_writable (True)
			assert ("Group writable enabled", unit_under_test.is_group_writable and unit_under_test.mode = 0c20)
			unit_under_test.set_group_writable (False)
			assert ("Group writable disabled", not unit_under_test.is_group_writable and unit_under_test.mode = 0)
					-- execute
			unit_under_test.set_mode (0)
			unit_under_test.set_group_executable (True)
			assert ("Group executable enabled", unit_under_test.is_group_executable and unit_under_test.mode = 0c10)
			unit_under_test.set_group_executable (False)
			assert ("Group executable disabled", not unit_under_test.is_group_executable and unit_under_test.mode = 0)
				-- other
					-- read
			unit_under_test.set_mode (0)
			unit_under_test.set_other_readable (True)
			assert ("Other readable enabled", unit_under_test.is_other_readable and unit_under_test.mode = 0c4)
			unit_under_test.set_other_readable (False)
			assert ("Other readable disabled", not unit_under_test.is_other_readable and unit_under_test.mode = 0)
					-- write
			unit_under_test.set_mode (0)
			unit_under_test.set_other_writable (True)
			assert ("Other writable enabled", unit_under_test.is_other_writable and unit_under_test.mode = 0c2)
			unit_under_test.set_other_writable (False)
			assert ("Other writable disabled", not unit_under_test.is_other_writable and unit_under_test.mode = 0)
					-- execute
			unit_under_test.set_mode (0)
			unit_under_test.set_other_executable (True)
			assert ("Other executable enabled", unit_under_test.is_other_executable and unit_under_test.mode = 0c1)
			unit_under_test.set_other_executable (False)
			assert ("Other executable disabled", not unit_under_test.is_other_executable and unit_under_test.mode = 0)
		end

	test_user_id
			-- Test uid setting / reading
		local
			unit_under_test: TAR_HEADER
			uid: NATURAL_32
		do
			create unit_under_test

			-- Root
			uid := 0
			unit_under_test.set_user_id (uid)
			assert ("Uid set to 0", unit_under_test.user_id = uid)

			-- First user
			uid := 1000
			unit_under_test.set_user_id (uid)
			assert ("uid set to 1000", unit_under_test.user_id = uid)
		end

	test_group_id
			-- Test gid setting / reading
		local
			unit_under_test: TAR_HEADER
			gid: NATURAL_32
		do
			create unit_under_test

			-- Zero
			gid := 0
			unit_under_test.set_group_id (gid)
			assert ("gid set to 0", unit_under_test.group_id = gid)

			-- Something else
			gid := 1000
			unit_under_test.set_group_id (gid)
			assert ("gid set to 1000", unit_under_test.group_id = gid)
		end

	test_size
			-- Test size setting / reading
		local
			unit_under_test: TAR_HEADER
			l_size: NATURAL_64
		do
			create unit_under_test

			-- Zero
			l_size := 0
			unit_under_test.set_size (l_size)
			assert ("size set to 0", unit_under_test.size = l_size)

			-- Something else
			l_size := 1021512
			unit_under_test.set_size (l_size)
			assert ("size set to 1021512", unit_under_test.size = l_size)
		end

	test_mtime
			-- Test mtime setting / reading
		local
			unit_under_test: TAR_HEADER
			l_mtime: NATURAL_64
		do
			create unit_under_test

			-- Zero
			l_mtime := 0
			unit_under_test.set_mtime (l_mtime)
			assert ("mtime set to 0", unit_under_test.mtime = l_mtime)

			-- Something else
			l_mtime := 1021512
			unit_under_test.set_mtime (l_mtime)
			assert ("mtime set to 1021512", unit_under_test.mtime = l_mtime)
		end

	test_typeflag
			-- Test typeflag setting / reading
		local
			unit_under_test: TAR_HEADER
			l_typeflag: CHARACTER_8
		do
			create unit_under_test

			-- block
			l_typeflag := {TAR_CONST}.tar_typeflag_block_special
			unit_under_test.set_typeflag (l_typeflag)
			assert ("Typeflag set to block", unit_under_test.typeflag = l_typeflag)

			-- regular file
			l_typeflag := {TAR_CONST}.tar_typeflag_regular_file
			unit_under_test.set_typeflag (l_typeflag)
			assert ("Typeflag set to regular file", unit_under_test.typeflag = l_typeflag)
		end

	test_username
			-- Test username setting / reading
		local
			unit_under_test: TAR_HEADER
			l_username, l_username_copy: STRING
		do
			create unit_under_test

			l_username := "nicolas"
			unit_under_test.set_user_name (l_username)
			assert ("Username set", unit_under_test.user_name ~ l_username)

			-- Copy and modify
			create l_username_copy.make_from_string (l_username)
			l_username := "root"
			assert ("Username unchanged if original changed", unit_under_test.user_name ~ l_username_copy)
		end

	test_groupname
			-- Test groupname setting / reading
		local
			unit_under_test: TAR_HEADER
			l_groupname, l_groupname_copy: STRING
		do
			create unit_under_test

			l_groupname := "users"
			unit_under_test.set_group_name (l_groupname)
			assert ("Groupname set", unit_under_test.group_name ~ l_groupname)

			-- Copy and modify
			create l_groupname_copy.make_from_string (l_groupname)
			l_groupname := "disk"
			assert ("Groupname unchanged if original changed", unit_under_test.group_name ~ l_groupname_copy)
		end

	test_devmajor
			-- Test devmajor setting / reading
		local
			unit_under_test: TAR_HEADER
			l_devmajor: NATURAL_32
		do
			create unit_under_test

			-- Zero
			l_devmajor := 0
			unit_under_test.set_device_major (l_devmajor)
			assert ("Devmajor set to 0", unit_under_test.device_major = l_devmajor)

			-- Something different
			l_devmajor := 153
			unit_under_test.set_device_major (l_devmajor)
			assert ("Devmajor set to 153", unit_under_test.device_major = l_devmajor)
		end

	test_devmior
			-- Test devminor setting / reading
		local
			unit_under_test: TAR_HEADER
			l_devminor: NATURAL_32
		do
			create unit_under_test

			-- Zero
			l_devminor := 0
			unit_under_test.set_device_minor (l_devminor)
			assert ("Devminor set to 0", unit_under_test.device_minor = l_devminor)

			-- Something different
			l_devminor := 153
			unit_under_test.set_device_minor (l_devminor)
			assert ("Devminor set to 153", unit_under_test.device_minor = l_devminor)
		end

end


