indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.Directory"

frozen external class
	SYSTEM_IO_DIRECTORY

create {NONE}

feature -- Basic Operations

	frozen set_last_write_time (path: STRING; last_write_time: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.Directory"
		alias
			"SetLastWriteTime"
		end

	frozen move (source_dir_name: STRING; dest_dir_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.Directory"
		alias
			"Move"
		end

	frozen set_current_directory (path: STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.Directory"
		alias
			"SetCurrentDirectory"
		end

	frozen get_files (path: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String): System.String[] use System.IO.Directory"
		alias
			"GetFiles"
		end

	frozen create_directory (path: STRING): SYSTEM_IO_DIRECTORYINFO is
		external
			"IL static signature (System.String): System.IO.DirectoryInfo use System.IO.Directory"
		alias
			"CreateDirectory"
		end

	frozen exists (path: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.Directory"
		alias
			"Exists"
		end

	frozen get_current_directory: STRING is
		external
			"IL static signature (): System.String use System.IO.Directory"
		alias
			"GetCurrentDirectory"
		end

	frozen get_file_system_entries_string_string (path: STRING; search_pattern: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.IO.Directory"
		alias
			"GetFileSystemEntries"
		end

	frozen get_logical_drives: ARRAY [STRING] is
		external
			"IL static signature (): System.String[] use System.IO.Directory"
		alias
			"GetLogicalDrives"
		end

	frozen get_last_write_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.Directory"
		alias
			"GetLastWriteTime"
		end

	frozen get_file_system_entries (path: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String): System.String[] use System.IO.Directory"
		alias
			"GetFileSystemEntries"
		end

	frozen get_directories_string_string (path: STRING; search_pattern: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.IO.Directory"
		alias
			"GetDirectories"
		end

	frozen delete_string_boolean (path: STRING; recursive: BOOLEAN) is
		external
			"IL static signature (System.String, System.Boolean): System.Void use System.IO.Directory"
		alias
			"Delete"
		end

	frozen get_directory_root (path: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Directory"
		alias
			"GetDirectoryRoot"
		end

	frozen delete (path: STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.Directory"
		alias
			"Delete"
		end

	frozen set_last_access_time (path: STRING; last_access_time: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.Directory"
		alias
			"SetLastAccessTime"
		end

	frozen get_files_string_string (path: STRING; search_pattern: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.IO.Directory"
		alias
			"GetFiles"
		end

	frozen get_parent (path: STRING): SYSTEM_IO_DIRECTORYINFO is
		external
			"IL static signature (System.String): System.IO.DirectoryInfo use System.IO.Directory"
		alias
			"GetParent"
		end

	frozen get_directories (path: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String): System.String[] use System.IO.Directory"
		alias
			"GetDirectories"
		end

	frozen get_last_access_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.Directory"
		alias
			"GetLastAccessTime"
		end

	frozen get_creation_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.Directory"
		alias
			"GetCreationTime"
		end

	frozen set_creation_time (path: STRING; creation_time: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.Directory"
		alias
			"SetCreationTime"
		end

end -- class SYSTEM_IO_DIRECTORY
