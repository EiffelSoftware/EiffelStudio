indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryEntry"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_ENTRY

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_dir_serv_directory_entry_4,
	make_dir_serv_directory_entry_3,
	make_dir_serv_directory_entry,
	make_dir_serv_directory_entry_2,
	make_dir_serv_directory_entry_1

feature {NONE} -- Initialization

	frozen make_dir_serv_directory_entry_4 (ads_object: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_dir_serv_directory_entry_3 (path: SYSTEM_STRING; username: SYSTEM_STRING; password: SYSTEM_STRING; authentication_type: DIR_SERV_AUTHENTICATION_TYPES) is
		external
			"IL creator signature (System.String, System.String, System.String, System.DirectoryServices.AuthenticationTypes) use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_dir_serv_directory_entry is
		external
			"IL creator use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_dir_serv_directory_entry_2 (path: SYSTEM_STRING; username: SYSTEM_STRING; password: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_dir_serv_directory_entry_1 (path: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.DirectoryServices.DirectoryEntry"
		end

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Path"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Name"
		end

	frozen get_native_guid: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_NativeGuid"
		end

	frozen get_guid: GUID is
		external
			"IL signature (): System.Guid use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Guid"
		end

	frozen get_password: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Password"
		end

	frozen get_use_property_cache: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.DirectoryEntry"
		alias
			"get_UsePropertyCache"
		end

	frozen get_schema_entry: DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"get_SchemaEntry"
		end

	frozen get_parent: DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Parent"
		end

	frozen get_schema_class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_SchemaClassName"
		end

	frozen get_username: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Username"
		end

	frozen get_authentication_type: DIR_SERV_AUTHENTICATION_TYPES is
		external
			"IL signature (): System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.DirectoryEntry"
		alias
			"get_AuthenticationType"
		end

	frozen get_native_object: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.DirectoryServices.DirectoryEntry"
		alias
			"get_NativeObject"
		end

	frozen get_properties: DIR_SERV_PROPERTY_COLLECTION is
		external
			"IL signature (): System.DirectoryServices.PropertyCollection use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Properties"
		end

	frozen get_children: DIR_SERV_DIRECTORY_ENTRIES is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntries use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Children"
		end

feature -- Element Change

	frozen set_authentication_type (value: DIR_SERV_AUTHENTICATION_TYPES) is
		external
			"IL signature (System.DirectoryServices.AuthenticationTypes): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_AuthenticationType"
		end

	frozen set_username (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_Username"
		end

	frozen set_password (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_Password"
		end

	frozen set_use_property_cache (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_UsePropertyCache"
		end

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_Path"
		end

feature -- Basic Operations

	frozen refresh_cache_array_string (property_names: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"RefreshCache"
		end

	frozen exists (path: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.DirectoryServices.DirectoryEntry"
		alias
			"Exists"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"Close"
		end

	frozen copy_to_directory_entry_string (new_parent: DIR_SERV_DIRECTORY_ENTRY; new_name: SYSTEM_STRING): DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry, System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"CopyTo"
		end

	frozen copy_to (new_parent: DIR_SERV_DIRECTORY_ENTRY): DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"CopyTo"
		end

	frozen move_to_directory_entry_string (new_parent: DIR_SERV_DIRECTORY_ENTRY; new_name: SYSTEM_STRING) is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry, System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"MoveTo"
		end

	frozen refresh_cache is
		external
			"IL signature (): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"RefreshCache"
		end

	frozen delete_tree is
		external
			"IL signature (): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"DeleteTree"
		end

	frozen invoke (method_name: SYSTEM_STRING; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Object[]): System.Object use System.DirectoryServices.DirectoryEntry"
		alias
			"Invoke"
		end

	frozen commit_changes is
		external
			"IL signature (): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"CommitChanges"
		end

	frozen rename_ (new_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"Rename"
		end

	frozen move_to (new_parent: DIR_SERV_DIRECTORY_ENTRY) is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"MoveTo"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"Dispose"
		end

end -- class DIR_SERV_DIRECTORY_ENTRY
