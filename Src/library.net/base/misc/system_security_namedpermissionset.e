indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.NamedPermissionSet"

frozen external class
	SYSTEM_SECURITY_NAMEDPERMISSIONSET

inherit
	SYSTEM_SECURITY_PERMISSIONSET
		redefine
			from_xml,
			to_xml,
			copy
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
	make_namedpermissionset_2,
	make_namedpermissionset_3,
	make_namedpermissionset_1,
	make_namedpermissionset

feature {NONE} -- Initialization

	frozen make_namedpermissionset_2 (name: STRING; perm_set: SYSTEM_SECURITY_PERMISSIONSET) is
		external
			"IL creator signature (System.String, System.Security.PermissionSet) use System.Security.NamedPermissionSet"
		end

	frozen make_namedpermissionset_3 (perm_set: SYSTEM_SECURITY_NAMEDPERMISSIONSET) is
		external
			"IL creator signature (System.Security.NamedPermissionSet) use System.Security.NamedPermissionSet"
		end

	frozen make_namedpermissionset_1 (name: STRING; state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (System.String, enum System.Security.Permissions.PermissionState) use System.Security.NamedPermissionSet"
		end

	frozen make_namedpermissionset (name: STRING) is
		external
			"IL creator signature (System.String) use System.Security.NamedPermissionSet"
		end

feature -- Access

	frozen get_description: STRING is
		external
			"IL signature (): System.String use System.Security.NamedPermissionSet"
		alias
			"get_Description"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Security.NamedPermissionSet"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_description (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.NamedPermissionSet"
		alias
			"set_Description"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.NamedPermissionSet"
		alias
			"set_Name"
		end

feature -- Basic Operations

	from_xml (et: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.NamedPermissionSet"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.NamedPermissionSet"
		alias
			"ToXml"
		end

	frozen copy_string (name: STRING): SYSTEM_SECURITY_NAMEDPERMISSIONSET is
		external
			"IL signature (System.String): System.Security.NamedPermissionSet use System.Security.NamedPermissionSet"
		alias
			"Copy"
		end

	copy: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.NamedPermissionSet"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_NAMEDPERMISSIONSET
