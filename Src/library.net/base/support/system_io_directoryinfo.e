indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.DirectoryInfo"

frozen external class
	SYSTEM_IO_DIRECTORYINFO

inherit
	SYSTEM_IO_FILESYSTEMINFO
		redefine
			to_string
		end

create
	make_directory_info

feature {NONE} -- Initialization

	frozen make_directory_info (path: STRING) is
		external
			"IL creator signature (System.String) use System.IO.DirectoryInfo"
		end

feature -- Access

	frozen get_root: SYSTEM_IO_DIRECTORYINFO is
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

	get_name: STRING is
		external
			"IL signature (): System.String use System.IO.DirectoryInfo"
		alias
			"get_Name"
		end

	frozen get_parent: SYSTEM_IO_DIRECTORYINFO is
		external
			"IL signature (): System.IO.DirectoryInfo use System.IO.DirectoryInfo"
		alias
			"get_Parent"
		end

feature -- Basic Operations

	frozen create_ is
		external
			"IL signature (): System.Void use System.IO.DirectoryInfo"
		alias
			"Create"
		end

	frozen get_files_with_pattern (searchPattern: STRING): ARRAY [SYSTEM_IO_FILEINFO] is
		external
			"IL signature (System.String): System.IO.FileInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFiles"
		end

	delete is
		external
			"IL signature (): System.Void use System.IO.DirectoryInfo"
		alias
			"Delete"
		end

	frozen get_directories_with_pattern (searchPattern: STRING): ARRAY [SYSTEM_IO_DIRECTORYINFO] is
		external
			"IL signature (System.String): System.IO.DirectoryInfo[] use System.IO.DirectoryInfo"
		alias
			"GetDirectories"
		end

	frozen get_file_system_infos_with_pattern (searchPattern: STRING): ARRAY [SYSTEM_IO_FILESYSTEMINFO] is
		external
			"IL signature (System.String): System.IO.FileSystemInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFileSystemInfos"
		end

	frozen get_files: ARRAY [SYSTEM_IO_FILEINFO] is
		external
			"IL signature (): System.IO.FileInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFiles"
		end

	frozen get_directories: ARRAY [SYSTEM_IO_DIRECTORYINFO] is
		external
			"IL signature (): System.IO.DirectoryInfo[] use System.IO.DirectoryInfo"
		alias
			"GetDirectories"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.DirectoryInfo"
		alias
			"ToString"
		end

	frozen create_sbdirectory (path: STRING): SYSTEM_IO_DIRECTORYINFO is
		external
			"IL signature (System.String): System.IO.DirectoryInfo use System.IO.DirectoryInfo"
		alias
			"CreateSubdirectory"
		end

	frozen move_to (destDirName: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.DirectoryInfo"
		alias
			"MoveTo"
		end

	frozen delete_all (recursive: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.DirectoryInfo"
		alias
			"Delete"
		end

	frozen get_file_system_infos: ARRAY [SYSTEM_IO_FILESYSTEMINFO] is
		external
			"IL signature (): System.IO.FileSystemInfo[] use System.IO.DirectoryInfo"
		alias
			"GetFileSystemInfos"
		end

end -- class SYSTEM_IO_DIRECTORYINFO
