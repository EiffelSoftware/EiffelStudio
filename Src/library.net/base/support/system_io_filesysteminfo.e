indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileSystemInfo"

deferred external class
	SYSTEM_IO_FILESYSTEMINFO

inherit
	SYSTEM_MARSHALBYREFOBJECT

feature -- Access

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

	frozen get_extension: STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_Extension"
		end

	get_exists: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.FileSystemInfo"
		alias
			"get_Exists"
		end

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_Name"
		end

	frozen get_attributes: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL signature (): System.IO.FileAttributes use System.IO.FileSystemInfo"
		alias
			"get_Attributes"
		end

	frozen get_creation_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_CreationTime"
		end

	frozen get_last_write_time: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_LastWriteTime"
		end

feature -- Element Change

	frozen set_last_access_time (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_LastAccessTime"
		end

	frozen set_last_write_time (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_LastWriteTime"
		end

	frozen set_creation_time (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_CreationTime"
		end

	frozen set_attributes (value: SYSTEM_IO_FILEATTRIBUTES) is
		external
			"IL signature (System.IO.FileAttributes): System.Void use System.IO.FileSystemInfo"
		alias
			"set_Attributes"
		end

feature -- Basic Operations

	delete is
		external
			"IL deferred signature (): System.Void use System.IO.FileSystemInfo"
		alias
			"Delete"
		end

	frozen refresh is
		external
			"IL signature (): System.Void use System.IO.FileSystemInfo"
		alias
			"Refresh"
		end

end -- class SYSTEM_IO_FILESYSTEMINFO
