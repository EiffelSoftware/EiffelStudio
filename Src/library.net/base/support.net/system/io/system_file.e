indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.File"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_FILE

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen copy_ (source_file_name: SYSTEM_STRING; dest_file_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.File"
		alias
			"Copy"
		end

	frozen set_last_write_time (path: SYSTEM_STRING; last_write_time: SYSTEM_DATE_TIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetLastWriteTime"
		end

	frozen open_write (path: SYSTEM_STRING): FILE_STREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"OpenWrite"
		end

	frozen create_text (path: SYSTEM_STRING): STREAM_WRITER is
		external
			"IL static signature (System.String): System.IO.StreamWriter use System.IO.File"
		alias
			"CreateText"
		end

	frozen copy__string_string_boolean (source_file_name: SYSTEM_STRING; dest_file_name: SYSTEM_STRING; overwrite: BOOLEAN) is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Void use System.IO.File"
		alias
			"Copy"
		end

	frozen set_last_access_time (path: SYSTEM_STRING; last_access_time: SYSTEM_DATE_TIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetLastAccessTime"
		end

	frozen exists (path: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.File"
		alias
			"Exists"
		end

	frozen open_text (path: SYSTEM_STRING): STREAM_READER is
		external
			"IL static signature (System.String): System.IO.StreamReader use System.IO.File"
		alias
			"OpenText"
		end

	frozen open_string_file_mode_file_access_file_share (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS; share: FILE_SHARE): FILE_STREAM is
		external
			"IL static signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen open (path: SYSTEM_STRING; mode: FILE_MODE): FILE_STREAM is
		external
			"IL static signature (System.String, System.IO.FileMode): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen get_creation_time (path: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetCreationTime"
		end

	frozen move (source_file_name: SYSTEM_STRING; dest_file_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.File"
		alias
			"Move"
		end

	frozen get_last_write_time (path: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetLastWriteTime"
		end

	frozen create__string_int32 (path: SYSTEM_STRING; buffer_size: INTEGER): FILE_STREAM is
		external
			"IL static signature (System.String, System.Int32): System.IO.FileStream use System.IO.File"
		alias
			"Create"
		end

	frozen open_string_file_mode_file_access (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS): FILE_STREAM is
		external
			"IL static signature (System.String, System.IO.FileMode, System.IO.FileAccess): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen get_attributes (path: SYSTEM_STRING): FILE_ATTRIBUTES is
		external
			"IL static signature (System.String): System.IO.FileAttributes use System.IO.File"
		alias
			"GetAttributes"
		end

	frozen delete (path: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.File"
		alias
			"Delete"
		end

	frozen set_attributes (path: SYSTEM_STRING; file_attributes: FILE_ATTRIBUTES) is
		external
			"IL static signature (System.String, System.IO.FileAttributes): System.Void use System.IO.File"
		alias
			"SetAttributes"
		end

	frozen get_last_access_time (path: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetLastAccessTime"
		end

	frozen append_text (path: SYSTEM_STRING): STREAM_WRITER is
		external
			"IL static signature (System.String): System.IO.StreamWriter use System.IO.File"
		alias
			"AppendText"
		end

	frozen create_ (path: SYSTEM_STRING): FILE_STREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"Create"
		end

	frozen open_read (path: SYSTEM_STRING): FILE_STREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"OpenRead"
		end

	frozen set_creation_time (path: SYSTEM_STRING; creation_time: SYSTEM_DATE_TIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetCreationTime"
		end

end -- class SYSTEM_FILE
