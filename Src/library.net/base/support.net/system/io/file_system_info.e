indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileSystemInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	FILE_SYSTEM_INFO

inherit
	MARSHAL_BY_REF_OBJECT

feature -- Access

	get_full_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_FullName"
		end

	frozen get_last_access_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_LastAccessTime"
		end

	frozen get_extension: SYSTEM_STRING is
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

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.IO.FileSystemInfo"
		alias
			"get_Name"
		end

	frozen get_attributes: FILE_ATTRIBUTES is
		external
			"IL signature (): System.IO.FileAttributes use System.IO.FileSystemInfo"
		alias
			"get_Attributes"
		end

	frozen get_creation_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_CreationTime"
		end

	frozen get_last_write_time: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.IO.FileSystemInfo"
		alias
			"get_LastWriteTime"
		end

feature -- Element Change

	frozen set_last_access_time (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_LastAccessTime"
		end

	frozen set_last_write_time (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_LastWriteTime"
		end

	frozen set_creation_time (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.IO.FileSystemInfo"
		alias
			"set_CreationTime"
		end

	frozen set_attributes (value: FILE_ATTRIBUTES) is
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

end -- class FILE_SYSTEM_INFO
