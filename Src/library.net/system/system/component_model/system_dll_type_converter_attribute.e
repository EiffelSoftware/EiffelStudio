indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.TypeConverterAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_TYPE_CONVERTER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_type_converter_attribute,
	make_system_dll_type_converter_attribute_2,
	make_system_dll_type_converter_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_type_converter_attribute is
		external
			"IL creator use System.ComponentModel.TypeConverterAttribute"
		end

	frozen make_system_dll_type_converter_attribute_2 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.TypeConverterAttribute"
		end

	frozen make_system_dll_type_converter_attribute_1 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.TypeConverterAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_TYPE_CONVERTER_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.TypeConverterAttribute use System.ComponentModel.TypeConverterAttribute"
		alias
			"Default"
		end

	frozen get_converter_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.TypeConverterAttribute"
		alias
			"get_ConverterTypeName"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.TypeConverterAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverterAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_TYPE_CONVERTER_ATTRIBUTE
