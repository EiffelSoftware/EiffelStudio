indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.IsolatedStorage.IsolatedStorage"

deferred external class
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGE

inherit
	SYSTEM_MARSHALBYREFOBJECT

feature -- Access

	get_current_size: INTEGER_64 is
		external
			"IL signature (): System.UInt64 use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_CurrentSize"
		end

	frozen get_assembly_identity: ANY is
		external
			"IL signature (): System.Object use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_AssemblyIdentity"
		end

	frozen get_scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE is
		external
			"IL signature (): System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_Scope"
		end

	frozen get_domain_identity: ANY is
		external
			"IL signature (): System.Object use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_DomainIdentity"
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

	get_permission (ps: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSION is
		external
			"IL deferred signature (System.Security.PermissionSet): System.Security.Permissions.IsolatedStoragePermission use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"GetPermission"
		end

	get_separator_internal: CHARACTER is
		external
			"IL signature (): System.Char use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_SeparatorInternal"
		end

	frozen init_store (scope: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGESCOPE; domain_evidence_type: SYSTEM_TYPE; assembly_evidence_type: SYSTEM_TYPE) is
		external
			"IL signature (System.IO.IsolatedStorage.IsolatedStorageScope, System.Type, System.Type): System.Void use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"InitStore"
		end

	get_separator_external: CHARACTER is
		external
			"IL signature (): System.Char use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_SeparatorExternal"
		end

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGE
