indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.FileSystemInfo"

deferred external class
	SYSTEM_IO_FILESYSTEMINFO

inherit
	SYSTEM_MARSHALBYREFOBJECT

feature -- Access

	frozen get_extension: STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_Extension"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_FullName"
		end

	frozen get_last_access_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_LastAccessTime"
		end

	frozen get_last_write_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_LastWriteTime"
		end

	get_exists: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.FileSystemInfo"
		alias
			"get_Exists"
		end

	frozen get_attributes: INTEGER is
		external
			"IL signature (): enum System.IO.FileAttributes use System.IO.FileSystemInfo"
		alias
			"get_Attributes"
		ensure
			valid_file_attributes: Result = 1 or Result = 2 or Result = 4 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096 or Result = 8192 or Result = 16384
		end

	frozen get_creation_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_CreationTime"
		end

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_last_access_time (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_LastAccessTime"
		end

	frozen set_creation_time (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_CreationTime"
		end

	frozen set_last_write_time (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_LastWriteTime"
		end

	frozen set_attributes (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- ReadOnly = 1
			-- Hidden = 2
			-- System = 4
			-- Directory = 16
			-- Archive = 32
			-- Device = 64
			-- Normal = 128
			-- Temporary = 256
			-- SparseFile = 512
			-- ReparsePoint = 1024
			-- Compressed = 2048
			-- Offline = 4096
			-- NotContentIndexed = 8192
			-- Encrypted = 16384
		require
			valid_file_attributes: (1 + 2 + 4 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384) & value = 1 + 2 + 4 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384
		external
			"IL signature (enum System.IO.FileAttributes): System.Void use System.IO.FileSystemInfo"
		alias
			"set_Attributes"
		end

feature -- Basic Operations

	frozen refresh is
		external
			"IL signature (): System.Void use System.IO.FileSystemInfo"
		alias
			"Refresh"
		end

	delete is
		external
			"IL deferred signature (): System.Void use System.IO.FileSystemInfo"
		alias
			"Delete"
		end

end -- class SYSTEM_IO_FILESYSTEMINFO
