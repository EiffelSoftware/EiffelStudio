indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IValidator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IVALIDATOR

inherit
	SYSTEM_OBJECT
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

	get_error_message: SYSTEM_STRING is
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

	set_error_message (value: SYSTEM_STRING) is
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

end -- class WEB_IVALIDATOR
