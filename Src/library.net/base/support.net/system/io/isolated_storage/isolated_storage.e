indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IsolatedStorage.IsolatedStorage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISOLATED_STORAGE

inherit
	MARSHAL_BY_REF_OBJECT

feature -- Access

	get_current_size: INTEGER_64 is
		external
			"IL signature (): System.UInt64 use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_CurrentSize"
		end

	frozen get_assembly_identity: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_AssemblyIdentity"
		end

	frozen get_scope: ISOLATED_STORAGE_SCOPE is
		external
			"IL signature (): System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorage"
		alias
			"get_Scope"
		end

	frozen get_domain_identity: SYSTEM_OBJECT is
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

	get_permission (ps: PERMISSION_SET): ISOLATED_STORAGE_PERMISSION is
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

	frozen init_store (scope: ISOLATED_STORAGE_SCOPE; domain_evidence_type: TYPE; assembly_evidence_type: TYPE) is
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

end -- class ISOLATED_STORAGE
