class
	STATICS

feature -- Statics

	Console: SYSTEM_CONSOLE
	
	String: STRING
	
	File_mode_create_new: INTEGER is 1
	File_mode_create: INTEGER is 2
	File_mode_open: INTEGER is 3
	File_mode_open_or_create: INTEGER is 4
	File_mode_truncate: INTEGER is 5
	File_mode_append: INTEGER is 6

	File_access_read: INTEGER is 1
	File_access_write: INTEGER is 2
	File_access_read_write: INTEGER is 3

	File_share_none: INTEGER is 0
	File_share_read: INTEGER is 1
	File_share_write: INTEGER is 2
	File_share_read_write: INTEGER is 3

	No_error, Error, Show_usage: INTEGER is unique

	Array: SYSTEM_ARRAY

	File: SYSTEM_IO_FILE

	Encoding: SYSTEM_TEXT_ENCODING
	
	Environment: SYSTEM_ENVIRONMENT
	
end -- class STATICS	