indexing
	description: "Constants used in conjonction with File/Pipe handle creation/update."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FILE_CONSTANTS

feature -- Access

	generic_read: INTEGER is 0x80000000
			-- Read access
			
	generic_write: INTEGER is 0x40000000
			-- Write access			

	generic_execute: INTEGER is 0x20000000
			-- Execute access
			
	generic_all: INTEGER is 0x10000000
			-- Read/write/execute access
			
feature -- CreateFile

	create_new: INTEGER is 1
			-- Creates a new file. The function fails if the specified file already exists
			
	create_always: INTEGER is 2
			-- Creates a new file. If the file exists, the function overwrites the file,
			-- clears the existing attributes, combines the specified file attributes
			-- and flags with FILE_ATTRIBUTE_ARCHIVE, but does not set the security 
			-- descriptor specified by the SECURITY_ATTRIBUTES structure
			
	open_existing: INTEGER is 3
			-- Opens the file. The function fails if the file does not exist. 
			-- For a discussion of why you should use OPEN_EXISTING for devices, see Remarks.

	open_always: INTEGER is 4
			-- Opens the file, if it exists. If the file does not exist, the function
			-- creates the file as if dwCreationDisposition were CREATE_NEW

	truncate_existing: INTEGER is 5
			-- Opens the file and truncates it so that its size is zero bytes.
			-- The calling process must open the file with the GENERIC_WRITE access right.
			-- The function fails if the file does not exist. 

feature -- Attributes

	file_attribute_normal: INTEGER is 0x00000080
			-- The file has no other attributes set. This attribute is valid only if used alone.

	file_attribute_temporary: INTEGER is 0x100
			-- The file is being used for temporary storage. File systems avoid writing
			-- data back to mass storage if sufficient cache memory is available, because
			-- often the application deletes the temporary file shortly after the handle
			-- is closed. In that case, the system can entirely avoid writing the data.
			-- Otherwise, the data will be written after the handle is closed.

feature -- Share mode

	file_share_read: INTEGER is 0x00000001
			-- Enables subsequent open operations on the object to request read access.
			-- Otherwise, other processes cannot open the object if they request read access.
			--
			-- If the object has already been opened with read access, the sharing mode must
			-- include this flag.

	file_share_write: INTEGER is 0x00000002
			-- Enables subsequent open operations on the object to request write access.
			-- Otherwise, other processes cannot open the object if they request write access.
			--
			-- If the object has already been opened with write access, the sharing mode
			-- must include this flag.

	file_flag_write_through: INTEGER is 0x80000000
	
	File_flag_no_buffering: INTEGER is 0x20000000
	
feature -- Position

	file_begin: INTEGER is 0
	file_current: INTEGER is 1
	file_end: INTEGER is 2;
			-- Position in file where to set pointer

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_FILE_CONSTANTS

