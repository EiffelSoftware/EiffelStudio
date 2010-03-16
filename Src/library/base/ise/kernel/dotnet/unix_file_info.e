note

	description:
		"Internal file information"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UNIX_FILE_INFO

create
	make

feature -- Initialization

	make
			-- Creation procedure
		do
		end

feature -- Access

	protection: INTEGER
			-- Protection mode of file (12 lower bits)

	type: INTEGER
			-- File type (4 bits, 12 lowest bits zeroed)

	inode: INTEGER
			-- Inode number

	size: INTEGER
			-- File size, in bytes

	user_id: INTEGER
			-- UID of the file owner

	group_id: INTEGER
			-- GID of the file

	date: INTEGER
			-- Last modification date

	access_date: INTEGER
			-- Date of last access

	change_date: INTEGER
			-- Date of last status change

	device: INTEGER
			-- Device number on which inode resides

	device_type: INTEGER
			-- Device type on which inode resides

	links: INTEGER
			-- Number of links

	owner_name: STRING
			-- Name of the file owner, if available from /etc/passwd.
			-- Otherwise, the UID
		do
			Result := "0"
		end

	group_name: STRING
			-- Name of the file group, if available from /etc/group.
			-- Otherwise, the GID
		do
			Result := "0"
		end

	file_name: detachable STRING
			-- File name to which information applies.

feature -- Status report

	is_plain: BOOLEAN
			-- Is file a plain file?

	is_device: BOOLEAN
			-- Is file a device?

	is_directory: BOOLEAN
			-- Is file a directory?

	is_symlink: BOOLEAN
			-- Is file a symbolic link?

	is_fifo: BOOLEAN
			-- Is file a named pipe?

	is_socket: BOOLEAN
			-- Is file a named socket?

	is_block: BOOLEAN
			-- Is file a device block special file?

	is_character: BOOLEAN
			-- Is file a character block special file?

	is_readable: BOOLEAN
			-- Is file readable by effective UID?

	is_writable: BOOLEAN
			-- Is file writable by effective UID?

	is_executable: BOOLEAN
			-- Is file executable by effective UID?

	is_setuid: BOOLEAN
			-- Is file setuid?

	is_setgid: BOOLEAN
			-- Is file setgid?

	is_sticky: BOOLEAN
			-- Is file sticky?

	is_owner: BOOLEAN
			-- Is file owned by effective UID?

	is_access_owner: BOOLEAN
			-- Is file owned by real UID?

	is_access_readable: BOOLEAN
			-- Is file readable by real UID?

	is_access_writable: BOOLEAN
			-- Is file writable by real UID?

	is_access_executable: BOOLEAN
			-- Is file executable by real UID?

feature -- Element change

	update (f_name: STRING)
			-- Update information buffer: fill it in with information
			-- from the inode of `f_name'.
		local
			f: RAW_FILE
			fi: FILE_INFO
			l_name: detachable SYSTEM_STRING
		do
			create f.make (f_name)
			create fi.make (f_name.to_cil)
			protection := 0
			type := 0
			is_directory := f.is_directory
			is_plain := f.is_plain
			is_access_readable := f.is_readable
			is_access_executable := f.is_executable
			is_access_writable := f.is_writable
			if is_directory then
				type := type | (1 |<< 14)
			end
			if is_plain then
				type := type | (1 |<< 15)
			end
			if is_access_readable then
				protection := protection | (1 |<< 8)
			end
			if is_access_executable then
				protection := protection | (1 |<< 6)
			end
			if is_access_writable then
				protection := protection | (1 |<< 7)
			end
			inode := 0
			size := f.count
			user_id := 0
			group_id := 0
			date := f.date
			access_date := f.access_date
			change_date := f.change_date
			l_name := fi.full_name
			check l_name_attached: l_name /= Void end
			device := l_name.chars (0).code - ('A').code
			device_type := device
			links := 1
			is_owner := True
			is_access_owner := True
			file_name := f_name
		end -- update

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class UNIX_FILE_INFO



