indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen get_store_isolated_storage_scope_evidence (scope2: INTEGER; domainEvidence: SYSTEM_SECURITY_POLICY_EVIDENCE; domainEvidenceType: SYSTEM_TYPE; assemblyEvidence: SYSTEM_SECURITY_POLICY_EVIDENCE; assemblyEvidenceType: SYSTEM_TYPE): SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
			-- Valid values for `scope2' are a combination of the following values:
			-- None = 0
			-- User = 1
			-- Domain = 2
			-- Assembly = 4
			-- Roaming = 8
		require
			valid_isolated_storage_scope: (0 + 1 + 2 + 4 + 8) & scope2 = 0 + 1 + 2 + 4 + 8
		external
			"IL static signature (enum System.IO.IsolatedStorage.IsolatedStorageScope, System.Security.Policy.Evidence, System.Type, System.Security.Policy.Evidence, System.Type): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

	frozen get_user_store_for_domain: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
		external
			"IL static signature (): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetUserStoreForDomain"
		end

	frozen get_directory_names (searchPattern: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetDirectoryNames"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Close"
		end

	frozen get_user_store_for_assembly: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
		external
			"IL static signature (): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetUserStoreForAssembly"
		end

	frozen remove_isolated_storage_scope (scope2: INTEGER) is
			-- Valid values for `scope2' are a combination of the following values:
			-- None = 0
			-- User = 1
			-- Domain = 2
			-- Assembly = 4
			-- Roaming = 8
		require
			valid_isolated_storage_scope: (0 + 1 + 2 + 4 + 8) & scope2 = 0 + 1 + 2 + 4 + 8
		external
			"IL static signature (enum System.IO.IsolatedStorage.IsolatedStorageScope): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Remove"
		end

	frozen create_directory (dir: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"CreateDirectory"
		end

	frozen get_store_isolated_storage_scope_type (scope2: INTEGER; domainEvidenceType: SYSTEM_TYPE; assemblyEvidenceType: SYSTEM_TYPE): SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
			-- Valid values for `scope2' are a combination of the following values:
			-- None = 0
			-- User = 1
			-- Domain = 2
			-- Assembly = 4
			-- Roaming = 8
		require
			valid_isolated_storage_scope: (0 + 1 + 2 + 4 + 8) & scope2 = 0 + 1 + 2 + 4 + 8
		external
			"IL static signature (enum System.IO.IsolatedStorage.IsolatedStorageScope, System.Type, System.Type): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

	remove is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Remove"
		end

	frozen delete_file (file: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"DeleteFile"
		end

	frozen delete_directory (dir: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"DeleteDirectory"
		end

	frozen get_store (scope2: INTEGER; domainIdentity2: ANY; assemblyIdentity2: ANY): SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE is
			-- Valid values for `scope2' are a combination of the following values:
			-- None = 0
			-- User = 1
			-- Domain = 2
			-- Assembly = 4
			-- Roaming = 8
		require
			valid_isolated_storage_scope: (0 + 1 + 2 + 4 + 8) & scope2 = 0 + 1 + 2 + 4 + 8
		external
			"IL static signature (enum System.IO.IsolatedStorage.IsolatedStorageScope, System.Object, System.Object): System.IO.IsolatedStorage.IsolatedStorageFile use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetStore"
		end

	frozen get_file_names (searchPattern: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetFileNames"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Dispose"
		end

	frozen get_enumerator (scope2: INTEGER): SYSTEM_COLLECTIONS_IENUMERATOR is
			-- Valid values for `scope2' are a combination of the following values:
			-- None = 0
			-- User = 1
			-- Domain = 2
			-- Assembly = 4
			-- Roaming = 8
		require
			valid_isolated_storage_scope: (0 + 1 + 2 + 4 + 8) & scope2 = 0 + 1 + 2 + 4 + 8
		external
			"IL static signature (enum System.IO.IsolatedStorage.IsolatedStorageScope): System.Collections.IEnumerator use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetEnumerator"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"Finalize"
		end

	get_permission (ps: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION is
		external
			"IL signature (System.Security.PermissionSet): System.Security.Permissions.IsolatedStoragePermission use System.IO.IsolatedStorage.IsolatedStorageFile"
		alias
			"GetPermission"
		end

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE
