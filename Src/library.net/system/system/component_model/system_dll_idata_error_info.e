indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IDataErrorInfo"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDATA_ERROR_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_error: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.IDataErrorInfo"
		alias
			"get_Error"
		end

	get_item (column_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.ComponentModel.IDataErrorInfo"
		alias
			"get_Item"
		end

end -- class SYSTEM_DLL_IDATA_ERROR_INFO
