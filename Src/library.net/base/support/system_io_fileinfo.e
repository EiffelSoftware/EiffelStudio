indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileInfo"

frozen external class
	SYSTEM_IO_FILEINFO

inherit
	SYSTEM_IO_FILESYSTEMINFO
		redefine
			to_string
		end

create
	make_fileinfo

feature {NONE} -- Initialization

	frozen make_fileinfo (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileInfo"
		end

feature -- Access

	frozen get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.FileInfo"
		alias
			"get_Length"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"get_Name"
		end

	frozen get_directory: SYSTEM_IO_DIRECTORYINFO is
		external
			"IL signature (): System.IO.DirectoryInfo use System.IO.FileInfo"
		alias
			"get_Directory"
		end

	get_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileInfo"
		alias
			"get_Exists"
		end

	frozen get_directory_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"get_DirectoryName"
		end

feature -- Basic Operations

	frozen Create_: SYSTEM_IO_FILESTREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Create"
		end

	frozen open_text: SYSTEM_IO_STREAMREADER is
		external
			"IL signature (): System.IO.StreamReader use System.IO.FileInfo"
		alias
			"OpenText"
		end

	frozen open_read: SYSTEM_IO_FILESTREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"OpenRead"
		end

	frozen append_text: SYSTEM_IO_STREAMWRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.IO.FileInfo"
		alias
			"AppendText"
		end

	frozen open_write: SYSTEM_IO_FILESTREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"OpenWrite"
		end

	frozen open (mode: SYSTEM_IO_FILEMODE): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.IO.FileMode): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen copy_to (dest_file_name: STRING): SYSTEM_IO_FILEINFO is
		external
			"IL signature (System.String): System.IO.FileInfo use System.IO.FileInfo"
		alias
			"CopyTo"
		end

	frozen open_file_mode_file_access_file_share (mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen open_file_mode_file_access (mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.IO.FileMode, System.IO.FileAccess): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"ToString"
		end

	frozen copy_to_string_boolean (dest_file_name: STRING; overwrite: BOOLEAN): SYSTEM_IO_FILEINFO is
		external
			"IL signature (System.String, System.Boolean): System.IO.FileInfo use System.IO.FileInfo"
		alias
			"CopyTo"
		end

	delete is
		external
			"IL signature (): System.Void use System.IO.FileInfo"
		alias
			"Delete"
		end

	frozen create_text: SYSTEM_IO_STREAMWRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.IO.FileInfo"
		alias
			"CreateText"
		end

	frozen move_to (dest_file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.FileInfo"
		alias
			"MoveTo"
		end

end -- class SYSTEM_IO_FILEINFO
