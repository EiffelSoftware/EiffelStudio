indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DBDataPermissionAttribute"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_DBDATA_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

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

end -- class DATA_DBDATA_PERMISSION_ATTRIBUTE
