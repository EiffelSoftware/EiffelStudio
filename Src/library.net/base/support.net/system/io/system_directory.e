indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.Directory"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DIRECTORY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen set_last_write_time (path: SYSTEM_STRING; last_write_time: SYSTEM_DATE_TIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.Directory"
		alias
			"SetLastWriteTime"
		end

	frozen move (source_dir_name: SYSTEM_STRING; dest_dir_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.Directory"
		alias
			"Move"
		end

	frozen set_current_directory (path: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.Directory"
		alias
			"SetCurrentDirectory"
		end

	frozen get_files (path: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String): System.String[] use System.IO.Directory"
		alias
			"GetFiles"
		end

	frozen create_directory (path: SYSTEM_STRING): DIRECTORY_INFO is
		external
			"IL static signature (System.String): System.IO.DirectoryInfo use System.IO.Directory"
		alias
			"CreateDirectory"
		end

	frozen exists (path: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.Directory"
		alias
			"Exists"
		end

	frozen get_current_directory: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.IO.Directory"
		alias
			"GetCurrentDirectory"
		end

	frozen get_file_system_entries_string_string (path: SYSTEM_STRING; search_pattern: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.IO.Directory"
		alias
			"GetFileSystemEntries"
		end

	frozen get_logical_drives: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (): System.String[] use System.IO.Directory"
		alias
			"GetLogicalDrives"
		end

	frozen get_last_write_time (path: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.Directory"
		alias
			"GetLastWriteTime"
		end

	frozen get_file_system_entries (path: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String): System.String[] use System.IO.Directory"
		alias
			"GetFileSystemEntries"
		end

	frozen get_directories_string_string (path: SYSTEM_STRING; search_pattern: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.IO.Directory"
		alias
			"GetDirectories"
		end

	frozen delete_string_boolean (path: SYSTEM_STRING; recursive: BOOLEAN) is
		external
			"IL static signature (System.String, System.Boolean): System.Void use System.IO.Directory"
		alias
			"Delete"
		end

	frozen get_directory_root (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.IO.Directory"
		alias
			"GetDirectoryRoot"
		end

	frozen delete (path: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.Directory"
		alias
			"Delete"
		end

	frozen set_last_access_time (path: SYSTEM_STRING; last_access_time: SYSTEM_DATE_TIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.Directory"
		alias
			"SetLastAccessTime"
		end

	frozen get_files_string_string (path: SYSTEM_STRING; search_pattern: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.IO.Directory"
		alias
			"GetFiles"
		end

	frozen get_parent (path: SYSTEM_STRING): DIRECTORY_INFO is
		external
			"IL static signature (System.String): System.IO.DirectoryInfo use System.IO.Directory"
		alias
			"GetParent"
		end

	frozen get_directories (path: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String): System.String[] use System.IO.Directory"
		alias
			"GetDirectories"
		end

	frozen get_last_access_time (path: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.Directory"
		alias
			"GetLastAccessTime"
		end

	frozen get_creation_time (path: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.Directory"
		alias
			"GetCreationTime"
		end

	frozen set_creation_time (path: SYSTEM_STRING; creation_time: SYSTEM_DATE_TIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.Directory"
		alias
			"SetCreationTime"
		end

end -- class SYSTEM_DIRECTORY
