indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.PermissionSet"

external class
	SYSTEM_SECURITY_PERMISSIONSET

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
		rename
			on_deserialization as system_runtime_serialization_ideserialization_callback_on_deserialization
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.PermissionSet"
		end

	frozen make_1 (perm_set: SYSTEM_SECURITY_PERMISSIONSET) is
		external
			"IL creator signature (System.Security.PermissionSet) use System.Security.PermissionSet"
		end

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"get_IsSynchronized"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Security.PermissionSet"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.PermissionSet"
		alias
			"get_Count"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	from_xml (et: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.PermissionSet"
		alias
			"FromXml"
		end

	union (other: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (System.Security.PermissionSet): System.Security.PermissionSet use System.Security.PermissionSet"
		alias
			"Union"
		end

	set_permission (perm: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"SetPermission"
		end

	is_subset_of (target: SYSTEM_SECURITY_PERMISSIONSET): BOOLEAN is
		external
			"IL signature (System.Security.PermissionSet): System.Boolean use System.Security.PermissionSet"
		alias
			"IsSubsetOf"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.PermissionSet"
		alias
			"Equals"
		end

	copy: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.PermissionSet"
		alias
			"Copy"
		end

	get_permission (perm_class: SYSTEM_TYPE): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Type): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"GetPermission"
		end

	frozen convert_permission_set (in_format: STRING; in_data: ARRAY [INTEGER_8]; out_format: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String, System.Byte[], System.String): System.Byte[] use System.Security.PermissionSet"
		alias
			"ConvertPermissionSet"
		end

	intersect (other: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (System.Security.PermissionSet): System.Security.PermissionSet use System.Security.PermissionSet"
		alias
			"Intersect"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Security.PermissionSet"
		alias
			"CopyTo"
		end

	frozen contains_non_code_access_permissions: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"ContainsNonCodeAccessPermissions"
		end

	add_permission (perm: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"AddPermission"
		end

	is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"IsUnrestricted"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.PermissionSet"
		alias
			"ToString"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Security.PermissionSet"
		alias
			"GetEnumerator"
		end

	deny is
		external
			"IL signature (): System.Void use System.Security.PermissionSet"
		alias
			"Deny"
		end

	permit_only is
		external
			"IL signature (): System.Void use System.Security.PermissionSet"
		alias
			"PermitOnly"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.PermissionSet"
		alias
			"ToXml"
		end

	assert is
		external
			"IL signature (): System.Void use System.Security.PermissionSet"
		alias
			"Assert"
		end

	demand is
		external
			"IL signature (): System.Void use System.Security.PermissionSet"
		alias
			"Demand"
		end

	demand_immediate is
		external
			"IL signature (): System.Void use System.Security.PermissionSet"
		alias
			"DemandImmediate"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"IsEmpty"
		end

	remove_permission (perm_class: SYSTEM_TYPE): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Type): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"RemovePermission"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.PermissionSet"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.PermissionSet"
		alias
			"Finalize"
		end

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Security.PermissionSet"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class SYSTEM_SECURITY_PERMISSIONSET
