indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SUPPORT"

deferred external class
	SUPPORT

feature -- Basic Operations

	create_error (a_name: STRING; a_description: STRING) is
		external
			"IL deferred signature (STRING, STRING): System.Void use SUPPORT"
		alias
			"create_error"
		end

	create_error_from_info (a_code: INTEGER; a_name: STRING; a_description: STRING) is
		external
			"IL deferred signature (System.Int32, STRING, STRING): System.Void use SUPPORT"
		alias
			"create_error_from_info"
		end

	errors_table: ERRORS_TABLE is
		external
			"IL deferred signature (): ERRORS_TABLE use SUPPORT"
		alias
			"errors_table"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use SUPPORT"
		alias
			"_set_last_error"
		end

	last_error: ERROR_INFO is
		external
			"IL deferred signature (): ERROR_INFO use SUPPORT"
		alias
			"last_error"
		end

end -- class SUPPORT
