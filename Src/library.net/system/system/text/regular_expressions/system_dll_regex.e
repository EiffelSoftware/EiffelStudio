indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.Regex"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_REGEX

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (pattern: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Text.RegularExpressions.Regex"
		end

	frozen make_1 (pattern: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS) is
		external
			"IL creator signature (System.String, System.Text.RegularExpressions.RegexOptions) use System.Text.RegularExpressions.Regex"
		end

feature -- Access

	frozen get_right_to_left: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"get_RightToLeft"
		end

	frozen get_options: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL signature (): System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.Regex"
		alias
			"get_Options"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.Regex"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.Regex"
		alias
			"ToString"
		end

	frozen is_match_string_string_regex_options (input: SYSTEM_STRING; pattern: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	frozen matches_string_string_regex_options (input: SYSTEM_STRING; pattern: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS): SYSTEM_DLL_MATCH_COLLECTION is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen match (input: SYSTEM_STRING): SYSTEM_DLL_MATCH is
		external
			"IL signature (System.String): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen match_string_int32_int32 (input: SYSTEM_STRING; beginning: INTEGER; length: INTEGER): SYSTEM_DLL_MATCH is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen split_string_int32 (input: SYSTEM_STRING; count: INTEGER): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String, System.Int32): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen split_string_int32_int32 (input: SYSTEM_STRING; count: INTEGER; startat: INTEGER): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen group_name_from_number (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"GroupNameFromNumber"
		end

	frozen compile_to_assembly_array_regex_compilation_info_assembly_name_array_custom_attribute_builder (regexinfos: NATIVE_ARRAY [SYSTEM_DLL_REGEX_COMPILATION_INFO]; assemblyname: ASSEMBLY_NAME; attributes: NATIVE_ARRAY [CUSTOM_ATTRIBUTE_BUILDER]) is
		external
			"IL static signature (System.Text.RegularExpressions.RegexCompilationInfo[], System.Reflection.AssemblyName, System.Reflection.Emit.CustomAttributeBuilder[]): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"CompileToAssembly"
		end

	frozen replace_string_string_match_evaluator (input: SYSTEM_STRING; pattern: SYSTEM_STRING; evaluator: SYSTEM_DLL_MATCH_EVALUATOR): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.MatchEvaluator): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen compile_to_assembly_array_regex_compilation_info_assembly_name_array_custom_attribute_builder_string (regexinfos: NATIVE_ARRAY [SYSTEM_DLL_REGEX_COMPILATION_INFO]; assemblyname: ASSEMBLY_NAME; attributes: NATIVE_ARRAY [CUSTOM_ATTRIBUTE_BUILDER]; resource_file: SYSTEM_STRING) is
		external
			"IL static signature (System.Text.RegularExpressions.RegexCompilationInfo[], System.Reflection.AssemblyName, System.Reflection.Emit.CustomAttributeBuilder[], System.String): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"CompileToAssembly"
		end

	frozen match_string_int32 (input: SYSTEM_STRING; startat: INTEGER): SYSTEM_DLL_MATCH is
		external
			"IL signature (System.String, System.Int32): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen get_group_numbers: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Text.RegularExpressions.Regex"
		alias
			"GetGroupNumbers"
		end

	frozen replace_string_string_string (input: SYSTEM_STRING; pattern: SYSTEM_STRING; replacement: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String, System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen matches_string_int32 (input: SYSTEM_STRING; startat: INTEGER): SYSTEM_DLL_MATCH_COLLECTION is
		external
			"IL signature (System.String, System.Int32): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen replace_string_match_evaluator_int32 (input: SYSTEM_STRING; evaluator: SYSTEM_DLL_MATCH_EVALUATOR; count: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Text.RegularExpressions.MatchEvaluator, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen replace_string_match_evaluator (input: SYSTEM_STRING; evaluator: SYSTEM_DLL_MATCH_EVALUATOR): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Text.RegularExpressions.MatchEvaluator): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen replace_string_string_int32 (input: SYSTEM_STRING; replacement: SYSTEM_STRING; count: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen compile_to_assembly (regexinfos: NATIVE_ARRAY [SYSTEM_DLL_REGEX_COMPILATION_INFO]; assemblyname: ASSEMBLY_NAME) is
		external
			"IL static signature (System.Text.RegularExpressions.RegexCompilationInfo[], System.Reflection.AssemblyName): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"CompileToAssembly"
		end

	frozen replace_string_string_match_evaluator_regex_options (input: SYSTEM_STRING; pattern: SYSTEM_STRING; evaluator: SYSTEM_DLL_MATCH_EVALUATOR; options: SYSTEM_DLL_REGEX_OPTIONS): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.MatchEvaluator, System.Text.RegularExpressions.RegexOptions): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen unescape (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Unescape"
		end

	frozen matches (input: SYSTEM_STRING): SYSTEM_DLL_MATCH_COLLECTION is
		external
			"IL signature (System.String): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen is_match_string_int32 (input: SYSTEM_STRING; startat: INTEGER): BOOLEAN is
		external
			"IL signature (System.String, System.Int32): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	frozen replace_string_string_int32_int32 (input: SYSTEM_STRING; replacement: SYSTEM_STRING; count: INTEGER; startat: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen matches_string_string (input: SYSTEM_STRING; pattern: SYSTEM_STRING): SYSTEM_DLL_MATCH_COLLECTION is
		external
			"IL static signature (System.String, System.String): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen replace_string_match_evaluator_int32_int32 (input: SYSTEM_STRING; evaluator: SYSTEM_DLL_MATCH_EVALUATOR; count: INTEGER; startat: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Text.RegularExpressions.MatchEvaluator, System.Int32, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen split (input: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen replace_string_string_string_regex_options (input: SYSTEM_STRING; pattern: SYSTEM_STRING; replacement: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen split_string_string (input: SYSTEM_STRING; pattern: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen group_number_from_name (name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.RegularExpressions.Regex"
		alias
			"GroupNumberFromName"
		end

	frozen is_match_string_string (input: SYSTEM_STRING; pattern: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	frozen split_string_string_regex_options (input: SYSTEM_STRING; pattern: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen match_string_string_regex_options (input: SYSTEM_STRING; pattern: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS): SYSTEM_DLL_MATCH is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen replace (input: SYSTEM_STRING; replacement: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen get_group_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"GetGroupNames"
		end

	frozen is_match (input: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"Equals"
		end

	frozen escape (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Escape"
		end

	frozen match_string_string (input: SYSTEM_STRING; pattern: SYSTEM_STRING): SYSTEM_DLL_MATCH is
		external
			"IL static signature (System.String, System.String): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

feature {NONE} -- Implementation

	frozen use_option_c: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"UseOptionC"
		end

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"Finalize"
		end

	frozen initialize_references is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"InitializeReferences"
		end

	frozen use_option_r: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"UseOptionR"
		end

end -- class SYSTEM_DLL_REGEX
