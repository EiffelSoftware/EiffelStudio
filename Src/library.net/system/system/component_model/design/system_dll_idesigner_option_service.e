indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IDesignerOptionService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_OPTION_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_option_value (page_name: SYSTEM_STRING; value_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.ComponentModel.Design.IDesignerOptionService"
		alias
			"GetOptionValue"
		end

	set_option_value (page_name: SYSTEM_STRING; value_name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.String, System.Object): System.Void use System.ComponentModel.Design.IDesignerOptionService"
		alias
			"SetOptionValue"
		end

end -- class SYSTEM_DLL_IDESIGNER_OPTION_SERVICE
