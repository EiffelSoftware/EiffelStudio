indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.File"

frozen external class
	SYSTEM_IO_FILE

create {NONE}

feature -- Basic Operations

	frozen get_attributes (path: STRING): SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL static signature (System.String): System.IO.FileAttributes use System.IO.File"
		alias
			"GetAttributes"
		end

	frozen set_last_write_time (path: STRING; last_access_time: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetLastWriteTime"
		end

	frozen open_write (path: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"OpenWrite"
		end

	frozen create_text (path: STRING): SYSTEM_IO_STREAMWRITER is
		external
			"IL static signature (System.String): System.IO.StreamWriter use System.IO.File"
		alias
			"CreateText"
		end

	frozen set_last_access_time (path: STRING; last_access_time: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetLastAccessTime"
		end

	frozen copy (source_file_name: STRING; dest_file_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.File"
		alias
			"Copy"
		end

	frozen exists (path: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.File"
		alias
			"Exists"
		end

	frozen open_text (path: STRING): SYSTEM_IO_STREAMREADER is
		external
			"IL static signature (System.String): System.IO.StreamReader use System.IO.File"
		alias
			"OpenText"
		end

	frozen open_string_file_mode_file_access_file_share (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen open (path: STRING; mode: SYSTEM_IO_FILEMODE): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String, System.IO.FileMode): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen get_creation_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetCreationTime"
		end

	frozen open_read (path: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"OpenRead"
		end

	frozen get_last_write_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetLastWriteTime"
		end

	frozen create__string_int32 (path: STRING; buffer_size: INTEGER): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String, System.Int32): System.IO.FileStream use System.IO.File"
		alias
			"Create"
		end

	frozen open_string_file_mode_file_access (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String, System.IO.FileMode, System.IO.FileAccess): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen delete (path: STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.File"
		alias
			"Delete"
		end

	frozen Create_ (path: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"Create"
		end

	frozen set_attributes (path: STRING; file_attributes: SYSTEM_IO_FILEATTRIBUTES) is
		external
			"IL static signature (System.String, System.IO.FileAttributes): System.Void use System.IO.File"
		alias
			"SetAttributes"
		end

	frozen get_last_access_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetLastAccessTime"
		end

	frozen move (source_file_name: STRING; dest_file_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.File"
		alias
			"Move"
		end

	frozen append_text (path: STRING): SYSTEM_IO_STREAMWRITER is
		external
			"IL static signature (System.String): System.IO.StreamWriter use System.IO.File"
		alias
			"AppendText"
		end

	frozen copy_string_string_boolean (source_file_name: STRING; dest_file_name: STRING; overwrite: BOOLEAN) is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Void use System.IO.File"
		alias
			"Copy"
		end

	frozen set_creation_time (path: STRING; creation_time: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetCreationTime"
		end

end -- class SYSTEM_IO_FILE
