indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.AmbientValueAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_AMBIENT_VALUE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_ambient_value_attribute_6,
	make_system_dll_ambient_value_attribute,
	make_system_dll_ambient_value_attribute_4,
	make_system_dll_ambient_value_attribute_5,
	make_system_dll_ambient_value_attribute_2,
	make_system_dll_ambient_value_attribute_3,
	make_system_dll_ambient_value_attribute_1,
	make_system_dll_ambient_value_attribute_7,
	make_system_dll_ambient_value_attribute_9,
	make_system_dll_ambient_value_attribute_8,
	make_system_dll_ambient_value_attribute_10

feature {NONE} -- Initialization

	frozen make_system_dll_ambient_value_attribute_6 (value: REAL) is
		external
			"IL creator signature (System.Single) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute (type: TYPE; value: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_4 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_5 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_2 (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_3 (value: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_1 (value: CHARACTER) is
		external
			"IL creator signature (System.Char) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_7 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_9 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_8 (value: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_system_dll_ambient_value_attribute_10 (value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.ComponentModel.AmbientValueAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.AmbientValueAttribute"
		alias
			"get_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.AmbientValueAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.AmbientValueAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_AMBIENT_VALUE_ATTRIBUTE
