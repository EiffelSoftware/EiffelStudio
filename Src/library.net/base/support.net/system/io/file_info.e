indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FILE_INFO

inherit
	FILE_SYSTEM_INFO
		redefine
			to_string
		end

create
	make_file_info

feature {NONE} -- Initialization

	frozen make_file_info (file_name: SYSTEM_STRING) is
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

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"get_Name"
		end

	frozen get_directory: DIRECTORY_INFO is
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

	frozen get_directory_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"get_DirectoryName"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileInfo"
		alias
			"ToString"
		end

	frozen open (mode: FILE_MODE): FILE_STREAM is
		external
			"IL signature (System.IO.FileMode): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen open_read: FILE_STREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"OpenRead"
		end

	frozen append_text: STREAM_WRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.IO.FileInfo"
		alias
			"AppendText"
		end

	frozen open_write: FILE_STREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"OpenWrite"
		end

	frozen copy_to (dest_file_name: SYSTEM_STRING): FILE_INFO is
		external
			"IL signature (System.String): System.IO.FileInfo use System.IO.FileInfo"
		alias
			"CopyTo"
		end

	frozen open_file_mode_file_access_file_share (mode: FILE_MODE; access: FILE_ACCESS; share: FILE_SHARE): FILE_STREAM is
		external
			"IL signature (System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen open_file_mode_file_access (mode: FILE_MODE; access: FILE_ACCESS): FILE_STREAM is
		external
			"IL signature (System.IO.FileMode, System.IO.FileAccess): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Open"
		end

	frozen create_: FILE_STREAM is
		external
			"IL signature (): System.IO.FileStream use System.IO.FileInfo"
		alias
			"Create"
		end

	frozen open_text: STREAM_READER is
		external
			"IL signature (): System.IO.StreamReader use System.IO.FileInfo"
		alias
			"OpenText"
		end

	frozen copy_to_string_boolean (dest_file_name: SYSTEM_STRING; overwrite: BOOLEAN): FILE_INFO is
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

	frozen create_text: STREAM_WRITER is
		external
			"IL signature (): System.IO.StreamWriter use System.IO.FileInfo"
		alias
			"CreateText"
		end

	frozen move_to (dest_file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.FileInfo"
		alias
			"MoveTo"
		end

end -- class FILE_INFO
