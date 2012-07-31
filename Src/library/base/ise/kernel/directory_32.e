note
	description: "Same as {DIRECTORY} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_32

inherit

	DIRECTORY
		rename
			change_name as change_name_8,
			delete_content_with_action as delete_content_with_action_8,
			has_entry as has_entry_8,
			lastentry as lastentry_8,
			linear_representation as linear_representation_8,
			make as make_8,
			make_open_read as make_open_read_8,
			name as name_8,
			recursive_delete_with_action as recursive_delete_with_action_8
		export
			{NONE} all
			{ANY}
				close,
				deep_twin,
				is_closed,
				is_deep_equal,
				is_empty,
				readentry,
				recursive_delete,
				standard_is_equal,
				start
		redefine
			count,
			create_dir,
			delete,
			delete_content,
			dir_next,
			exists,
			file_info,
			is_executable,
			is_readable,
			is_writable,
			open_read,
			recursive_create_dir
		end

create
	make

create {DIRECTORY_32}
	make_open_read

feature {DIRECTORY_32} -- Creation

	make (dn: READABLE_STRING_32)
			-- Create directory object for directory
			-- of name `dn'.
		require
			string_exists: dn /= Void
		local
			u: UTF_CONVERTER
		do
				-- Use UTF-8 versions of the features by default.
			make_8 (u.string_32_to_utf_8_string_8 (dn))
		ensure
			name_set: name ~ dn
		end

	make_open_read (dn: READABLE_STRING_32)
			-- Create directory object for directory
			-- of name `dn' and open it for reading.
		require
			string_exists: dn /= Void
		do
			make (dn)
			open_read
		ensure
			name_set: name ~ dn
		end

feature -- Basic operations

	open_read
			-- <Precursor>
		do
			if attached external_name_16 as n then
				directory_pointer := eif_dir_open_16 ($n)
				mode := Read_directory
			else
				Precursor
			end
		end

feature -- Access

	name: STRING_32
			-- Directory name
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32 (name_8)
		end

	linear_representation: ARRAYED_LIST [STRING_32]
			-- The entries, in sequential format.
		local
			dir_temp: DIRECTORY_32
			e: detachable STRING_32
		do
			create dir_temp.make_open_read (name)
				-- Arbitrary size for arrayed_list creation to avoid
				-- querying `count' which traverses list of entries
				-- in current directory as we do here, making current
				-- less efficient if Current has a lot of entries.
			create Result.make (16)
			from
				dir_temp.start
				dir_temp.readentry
				e := dir_temp.lastentry
			until
				e = Void
			loop
				Result.extend (e)
				dir_temp.readentry
				e := dir_temp.lastentry
			end
			dir_temp.close
		end

	lastentry: detachable STRING_32
			-- Last entry read by `readentry'.
		local
			u: UTF_CONVERTER
		do
			if attached lastentry_8 as e then
					-- Decode UTF-8 representation.
				Result := u.utf_8_string_8_to_string_32 (e)
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Does the directory exist?
		do
			if attached external_name_16 as n then
				Result := eif_dir_exists_16 ($n)
			else
				Result := Precursor
			end
		end

	is_readable: BOOLEAN
			-- <Precursor>
		do
			if attached external_name_16 as n then
				Result := eif_dir_is_readable_16 ($n)
			else
				Result := Precursor
			end
		end

	is_writable: BOOLEAN
			-- <Precursor>
		do
			if attached external_name_16 as n then
				Result := eif_dir_is_writable_16 ($n)
			else
				Result := Precursor
			end
		end

	is_executable: BOOLEAN
			-- <Precursor>
		do
			if attached external_name_16 as n then
				Result := eif_dir_is_executable_16 ($n)
			else
				Result := Precursor
			end
		end

	has_entry (entry_name: STRING_32): BOOLEAN
			-- Has directory the entry `entry_name'?
			--| The use of `dir_temp' is required not
			--| to change the position in the current
			--| directory entries list.
		require
			string_exists: entry_name /= Void
		local
			dir_temp: DIRECTORY_32
			e: detachable STRING_32
		do
			create dir_temp.make_open_read (name)
			from
				dir_temp.start
				dir_temp.readentry
				e := dir_temp.lastentry
			until
				Result or e = Void
			loop
				Result := e.same_string (entry_name)
				dir_temp.readentry
				e := dir_temp.lastentry
			end
			dir_temp.close
		end

feature -- Measurement

	count: INTEGER
			-- <Precursor>
		local
			dir_temp: DIRECTORY_32
			counter: INTEGER
		do
			create dir_temp.make_open_read (name)
			from
				dir_temp.start
				dir_temp.readentry
			until
				dir_temp.lastentry = Void
			loop
				counter := counter + 1
				dir_temp.readentry
			end
			Result := counter
			dir_temp.close
		end

feature -- Modification

	create_dir
			-- Create a physical directory.
		do
			if attached external_name_16 as n then
				eif_file_mkdir_16 ($n)
			else
				Precursor
			end
		end

	recursive_create_dir
			-- Create the directory recursively.
			--
			-- Ex: if /temp/ exists but not /temp/test, calling
			--     `recursive_create_directory'
			--     will create /temp/test and then /temp/test/toto.
		local
			l_directory: DIRECTORY_32
			l_new_directory_name: DIRECTORY_NAME_32
			l_directories_to_build: ARRAYED_LIST [STRING_32]
			l_built_directory: STRING_32
			l_loc_directory_name: STRING_32
			l_separator_index: INTEGER
			l_io_exception: IO_FAILURE
		do
			create l_directories_to_build.make (10)

				-- Find the first existing directory in the path name
			from
				l_built_directory := name.twin
				l_separator_index := l_built_directory.count
				create l_directory.make (l_built_directory)
			until
				l_directory.exists
			loop
				l_separator_index := l_built_directory.last_index_of (Operating_environment.Directory_separator, l_built_directory.count)
				if l_separator_index = 0 then
					create l_io_exception
					l_io_exception.set_message ("Invalid directory: " + l_built_directory)
					l_io_exception.raise
				end
				l_directories_to_build.extend (l_built_directory.substring (l_separator_index + 1, l_built_directory.count))
				if l_built_directory @ (l_separator_index - 1) = ':' then
					l_loc_directory_name := l_built_directory.substring (1, l_separator_index)
				else
					l_loc_directory_name := l_built_directory.substring (1, l_separator_index - 1)
				end
				l_built_directory := l_built_directory.substring (1, l_separator_index - 1)
				create l_directory.make (l_loc_directory_name)
			end

				-- Recursively create the directory.
			from
				l_directories_to_build.finish
				create l_new_directory_name.make_from_string (l_built_directory)
			until
				l_directories_to_build.before
			loop
				l_new_directory_name.extend (l_directories_to_build.item)
				l_directories_to_build.back

				create l_directory.make (l_new_directory_name)
				l_directory.create_dir
				if not l_directory.exists then
					create l_io_exception
					l_io_exception.set_message ("Cannot create: " + l_new_directory_name.to_string_32.as_string_8)
					l_io_exception.raise
				end
			end
		end

	change_name (new_name: STRING_32)
			-- Change directory name to `new_name'.
		require
			new_name_not_void: new_name /= Void
			directory_exists: exists
		local
			n: attached like external_name_16
			u: UTF_CONVERTER
		do
			if attached external_name_16 as o then
				n := u.string_32_to_utf_16_0 (new_name)
				eif_file_rename_16 ($o, $n)
				name_8 := u.string_32_to_utf_8_string_8 (new_name)
			else
				change_name_8 (u.string_32_to_utf_8_string_8 (new_name))
			end
		ensure
			name_changed: name ~ new_name
		end

feature -- Removal

	delete
			-- <Precursor>
		do
			if attached external_name_16 as n then
				eif_dir_delete_16 ($n)
			else
				Precursor
			end
		end

	delete_content
			-- <Precursor>
		local
			file_name: detachable FILE_NAME_32
			file: detachable RAW_FILE_32
			l_info: like file_info
			dir: detachable DIRECTORY_32
			dir_temp: DIRECTORY_32
			l_name: detachable STRING_32
		do
			from
					-- To delete files we do not need to follow symbolic links.
				l_info := file_info
				l_info.set_is_following_symlinks (False)
					-- Create a new directory that we will use to list all of its content.
				create dir_temp.make_open_read (name)
				dir_temp.start
				dir_temp.readentry
				l_name := dir_temp.lastentry
			until
				l_name = Void
			loop
					-- Ignore current and parent directories.
				if not l_name.same_string (current_directory_string) and not l_name.same_string (parent_directory_string) then
						-- Avoid creating too many objects.
					if file_name /= Void then
						file_name.reset (name)
					else
						create file_name.make_from_string (name)
					end
					file_name.set_file_name (l_name)
					l_info.update (file_name)
					if l_info.exists then
						if not l_info.is_symlink and then l_info.is_directory then
								-- Start the recursion for true directory, we do not follow links to delete their content.
							if dir /= Void then
								dir.make (file_name)
							else
								create dir.make (file_name)
							end
							dir.recursive_delete
						elseif l_info.is_writable then
							if file /= Void then
								file.reset (file_name)
							else
								create file.make (file_name)
							end
							file.delete
						end
					end
				end
				dir_temp.readentry
				l_name := dir_temp.lastentry
			end
			dir_temp.close
		end

	delete_content_with_action (
			action: PROCEDURE [ANY, TUPLE [LIST [READABLE_STRING_32]]]
			is_cancel_requested: FUNCTION [ANY, TUPLE, BOOLEAN]
			file_number: INTEGER)
			-- Delete all files located in directory and subdirectories.
			--
			-- `action' is called each time `file_number' files has
			-- been deleted and before the function exits.
			-- `action' may be set to Void if you don't need it.
			--
			-- Same for `is_cancel_requested'.
			-- Make it return `True' to cancel the operation.
			-- `is_cancel_requested' may be set to Void if you don't need it.
		local
			file_name: detachable FILE_NAME_32
			file: detachable RAW_FILE_32
			l_info: like file_info
			dir: detachable DIRECTORY_32
			dir_temp: DIRECTORY_32
			l_name: detachable STRING_32
			file_count: INTEGER
			deleted_files: ARRAYED_LIST [READABLE_STRING_32]
			requested_cancel: BOOLEAN
		do
			file_count := 1
			create deleted_files.make (file_number)

			from
					-- To delete files we do not need to follow symbolic links.
				l_info := file_info
				l_info.set_is_following_symlinks (False)
					-- Create a new directory that we will use to list all of its content.
				create dir_temp.make_open_read (name)
				dir_temp.start
				dir_temp.readentry
				l_name := dir_temp.lastentry
			until
				l_name = Void or requested_cancel
			loop
					-- Ignore current and parent directories.
				if not l_name.same_string (current_directory_string) and not l_name.same_string (parent_directory_string) then
						-- Avoid creating too many objects.
					if file_name /= Void then
						file_name.reset (name)
					else
						create file_name.make_from_string (name)
					end
					file_name.set_file_name (l_name)
					l_info.update (file_name)
					if l_info.exists then
						if not l_info.is_symlink and then l_info.is_directory then
								-- Start the recursion for true directory, we do not follow links to delete their content.
							if dir /= Void then
								dir.make (file_name)
							else
								create dir.make (file_name)
							end
							dir.recursive_delete_with_action (action, is_cancel_requested, file_number)
						elseif l_info.is_writable then
							if file /= Void then
								file.reset (file_name)
							else
								create file.make (file_name)
							end
							file.delete
						end

							-- Add the name of the deleted file to our array
							-- of deleted files.
						deleted_files.extend (file_name)
						file_count := file_count + 1

							-- If `file_number' has been reached, call `action'.
						if file_count > file_number then
							if action /= Void then
								action.call ([deleted_files])
							end
							if is_cancel_requested /= Void then
								requested_cancel := is_cancel_requested.item (Void)
							end
							deleted_files.wipe_out
							file_count := 1
						end
					end
				end
				dir_temp.readentry
				l_name := dir_temp.lastentry
			end
			dir_temp.close

				-- If there is more than one deleted file and no
				-- agent has been called, call one now.
			if file_count > 1 and action /= Void then
				action.call ([deleted_files])
			end
		end

	recursive_delete_with_action (
			action: PROCEDURE [ANY, TUPLE [LIST [READABLE_STRING_32]]]
			is_cancel_requested: FUNCTION [ANY, TUPLE, BOOLEAN]
			file_number: INTEGER)
			-- Delete directory and all content contained within.
			--
			-- `action' is called each time `file_number' files has
			-- been deleted and before the function exits.
		require
			directory_exists: exists
		local
			deleted_files: ARRAYED_LIST [READABLE_STRING_32]
		do
			delete_content_with_action (action, is_cancel_requested, file_number)
			if (is_cancel_requested = Void) or else (not is_cancel_requested.item (Void)) then
				delete
					-- Call the agent with the name of the directory
				if action /= Void then
					create deleted_files.make (1)
					deleted_files.extend (name)
					action.call ([deleted_files])
				end
			end
		end

feature {NONE} -- Access

	external_name_16: detachable SPECIAL [NATURAL_16]
			-- UTF-16 representation of `name' with terminating zero
			-- if supported on the current platform.
		local
			u: UTF_CONVERTER
		do
			if {PLATFORM}.is_windows then
					-- Convert to UTF-16 and add terminating zero.
				Result := u.utf_8_string_8_to_utf_16_0 (name_8)
			end
		end

feature {NONE} -- Cursor movement

	dir_next (dir_ptr: POINTER): detachable STRING_8
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			Result := Precursor (dir_ptr)
			if attached Result and then {PLATFORM}.is_windows then
					-- `Result' is encoded in UTF-16LE.
					-- Convert it to UTF-8.
				Result := u.utf_16le_string_8_to_utf_8_string_8 (Result)
			end
		end

feature {NONE} -- Status report

	file_info: UNIX_FILE_INFO_32
			-- To avoid creating objects when querying for files.
		once
			create Result.make
		end

	eif_dir_exists_16 (dir_name: POINTER): BOOLEAN
			-- Does the directory `dir_name' exist?
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *): EIF_BOOLEAN use %"eif_dir.h%""
		end

	eif_dir_is_readable_16 (dir_name: POINTER): BOOLEAN
			-- Is `dir_name' readable?
		external
			"C signature (EIF_NATURAL_16 *): EIF_BOOLEAN use %"eif_dir.h%""
		end

	eif_dir_is_writable_16 (dir_name: POINTER): BOOLEAN
			-- Is `dir_name' writable?
		external
			"C signature (EIF_NATURAL_16 *): EIF_BOOLEAN use %"eif_dir.h%""
		end

	eif_dir_is_executable_16 (dir_name: POINTER): BOOLEAN
			-- Is `dir_name' executable?
		external
			"C signature (EIF_NATURAL_16 *): EIF_BOOLEAN use %"eif_dir.h%""
		end

feature {NONE} -- Modification

	eif_file_mkdir_16 (dir_name: POINTER)
			-- Make directory `dir_name'.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *) use %"eif_file.h%""
		end

	eif_file_rename_16 (old_name, new_name: POINTER)
			-- Change directory name from `old_name' to `new_name'.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *, EIF_NATURAL_16 *) use %"eif_file.h%""
		end

	eif_dir_delete_16 (dir_name: POINTER)
			-- Delete the directory `dir_name'.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *) use %"eif_dir.h%""
		end

feature {NONE} -- Cursor movement

	eif_dir_open_16 (dir_name: POINTER): POINTER
			-- Open the directory `dir_name'.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *): EIF_POINTER use %"eif_dir.h%""
		end

invariant
	name_attached: attached name_8

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
