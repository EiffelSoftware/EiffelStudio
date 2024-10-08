note

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

	make
			-- Creation procedure
		do
			make_buffered_file_info (stat_size)
		end

feature -- Access

	protection: INTEGER
			-- Protection mode of file (12 lower bits)
		do
			Result := file_info ($buffered_file_info, 0)
		end

	type: INTEGER
			-- File type (4 bits, 12 lowest bits zeroed)
		do
			Result := file_info ($buffered_file_info, 11)
		end

	inode: INTEGER
			-- Inode number
		do
			Result := file_info ($buffered_file_info, 1)
		end

	size: INTEGER
			-- File size, in bytes
		do
			Result := file_info ($buffered_file_info, 6)
		end

	user_id: INTEGER
			-- UID of the file owner
		do
			Result := file_info ($buffered_file_info, 4)
		end

	group_id: INTEGER
			-- GID of the file
		do
			Result := file_info ($buffered_file_info, 5)
		end

	date: INTEGER
			-- Last modification date
		do
			Result := file_info ($buffered_file_info, 7)
		end

	access_date: INTEGER
			-- Date of last access
		do
			Result := file_info ($buffered_file_info, 8)
		end

	change_date: INTEGER
			-- Date of last status change
		do
			Result := file_info ($buffered_file_info, 9)
		end

	device: INTEGER
			-- Device number on which inode resides
		do
			Result := file_info ($buffered_file_info, 2)
		end

	device_type: INTEGER
			-- Device type on which inode resides
		do
			Result := file_info ($buffered_file_info, 3)
		end

	links: INTEGER
			-- Number of links
		do
			Result := file_info ($buffered_file_info, 10)
		end

	owner_name: STRING
			-- Name of the file owner, if available from /etc/passwd.
			-- Otherwise, the UID
		do
			Result := file_owner (user_id)
		end -- owner_name

	group_name: STRING
			-- Name of the file group, if available from /etc/group.
			-- Otherwise, the GID
		do
			Result := file_group (group_id)
		end -- owner_name

	file_name: STRING
			-- File name to which information applies.

feature -- Status report

	is_plain: BOOLEAN
			-- Is file a plain file?
		do
			Result := file_info ($buffered_file_info, 13) /= 0
		end

	is_device: BOOLEAN
			-- Is file a device?
		do
			Result := file_info ($buffered_file_info, 14) /= 0
		end

	is_directory: BOOLEAN
			-- Is file a directory?
		do
			Result := file_info ($buffered_file_info, 12) /= 0
		end

	is_symlink: BOOLEAN
			-- Is file a symbolic link?
		do
			Result := file_info ($buffered_file_info, 18) /= 0
		end

	is_fifo: BOOLEAN
			-- Is file a named pipe?
		do
			Result := file_info ($buffered_file_info, 17) /= 0
		end

	is_socket: BOOLEAN
			-- Is file a named socket?
		do
			Result := file_info ($buffered_file_info, 19) /= 0
		end

	is_block: BOOLEAN
			-- Is file a device block special file?
		do
			Result := file_info ($buffered_file_info, 16) /= 0
		end

	is_character: BOOLEAN
			-- Is file a character block special file?
		do
			Result := file_info ($buffered_file_info, 15) /= 0
		end

	is_readable: BOOLEAN
			-- Is file readable by effective UID?
		do
			Result := file_eaccess ($buffered_file_info, 0)
		end

	is_writable: BOOLEAN
			-- Is file writable by effective UID?
		do
			Result := file_eaccess ($buffered_file_info, 1)
		end

	is_executable: BOOLEAN
			-- Is file executable by effective UID?
		do
			Result := file_eaccess ($buffered_file_info, 2)
		end

	is_setuid: BOOLEAN
			-- Is file setuid?
		do
			Result := file_eaccess ($buffered_file_info, 3)
		end

	is_setgid: BOOLEAN
			-- Is file setgid?
		do
			Result := file_eaccess ($buffered_file_info, 4)
		end

	is_sticky: BOOLEAN
			-- Is file sticky?
		do
			Result := file_eaccess ($buffered_file_info, 5)
		end

	is_owner: BOOLEAN
			-- Is file owned by effective UID?
		do
			Result := file_eaccess ($buffered_file_info, 6)
		end

	is_access_owner: BOOLEAN
			-- Is file owned by real UID?
		do
			Result := file_eaccess ($buffered_file_info, 7)
		end

	is_access_readable: BOOLEAN
			-- Is file readable by real UID?
		local
			ext_name: ANY
		do
			ext_name := file_name.to_c
			Result := file_access ($ext_name, 3)
		end

	is_access_writable: BOOLEAN
			-- Is file writable by real UID?
		local
			ext_name: ANY
		do
			ext_name := file_name.to_c
			Result := file_access ($ext_name, 2)
		end

	is_access_executable: BOOLEAN
			-- Is file executable by real UID?
		local
			ext_name: ANY
		do
			ext_name := file_name.to_c
			Result := file_access ($ext_name, 1)
		end

feature -- Element change

	update (f_name: STRING)
			-- Update information buffer: fill it in with information
			-- from the inode of `f_name'.
		local
			ext_name: ANY
		do
			ext_name := f_name.to_c
			file_stat ($ext_name, $buffered_file_info)
				-- Do not duplicate the file name. That way, if the file is
				-- renamed, the name here will change accordingly and access()
				-- based calls will continue to work properly.
			file_name := f_name
		end -- update

feature {NONE} -- Implementation

	stat_size: INTEGER
			-- Get size of 'struct stat' (in bytes)
		external
			"C | %"eif_file.h%""
		end

	file_stat (name, stat_buf: POINTER)
			-- Get information from file `name' into `stat_buf'
		external
			"C (char *, struct stat *) | %"eif_file.h%""
		end

	file_access (f_name: POINTER; which: INTEGER): BOOLEAN
			-- Perform access test `which' on `f_name' using real ID.
		external
			"C (char *, EIF_INTEGER): EIF_BOOLEAN | %"eif_file.h%""
		end

	file_eaccess (stat_buf: POINTER; which: INTEGER): BOOLEAN
			-- Perform access tests using effective ID.
		external
			"C (struct stat *, int): EIF_BOOLEAN | %"eif_file.h%""
		end

	file_info (stat_buf: POINTER; which: INTEGER): INTEGER
			-- Extract information `which' from information buffer
		external
			"C (struct stat *, int): EIF_INTEGER | %"eif_file.h%""
		end

	file_owner (uid: INTEGER): STRING
			-- Convert UID to login name if possible
		external
			"C signature (int): EIF_REFERENCE use %"eif_file.h%""
		end

	file_group (gid: INTEGER): STRING
			-- Convert GID to group name if possible
		external
			"C signature (int): EIF_REFERENCE use %"eif_file.h%""
		end

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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



