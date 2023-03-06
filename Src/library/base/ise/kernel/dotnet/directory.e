note
	description: "Directories, in the Unix sense, with creation and exploration features"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DIRECTORY

inherit
	DISPOSABLE

create
	make, make_with_path, make_with_name,
	make_open_read

feature -- Initialization

	make (dn: READABLE_STRING_GENERAL)
			-- Create directory object for directory
			-- of name `dn'.
		require
			string_exists: dn /= Void
		do
			make_with_name (dn)
		ensure
			name_set: internal_name = dn
		end

	make_with_name (dn: READABLE_STRING_GENERAL)
			-- Create directory object for directory
			-- of name `dn'.
		require
			string_exists: dn /= Void
		do
			set_name (dn)
			mode := Close_directory
		ensure
			name_set: internal_name = dn
		end

	make_with_path (a_path: PATH)
			-- Create file object with `a_path' as path.
		require
			a_path_attached: a_path /= Void
		do
			make (a_path.name)
		end

	make_open_read (dn: READABLE_STRING_GENERAL)
			-- Create directory object for directory
			-- of name `dn' and open it for reading.
		require
			string_exists: dn /= Void
		do
			make (dn)
			open_read
		ensure
			name_set: internal_name = dn
		end

feature -- Creation

	create_dir
			-- Create a physical directory.
		require
			physical_not_exists: not exists
		local
			di: detachable DIRECTORY_INFO
			l_sub_dir: STRING_32
			l_sep_index: INTEGER
			l_full_path: STRING_32
		do
			create di.make (internal_name.to_cil)
			create l_full_path.make_from_cil (di.full_name)
			l_sep_index := l_full_path.last_index_of ({SYSTEM_PATH}.directory_separator_char,
				(1).max (l_full_path.count - 1))
			if l_sep_index = 0 then
				di := {SYSTEM_DIRECTORY}.create_directory (l_full_path.to_cil)
			else
					-- Might be a complex path, we need to check that path up to `l_sep_index'
					-- does not exist.
				l_sub_dir := l_full_path.substring (1, l_sep_index - 1)
				if {SYSTEM_DIRECTORY}.exists (l_sub_dir.to_cil) then
					di := {SYSTEM_DIRECTORY}.create_directory (l_full_path.to_cil)
				else
					{ISE_RUNTIME}.raise (create {IO_EXCEPTION}.make)
				end
			end
		end

	recursive_create_dir
			-- Create the directory recursively.
			--
			-- Ex: if /temp/ exists but not /temp/test, then trying
			--  to create /temp/test/toto will create /temp/test
			--  and then /temp/test/toto.
		local
			l_directory: DIRECTORY
			l_directories_to_build: ARRAYED_LIST [PATH]
			l_path: PATH
			l_parent, l_entry: detachable PATH
			l_io_exception: IO_FAILURE
		do

				-- Find the first existing directory in the path name
			from
				create l_directories_to_build.make (10)
				l_path := path
				create l_directory.make_with_path (l_path)
			until
				l_directory.exists or l_path = Void
			loop
				l_parent := l_path.parent
				l_entry := l_path.entry
				if l_parent = Void or l_entry = Void then
					create l_io_exception
					l_io_exception.set_description ({STRING_32} "Invalid directory: " + l_path.name)
					l_io_exception.raise
				else
					l_directories_to_build.extend (l_entry)
					create l_directory.make_with_path (l_parent)
					l_path := l_parent
				end
			end

				-- Recursively create the directory.
			l_directories_to_build.finish
			from
					-- Make sure we start from somewhere. If `l_path' is Void,
					-- it means we were trying to create a path without a root such as "abc/def".
				if l_path = Void then
					create l_path.make_empty
				end
			until
				l_directories_to_build.before
			loop
				l_path := l_path.extended_path (l_directories_to_build.item)
				l_directories_to_build.back

				create l_directory.make_with_path (l_path)
				l_directory.create_dir
				if not l_directory.exists then
					create l_io_exception
					l_io_exception.set_description ({STRING_32} "Cannot create: " + l_path.name)
					l_io_exception.raise
				end
			end
		ensure
			physical_exists: exists
		end



feature -- Access

	path: PATH
			-- Associated path of Current.
		do
			create Result.make_from_string (internal_name)
		ensure
			entry_not_empty: not Result.is_empty
		end

	readentry
			-- Read next directory entry
			-- make result available in `lastentry'.
			-- Make result Void if all entries have been read.
		require
			is_opened: not is_closed
		local
			l_entry: like lastentry
		do
			if not attached directory_listing as l_listing or else search_index >= l_listing.count then
				lastentry := Void
			else
				create l_entry.make_from_cil (l_listing.item (search_index))
					-- Because .NET will return something like `Current_dir\found_entry'
					-- we need to get rid of `Current_dir\' to be consistent with
					-- classic EiffelBase.
				l_entry.remove_head (internal_name.count + 1)
				lastentry := l_entry
				search_index := search_index + 1
			end
		end

	name: STRING_8
			-- File name as a STRING_8 instance. The value might be truncated
			-- from the original name used to create the current FILE instance.
		obsolete
			"Use `path' to ensure you can retrieve all kind of names. [2017-05-31]"
		do
			Result := internal_name.as_string_8
		ensure then
			name_not_empty: not Result.is_empty
		end

	has_entry (entry_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has directory the entry `entry_name'?
			--| The use of `dir_temp' is required not
			--| to change the position in the current
			--| directory entries list.
		require
			string_exists: entry_name /= Void
		local
			l_name: SYSTEM_STRING
			en: SYSTEM_STRING
			i: INTEGER
			c: INTEGER
		do
			l_name := internal_name.to_cil
			check attached {SYSTEM_DIRECTORY}.get_file_system_entries (l_name) as ent then
				en := entry_name.to_cil
				c := ent.count
				from

				until
					i = c or Result
				loop
					Result := attached ent.item (i) as l_string and then l_string.ends_with (en)
					i := i + 1
				end
			end
		end

	open_read
			-- Open directory for reading.
		do
			mode := Read_directory
			directory_listing := Void
			search_index := 0
		end

	close
			-- Close directory.
		require
			is_open: not is_closed
		do
			mode := Close_directory
			directory_listing := Void
		end

	start
			-- Go to first entry of directory.
		require
			is_opened: not is_closed
		do
			directory_listing := {SYSTEM_DIRECTORY}.get_file_system_entries (internal_name.to_cil)
			search_index := 0
		end

	change_name (new_name: READABLE_STRING_GENERAL)
			-- Change directory name to `new_name'.
		require
			new_name_not_void: new_name /= Void
			directory_exists: exists
		local
			l_info: SYSTEM_FILE_INFO
		do
			create l_info.make (new_name.to_cil)
			if l_info.exists then
				l_info.delete
			end
			{SYSTEM_DIRECTORY}.move (internal_name.to_cil, new_name.to_cil)
			set_name (new_name)
		ensure
			name_changed: internal_name = new_name
		end

	rename_path (new_name: PATH)
			-- Change directory name to `new_name'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
			file_exists: exists
		do
			change_name (new_name.name)
		ensure
			name_changed: internal_name = new_name.name
		end

feature -- Measurement

	count: INTEGER
			-- Number of entries in directory.
		require
			directory_exists: exists
		do
			if attached {SYSTEM_DIRECTORY}.get_file_system_entries (internal_name.to_cil) as ent then
				Result := ent.count
			end
		end

feature -- Conversion

	entries: ARRAYED_LIST [PATH]
			-- The entries, in sequential format, in a platform specific order.
		local
			i, c, dc: INTEGER
			l_string: detachable SYSTEM_STRING
		do
			check attached {SYSTEM_DIRECTORY}.get_file_system_entries (internal_name.to_cil) as ent then
				c := ent.count
				dc := internal_name.count
				if internal_name.item (internal_name.count) = (create {OPERATING_ENVIRONMENT}).directory_separator then
					dc := dc - 1
				end
				from
					create Result.make (c)
				until
					i = c
				loop
					l_string := ent.item (i)
					if l_string /= Void then
						Result.extend (create {PATH}.make_from_string (
							create {STRING_32}.make_from_cil (l_string.remove (0, dc + 1))))
					end
					i := i + 1
				end
			end
		end

	resolved_entries: ARRAYED_LIST [PATH]
			-- Entries of current directory resolved in the context of current directory (i.e. the path
			-- of the current directory appended with the entry) in sequential format, in a platform specific
			-- order.
			-- Compared to `entries', it removes the need for callers to build the full path of the entry
			-- using `Current'.
		local
			i, c, dc: INTEGER
			l_string: detachable SYSTEM_STRING
			l_path: like path
		do
			check attached {SYSTEM_DIRECTORY}.get_file_system_entries (internal_name.to_cil) as ent then
				c := ent.count
				dc := internal_name.count
				if internal_name.item (internal_name.count) = (create {OPERATING_ENVIRONMENT}).directory_separator then
					dc := dc - 1
				end
				from
					create Result.make (c)
					l_path := path
				until
					i = c
				loop
					l_string := ent.item (i)
					if l_string /= Void then
						Result.extend (l_path.extended (
							create {STRING_32}.make_from_cil (l_string.remove (0, dc + 1))))
					end
					i := i + 1
				end
			end
		end


	linear_representation: ARRAYED_LIST [STRING_8]
			-- The entries, in sequential format. Entries that can be
			-- expressed in Unicode are excluded and one has to use
			-- `linear_representation' to get them.
		obsolete
			"Use `entries' instead if your application is using Unicode file names. [2017-05-31]"
		local
			i, c, dc: INTEGER
			l_string: detachable SYSTEM_STRING
		do
			check attached {SYSTEM_DIRECTORY}.get_file_system_entries (internal_name.to_cil) as ent then
				c := ent.count
				dc := internal_name.count
				if internal_name.item (internal_name.count) = (create {OPERATING_ENVIRONMENT}).directory_separator then
					dc := dc - 1
				end
				create Result.make (c)
				from

				until
					i = c
				loop
					l_string := ent.item (i)
					if l_string /= Void then
						Result.extend (create {STRING}.make_from_cil (l_string.remove (0, dc + 1)))
					end
					i := i + 1
				end
			end
		end

	linear_representation_32: ARRAYED_LIST [STRING_32]
			-- The entries, in sequential format. Entries
			-- that cannot be expressed in UTF-32 are excluded from
			-- the list and one has to use `entries' to get them.
		local
			i, c, dc: INTEGER
			l_string: detachable SYSTEM_STRING
		do
			check attached {SYSTEM_DIRECTORY}.get_file_system_entries (internal_name.to_cil) as ent then
				c := ent.count
				dc := internal_name.count
				if internal_name.item (internal_name.count) = (create {OPERATING_ENVIRONMENT}).directory_separator then
					dc := dc - 1
				end
				create Result.make (c)
				from

				until
					i = c
				loop
					l_string := ent.item (i)
					if l_string /= Void then
						Result.extend (create {STRING_32}.make_from_cil (l_string.remove (0, dc + 1)))
					end
					i := i + 1
				end
			end
		end

feature -- Status report

	last_entry_32: detachable STRING_32
			-- Last Unicode entry read by `readentry' if any.
		do
			if attached directory_listing as l_listing and then search_index < l_listing.count then
				create Result.make_from_cil (l_listing.item (search_index))
					-- Because .NET will return something like `Current_dir\found_entry'
					-- we need to get rid of `Current_dir\' to be consistent with
					-- classic EiffelBase.
				Result.remove_head (internal_name.count + 1)
			end
		end

	last_entry_8: detachable STRING_8
			-- Raw byte sequence of the last found entry if this entry cannot be
			-- expressed with Unicode characters. This is useful
			-- when handling a file that is not a valid UTF-8 sequence on Unix.
		do
			if attached directory_listing as l_listing and then search_index < l_listing.count then
				create Result.make_from_cil (l_listing.item (search_index))
					-- Because .NET will return something like `Current_dir\found_entry'
					-- we need to get rid of `Current_dir\' to be consistent with
					-- classic EiffelBase.
				Result.remove_head (internal_name.count + 1)
			end
		end

	lastentry: detachable STRING_8
			-- Last entry read by `readentry'.
		obsolete
			"Use `last_entry_32' for Unicode file names, or `last_entry_8' otherwise. [2017-05-31]"
		attribute
		end

	is_closed: BOOLEAN
			-- Is current directory closed?
		do
			Result := mode = Close_directory
		end

	is_empty: BOOLEAN
			-- Is directory empty?
		require
			directory_exists: exists
		do
				-- count = 0, since .NET does not return "." and ".." which
				-- are symbolic representations but not effective directories.
			Result := count = 0
		end

	exists: BOOLEAN
			-- Does the directory exist?
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {SYSTEM_DIRECTORY}.exists (internal_name.to_cil)
			end
		rescue
			retried := True
			retry
		end

	is_readable: BOOLEAN
			-- Is the directory readable?
		require
			directory_exists: exists
		local
			fs: FILE_STREAM
			di: DIRECTORY_INFO
			retried: INTEGER
		do
			if retried = 0 then
				create di.make (internal_name.to_cil)
				create fs.make (di.full_name, {FILE_MODE}.open, {FILE_ACCESS}.Read)
				Result := fs.can_read
				fs.dispose
			elseif retried = 1 and fs /= Void then
				fs.dispose
				Result := False
			else
				Result := False
			end
		rescue
			retried := retried + 1
			retry
		end

	is_executable: BOOLEAN
			-- Is the directory executable?
		require
			directory_exists: exists
		local
			fs: FILE_STREAM
			di: DIRECTORY_INFO
			retried: INTEGER
		do
			if retried = 0 then
				create di.make (internal_name.to_cil)
				create fs.make (di.full_name, {FILE_MODE}.open, {FILE_ACCESS}.Read)
				Result := fs.can_seek
				fs.dispose
			elseif retried = 1 and fs /= Void then
				fs.dispose
				Result := False
			else
				Result := False
			end
		rescue
			retried := retried + 1
			retry
		end

	is_writable: BOOLEAN
			-- Is the directory writable?
		require
			directory_exists: exists
		local
			fs: FILE_STREAM
			di: DIRECTORY_INFO
			retried: INTEGER
		do
			if retried = 0 then
				create di.make (internal_name.to_cil)
				create fs.make (di.full_name, {FILE_MODE}.open, {FILE_ACCESS}.Write)
				Result := fs.can_write
				fs.dispose
			elseif retried = 1 and fs /= Void then
				fs.dispose
				Result := False
			else
				Result := False
			end
		rescue
			retried := retried + 1
			retry
		end

feature -- Removal

	delete
			-- Delete directory if empty.
		require
			directory_exists: exists
			empty_directory: is_empty
		do
			{SYSTEM_DIRECTORY}.delete (internal_name.to_cil)
		end

	delete_content
			-- Delete all files located in current directory and its
			-- subdirectories.
		require
			directory_exists: exists
		do
			delete_content_with_action (Void, Void, 0)
		end

	recursive_delete
			-- Delete directory, its files and its subdirectories.
		require
			directory_exists: exists
		do
			{SYSTEM_DIRECTORY}.delete_string_boolean (internal_name.to_cil, True)
		end

	delete_content_with_action (
			action: detachable PROCEDURE [LIST [READABLE_STRING_GENERAL]]
			is_cancel_requested: detachable FUNCTION [BOOLEAN]
			file_number: INTEGER)
			-- Delete all files located in current directory and its
			-- subdirectories.
			--
			-- `action' is called each time `file_number' files has
			-- been deleted and before the function exits.
			-- `action' may be set to Void if you don't need it.
			--
			-- Same for `is_cancel_requested'.
			-- Make it return `True' to cancel the operation.
			-- `is_cancel_requested' may be set to Void if you don't need it.
		require
			directory_exists: exists
			valid_file_number: file_number >= 0
		local
			l_path, l_file_name: PATH
			file: detachable RAW_FILE
			dir: detachable DIRECTORY
			dir_temp: DIRECTORY
			l_name: detachable STRING_32
			file_count: INTEGER
			deleted_files: ARRAYED_LIST [READABLE_STRING_32]
			requested_cancel: BOOLEAN
		do
			file_count := 1
			create deleted_files.make (file_number)

			from
					-- Create a new directory that we will use to list all of its content.
				create dir_temp.make_open_read (internal_name)
				dir_temp.start
				dir_temp.readentry
				l_name := dir_temp.last_entry_32
				l_path := path
			until
				l_name = Void or requested_cancel
			loop
					-- Ignore current and parent directories.
				if not l_name.same_string_general (current_directory_string) and not l_name.same_string_general (parent_directory_string) then
						-- Avoid creating too many objects.
					l_file_name := l_path.extended (l_name)
					create file.make_with_path (l_file_name)
					if file.exists then
						if not file.is_symlink and then file.is_directory then
								-- Start the recursion for true directory, we do not follow links to delete their content.
							if dir /= Void then
								dir.make_with_path (l_file_name)
							else
								create dir.make_with_path (l_file_name)
							end
							dir.recursive_delete_with_action (action, is_cancel_requested, file_number)
						elseif file.is_writable then
							file.delete
						end

							-- Add the name of the deleted file to our array
							-- of deleted files.
						deleted_files.extend (l_file_name.name)
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
				l_name := dir_temp.last_entry_32
			end
			dir_temp.close

				-- If there is more than one deleted file and no
				-- agent has been called, call one now.
			if file_count > 1 and action /= Void then
				action.call ([deleted_files])
			end
		end

	recursive_delete_with_action (
			action: detachable PROCEDURE [LIST [READABLE_STRING_GENERAL]]
			is_cancel_requested: detachable FUNCTION [BOOLEAN]
			file_number: INTEGER)

			-- Delete directory, its files and its subdirectories.
			--
			-- `action' is called each time `file_number' files has
			-- been deleted and before the function exits.
		require
			directory_exists: exists
		local
			deleted_files: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			delete_content_with_action (action, is_cancel_requested, file_number)
			if (is_cancel_requested = Void) or else (not is_cancel_requested.item (Void)) then
				delete

					-- Call the agent with the name of the directory
				if action /= Void then
					create deleted_files.make (1)
					deleted_files.extend (internal_name)
					action.call ([deleted_files])
				end
			end
		end

	dispose
			-- Ensure this medium is closed when garbage collected.
		do
			if not is_closed then
				close
			end
		end

feature {DIRECTORY} -- Implementation

	directory_listing: detachable NATIVE_ARRAY [detachable SYSTEM_STRING]
			-- Directory pointer as required in C

	search_index: INTEGER
			-- Position in the list of entries

feature {NONE} -- Implementation

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set `name' with `a_name'.
		do
			internal_name := a_name
		ensure
			name_set: internal_name = a_name
		end

	internal_name: READABLE_STRING_GENERAL
			-- Store the name of the file as it was given to us by the user
			-- to avoid conversion on storing as it is not necessary.

	mode: INTEGER
			-- Status mode of the directory.
			-- Possible values are the following:

	Close_directory: INTEGER = 1

	Read_directory: INTEGER = 2

	current_directory_string: STRING = "."
	parent_directory_string: STRING = ".."
			-- Constants to represent current (".") and parent ("..") directory.

invariant
	name_attached: attached internal_name

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
