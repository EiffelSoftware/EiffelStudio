indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.CompareInfo"

external class
	SYSTEM_GLOBALIZATION_COMPAREINFO

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Globalization.CompareInfo"
		alias
			"ToString"
		end

	last_index_of_string_char_int32_int32_compare_options (source: STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	is_suffix (source: STRING; suffix: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsSuffix"
		end

	index_of_string_char_int32_int32_compare_options (source: STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of_string_char_compare_options (source: STRING; value: CHARACTER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of_string_string_int32_int32_compare_options (source: STRING; value: STRING; start_index: INTEGER; count: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	frozen get_compare_info_string_assembly (name: STRING; assembly: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_GLOBALIZATION_COMPAREINFO is
		external
			"IL static signature (System.String, System.Reflection.Assembly): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

	index_of_string_char_int32_compare_options (source: STRING; value: CHARACTER; start_index: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of_string_string_int32_compare_options (source: STRING; value: STRING; start_index: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	last_index_of_string_char (source: STRING; value: CHARACTER): INTEGER is
		external
			"IL signature (System.String, System.Char): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.CompareInfo"
		alias
			"Equals"
		end

	compare_string_int32_string_int32_compare_options (string1: STRING; offset1: INTEGER; string2: STRING; offset2: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.String, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	get_sort_key (source: STRING): SYSTEM_GLOBALIZATION_SORTKEY is
		external
			"IL signature (System.String): System.Globalization.SortKey use System.Globalization.CompareInfo"
		alias
			"GetSortKey"
		end

	index_of_string_string_int32_int32 (source: STRING; value: STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of (source: STRING; value: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	last_index_of_string_char_int32_compare_options (source: STRING; value: CHARACTER; start_index: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_char_int32_int32 (source: STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	compare_string_int32_int32_string_int32_int32 (string1: STRING; offset1: INTEGER; length1: INTEGER; string2: STRING; offset2: INTEGER; length2: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	compare_string_int32_string_int32 (string1: STRING; offset1: INTEGER; string2: STRING; offset2: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.String, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	get_sort_key_string_compare_options (source: STRING; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): SYSTEM_GLOBALIZATION_SORTKEY is
		external
			"IL signature (System.String, System.Globalization.CompareOptions): System.Globalization.SortKey use System.Globalization.CompareInfo"
		alias
			"GetSortKey"
		end

	index_of_string_char_int32 (source: STRING; value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of_string_string_compare_options (source: STRING; value: STRING; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of_string_char_int32 (source: STRING; value: CHARACTER; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	compare_string_int32_int32_string_int32_int32_compare_options (string1: STRING; offset1: INTEGER; length1: INTEGER; string2: STRING; offset2: INTEGER; length2: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	last_index_of_string_string_int32 (source: STRING; value: STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_string_int32_compare_options (source: STRING; value: STRING; start_index: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	compare (string1: STRING; string2: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	frozen get_compare_info_int32_assembly (culture: INTEGER; assembly: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_GLOBALIZATION_COMPAREINFO is
		external
			"IL static signature (System.Int32, System.Reflection.Assembly): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

	is_prefix (source: STRING; prefix_: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsPrefix"
		end

	last_index_of_string_string_compare_options (source: STRING; value: STRING; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_string_int32 (source: STRING; value: STRING; start_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	last_index_of_string_char_int32_int32 (source: STRING; value: CHARACTER; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	frozen get_compare_info (culture: INTEGER): SYSTEM_GLOBALIZATION_COMPAREINFO is
		external
			"IL static signature (System.Int32): System.Globalization.CompareInfo use System.Globalization.CompareInfo"
		alias
			"GetCompareInfo"
		end

	compare_string_string_compare_options (string1: STRING; string2: STRING; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"Compare"
		end

	is_prefix_string_string_compare_options (source: STRING; prefix_: STRING; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsPrefix"
		end

	last_index_of_string_string_int32_int32 (source: STRING; value: STRING; start_index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	index_of_string_char (source: STRING; value: CHARACTER): INTEGER is
		external
			"IL signature (System.String, System.Char): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	index_of (source: STRING; value: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Globalization.CompareInfo"
		alias
			"IndexOf"
		end

	is_suffix_string_string_compare_options (source: STRING; suffix: STRING; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Globalization.CompareOptions): System.Boolean use System.Globalization.CompareInfo"
		alias
			"IsSuffix"
		end

	last_index_of_string_string_int32_int32_compare_options (source: STRING; value: STRING; start_index: INTEGER; count: INTEGER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	last_index_of_string_char_compare_options (source: STRING; value: CHARACTER; options: SYSTEM_GLOBALIZATION_COMPAREOPTIONS): INTEGER is
		external
			"IL signature (System.String, System.Char, System.Globalization.CompareOptions): System.Int32 use System.Globalization.CompareInfo"
		alias
			"LastIndexOf"
		end

	frozen get_compare_info_string (name: STRING): SYSTEM_GLOBALIZATION_COMPAREINFO is
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

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Globalization.CompareInfo"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class SYSTEM_GLOBALIZATION_COMPAREINFO
