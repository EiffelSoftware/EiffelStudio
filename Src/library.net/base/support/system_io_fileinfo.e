indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.FileInfo"

frozen external class
	SYSTEM_IO_FILEINFO

inherit
	SYSTEM_IO_FILESYSTEMINFO
		redefine
			to_string
		end

create
	make_file_info

feature {NONE} -- Initialization

	frozen make_file_info (fileName: STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileInfo"
		end

feature -- Access

	get_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileInfo"
		alias
			"get_Exists"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"get_Name"
		end

	frozen get_directory_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"get_DirectoryName"
		end

	frozen get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.FileInfo"
		alias
			"get_Length"
		end

	frozen get_directory: SYSTEM_IO_DIRECTORYINFO is
		external
			"IL signature (): System.IO.DirectoryInfo use System.IO.FileInfo"
		alias
			"get_Directory"
		end

feature -- Basic Operations

	frozen create_: SYSTEM_IO_FILESTREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Create"
		end

	frozen copy_to (destFileName: STRING): SYSTEM_IO_FILEINFO is
		external
			"IL signature (System.String): System.IO.FileInfo use System.IO.FileInfo"
		alias
			"CopyTo"
		end

	frozen open_write: SYSTEM_IO_FILESTREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"OpenWrite"
		end

	frozen open_in_mode_and_access (mode: INTEGER; access: INTEGER): SYSTEM_IO_FILESTREAM is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL signature (enum System.IO.FileMode, enum System.IO.FileAccess): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	delete is
		external
			"IL signature (): System.Void use System.IO.FileInfo"
		alias
			"Delete"
		end

	frozen copy_to_and_overwrite (destFileName: STRING; overwrite: BOOLEAN): SYSTEM_IO_FILEINFO is
		external
			"IL signature (System.String, System.Boolean): System.IO.FileInfo use System.IO.FileInfo"
		alias
			"CopyTo"
		end

	frozen open_in_mode_access_and_sharing (mode: INTEGER; access: INTEGER; share: INTEGER): SYSTEM_IO_FILESTREAM is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL signature (enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen open_read: SYSTEM_IO_FILESTREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"OpenRead"
		end

	frozen create_text: SYSTEM_IO_STREAMWRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.IO.FileInfo"
		alias
			"CreateText"
		end

	frozen open (mode: INTEGER): SYSTEM_IO_FILESTREAM is
			-- Valid values for `mode' are:
			-- CreateNew = 1
			-- Create = 2
			-- Open = 3
			-- OpenOrCreate = 4
			-- Truncate = 5
			-- Append = 6
		require
			valid_file_mode: mode = 1 or mode = 2 or mode = 3 or mode = 4 or mode = 5 or mode = 6
		external
			"IL signature (enum System.IO.FileMode): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen open_text: SYSTEM_IO_STREAMREADER is
		external
			"IL signature (): System.IO.StreamReader use System.IO.FileInfo"
		alias
			"OpenText"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"ToString"
		end

	frozen move_to (destFileName: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.FileInfo"
		alias
			"MoveTo"
		end

	frozen append_text: SYSTEM_IO_STREAMWRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.IO.FileInfo"
		alias
			"AppendText"
		end

end -- class SYSTEM_IO_FILEINFO
