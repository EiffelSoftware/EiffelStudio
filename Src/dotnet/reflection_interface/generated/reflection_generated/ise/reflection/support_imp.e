indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SUPPORT_IMP"

deferred external class
	SUPPORT_IMP

feature -- Basic Operations

	interface: SUPPORT is
		external
			"IL deferred signature (): SUPPORT use SUPPORT_IMP"
		alias
			"interface"
		end

	create_error (a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use SUPPORT_IMP"
		alias
			"create_error"
		end

	create_error_from_info (a_code: INTEGER; a_name: SYSTEM_STRING; a_description: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Int32, System.String, System.String): System.Void use SUPPORT_IMP"
		alias
			"create_error_from_info"
		end

	a_set_interface (interface2: SUPPORT) is
		external
			"IL deferred signature (SUPPORT): System.Void use SUPPORT_IMP"
		alias
			"_set_interface"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL deferred signature (): ERRORS_TABLE use SUPPORT_IMP"
		alias
			"errors_table"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use SUPPORT_IMP"
		alias
			"_set_last_error"
		end

	last_error: ERROR_INFO is
		external
			"IL deferred signature (): ERROR_INFO use SUPPORT_IMP"
		alias
			"last_error"
		end

end -- class SUPPORT_IMP
