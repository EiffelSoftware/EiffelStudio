indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.IValidator"

deferred external class
	SYSTEM_WEB_UI_IVALIDATOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_is_valid: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.IValidator"
		alias
			"get_IsValid"
		end

	get_error_message: STRING is
		external
			"IL deferred signature (): System.String use System.Web.UI.IValidator"
		alias
			"get_ErrorMessage"
		end

feature -- Element Change

	set_is_valid (value: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Web.UI.IValidator"
		alias
			"set_IsValid"
		end

	set_error_message (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Web.UI.IValidator"
		alias
			"set_ErrorMessage"
		end

feature -- Basic Operations

	validate is
		external
			"IL deferred signature (): System.Void use System.Web.UI.IValidator"
		alias
			"Validate"
		end

end -- class SYSTEM_WEB_UI_IVALIDATOR
