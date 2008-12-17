indexing
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

	make (a_environment: like environment)
			-- Initialize `Current'.
			--
			-- `a_environment': Environment for current system test.
		require
			a_environment_valid: a_environment.test_set.has_valid_name
		do
			environment := a_environment
		end

feature -- Access

	environment: !EQA_SYSTEM_ENVIRONMENT
			-- Environment for current system test.

	last_created_directory: ?DIRECTORY
			-- Directory last created through `create_directory_from_path'

	last_created_file: ?PLAIN_TEXT_FILE
			-- File last created through `create_file_from_path'

feature -- Query

	build_source_path (a_path: !EQA_SYSTEM_PATH): !STRING
			-- Build the actual path name relative to the source directory for given path.
			--
			-- `a_path': Path for which path name should be built
			-- `Result': Path name relative to source directory.
		do
			Result := build_partial_path (a_path, source_directory, 0)
		end

	build_target_path (a_path: !EQA_SYSTEM_PATH): !STRING
			-- Build the actual path name relative to the target directory for given path.
			--
			-- `a_path': Path for which path name should be built
			-- `Result': Path name relative to target directory.
		do
			Result := build_partial_path (a_path, target_directory, 0)
		end

feature {NONE} -- Query

	source_directory: !READABLE_STRING_8
			-- Name of directory in which original testing directories are located.
		do
			Result := environment.source_directory
		end

	target_directory: !READABLE_STRING_8
			-- Name of directory in which testing directories are created.
		do
			Result := environment.target_directory
		end

	build_partial_path (a_path: !EQA_SYSTEM_PATH; a_prefix: !READABLE_STRING_8; a_strip: INTEGER): !DIRECTORY_NAME
			-- Build a partial path name relative to to a given directory.
			--
			-- `a_path': Path for which path name should be built
			-- `a_prefix': Absolute directory name to which `a_path' is relative.
			-- `a_strip': Numer of items at the end of `a_path' to be neglected.
			-- `Result': Path name relative to target directory.
		require
			a_strip_valid: a_strip >= 0 and a_strip <= a_path.count
		local
			i, l_count: INTEGER
		do
			create Result.make_from_string (a_prefix)
			Result.extend (environment.test_suffix)
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

feature -- Basic operations

	create_directory_from_path (a_path: !EQA_SYSTEM_PATH)
			-- Recursively create target directory from path and store {DIRECTORY} instance in
			-- `last_created_directory'.
			--
			-- `a_path': Path representing path name for target directory.
		do
			last_created_directory := Void
			create_directory_from_partial_path (a_path, 0)
		ensure
			last_created_directory_attached: last_created_directory /= Void
			last_created_directory_valid: {l_dir: !like last_created_directory} last_created_directory and then
				l_dir.name ~ build_target_path (a_path).string and then
				l_dir.exists
		end

	create_file_from_path (a_path: !EQA_SYSTEM_PATH)
			-- Create target file from path recursively and store open writable {PLAIN_TEXT_FILE}
			-- instance in `last_crerated_file'. Also {DIRECTORY} instance of target directory in which new
			-- file is located will be stored in `last_created_directory'.
			--
			-- `a_path': Path representing path name for target file.
		require
			a_path_not_empty: not a_path.is_empty
		local
			l_file: PLAIN_TEXT_FILE
		do
			create_directory_from_partial_path (a_path, 1)
			create l_file.make (build_target_path (a_path))
			if (l_file.exists and then l_file.is_writable) or l_file.is_creatable then
				l_file.open_write
			elseif l_file.is_creatable then
				l_file.create_read_write
			end
			last_created_file := l_file
		ensure
			last_created_file_attached: last_created_file /= Void
			last_created_file_open_write: {l_last_file: like last_created_file} last_created_file and then
				l_last_file.is_open_write
			last_created_directory_attached: last_created_directory /= Void
			last_created_directory_valid: {l_dir: !like last_created_directory} last_created_directory and then
				l_dir.name ~ build_partial_path (a_path, target_directory, 1).string and then
				l_dir.exists
		end

feature {NONE} -- Implementation

	create_directory_from_partial_path (a_path: !EQA_SYSTEM_PATH; a_strip: INTEGER)
			-- Recursively create target directory from partial path recursively and store {DIRECTORY}
			-- instance in `last_created_directory'.
			--
			-- `a_path': Path representing path name for target directory.
			-- `a_strip': Numer of items at the end of `a_path' to be neglected.
		require
			a_strip_valid: a_strip >= 0 and a_strip <= a_path.count
		local
			l_dirname: DIRECTORY_NAME
			l_directory: like last_created_directory
		do
			l_dirname := build_partial_path (a_path, target_directory, a_strip)

				-- Reuse any existing directory in `last_created_directory'
				--
				-- Note: setting `last_created_directory' Void in `create_directory_from_path' prevents reusing
				--       a directory instance used by a client.
			l_directory := last_created_directory
			if l_directory = Void then
				create l_directory.make (l_dirname)
				last_created_directory := l_directory
			else
				l_directory.make (l_dirname)
			end

			if not l_directory.exists then
				if a_strip = a_path.count then
					check_target_directory_existence
				else
					create_directory_from_partial_path (a_path, a_strip + 1)
				end

					-- `check_target_directory_existence' and `create_directory_from_partial_path' both alter the
					-- current directory name, so we have to reset it.
				l_directory.make (l_dirname)

				l_directory.create_dir
				assert ("target_directory_createable", l_directory.exists)
			end
		ensure
			last_created_directory_attached: last_created_directory /= Void
			last_created_directory_valid: {l_dir: !like last_created_directory} last_created_directory and then
				l_dir.name ~ build_partial_path (a_path, target_directory, a_strip).string and then
				l_dir.exists
		end

	check_target_directory_existence
			-- Check if `target_directory' exists, raise exception through `assert' if that is not the case.
		require
			last_created_directory_attached: last_created_directory /= Void
		local
			l_directory: like last_created_directory
		do
			l_directory := last_created_directory
			check l_directory /= Void end
			l_directory.make (target_directory)
			assert ("testing_directory_exists", l_directory.exists)
		ensure
			last_created_directory_attached: last_created_directory /= Void
			last_created_directory_valid: {l_dir: !like last_created_directory} last_created_directory and then
				l_dir.name ~ target_directory.as_string_8 and then l_dir.exists
		end

	frozen assert (a_tag: !STRING; a_condition: BOOLEAN)
			-- Assert `a_condition' using asserter from current test set.
		do
			environment.test_set.assert (a_tag, a_condition)
		end

invariant
	current_test_has_name: environment.test_set.has_valid_name

end
