indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.StringBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRING_BUILDER

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (capacity: INTEGER; max_capacity: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Text.StringBuilder"
		end

	frozen make_4 (value: SYSTEM_STRING; start_index: INTEGER; length: INTEGER; capacity: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.Int32) use System.Text.StringBuilder"
		end

	frozen make_3 (value: SYSTEM_STRING; capacity: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Text.StringBuilder"
		end

	frozen make_2 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Text.StringBuilder"
		end

	frozen make is
		external
			"IL creator use System.Text.StringBuilder"
		end

	frozen make_1 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Text.StringBuilder"
		end

feature -- Access

	frozen get_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.StringBuilder"
		alias
			"get_Capacity"
		end

	frozen get_max_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.StringBuilder"
		alias
			"get_MaxCapacity"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.StringBuilder"
		alias
			"get_Length"
		end

	frozen get_chars (index: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use System.Text.StringBuilder"
		alias
			"get_Chars"
		end

feature -- Element Change

	frozen set_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Text.StringBuilder"
		alias
			"set_Length"
		end

	frozen set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Text.StringBuilder"
		alias
			"set_Capacity"
		end

	frozen set_chars (index: INTEGER; value: CHARACTER) is
		external
			"IL signature (System.Int32, System.Char): System.Void use System.Text.StringBuilder"
		alias
			"set_Chars"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.StringBuilder"
		alias
			"ToString"
		end

	frozen append (value: INTEGER_64): STRING_BUILDER is
		external
			"IL signature (System.Int64): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_array_char_int32_int32 (value: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; char_count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_char (index: INTEGER; value: CHARACTER): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Char): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace_char_char_int32_int32 (old_char: CHARACTER; new_char: CHARACTER; start_index: INTEGER; count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Char, System.Char, System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen ensure_capacity (capacity: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.StringBuilder"
		alias
			"EnsureCapacity"
		end

	frozen append_boolean (value: BOOLEAN): STRING_BUILDER is
		external
			"IL signature (System.Boolean): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_int16 (index: INTEGER; value: INTEGER_16): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Int16): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace_string_string (old_value: SYSTEM_STRING; new_value: SYSTEM_STRING): STRING_BUILDER is
		external
			"IL signature (System.String, System.String): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen equals_string_builder (sb: STRING_BUILDER): BOOLEAN is
		external
			"IL signature (System.Text.StringBuilder): System.Boolean use System.Text.StringBuilder"
		alias
			"Equals"
		end

	frozen insert (index: INTEGER; value: DOUBLE): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Double): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_format_string_array_object (format: SYSTEM_STRING; args: NATIVE_ARRAY [SYSTEM_OBJECT]): STRING_BUILDER is
		external
			"IL signature (System.String, System.Object[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen insert_int32_byte (index: INTEGER; value: INTEGER_8): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Byte): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_int16 (value: INTEGER_16): STRING_BUILDER is
		external
			"IL signature (System.Int16): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen remove (start_index: INTEGER; length: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Remove"
		end

	frozen append_single (value: REAL): STRING_BUILDER is
		external
			"IL signature (System.Single): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_string_int32_int32 (value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_array_char_int32_int32 (index: INTEGER; value: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; char_count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Char[], System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_array_char (value: NATIVE_ARRAY [CHARACTER]): STRING_BUILDER is
		external
			"IL signature (System.Char[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_char_int32 (value: CHARACTER; repeat_count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Char, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_string_int32 (index: INTEGER; value: SYSTEM_STRING; count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.String, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace_string_string_int32_int32 (old_value: SYSTEM_STRING; new_value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen append_format_iformat_provider (provider: IFORMAT_PROVIDER; format: SYSTEM_STRING; args: NATIVE_ARRAY [SYSTEM_OBJECT]): STRING_BUILDER is
		external
			"IL signature (System.IFormatProvider, System.String, System.Object[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen append_decimal (value: DECIMAL): STRING_BUILDER is
		external
			"IL signature (System.Decimal): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_double (value: DOUBLE): STRING_BUILDER is
		external
			"IL signature (System.Double): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_format_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT): STRING_BUILDER is
		external
			"IL signature (System.String, System.Object, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen append_object (value: SYSTEM_OBJECT): STRING_BUILDER is
		external
			"IL signature (System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_string (index: INTEGER; value: SYSTEM_STRING): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.String): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen insert_int32_object (index: INTEGER; value: SYSTEM_OBJECT): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_format (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT): STRING_BUILDER is
		external
			"IL signature (System.String, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen insert_int32_int64 (index: INTEGER; value: INTEGER_64): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Int64): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace (old_char: CHARACTER; new_char: CHARACTER): STRING_BUILDER is
		external
			"IL signature (System.Char, System.Char): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen append_char (value: CHARACTER): STRING_BUILDER is
		external
			"IL signature (System.Char): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_string (value: SYSTEM_STRING): STRING_BUILDER is
		external
			"IL signature (System.String): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_decimal (index: INTEGER; value: DECIMAL): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Decimal): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_byte (value: INTEGER_8): STRING_BUILDER is
		external
			"IL signature (System.Byte): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_int32 (index: INTEGER; value: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_format_string_object_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT): STRING_BUILDER is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen insert_int32_single (index: INTEGER; value: REAL): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Single): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_int32 (value: INTEGER): STRING_BUILDER is
		external
			"IL signature (System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_array_char (index: INTEGER; value: NATIVE_ARRAY [CHARACTER]): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Char[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen insert_int32_boolean (index: INTEGER; value: BOOLEAN): STRING_BUILDER is
		external
			"IL signature (System.Int32, System.Boolean): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen to_string_int32 (start_index: INTEGER; length: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.Text.StringBuilder"
		alias
			"ToString"
		end

end -- class STRING_BUILDER
