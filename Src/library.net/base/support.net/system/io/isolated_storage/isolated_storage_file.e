indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageFile"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ISOLATED_STORAGE_FILE

inherit
	ISOLATED_STORAGE
		redefine
			get_current_size,
			get_maximum_size,
			finalize
		end
	IDISPOSABLE

create {NONE}

feature -- Access

	get_current_size: INTEGER_64 is
		external
			"IL signature (): System.UInt64 use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"get_CurrentSize"
		end

	get_maximum_size: INTEGER_64 is
		external
			"IL signature (): System.UInt64 use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"get_MaximumSize"
		end

feature -- Basic Operations

	frozen get_user_store_for_assembly: ISOLATED_STORAGE_FILE is
		external
			"IL static signature (): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetUserStoreForAssembly"
		end

	frozen get_user_store_for_domain: ISOLATED_STORAGE_FILE is
		external
			"IL static signature (): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetUserStoreForDomain"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Close"
		end

	frozen get_store (scope: ISOLATED_STORAGE_SCOPE; domain_identity: SYSTEM_OBJECT; assembly_identity: SYSTEM_OBJECT): ISOLATED_STORAGE_FILE is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope, System.Object, System.Object): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

	frozen get_file_names (search_pattern: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetFileNames"
		end

	frozen remove_isolated_storage_scope (scope: ISOLATED_STORAGE_SCOPE) is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Remove"
		end

	frozen get_directory_names (search_pattern: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetDirectoryNames"
		end

	frozen get_store_isolated_storage_scope_type (scope: ISOLATED_STORAGE_SCOPE; domain_evidence_type: TYPE; assembly_evidence_type: TYPE): ISOLATED_STORAGE_FILE is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope, System.Type, System.Type): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

	remove is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Remove"
		end

	frozen create_directory (dir: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"CreateDirectory"
		end

	frozen delete_directory (dir: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"DeleteDirectory"
		end

	frozen delete_file (file: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"DeleteFile"
		end

	frozen get_enumerator (scope: ISOLATED_STORAGE_SCOPE): IENUMERATOR is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope): System.Collections.IEnumerator use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetEnumerator"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Dispose"
		end

	frozen get_store_isolated_storage_scope_evidence (scope: ISOLATED_STORAGE_SCOPE; domain_evidence: EVIDENCE; domain_evidence_type: TYPE; assembly_evidence: EVIDENCE; assembly_evidence_type: TYPE): ISOLATED_STORAGE_FILE is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope, System.Security.Policy.Evidence, System.Type, System.Security.Policy.Evidence, System.Type): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

feature {NONE} -- Implementation

	get_permission (ps: PERMISSION_SET): ISOLATED_STORAGE_PERMISSION is
		external
			"IL signature (System.Security.PermissionSet): System.Security.Permissions.IsolatedStoragePermission use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetPermission"
		end

	finalize is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Finalize"
		end

end -- class ISOLATED_STORAGE_FILE
