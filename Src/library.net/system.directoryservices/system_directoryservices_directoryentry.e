indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectoryEntry"

external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE

create
	make_directoryentry_1,
	make_directoryentry_3,
	make_directoryentry_2,
	make_directoryentry,
	make_directoryentry_4

feature {NONE} -- Initialization

	frozen make_directoryentry_1 (path: STRING) is
		external
			"IL creator signature (System.String) use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_directoryentry_3 (path: STRING; username: STRING; password: STRING; authentication_type: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES) is
		external
			"IL creator signature (System.String, System.String, System.String, System.DirectoryServices.AuthenticationTypes) use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_directoryentry_2 (path: STRING; username: STRING; password: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_directoryentry is
		external
			"IL creator use System.DirectoryServices.DirectoryEntry"
		end

	frozen make_directoryentry_4 (ads_object: ANY) is
		external
			"IL creator signature (System.Object) use System.DirectoryServices.DirectoryEntry"
		end

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Path"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Name"
		end

	frozen get_native_guid: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_NativeGuid"
		end

	frozen get_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Guid"
		end

	frozen get_password: STRING is
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

	frozen get_schema_entry: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"get_SchemaEntry"
		end

	frozen get_parent: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Parent"
		end

	frozen get_schema_class_name: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_SchemaClassName"
		end

	frozen get_username: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Username"
		end

	frozen get_authentication_type: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES is
		external
			"IL signature (): System.DirectoryServices.AuthenticationTypes use System.DirectoryServices.DirectoryEntry"
		alias
			"get_AuthenticationType"
		end

	frozen get_native_object: ANY is
		external
			"IL signature (): System.Object use System.DirectoryServices.DirectoryEntry"
		alias
			"get_NativeObject"
		end

	frozen get_properties: SYSTEM_DIRECTORYSERVICES_PROPERTYCOLLECTION is
		external
			"IL signature (): System.DirectoryServices.PropertyCollection use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Properties"
		end

	frozen get_children: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRIES is
		external
			"IL signature (): System.DirectoryServices.DirectoryEntries use System.DirectoryServices.DirectoryEntry"
		alias
			"get_Children"
		end

feature -- Element Change

	frozen set_authentication_type (value: SYSTEM_DIRECTORYSERVICES_AUTHENTICATIONTYPES) is
		external
			"IL signature (System.DirectoryServices.AuthenticationTypes): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_AuthenticationType"
		end

	frozen set_username (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_Username"
		end

	frozen set_password (value: STRING) is
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

	frozen set_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"set_Path"
		end

feature -- Basic Operations

	frozen refresh_cache_array_string (property_names: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"RefreshCache"
		end

	frozen exists (path: STRING): BOOLEAN is
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

	frozen copy_to_directory_entry_string (new_parent: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY; new_name: STRING): SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry, System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"CopyTo"
		end

	frozen copy_to (new_parent: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY): SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntry"
		alias
			"CopyTo"
		end

	frozen move_to_directory_entry_string (new_parent: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY; new_name: STRING) is
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

	frozen invoke (method_name: STRING; args: ARRAY [ANY]): ANY is
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

	frozen Rename_ (new_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryEntry"
		alias
			"Rename"
		end

	frozen move_to (new_parent: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY) is
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

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY
