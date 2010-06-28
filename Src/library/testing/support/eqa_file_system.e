note
	description: "[
		Objects creating directories and files in a system test set environment.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_FILE_SYSTEM

create
	make

feature {NONE} -- Initialization

	make (a_test_set: like test_set)
			-- Initialize `Current'.
			--
			-- `a_test_set': Test set in which `Current' is used.
		require
			a_test_set_attached: a_test_set /= Void
		do
			test_set := a_test_set
		end

feature -- Access

	test_set: EQA_TEST_SET
			-- Test set in which `Current' is used

feature -- Command

	copy_file (a_src: FILE; a_env: EQA_ENVIRONMENT; a_dest: FILE; a_substitute: BOOLEAN)
			-- Append lines of file `a_src', with environment
			-- variables substituted according to `a_env' (but
			-- only if `substitute' is true) to
			-- file `a_dest'.
		require
			source_not_void: a_src /= Void
			destination_not_void: a_dest /= Void
			environment_not_void: a_env /= Void
			source_is_closed: a_src.is_closed
			destination_is_closed: a_dest.is_closed
		local
			l_line: STRING
		do
			from
				a_src.open_read
				a_dest.open_write
			until
				a_src.end_of_file
			loop
				a_src.read_line
				if a_substitute then
					l_line := a_env.substitute (a_src.last_string)
				else
					l_line := a_src.last_string
				end
				if not a_src.end_of_file then
					a_dest.put_string (l_line)
					a_dest.new_line
				elseif not l_line.is_empty then
					a_dest.put_string (l_line)
				end
			end;
			a_src.close
			a_dest.flush
			a_dest.close
		end

feature -- Query: Path

	build_path (a_dir: READABLE_STRING_8; a_path: detachable EQA_SYSTEM_PATH): STRING
			-- Build an absolute path name given a base directory and an optional path
			--
			-- `a_dir': A base dir in form of an absolute path.
			-- `a_path': A relative path to append to `a_dir'.
			-- `Result': Absolute path that results from appending items in `a_path' to `a_dir'
		require
			a_dir_attached: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
		do
			Result := build_partial_path (a_path, a_dir, 0)
		ensure
			result_attached: Result /= Void
		end

	build_path_from_key (a_key: READABLE_STRING_8; a_path: detachable EQA_SYSTEM_PATH): STRING
			-- Build an absolte path name given the key of an defined absolte path
			--
			-- Note: will raise exception if value for `a_key' is not defined.
			--
			-- `a_key': Key for which an absolute base dir is defined in {EQA_ENVIRONMENT}
			-- `a_path': An optional relative path to append to the resulting path.
			-- `Result': Absolute path that results from appending items in `a_path' to base dir.
		require
			a_key_attached: a_key /= Void
			a_key_not_empty: not a_key.is_empty
		local
			l_base: READABLE_STRING_8
			l_test_set: like test_set
		do
			l_test_set := test_set
			l_base := l_test_set.environment.get_attached (a_key, l_test_set)
			Result := build_partial_path (a_path, l_base, 0)
		ensure
			result_attached: Result /= Void
		end

	build_source_path (a_path: detachable EQA_SYSTEM_PATH): STRING
			-- Build the actual path name relative to the source directory for given path
			--
			-- Note: will raise exception if {EQA_SYSTEM_TEST_SET}.source_path_key is not defined.
			--
			-- `a_path': Optional path for which path name should be built.
			-- `Result': Path name relative to source directory.
		do
			Result := build_path_from_key ({EQA_SYSTEM_TEST_SET}.source_path_key, a_path)
		ensure
			result_attached: Result /= Void
		end

	build_target_path (a_path: detachable EQA_SYSTEM_PATH): STRING
			-- Build the actual path name relative to the target directory for given path.
			--
			-- Note: will raise exception if {EQA_SYSTEM_TEST_SET}.target_path_key is not defined.
			--
			-- `a_path': Optional path for which path name should be built
			-- `Result': Path name relative to target directory.
		do
			Result := build_path_from_key ({EQA_SYSTEM_TEST_SET}.target_path_key, a_path)
		ensure
			result_attached: Result /= Void
		end

feature -- Query: Content

	has_same_content_as_string (a_path: EQA_SYSTEM_PATH; a_string: READABLE_STRING_8): BOOLEAN
			-- Does target file for path have same content as given string?
			--
			-- `a_path': Path relative to `target_directory' of file
			-- `a_string': String to be compared with content of file
			-- `Result': True if file has same content as `a_string', False otherwise
			--
			-- Note: if file does not exists or is not readable an exception is raised.
		require
			a_path_attached: a_path /= Void
			a_path_not_empty: not a_path.is_empty
			a_string_attached: a_string /= Void
		local
			l_filename: like build_target_path
			l_file: FILE
			i, l_count: INTEGER
		do
			l_filename := build_target_path (a_path)
			create {PLAIN_TEXT_FILE} l_file.make (l_filename)
			assert ("file_exists", l_file.exists)
			assert ("file_readable", l_file.is_readable)
			l_file.open_read
			from
				i := 1
				l_count := a_string.count
				Result := True
				l_file.read_character
			until
				i > l_count or l_file.end_of_file or not Result
			loop
				Result := a_string.item (i) = l_file.last_character
				l_file.read_character
				i := i + 1
			end
			if Result then
				Result := i > l_count and l_file.end_of_file
			end
			l_file.close
		end

	has_same_content_as_path (a_first_path, a_second_path: EQA_SYSTEM_PATH): BOOLEAN
			-- Do target files for given paths have the same content?
			--
			-- `a_first': Relative path of first file.
			-- `a_second': Relative path of second file.
			-- `Result': True if both files existed and are readable and have identical content, False
			--           otherwise
			--
			-- Note: if files do not exist or are not readable an exception is raised.
		require
			a_first_path_attached: a_first_path /= Void
			a_first_path_not_empty: not a_first_path.is_empty
			a_second_path_attached: a_second_path /= Void
			a_second_path_not_empty: not a_second_path.is_empty
		local
			l_filename1, l_filename2: like build_target_path
			l_file1, l_file2: FILE
		do
			l_filename1 := build_target_path (a_first_path)
			l_filename2 := build_target_path (a_second_path)
			create {PLAIN_TEXT_FILE} l_file1.make (l_filename1)
			create {PLAIN_TEXT_FILE} l_file2.make (l_filename2)
			assert ("file1_exists", l_file1.exists)
			assert ("file2_exists", l_file2.exists)
			assert ("file1_readable", l_file1.readable)
			assert ("file2_readable", l_file2.readable)
			l_file1.open_read
			l_file2.open_read
			from
				l_file1.read_character
				l_file2.read_character
				Result := True
			until
				l_file1.end_of_file or l_file2.end_of_file or not Result
			loop
				Result := l_file1.last_character = l_file2.last_character
				l_file1.read_character
				l_file2.read_character
			end
			if Result then
				Result := l_file1.end_of_file and l_file2.end_of_file
			end
			l_file1.close
			l_file2.close
		end

	executable_file_exists (s: STRING): detachable STRING
			-- If file `s' does not exist or is not a file or
			-- is not executable, string describing the
			-- problem.  Void otherwise
		local
			f: RAW_FILE
			l_fname: STRING
		do
			if s /= Void then
				l_fname := s
			else
				l_fname := "(Void file name)"
			end
			create f.make (l_fname)
			if not f.exists then
				Result := "file " + l_fname + " not found"
			elseif not f.is_plain then
				Result := "file " + l_fname + " not a plain file"
			elseif not f.is_executable then
				Result := "file " + l_fname + " not executable"
			end
		end

feature {NONE} -- Query

	build_partial_path (a_path: detachable EQA_SYSTEM_PATH; a_prefix: READABLE_STRING_8; a_strip: INTEGER): DIRECTORY_NAME
			-- Build a partial path name relative to to a given directory.
			--
			-- `a_path': Path for which path name should be built
			-- `a_prefix': Absolute directory name to which `a_path' is relative.
			-- `a_strip': Numer of items at the end of `a_path' to be neglected.
			-- `Result': Path name relative to target directory.
		require
			a_prefix_attached: a_prefix /= Void
			a_strip_not_negative: a_strip >= 0
			a_stip_not_too_large: a_strip > 0 implies (attached a_path and then a_strip <= a_path.count)
		local
			i, l_count: INTEGER
		do
			create Result.make_from_string (a_prefix)
			if a_path /= Void then
				from
					l_count := a_path.count - a_strip
					i := 1
				until
					i > l_count
				loop
					Result.extend (a_path.item (i))
					i := i + 1
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Basic

	delete_directory_tree (a_dir_name: READABLE_STRING_8)
			-- Try to delete the directory tree rooted at
			-- `a_dir_name'.  Ignore any errors
		require
			directory_not_void: a_dir_name /= Void;
		local
			l_dir: DIRECTORY
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_dir.make (a_dir_name)
				l_dir.recursive_delete
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	frozen assert (a_tag: STRING; a_condition: BOOLEAN)
			-- Assert `a_condition' using asserter from current test set.
		require
			a_tag_attached: a_tag /= Void
		do
			test_set.assert (a_tag, a_condition)
		end

feature -- Constants

	source_directory_key: STRING = "SOURCE_DIRECTORY"

	target_directory_key: STRING = "EQA_TARGET_DIRECTORY"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
