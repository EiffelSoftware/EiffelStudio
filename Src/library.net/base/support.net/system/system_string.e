indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.String"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_STRING

inherit
	SYSTEM_OBJECT
		rename
			equals as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
		end
	ICOMPARABLE
		rename
			compare_to as compare_to_object,
			equals as equals_object
		end
	ICLONEABLE
		rename
			equals as equals_object
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			equals as equals_object
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (c: CHARACTER; count: INTEGER) is
		external
			"IL creator signature (System.Char, System.Int32) use System.String"
		end

	frozen make (value: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; length: INTEGER) is
		external
			"IL creator signature (System.Char[], System.Int32, System.Int32) use System.String"
		end

	frozen make_1 (value: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL creator signature (System.Char[]) use System.String"
		end

feature -- Access

	frozen empty: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.String"
		alias
			"Empty"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.String"
		alias
			"get_Length"
		end

	frozen get_chars (index: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use System.String"
		alias
			"get_Chars"
		end

feature -- Basic Operations

	frozen compare_string_int32_string_int32_int32_boolean_culture_info (str_a: SYSTEM_STRING; index_a: INTEGER; str_b: SYSTEM_STRING; index_b: INTEGER; length: INTEGER; ignore_case: BOOLEAN; culture: CULTURE_INFO): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32, System.Boolean, System.Globalization.CultureInfo): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen concat_string_string (str0: SYSTEM_STRING; str1: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.String"
		alias
			"Concat"
		end

	frozen concat (arg0: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.Object): System.String use System.String"
		alias
			"Concat"
		end

	frozen last_index_of_string_int32 (value: SYSTEM_STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen compare_to (str_b: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.String"
		alias
			"CompareTo"
		end

	frozen compare_to_object (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.String"
		alias
			"CompareTo"
		end

	frozen last_index_of_char_int32 (value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen to_upper_culture_info (culture: CULTURE_INFO): SYSTEM_STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.String"
		alias
			"ToUpper"
		end

	frozen index_of_any_array_char_int32_int32 (any_of: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"IndexOfAny"
		end

	frozen trim_end (trim_chars: NATIVE_ARRAY [CHARACTER]): SYSTEM_STRING is
		external
			"IL signature (System.Char[]): System.String use System.String"
		alias
			"TrimEnd"
		end

	frozen substring (start_index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.String"
		alias
			"Substring"
		end

	frozen concat_object_object_object (arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.Object, System.Object, System.Object): System.String use System.String"
		alias
			"Concat"
		end

	frozen copy_ (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.String"
		alias
			"Copy"
		end

	frozen to_upper: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"ToUpper"
		end

	frozen get_enumerator: CHAR_ENUMERATOR is
		external
			"IL signature (): System.CharEnumerator use System.String"
		alias
			"GetEnumerator"
		end

	frozen index_of_char (value: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen compare_string_string_boolean_culture_info (str_a: SYSTEM_STRING; str_b: SYSTEM_STRING; ignore_case: BOOLEAN; culture: CULTURE_INFO): INTEGER is
		external
			"IL static signature (System.String, System.String, System.Boolean, System.Globalization.CultureInfo): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen index_of_string_int32 (value: SYSTEM_STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen last_index_of_any_array_char_int32 (any_of: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOfAny"
		end

	frozen index_of_char_int32_int32 (value: CHARACTER; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen concat_string_string_string (str0: SYSTEM_STRING; str1: SYSTEM_STRING; str2: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String, System.String): System.String use System.String"
		alias
			"Concat"
		end

	frozen last_index_of_any_array_char_int32_int32 (any_of: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOfAny"
		end

	equals_object (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.String"
		alias
			"Equals"
		end

	frozen compare_ordinal (str_a: SYSTEM_STRING; str_b: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.String, System.String): System.Int32 use System.String"
		alias
			"CompareOrdinal"
		end

	frozen concat_string_string_string_string (str0: SYSTEM_STRING; str1: SYSTEM_STRING; str2: SYSTEM_STRING; str3: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String, System.String, System.String): System.String use System.String"
		alias
			"Concat"
		end

	frozen copy_to (source_index: INTEGER; destination: NATIVE_ARRAY [CHARACTER]; destination_index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Int32, System.Char[], System.Int32, System.Int32): System.Void use System.String"
		alias
			"CopyTo"
		end

	frozen last_index_of_char_int32_int32 (value: CHARACTER; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen to_lower_culture_info (culture: CULTURE_INFO): SYSTEM_STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.String"
		alias
			"ToLower"
		end

	frozen remove (start_index: INTEGER; count: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.String"
		alias
			"Remove"
		end

	frozen compare (str_a: SYSTEM_STRING; str_b: SYSTEM_STRING): INTEGER is
		external
			"IL static signature (System.String, System.String): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen pad_left (total_width: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.String"
		alias
			"PadLeft"
		end

	frozen trim_array_char (trim_chars: NATIVE_ARRAY [CHARACTER]): SYSTEM_STRING is
		external
			"IL signature (System.Char[]): System.String use System.String"
		alias
			"Trim"
		end

	frozen replace_char (old_char: CHARACTER; new_char: CHARACTER): SYSTEM_STRING is
		external
			"IL signature (System.Char, System.Char): System.String use System.String"
		alias
			"Replace"
		end

	frozen pad_right_int32_char (total_width: INTEGER; padding_char: CHARACTER): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.Char): System.String use System.String"
		alias
			"PadRight"
		end

	frozen insert (start_index: INTEGER; value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.String): System.String use System.String"
		alias
			"Insert"
		end

	frozen index_of (value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen split_array_char_int32 (separator: NATIVE_ARRAY [CHARACTER]; count: INTEGER): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.Char[], System.Int32): System.String[] use System.String"
		alias
			"Split"
		end

	frozen compare_string_int32_string_int32_int32 (str_a: SYSTEM_STRING; index_a: INTEGER; str_b: SYSTEM_STRING; index_b: INTEGER; length: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen trim_start (trim_chars: NATIVE_ARRAY [CHARACTER]): SYSTEM_STRING is
		external
			"IL signature (System.Char[]): System.String use System.String"
		alias
			"TrimStart"
		end

	frozen format_string_array_object (format2: SYSTEM_STRING; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Object[]): System.String use System.String"
		alias
			"Format"
		end

	frozen join (separator: SYSTEM_STRING; value: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String[]): System.String use System.String"
		alias
			"Join"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.String"
		alias
			"ToString"
		end

	frozen format_string_object_object_object (format2: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Object, System.Object, System.Object): System.String use System.String"
		alias
			"Format"
		end

	frozen trim: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"Trim"
		end

	frozen index_of_any_array_char_int32 (any_of: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32): System.Int32 use System.String"
		alias
			"IndexOfAny"
		end

	frozen concat_array_string (values: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_STRING is
		external
			"IL static signature (System.String[]): System.String use System.String"
		alias
			"Concat"
		end

	frozen index_of_char_int32 (value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen index_of_string_int32_int32 (value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen split (separator: NATIVE_ARRAY [CHARACTER]): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.Char[]): System.String[] use System.String"
		alias
			"Split"
		end

	frozen format (format2: SYSTEM_STRING; arg0: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Object): System.String use System.String"
		alias
			"Format"
		end

	frozen intern (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.String"
		alias
			"Intern"
		end

	frozen equals_string_string (a: SYSTEM_STRING; b: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.String"
		alias
			"Equals"
		end

	frozen last_index_of_string_int32_int32 (value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen replace (old_value: SYSTEM_STRING; new_value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.String"
		alias
			"Replace"
		end

	frozen to_char_array: NATIVE_ARRAY [CHARACTER] is
		external
			"IL signature (): System.Char[] use System.String"
		alias
			"ToCharArray"
		end

	frozen to_lower: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"ToLower"
		end

	frozen format_iformat_provider (provider: IFORMAT_PROVIDER; format2: SYSTEM_STRING; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_STRING is
		external
			"IL static signature (System.IFormatProvider, System.String, System.Object[]): System.String use System.String"
		alias
			"Format"
		end

	frozen index_of_any (any_of: NATIVE_ARRAY [CHARACTER]): INTEGER is
		external
			"IL signature (System.Char[]): System.Int32 use System.String"
		alias
			"IndexOfAny"
		end

	frozen last_index_of (value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen last_index_of_char (value: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen to_char_array_int32 (start_index: INTEGER; length: INTEGER): NATIVE_ARRAY [CHARACTER] is
		external
			"IL signature (System.Int32, System.Int32): System.Char[] use System.String"
		alias
			"ToCharArray"
		end

	frozen starts_with (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.String"
		alias
			"StartsWith"
		end

	frozen pad_left_int32_char (total_width: INTEGER; padding_char: CHARACTER): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.Char): System.String use System.String"
		alias
			"PadLeft"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.String"
		alias
			"Clone"
		end

	frozen concat_object_object (arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.Object, System.Object): System.String use System.String"
		alias
			"Concat"
		end

	frozen format_string_object_object (format2: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Object, System.Object): System.String use System.String"
		alias
			"Format"
		end

	frozen join_string_array_string_int32 (separator: SYSTEM_STRING; value: NATIVE_ARRAY [SYSTEM_STRING]; start_index: INTEGER; count: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String[], System.Int32, System.Int32): System.String use System.String"
		alias
			"Join"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.String"
		alias
			"GetTypeCode"
		end

	frozen pad_right (total_width: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.String"
		alias
			"PadRight"
		end

	frozen equals (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.String"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.String"
		alias
			"GetHashCode"
		end

	frozen compare_string_int32_string_int32_int32_boolean (str_a: SYSTEM_STRING; index_a: INTEGER; str_b: SYSTEM_STRING; index_b: INTEGER; length: INTEGER; ignore_case: BOOLEAN): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32, System.Boolean): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen compare_string_string_boolean (str_a: SYSTEM_STRING; str_b: SYSTEM_STRING; ignore_case: BOOLEAN): INTEGER is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen last_index_of_any (any_of: NATIVE_ARRAY [CHARACTER]): INTEGER is
		external
			"IL signature (System.Char[]): System.Int32 use System.String"
		alias
			"LastIndexOfAny"
		end

	frozen is_interned (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.String"
		alias
			"IsInterned"
		end

	frozen substring_int32_int32 (start_index: INTEGER; length: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.String"
		alias
			"Substring"
		end

	frozen ends_with (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.String"
		alias
			"EndsWith"
		end

	frozen concat_array_object (args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_STRING is
		external
			"IL static signature (System.Object[]): System.String use System.String"
		alias
			"Concat"
		end

	frozen compare_ordinal_string_int32 (str_a: SYSTEM_STRING; index_a: INTEGER; str_b: SYSTEM_STRING; index_b: INTEGER; length: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"CompareOrdinal"
		end

feature -- Binary Operators

	frozen infix "#==" (b: SYSTEM_STRING): BOOLEAN is
		external
			"IL operator signature (System.String): System.Boolean use System.String"
		alias
			"op_Equality"
		end

	frozen infix "|=" (b: SYSTEM_STRING): BOOLEAN is
		external
			"IL operator signature (System.String): System.Boolean use System.String"
		alias
			"op_Inequality"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.String"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.String"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_STRING
