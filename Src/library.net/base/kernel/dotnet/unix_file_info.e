indexing

	description:
		"Internal file information"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class UNIX_FILE_INFO inherit

	TO_SPECIAL [CHARACTER]
		rename
			area as buffered_file_info,
			make_area as make_buffered_file_info
		end

create

	make

feature -- Initialization

	make is
			-- Creation procedure
		do
			make_buffered_file_info (30)
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

	group_name: STRING
			-- Name of the file group, if available from /etc/group.
			-- Otherwise, the GID

	file_name: STRING
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

	update (f_name: STRING) is
			-- Update information buffer: fill it in with information
			-- from the inode of `f_name'.
		local
			f: RAW_FILE
			fi: FILE_INFO
		do	
			create f.make (f_name)
			create fi.make_file_info (f_name.to_cil)
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
			device := (fi.get_full_name.to_char_array @ 0).code - ('A').code
			device_type := device
			links := 1
			owner_name := "0"
			group_name := "0"
			is_owner := True
			is_access_owner := True
			file_name := f_name
		end -- update

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class UNIX_FILE_INFO



