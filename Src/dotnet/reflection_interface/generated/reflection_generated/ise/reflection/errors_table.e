indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ERRORS_TABLE"

deferred external class
	ERRORS_TABLE

feature -- Basic Operations

	error_name (a_code: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): STRING use ERRORS_TABLE"
		alias
			"error_name"
		end

	replace_error_description (a_code: INTEGER; new_description: STRING) is
		external
			"IL deferred signature (System.Int32, STRING): System.Void use ERRORS_TABLE"
		alias
			"replace_error_description"
		end

	error_info (a_code: INTEGER): ERROR_INFO is
		external
			"IL deferred signature (System.Int32): ERROR_INFO use ERRORS_TABLE"
		alias
			"error_info"
		end

	make is
		external
			"IL deferred signature (): System.Void use ERRORS_TABLE"
		alias
			"make"
		end

	errors_table: HASH_TABLE_ANY_INT32 is
		external
			"IL deferred signature (): HASH_TABLE_ANY_INT32 use ERRORS_TABLE"
		alias
			"errors_table"
		end

	remove_error (a_code: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use ERRORS_TABLE"
		alias
			"remove_error"
		end

	error_description (a_code: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): STRING use ERRORS_TABLE"
		alias
			"error_description"
		end

	add_error (an_error: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use ERRORS_TABLE"
		alias
			"add_error"
		end

	errors: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use ERRORS_TABLE"
		alias
			"errors"
		end

	a_set_errors_table (errors_table2: HASH_TABLE_ANY_INT32) is
		external
			"IL deferred signature (HASH_TABLE_ANY_INT32): System.Void use ERRORS_TABLE"
		alias
			"_set_errors_table"
		end

	replace_error_name (a_code: INTEGER; new_name: STRING) is
		external
			"IL deferred signature (System.Int32, STRING): System.Void use ERRORS_TABLE"
		alias
			"replace_error_name"
		end

end -- class ERRORS_TABLE
