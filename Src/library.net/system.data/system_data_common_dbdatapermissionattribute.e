indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DBDataPermissionAttribute"

deferred external class
	SYSTEM_DATA_COMMON_DBDATAPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

feature -- Access

	frozen get_allow_blank_password: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DBDataPermissionAttribute"
		alias
			"get_AllowBlankPassword"
		end

feature -- Element Change

	frozen set_allow_blank_password (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.Common.DBDataPermissionAttribute"
		alias
			"set_AllowBlankPassword"
		end

end -- class SYSTEM_DATA_COMMON_DBDATAPERMISSIONATTRIBUTE
