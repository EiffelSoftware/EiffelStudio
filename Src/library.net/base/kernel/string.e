indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.String"

frozen external class
	STRING

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	ICOMPARABLE
		rename
			compare_to as compare_to_object
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
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

	frozen make (value: ARRAY [CHARACTER]; start_index: INTEGER; length: INTEGER) is
		external
			"IL creator signature (System.Char[], System.Int32, System.Int32) use System.String"
		end

	frozen make_1 (value: ARRAY [CHARACTER]) is
		external
			"IL creator signature (System.Char[]) use System.String"
		end

feature -- Access

	frozen empty: STRING is
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

	frozen compare_string_int32_string_int32_int32_boolean_culture_info (str_a: STRING; index_a: INTEGER; str_b: STRING; index_b: INTEGER; length: INTEGER; ignore_case: BOOLEAN; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32, System.Boolean, System.Globalization.CultureInfo): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen concat_string_string (str0: STRING; str1: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.String"
		alias
			"Concat"
		end

	frozen concat (args: ARRAY [ANY]): STRING is
		external
			"IL static signature (System.Object[]): System.String use System.String"
		alias
			"Concat"
		end

	frozen last_index_of_string_int32 (value: STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen copy (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.String"
		alias
			"Copy"
		end

	frozen compare_to (str_b: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.String"
		alias
			"CompareTo"
		end

	frozen compare_to_object (value: ANY): INTEGER is
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

	frozen to_upper_culture_info (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.String"
		alias
			"ToUpper"
		end

	frozen index_of_any_array_char_int32_int32 (any_of: ARRAY [CHARACTER]; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"IndexOfAny"
		end

	frozen trim_end (trim_chars: ARRAY [CHARACTER]): STRING is
		external
			"IL signature (System.Char[]): System.String use System.String"
		alias
			"TrimEnd"
		end

	frozen substring (start_index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.String"
		alias
			"Substring"
		end

	frozen concat_object_object_object (arg0: ANY; arg1: ANY; arg2: ANY): STRING is
		external
			"IL static signature (System.Object, System.Object, System.Object): System.String use System.String"
		alias
			"Concat"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.String"
		alias
			"Clone"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"ToString"
		end

	frozen to_upper: STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"ToUpper"
		end

	frozen get_enumerator: SYSTEM_CHARENUMERATOR is
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

	frozen compare_string_string_boolean_culture_info (str_a: STRING; str_b: STRING; ignore_case: BOOLEAN; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): INTEGER is
		external
			"IL static signature (System.String, System.String, System.Boolean, System.Globalization.CultureInfo): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen index_of_string_int32 (value: STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen last_index_of_any_array_char_int32 (any_of: ARRAY [CHARACTER]; start_index: INTEGER): INTEGER is
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

	frozen concat_string_string_string (str0: STRING; str1: STRING; str2: STRING): STRING is
		external
			"IL static signature (System.String, System.String, System.String): System.String use System.String"
		alias
			"Concat"
		end

	frozen last_index_of_any_array_char_int32_int32 (any_of: ARRAY [CHARACTER]; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOfAny"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.String"
		alias
			"Equals"
		end

	frozen compare_ordinal (str_a: STRING; str_b: STRING): INTEGER is
		external
			"IL static signature (System.String, System.String): System.Int32 use System.String"
		alias
			"CompareOrdinal"
		end

	frozen concat_string_string_string_string (str0: STRING; str1: STRING; str2: STRING; str3: STRING): STRING is
		external
			"IL static signature (System.String, System.String, System.String, System.String): System.String use System.String"
		alias
			"Concat"
		end

	frozen copy_to (source_index: INTEGER; destination: ARRAY [CHARACTER]; destination_index: INTEGER; count: INTEGER) is
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

	frozen to_lower_culture_info (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.String"
		alias
			"ToLower"
		end

	frozen remove (start_index: INTEGER; count: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.String"
		alias
			"Remove"
		end

	frozen compare (str_a: STRING; str_b: STRING): INTEGER is
		external
			"IL static signature (System.String, System.String): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen equals_string (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.String"
		alias
			"Equals"
		end

	frozen pad_left (total_width: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.String"
		alias
			"PadLeft"
		end

	frozen trim_array_char (trim_chars: ARRAY [CHARACTER]): STRING is
		external
			"IL signature (System.Char[]): System.String use System.String"
		alias
			"Trim"
		end

	frozen replace_char (old_char: CHARACTER; new_char: CHARACTER): STRING is
		external
			"IL signature (System.Char, System.Char): System.String use System.String"
		alias
			"Replace"
		end

	frozen pad_right_int32_char (total_width: INTEGER; padding_char: CHARACTER): STRING is
		external
			"IL signature (System.Int32, System.Char): System.String use System.String"
		alias
			"PadRight"
		end

	frozen insert (start_index: INTEGER; value: STRING): STRING is
		external
			"IL signature (System.Int32, System.String): System.String use System.String"
		alias
			"Insert"
		end

	frozen index_of (value: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen split_array_char_int32 (separator: ARRAY [CHARACTER]; count: INTEGER): ARRAY [STRING] is
		external
			"IL signature (System.Char[], System.Int32): System.String[] use System.String"
		alias
			"Split"
		end

	frozen compare_string_int32_string_int32_int32 (str_a: STRING; index_a: INTEGER; str_b: STRING; index_b: INTEGER; length: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen trim_start (trim_chars: ARRAY [CHARACTER]): STRING is
		external
			"IL signature (System.Char[]): System.String use System.String"
		alias
			"TrimStart"
		end

	frozen join (separator: STRING; value: ARRAY [STRING]): STRING is
		external
			"IL static signature (System.String, System.String[]): System.String use System.String"
		alias
			"Join"
		end

	frozen to_string_iformat_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.String"
		alias
			"ToString"
		end

	frozen format_string_object_object_object (format2: STRING; arg0: ANY; arg1: ANY; arg2: ANY): STRING is
		external
			"IL static signature (System.String, System.Object, System.Object, System.Object): System.String use System.String"
		alias
			"Format"
		end

	frozen trim: STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"Trim"
		end

	frozen index_of_any_array_char_int32 (any_of: ARRAY [CHARACTER]; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32): System.Int32 use System.String"
		alias
			"IndexOfAny"
		end

	frozen concat_array_string (values: ARRAY [STRING]): STRING is
		external
			"IL static signature (System.String[]): System.String use System.String"
		alias
			"Concat"
		end

	frozen format_string_object (format2: STRING; arg0: ANY): STRING is
		external
			"IL static signature (System.String, System.Object): System.String use System.String"
		alias
			"Format"
		end

	frozen index_of_char_int32 (value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen index_of_string_int32_int32 (value: STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"IndexOf"
		end

	frozen split (separator: ARRAY [CHARACTER]): ARRAY [STRING] is
		external
			"IL signature (System.Char[]): System.String[] use System.String"
		alias
			"Split"
		end

	frozen format (format2: STRING; args: ARRAY [ANY]): STRING is
		external
			"IL static signature (System.String, System.Object[]): System.String use System.String"
		alias
			"Format"
		end

	frozen intern (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.String"
		alias
			"Intern"
		end

	frozen equals_string_string (a: STRING; b: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.String"
		alias
			"Equals"
		end

	frozen last_index_of_string_int32_int32 (value: STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"LastIndexOf"
		end

	frozen replace (old_value: STRING; new_value: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.String"
		alias
			"Replace"
		end

	frozen to_char_array: ARRAY [CHARACTER] is
		external
			"IL signature (): System.Char[] use System.String"
		alias
			"ToCharArray"
		end

	frozen to_lower: STRING is
		external
			"IL signature (): System.String use System.String"
		alias
			"ToLower"
		end

	frozen format_iformat_provider (provider: SYSTEM_IFORMATPROVIDER; format2: STRING; args: ARRAY [ANY]): STRING is
		external
			"IL static signature (System.IFormatProvider, System.String, System.Object[]): System.String use System.String"
		alias
			"Format"
		end

	frozen index_of_any (any_of: ARRAY [CHARACTER]): INTEGER is
		external
			"IL signature (System.Char[]): System.Int32 use System.String"
		alias
			"IndexOfAny"
		end

	frozen last_index_of (value: STRING): INTEGER is
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

	frozen to_char_array_int32 (start_index: INTEGER; length: INTEGER): ARRAY [CHARACTER] is
		external
			"IL signature (System.Int32, System.Int32): System.Char[] use System.String"
		alias
			"ToCharArray"
		end

	frozen starts_with (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.String"
		alias
			"StartsWith"
		end

	frozen pad_left_int32_char (total_width: INTEGER; padding_char: CHARACTER): STRING is
		external
			"IL signature (System.Int32, System.Char): System.String use System.String"
		alias
			"PadLeft"
		end

	frozen concat_object_object (arg0: ANY; arg1: ANY): STRING is
		external
			"IL static signature (System.Object, System.Object): System.String use System.String"
		alias
			"Concat"
		end

	frozen format_string_object_object (format2: STRING; arg0: ANY; arg1: ANY): STRING is
		external
			"IL static signature (System.String, System.Object, System.Object): System.String use System.String"
		alias
			"Format"
		end

	frozen join_string_array_string_int32 (separator: STRING; value: ARRAY [STRING]; start_index: INTEGER; count: INTEGER): STRING is
		external
			"IL static signature (System.String, System.String[], System.Int32, System.Int32): System.String use System.String"
		alias
			"Join"
		end

	frozen get_type_code: SYSTEM_TYPECODE is
		external
			"IL signature (): System.TypeCode use System.String"
		alias
			"GetTypeCode"
		end

	frozen pad_right (total_width: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.String"
		alias
			"PadRight"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.String"
		alias
			"GetHashCode"
		end

	frozen compare_string_int32_string_int32_int32_boolean (str_a: STRING; index_a: INTEGER; str_b: STRING; index_b: INTEGER; length: INTEGER; ignore_case: BOOLEAN): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32, System.Boolean): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen compare_string_string_boolean (str_a: STRING; str_b: STRING; ignore_case: BOOLEAN): INTEGER is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Int32 use System.String"
		alias
			"Compare"
		end

	frozen last_index_of_any (any_of: ARRAY [CHARACTER]): INTEGER is
		external
			"IL signature (System.Char[]): System.Int32 use System.String"
		alias
			"LastIndexOfAny"
		end

	frozen is_interned (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.String"
		alias
			"IsInterned"
		end

	frozen concat_object (arg0: ANY): STRING is
		external
			"IL static signature (System.Object): System.String use System.String"
		alias
			"Concat"
		end

	frozen substring_int32_int32 (start_index: INTEGER; length: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.String"
		alias
			"Substring"
		end

	frozen ends_with (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.String"
		alias
			"EndsWith"
		end

	frozen compare_ordinal_string_int32 (str_a: STRING; index_a: INTEGER; str_b: STRING; index_b: INTEGER; length: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32, System.String, System.Int32, System.Int32): System.Int32 use System.String"
		alias
			"CompareOrdinal"
		end

feature -- Binary Operators

	frozen infix "#==" (b: STRING): BOOLEAN is
		external
			"IL operator signature (System.String): System.Boolean use System.String"
		alias
			"op_Equality"
		end

	frozen infix "|=" (b: STRING): BOOLEAN is
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

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.String"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

feature -- Eiffel Basic Operations

	infix "<" (other: like Current): BOOLEAN is
			-- Is current integer less than `other'?
		do
		end

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
		end

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
		end

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		do
		end

end -- class STRING
