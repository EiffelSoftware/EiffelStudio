indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	IMPORTED_FROM_TYPE_LIB_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_imported_from_type_lib_attribute

feature {NONE} -- Initialization

	frozen make_imported_from_type_lib_attribute (tlb_file: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
		alias
			"get_Value"
		end

end -- class IMPORTED_FROM_TYPE_LIB_ATTRIBUTE
