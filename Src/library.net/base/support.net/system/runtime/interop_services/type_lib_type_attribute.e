indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TypeLibTypeAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TYPE_LIB_TYPE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_type_lib_type_attribute_1,
	make_type_lib_type_attribute

feature {NONE} -- Initialization

	frozen make_type_lib_type_attribute_1 (flags: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.TypeLibTypeAttribute"
		end

	frozen make_type_lib_type_attribute (flags: TYPE_LIB_TYPE_FLAGS) is
		external
			"IL creator signature (System.Runtime.InteropServices.TypeLibTypeFlags) use System.Runtime.InteropServices.TypeLibTypeAttribute"
		end

feature -- Access

	frozen get_value: TYPE_LIB_TYPE_FLAGS is
		external
			"IL signature (): System.Runtime.InteropServices.TypeLibTypeFlags use System.Runtime.InteropServices.TypeLibTypeAttribute"
		alias
			"get_Value"
		end

end -- class TYPE_LIB_TYPE_ATTRIBUTE
