indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.PermissionSet"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PERMISSION_SET

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISECURITY_ENCODABLE
	ICOLLECTION
	IENUMERABLE
	ISTACK_WALK
	IDESERIALIZATION_CALLBACK
		rename
			on_deserialization as system_runtime_serialization_ideserialization_callback_on_deserialization
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.PermissionSet"
		end

	frozen make_1 (perm_set: PERMISSION_SET) is
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

	get_sync_root: SYSTEM_OBJECT is
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

	copy_: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.PermissionSet"
		alias
			"Copy"
		end

	union (other: PERMISSION_SET): PERMISSION_SET is
		external
			"IL signature (System.Security.PermissionSet): System.Security.PermissionSet use System.Security.PermissionSet"
		alias
			"Union"
		end

	is_subset_of (target: PERMISSION_SET): BOOLEAN is
		external
			"IL signature (System.Security.PermissionSet): System.Boolean use System.Security.PermissionSet"
		alias
			"IsSubsetOf"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.PermissionSet"
		alias
			"Equals"
		end

	set_permission (perm: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"SetPermission"
		end

	get_permission (perm_class: TYPE): IPERMISSION is
		external
			"IL signature (System.Type): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"GetPermission"
		end

	frozen convert_permission_set (in_format: SYSTEM_STRING; in_data: NATIVE_ARRAY [INTEGER_8]; out_format: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String, System.Byte[], System.String): System.Byte[] use System.Security.PermissionSet"
		alias
			"ConvertPermissionSet"
		end

	intersect (other: PERMISSION_SET): PERMISSION_SET is
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

	from_xml (et: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.PermissionSet"
		alias
			"FromXml"
		end

	is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"IsUnrestricted"
		end

	add_permission (perm: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.PermissionSet"
		alias
			"AddPermission"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.PermissionSet"
		alias
			"ToString"
		end

	get_enumerator: IENUMERATOR is
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

	to_xml: SECURITY_ELEMENT is
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

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.PermissionSet"
		alias
			"IsEmpty"
		end

	remove_permission (perm_class: TYPE): IPERMISSION is
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

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Security.PermissionSet"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class PERMISSION_SET
