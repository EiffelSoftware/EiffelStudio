indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageFile"

frozen external class
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE

inherit
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGE
		redefine
			get_current_size,
			get_maximum_size,
			finalize
		end
	SYSTEM_IDISPOSABLE

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

	frozen get_user_store_for_assembly: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
		external
			"IL static signature (): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetUserStoreForAssembly"
		end

	frozen get_user_store_for_domain: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
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

	frozen get_store (scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE; domain_identity: ANY; assembly_identity: ANY): SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope, System.Object, System.Object): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

	frozen get_file_names (search_pattern: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetFileNames"
		end

	frozen remove_isolated_storage_scope (scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE) is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Remove"
		end

	frozen get_directory_names (search_pattern: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetDirectoryNames"
		end

	frozen get_store_isolated_storage_scope_type (scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE; domain_evidence_type: SYSTEM_TYPE; assembly_evidence_type: SYSTEM_TYPE): SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
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

	frozen create_directory (dir: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"CreateDirectory"
		end

	frozen delete_directory (dir: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"DeleteDirectory"
		end

	frozen delete_file (file: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"DeleteFile"
		end

	frozen get_enumerator (scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE): SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen get_store_isolated_storage_scope_evidence (scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE; domain_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE; domain_evidence_type: SYSTEM_TYPE; assembly_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE; assembly_evidence_type: SYSTEM_TYPE): SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
		external
			"IL static signature (System.IO.IsolatedStorage.IsolatedStorageScope, System.Security.Policy.Evidence, System.Type, System.Security.Policy.Evidence, System.Type): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

feature {NONE} -- Implementation

	get_permission (ps: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION is
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

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE
