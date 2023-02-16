note
	description: "Internal file information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILE_INFO

inherit
	ANY
		redefine
			copy, is_equal
		end

create
	make

convert
	to_unix_file_info: {UNIX_FILE_INFO}

feature -- Initialization

	make
			-- Creation procedure
		do
			is_following_symlinks := True
			exists := False
		ensure
			not_exists: not exists
			is_following_symlinks_set: is_following_symlinks
		end

feature -- Access

	protection: INTEGER
			-- Protection mode of file (12 lower bits)
		require
			exists: exists
		do
			if is_access_readable then
				Result := Result | (1 |<< 8)
			end
			if is_access_executable then
				Result := Result | (1 |<< 6)
			end
			if is_access_writable then
				Result := Result | (1 |<< 7)
			end
		end

	type: INTEGER
			-- File type (4 bits, 12 lowest bits zeroed)
		require
			exists: exists
		do
			if is_directory then
				Result := Result | (1 |<< 14)
			end
			if is_plain then
				Result := Result | (1 |<< 15)
			end
		end

	inode: INTEGER
			-- Inode number
		require
			exists: exists
		do
			Result := 0
		end

	size: INTEGER
			-- File size, in bytes
		require
			exists: exists
		do
			if attached internal_file as l_file and then not is_directory then
				Result := l_file.length.to_integer
			end
		end

	user_id: INTEGER
			-- UID of the file owner
		require
			exists: exists
		do
			Result := 0
		end

	group_id: INTEGER
			-- GID of the file
		require
			exists: exists
		do
			Result := 0
		end

	date: INTEGER
			-- Last modification date
		require
			exists: exists
		do
			if attached internal_file as l_file then
				Result := eiffel_file_date_time (l_file.last_write_time.to_universal_time)
			end
		end

	access_date: INTEGER
			-- Date of last access
		require
			exists: exists
		do
			if attached internal_file as l_file then
				Result := eiffel_file_date_time (l_file.last_access_time.to_universal_time)
			end
		end

	change_date: INTEGER
			-- Date of last status change
		require
			exists: exists
		do
			if attached internal_file as l_file then
				Result := eiffel_file_date_time (l_file.last_write_time.to_universal_time)
			end
		end

	device: INTEGER
			-- Device number on which inode resides
		require
			exists: exists
		do
			if attached internal_file as l_file and then attached l_file.full_name as l_name then
				Result := l_name.chars (0).code - ('A').code
			end
		end

	device_type: INTEGER
			-- Device type on which inode resides
		require
			exists: exists
		do
			Result := device
		end

	links: INTEGER
			-- Number of links
		require
			exists: exists
		do
			Result := 1
		end

	owner_name: STRING
			-- Name of the file owner, if available from /etc/passwd.
			-- Otherwise, the UID
		require
			exists: exists
		do
			Result := "0"
		end

	group_name: STRING
			-- Name of the file group, if available from /etc/group.
			-- Otherwise, the GID
		require
			exists: exists
		do
			Result := "0"
		end

	file_name: detachable STRING
			-- File name as a STRING_8 instance. The value might be truncated
			-- from the original name used to create the current FILE instance.
		obsolete
			"Use `file_entry' to ensure that filenames are not truncated. [2017-05-31]"
		do
			if attached internal_file_name as l_name then
				Result := l_name.as_string_8
			end
		end

	file_entry: detachable PATH
			-- Associated entry for Current.
		do
			if attached internal_file_name as l_name then
				create Result.make_from_string (l_name)
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Does current file exists?

	is_following_symlinks: BOOLEAN
			-- Does current follow symbolic links when retrieving properties?
			--| Without effect on Windows.

	is_ready: BOOLEAN
			-- Is current ready to perform a query?
		do
			Result := internal_file_name /= Void
		end

	is_plain: BOOLEAN
			-- Is file a plain file?
		require
			exists: exists
		do
			Result := not is_directory and not is_device
		end

	is_device: BOOLEAN
			-- Is file a device?
		require
			exists: exists
		do
			if attached internal_file as l_file then
				Result := (l_file.attributes & {FILE_ATTRIBUTES}.device) = {FILE_ATTRIBUTES}.device
			end
		end

	is_directory: BOOLEAN
			-- Is file a directory?
		require
			exists: exists
		do
			if attached internal_file as l_file then
				Result := (l_file.attributes & {FILE_ATTRIBUTES}.directory) = {FILE_ATTRIBUTES}.directory
			end
		end

	is_symlink: BOOLEAN
			-- Is file a symbolic link?
		require
			exists: exists
		do
			Result := False
		end

	is_fifo: BOOLEAN
			-- Is file a named pipe?
		require
			exists: exists
		do
			Result := False
		end

	is_socket: BOOLEAN
			-- Is file a named socket?
		require
			exists: exists
		do
			Result := False
		end

	is_block: BOOLEAN
			-- Is file a device block special file?
		require
			exists: exists
		do
			Result := False
		end

	is_character: BOOLEAN
			-- Is file a character block special file?
		require
			exists: exists
		do
			Result := False
		end

	is_readable: BOOLEAN
			-- Is file readable by effective UID?
		require
			exists: exists
		do
			Result := is_access_readable
		end

	is_writable: BOOLEAN
			-- Is file writable by effective UID?
		require
			exists: exists
		do
			Result := is_access_writable
		end

	is_executable: BOOLEAN
			-- Is file executable by effective UID?
		require
			exists: exists
		do
			Result := is_access_executable
		end

	is_setuid: BOOLEAN
			-- Is file setuid?
		require
			exists: exists
		do
			Result := False
		end

	is_setgid: BOOLEAN
			-- Is file setgid?
		require
			exists: exists
		do
			Result := False
		end

	is_sticky: BOOLEAN
			-- Is file sticky?
		require
			exists: exists
		do
			Result := False
		end

	is_owner: BOOLEAN
			-- Is file owned by effective UID?
		require
			exists: exists
		do
			Result := True
		end

	is_access_owner: BOOLEAN
			-- Is file owned by real UID?
		require
			exists: exists
		do
			Result := True
		end

	is_access_readable: BOOLEAN
			-- Is file readable by real UID?
		require
			is_ready: is_ready
		local
			fs: FILE_STREAM
			retried: INTEGER
		do
			if
				retried = 0 and then
				attached internal_file as l_file
			then
				create fs.make (l_file.full_name, {FILE_MODE}.open)
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

	is_access_writable: BOOLEAN
			-- Is file writable by real UID?
		require
			is_ready: is_ready
		local
			fs: FILE_STREAM
			retried: INTEGER
		do
			if
				retried = 0 and then
				attached internal_file as l_file
			then
				create fs.make (l_file.full_name, {FILE_MODE}.open)
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

	is_access_executable: BOOLEAN
			-- Is file executable by real UID?
		require
			is_ready: is_ready
		do
			Result := True
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			if other = Current then
				Result := True
			elseif attached internal_file_name as l_file_name and attached other.internal_file_name as l_other_file_name then
				Result := l_file_name.same_string (l_other_file_name) and is_following_symlinks = other.is_following_symlinks
			end
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				standard_copy (other)
				if attached other.internal_file as l_file then
					create internal_file.make (l_file.name)
				end
				if attached other.internal_file_name as l_file_name then
					internal_file_name := l_file_name.twin
				end
			end
		end

feature -- Conversion

	to_unix_file_info: UNIX_FILE_INFO
			-- Convert current to old format UNIX_FILE_INFO for backward compatibility.
		obsolete
			"Use `FILE_INFO' as type instead of `UNIX_FILE_INFO'. [2017-05-31]"
		do
			create Result.make
			if attached internal_file_name as l_name then
				Result.update (l_name)
			end
		end

feature -- Element change

	update (f_name: READABLE_STRING_GENERAL)
			-- Update information buffer: fill it in with information
			-- from the inode of `f_name'.
		do
			fast_update (f_name, create {SYSTEM_FILE_INFO}.make (f_name.to_cil))
		end

	set_is_following_symlinks (v: BOOLEAN)
			-- Should `update' follow symlinks or not?
		do
			is_following_symlinks := v
		ensure
			is_following_symlinks_set: is_following_symlinks = v
		end

feature {FILE, DIRECTORY} -- Element change

	fast_update (f_name: READABLE_STRING_GENERAL; fi: SYSTEM_FILE_INFO)
			-- Update information buffer: fill it in with information
			-- from the inode of `f_name'.
		do
			internal_file := fi
			fi.refresh
			internal_file_name := f_name
			exists := fi.exists
		end

feature {FILE_INFO} -- Access

	internal_file_name: detachable READABLE_STRING_GENERAL
			-- Store the name of the file as it was given to us by the user

	internal_file: detachable SYSTEM_FILE_INFO
			-- Instance enabling us to get some information on FILE.

	eiffel_file_date_time (dot_net_date: SYSTEM_DATE_TIME): INTEGER
			-- convert a .NET file date time to an eiffel date
			-- 'dot_net_date' must be the nano-seconds from 01/01/1601:00:00:00:00
			-- (file system time) returns seconds since 01/01/1970:00:00:00:00
		local
			i64: INTEGER_64
		do
			i64 := ((dot_net_date.ticks - eiffel_base_file_time) / 10000000).floor
			Result := i64.to_integer
		end

	eiffel_base_file_time: INTEGER_64
			-- nano-seconds between 01/01/0001:00:00:00:00 and 01/01/1970:00:00:00:00
		local
			t: SYSTEM_DATE_TIME
		once
			t.make (1970 ,1 ,1 ,0 ,0 ,0)
			Result := t.ticks
		end

invariant

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
