indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.IsolatedStorage.IsolatedStorage"

deferred external class
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGE

inherit
	SYSTEM_MARSHALBYREFOBJECT

feature -- Access

	frozen get_scope: INTEGER is
		external
			"IL signature (): enum System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_Scope"
		ensure
			valid_isolated_storage_scope: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8
		end

	get_current_size: INTEGER_64 is
		external
			"IL signature (): System.UInt64 use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_CurrentSize"
		end

	frozen get_domain_identity: ANY is
		external
			"IL signature (): System.Object use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_DomainIdentity"
		end

	frozen get_assembly_identity: ANY is
		external
			"IL signature (): System.Object use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_AssemblyIdentity"
		end

	get_maximum_size: INTEGER_64 is
		external
			"IL signature (): System.UInt64 use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_MaximumSize"
		end

feature -- Basic Operations

	remove is
		external
			"IL deferred signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"Remove"
		end

feature {NONE} -- Implementation

	get_separator_internal: CHARACTER is
		external
			"IL signature (): System.Char use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_SeparatorInternal"
		end

	get_separator_external: CHARACTER is
		external
			"IL signature (): System.Char use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_SeparatorExternal"
		end

	get_permission (ps: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION is
		external
			"IL deferred signature (System.Security.PermissionSet): System.Security.Permissions.IsolatedStoragePermission use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"GetPermission"
		end

	frozen init_store (scope2: INTEGER; domainEvidenceType: SYSTEM_TYPE; assemblyEvidenceType: SYSTEM_TYPE) is
			-- Valid values for `scope2' are a combination of the following values:
			-- None = 0
			-- User = 1
			-- Domain = 2
			-- Assembly = 4
			-- Roaming = 8
		require
			valid_isolated_storage_scope: (0 + 1 + 2 + 4 + 8) & scope2 = 0 + 1 + 2 + 4 + 8
		external
			"IL signature (enum System.IO.IsolatedStorage.IsolatedStorageScope, System.Type, System.Type): System.Void use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"InitStore"
		end

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGE
