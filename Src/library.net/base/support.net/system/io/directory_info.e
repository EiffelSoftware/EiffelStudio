indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.DirectoryInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DIRECTORY_INFO

inherit
	FILE_SYSTEM_INFO
		redefine
			to_string
		end

create
	make_directory_info

feature {NONE} -- Initialization

	frozen make_directory_info (path: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.DirectoryInfo"
		end

feature -- Access

	frozen get_parent: DIRECTORY_INFO is
		external
			"IL signature (): System.IO.DirectoryInfo use System.IO.DirectoryInfo"
		alias
			"get_Parent"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.DirectoryInfo"
		alias
			"get_Name"
		end

	frozen get_root: DIRECTORY_INFO is
		external
			"IL signature (): System.IO.DirectoryInfo use System.IO.DirectoryInfo"
		alias
			"get_Root"
		end

	get_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.DirectoryInfo"
		alias
			"get_Exists"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.DirectoryInfo"
		alias
			"ToString"
		end

	frozen move_to (dest_dir_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.DirectoryInfo"
		alias
			"MoveTo"
		end

	frozen get_files_string (search_pattern: SYSTEM_STRING): NATIVE_ARRAY [FILE_INFO] is
		external
			"IL signature (System.String): System.IO.FileInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFiles"
		end

	frozen get_file_system_infos: NATIVE_ARRAY [FILE_SYSTEM_INFO] is
		external
			"IL signature (): System.IO.FileSystemInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFileSystemInfos"
		end

	frozen get_file_system_infos_string (search_pattern: SYSTEM_STRING): NATIVE_ARRAY [FILE_SYSTEM_INFO] is
		external
			"IL signature (System.String): System.IO.FileSystemInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFileSystemInfos"
		end

	frozen get_files: NATIVE_ARRAY [FILE_INFO] is
		external
			"IL signature (): System.IO.FileInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFiles"
		end

	frozen delete_boolean (recursive: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.DirectoryInfo"
		alias
			"Delete"
		end

	frozen create_ is
		external
			"IL signature (): System.Void use System.IO.DirectoryInfo"
		alias
			"Create"
		end

	delete is
		external
			"IL signature (): System.Void use System.IO.DirectoryInfo"
		alias
			"Delete"
		end

	frozen get_directories_string (search_pattern: SYSTEM_STRING): NATIVE_ARRAY [DIRECTORY_INFO] is
		external
			"IL signature (System.String): System.IO.DirectoryInfo[] use System.IO.DirectoryInfo"
		alias
			"GetDirectories"
		end

	frozen create_subdirectory (path: SYSTEM_STRING): DIRECTORY_INFO is
		external
			"IL signature (System.String): System.IO.DirectoryInfo use System.IO.DirectoryInfo"
		alias
			"CreateSubdirectory"
		end

	frozen get_directories: NATIVE_ARRAY [DIRECTORY_INFO] is
		external
			"IL signature (): System.IO.DirectoryInfo[] use System.IO.DirectoryInfo"
		alias
			"GetDirectories"
		end

end -- class DIRECTORY_INFO
