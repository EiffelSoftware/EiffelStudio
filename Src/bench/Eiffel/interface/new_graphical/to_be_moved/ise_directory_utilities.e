indexing
	description	: "Features to create/manipulate directories and directory names"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ISE_DIRECTORY_UTILITIES

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

create
	default_create,
	make_for_test

feature -- Basic operations

	validate_directory_name (a_directory_name: STRING): DIRECTORY_NAME is
			-- Check the validy of `a_directory_name'. If it is valid or almost
			-- valid, returns the valid name of `a_directory_name', otherwise
			-- returns Void.
		require
			a_directory_name_not_void_nor_empty:
				a_directory_name /= Void and then not a_directory_name.is_empty
		local
			a_directory_name_string: STRING
			ending_char: CHARACTER
		do
			a_directory_name_string := clone (a_directory_name)

				-- Remove blanks
			a_directory_name_string.left_adjust
			a_directory_name_string.right_adjust
			
			if a_directory_name_string.count /= 0 then
					-- Remove any ending separator
				ending_char := (a_directory_name_string @ a_directory_name_string.count)
				if ending_char = Operating_environment.Directory_separator and then
				   a_directory_name_string.count >= 2 and then
				   a_directory_name_string @ (a_directory_name_string.count - 1) /= ':'
				then
				   a_directory_name_string.head (a_directory_name_string.count - 1)
				end

				create Result.make_from_string (a_directory_name_string)
				if not Result.is_valid then
					Result := Void
				end
			end
		ensure
			Result_is_void_or_a_valid_directory: Result = Void or else (Result.is_valid and not Result.is_empty)
		end

	recursive_create_directory (a_directory_name: DIRECTORY_NAME) is
			-- Create the directory `a_directory_name' recursively.
			-- 
			-- Ex: if /temp/ exists but not /temp/test, calling 
			--     `recursive_create_directory ("/temp/test/toto")'
			--     will create /temp/test and then /temp/test/toto.
		require
			valid_directory_name: 
				a_directory_name /= Void and then 
				not a_directory_name.is_empty and then
				a_directory_name.is_valid
		local
			a_directory: DIRECTORY
			new_directory_name: DIRECTORY_NAME
			directories_to_build: LINKED_LIST [STRING]
			built_directory: STRING
			loc_directory_name: STRING
			separator_index: INTEGER
		do
			create directories_to_build.make

				-- Find the first existing directory in the path name
			from
				built_directory := clone (a_directory_name)
				separator_index := built_directory.count
				create a_directory.make (built_directory)
			until
				a_directory.exists
			loop
				separator_index := built_directory.last_index_of (Operating_environment.Directory_separator, built_directory.count)
				if separator_index = 0 then
					raise ("Invalid_directory")
				end
				directories_to_build.put_front (built_directory.substring (separator_index + 1, built_directory.count))
				if built_directory @ (separator_index - 1) = ':' then
					loc_directory_name := built_directory.substring (1, separator_index)
				else
					loc_directory_name := built_directory.substring (1, separator_index - 1)
				end
				built_directory := built_directory.substring (1, separator_index - 1)
				create a_directory.make (loc_directory_name)
			end

				-- Recursively create the directory.
			from
				directories_to_build.start
				create new_directory_name.make_from_string (built_directory)
			until
				directories_to_build.is_empty
			loop
				new_directory_name.extend (directories_to_build.item)
				directories_to_build.remove
				
				create a_directory.make (new_directory_name)
				a_directory.create_dir
				if not a_directory.exists then
					raise ("Unable_to_create_directory")
				end
			end
		ensure
			Result_exists: (create {DIRECTORY}.make (a_directory_name)).exists
		end

	path_ellipsis (a_path: STRING; a_max_length: INTEGER): STRING is
			-- Create the displayed string of `a_path', with a maximum
			-- length of `a_max_length' characters. If `a_path' is
			-- longer than `a_max_length', we only keep the beginning
			-- and the end of the pathname, and we put "..." in the
			-- middle.
			-- A typical `Result' of this feature is "C:\...\EIFGEN\W_code\TRANSLAT"
		require
			a_path_valid: a_path /= Void
			a_max_length_valid: a_max_length > 0
		local
			slash_index: INTEGER
			cur_length: INTEGER
			a_path_count: INTEGER
			loc_directory_separator: CHARACTER
		do
				-- Initialize local/cached variables
			a_path_count := a_path.count
			loc_directory_separator := operating_environment.directory_separator

			if a_max_length >= a_path.count then
				Result := clone (a_path)
			else
				create Result.make (a_max_length)
				slash_index := a_path.index_of (loc_directory_separator, 1)
				Result.append (a_path.substring (1, slash_index))
				Result.append ("...")
				cur_length := a_max_length - slash_index - 3
				from until
					a_path.count - slash_index < cur_length or
					slash_index = 0
				loop
					slash_index := a_path.index_of (loc_directory_separator, slash_index + 1)
				end

				if slash_index /= 0 then
						-- We build a path like "C:\...\Dir\Dir\File"
					Result.append (a_path.substring (slash_index, a_path.count))
				else
						-- We can't build the same path as above (not enoug room) so
						-- we will only display the file name (the beginning at least)
					Result := a_path.substring (a_path.last_index_of (loc_directory_separator, a_path.count) + 1, a_path.count)
					if Result.count > a_max_length then
						Result := Result.substring (1, a_max_length)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
			Result_length_not_bigger_than_maximum: Result.count <= a_max_length
		end

feature {NONE} -- Validation

	make_for_test is
			-- Test the features of this class.
		local
			dir: DIRECTORY_NAME
		do
			if Operating_environment.directory_separator = '\' then
				test_validate_directory_name ("c:\", True)
				test_validate_directory_name (" c:\temp", True)
				test_validate_directory_name ("c:\temp ", True)
				test_validate_directory_name (" ", False)
				test_validate_directory_name ("c:\temp", True)
				test_validate_directory_name ("c:\temp\", True)
				test_validate_directory_name ("c:\\temp", False)
				test_validate_directory_name ("/:temp", False)
				test_validate_directory_name ("C:te?mp", False)
				test_validate_directory_name ("C:>", False)
				test_validate_directory_name ("C:<test", False)
				test_validate_directory_name ("C:\te<st", False)
				test_validate_directory_name ("C:\te|st", False)
				test_validate_directory_name ("|C:\", False)
				test_validate_directory_name ("\", True)
				test_validate_directory_name ("temp", True)
				test_validate_directory_name ("c:\temp/toto%%/test", False)

				create dir.make_from_string ("C:\009")
				recursive_create_directory (dir)
				create dir.make_from_string ("c:\temp\test1\test2\test3")
				recursive_create_directory (dir)
				create dir.make_from_string ("C:\Compils\555\zot\zoro")
				recursive_create_directory (dir)
			end
		end

	test_validate_directory_name (a_dir: STRING; a_dir_valid: BOOLEAN) is
		local
			dir: DIRECTORY_NAME
		do
			create dir.make_from_string (a_dir)
			if (validate_directory_name (dir) /= Void) /= a_dir_valid then
				io.putstring ("`validate_directory_name' failed for "+a_dir+"%N")
			end
			dir := validate_directory_name (dir)
		end


end -- class ISE_DIRECTORY_UTILS
