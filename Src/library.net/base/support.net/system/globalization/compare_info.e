indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.CompareInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	COMPARE_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDESERIALIZATION_CALLBACK
		rename
			on_deserialization as system_runtime_serialization_ideserialization_callback_on_deserialization
		end

create {NONE}

feature -- Access

	frozen get_lcid: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.CompareInfo"
		alias
			"get_LCID"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.CompareInfo"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.CompareInfo"
		alias
			"ToString"
		end

	last_index_of_string_char_int32_int32_compare_options (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	is_suffix (source: SYSTEM_STRING; suffix: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsSuffix"
		end

	index_of_string_char_int32_int32_compare_options (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of_string_char_compare_options (source: SYSTEM_STRING; value: CHARACTER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of_string_string_int32_int32_compare_options (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	frozen get_compare_info_string_assembly (name: SYSTEM_STRING; assembly: ASSEMBLY): COMPARE_INFO is
		external
			"IL static signature (System.String, System.Reflection.Assembly): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

	index_of_string_char_int32_compare_options (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of_string_string_int32_compare_options (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	last_index_of_string_char (source: SYSTEM_STRING; value: CHARACTER): INTEGER is
		external
			"IL signature (System.String, System.Char): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	compare_string_int32_string_int32_compare_options (string1: SYSTEM_STRING; offset1: INTEGER; string2: SYSTEM_STRING; offset2: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.String, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	get_sort_key (source: SYSTEM_STRING): SORT_KEY is
		external
			"IL signature (System.String): System.Globalization.SortKey use System.Globalization.CompareInfo"
		alias
			"GetSortKey"
		end

	index_of_string_string_int32_int32 (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of (source: SYSTEM_STRING; value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	last_index_of_string_char_int32_compare_options (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_char_int32_int32 (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	compare_string_int32_int32_string_int32_int32 (string1: SYSTEM_STRING; offset1: INTEGER; length1: INTEGER; string2: SYSTEM_STRING; offset2: INTEGER; length2: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	compare_string_int32_string_int32 (string1: SYSTEM_STRING; offset1: INTEGER; string2: SYSTEM_STRING; offset2: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.String, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	get_sort_key_string_compare_options (source: SYSTEM_STRING; options: COMPARE_OPTIONS): SORT_KEY is
		external
			"IL signature (System.String, System.Globalization.CompareOptions): System.Globalization.SortKey use System.Globalization.CompareInfo"
		alias
			"GetSortKey"
		end

	index_of_string_char_int32 (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of_string_string_compare_options (source: SYSTEM_STRING; value: SYSTEM_STRING; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of_string_char_int32 (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	compare_string_int32_int32_string_int32_int32_compare_options (string1: SYSTEM_STRING; offset1: INTEGER; length1: INTEGER; string2: SYSTEM_STRING; offset2: INTEGER; length2: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	last_index_of_string_string_int32 (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_string_int32_compare_options (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.CompareInfo"
		alias
			"Equals"
		end

	compare (string1: SYSTEM_STRING; string2: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	frozen get_compare_info_int32_assembly (culture: INTEGER; assembly: ASSEMBLY): COMPARE_INFO is
		external
			"IL static signature (System.Int32, System.Reflection.Assembly): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

	is_prefix (source: SYSTEM_STRING; prefix_: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsPrefix"
		end

	last_index_of_string_string_compare_options (source: SYSTEM_STRING; value: SYSTEM_STRING; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_string_int32 (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of_string_char_int32_int32 (source: SYSTEM_STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	frozen get_compare_info (culture: INTEGER): COMPARE_INFO is
		external
			"IL static signature (System.Int32): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

	compare_string_string_compare_options (string1: SYSTEM_STRING; string2: SYSTEM_STRING; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	is_prefix_string_string_compare_options (source: SYSTEM_STRING; prefix_: SYSTEM_STRING; options: COMPARE_OPTIONS): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsPrefix"
		end

	last_index_of_string_string_int32_int32 (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_char (source: SYSTEM_STRING; value: CHARACTER): INTEGER is
		external
			"IL signature (System.String, System.Char): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of (source: SYSTEM_STRING; value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	is_suffix_string_string_compare_options (source: SYSTEM_STRING; suffix: SYSTEM_STRING; options: COMPARE_OPTIONS): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsSuffix"
		end

	last_index_of_string_string_int32_int32_compare_options (source: SYSTEM_STRING; value: SYSTEM_STRING; start_index: INTEGER; count: INTEGER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	last_index_of_string_char_compare_options (source: SYSTEM_STRING; value: CHARACTER; options: COMPARE_OPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	frozen get_compare_info_string (name: SYSTEM_STRING): COMPARE_INFO is
		external
			"IL static signature (System.String): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Globalization.CompareInfo"
		alias
			"Finalize"
		end

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Globalization.CompareInfo"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class COMPARE_INFO
