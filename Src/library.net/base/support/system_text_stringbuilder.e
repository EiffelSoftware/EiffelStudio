indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.StringBuilder"

frozen external class
	SYSTEM_TEXT_STRINGBUILDER

inherit
	ANY
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

	frozen make_4 (value: STRING; start_index: INTEGER; length: INTEGER; capacity: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.Int32) use System.Text.StringBuilder"
		end

	frozen make_3 (value: STRING; capacity: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Text.StringBuilder"
		end

	frozen make_2 (value: STRING) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Text.StringBuilder"
		alias
			"ToString"
		end

	frozen append (value: REAL): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Single): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_array_char_int32_int32 (value: ARRAY [CHARACTER]; start_index: INTEGER; char_count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_format_string_object (format: STRING; arg0: ANY): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen insert_int32_char (index: INTEGER; value: CHARACTER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Char): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace_char_char_int32_int32 (old_char: CHARACTER; new_char: CHARACTER; start_index: INTEGER; count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
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

	frozen append_int64 (value: INTEGER_64): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int64): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_boolean (value: BOOLEAN): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Boolean): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_int16 (index: INTEGER; value: INTEGER_16): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Int16): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace_string_string (old_value: STRING; new_value: STRING): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.String): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen equals_string_builder (sb: SYSTEM_TEXT_STRINGBUILDER): BOOLEAN is
		external
			"IL signature (System.Text.StringBuilder): System.Boolean use System.Text.StringBuilder"
		alias
			"Equals"
		end

	frozen insert (index: INTEGER; value: REAL): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Single): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen insert_int32_byte (index: INTEGER; value: INTEGER_8): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Byte): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_int16 (value: INTEGER_16): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int16): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen remove (start_index: INTEGER; length: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Remove"
		end

	frozen append_string_int32_int32 (value: STRING; start_index: INTEGER; count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_array_char_int32_int32 (index: INTEGER; value: ARRAY [CHARACTER]; start_index: INTEGER; char_count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Char[], System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_array_char (value: ARRAY [CHARACTER]): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Char[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_char_int32 (value: CHARACTER; repeat_count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Char, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_string_int32 (index: INTEGER; value: STRING; count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.String, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen insert_int32_double (index: INTEGER; value: DOUBLE): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Double): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace_string_string_int32_int32 (old_value: STRING; new_value: STRING; start_index: INTEGER; count: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen append_format_iformat_provider (provider: SYSTEM_IFORMATPROVIDER; format: STRING; args: ARRAY [ANY]): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.IFormatProvider, System.String, System.Object[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen append_decimal (value: SYSTEM_DECIMAL): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Decimal): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_double (value: DOUBLE): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Double): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_format_string_object_object (format: STRING; arg0: ANY; arg1: ANY): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.Object, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen append_object (value: ANY): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_string (index: INTEGER; value: STRING): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.String): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen insert_int32_object (index: INTEGER; value: ANY): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_format (format: STRING; args: ARRAY [ANY]): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.Object[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen insert_int32_int64 (index: INTEGER; value: INTEGER_64): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Int64): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen replace (old_char: CHARACTER; new_char: CHARACTER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Char, System.Char): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Replace"
		end

	frozen append_char (value: CHARACTER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Char): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen append_string (value: STRING): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_decimal (index: INTEGER; value: SYSTEM_DECIMAL): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Decimal): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_byte (value: INTEGER_8): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Byte): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_int32 (index: INTEGER; value: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen append_format_string_object_object_object (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"AppendFormat"
		end

	frozen append_int32 (value: INTEGER): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Append"
		end

	frozen insert_int32_array_char (index: INTEGER; value: ARRAY [CHARACTER]): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Char[]): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen insert_int32_boolean (index: INTEGER; value: BOOLEAN): SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (System.Int32, System.Boolean): System.Text.StringBuilder use System.Text.StringBuilder"
		alias
			"Insert"
		end

	frozen to_string_int32 (start_index: INTEGER; length: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.Text.StringBuilder"
		alias
			"ToString"
		end

end -- class SYSTEM_TEXT_STRINGBUILDER
