indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DescriptionAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESCRIPTION_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_description_attribute,
	make_system_dll_description_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_description_attribute is
		external
			"IL creator use System.ComponentModel.DescriptionAttribute"
		end

	frozen make_system_dll_description_attribute_1 (description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DescriptionAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_DESCRIPTION_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DescriptionAttribute use System.ComponentModel.DescriptionAttribute"
		alias
			"Default"
		end

	get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DescriptionAttribute"
		alias
			"get_Description"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DescriptionAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DescriptionAttribute"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen get_description_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DescriptionAttribute"
		alias
			"get_DescriptionValue"
		end

	frozen set_description_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.ComponentModel.DescriptionAttribute"
		alias
			"set_DescriptionValue"
		end

end -- class SYSTEM_DLL_DESCRIPTION_ATTRIBUTE
