indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.NamedPermissionSet"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	NAMED_PERMISSION_SET

inherit
	PERMISSION_SET
		redefine
			from_xml,
			to_xml,
			copy_
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
	make_named_permission_set,
	make_named_permission_set_2,
	make_named_permission_set_3,
	make_named_permission_set_1

feature {NONE} -- Initialization

	frozen make_named_permission_set (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.NamedPermissionSet"
		end

	frozen make_named_permission_set_2 (name: SYSTEM_STRING; perm_set: PERMISSION_SET) is
		external
			"IL creator signature (System.String, System.Security.PermissionSet) use System.Security.NamedPermissionSet"
		end

	frozen make_named_permission_set_3 (perm_set: NAMED_PERMISSION_SET) is
		external
			"IL creator signature (System.Security.NamedPermissionSet) use System.Security.NamedPermissionSet"
		end

	frozen make_named_permission_set_1 (name: SYSTEM_STRING; state: PERMISSION_STATE) is
		external
			"IL creator signature (System.String, System.Security.Permissions.PermissionState) use System.Security.NamedPermissionSet"
		end

feature -- Access

	frozen get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.NamedPermissionSet"
		alias
			"get_Description"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.NamedPermissionSet"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.NamedPermissionSet"
		alias
			"set_Description"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.NamedPermissionSet"
		alias
			"set_Name"
		end

feature -- Basic Operations

	from_xml (et: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.NamedPermissionSet"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.NamedPermissionSet"
		alias
			"ToXml"
		end

	frozen copy__string (name: SYSTEM_STRING): NAMED_PERMISSION_SET is
		external
			"IL signature (System.String): System.Security.NamedPermissionSet use System.Security.NamedPermissionSet"
		alias
			"Copy"
		end

	copy_: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.NamedPermissionSet"
		alias
			"Copy"
		end

end -- class NAMED_PERMISSION_SET
