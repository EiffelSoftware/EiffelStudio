indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.Regex"

external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (pattern: STRING) is
		external
			"IL creator signature (System.String) use System.Text.RegularExpressions.Regex"
		end

	frozen make_1 (pattern: STRING; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS) is
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

	frozen get_options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.Regex"
		alias
			"ToString"
		end

	frozen is_match_string_string_regex_options (input: STRING; pattern: STRING; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	frozen matches_string_string_regex_options (input: STRING; pattern: STRING; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHCOLLECTION is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen match (input: STRING): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL signature (System.String): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen match_string_int32_int32 (input: STRING; beginning: INTEGER; length: INTEGER): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen split_string_int32 (input: STRING; count: INTEGER): ARRAY [STRING] is
		external
			"IL signature (System.String, System.Int32): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen split_string_int32_int32 (input: STRING; count: INTEGER; startat: INTEGER): ARRAY [STRING] is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen group_name_from_number (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"GroupNameFromNumber"
		end

	frozen compile_to_assembly_array_regex_compilation_info_assembly_name_array_custom_attribute_builder (regexes: ARRAY [SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXCOMPILATIONINFO]; aname: SYSTEM_REFLECTION_ASSEMBLYNAME; attribs: ARRAY [SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER]) is
		external
			"IL static signature (System.Text.RegularExpressions.RegexCompilationInfo[], System.Reflection.AssemblyName, System.Reflection.Emit.CustomAttributeBuilder[]): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"CompileToAssembly"
		end

	frozen replace_string_string_match_evaluator (input: STRING; pattern: STRING; evaluator: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR): STRING is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.MatchEvaluator): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen compile_to_assembly_array_regex_compilation_info_assembly_name_array_custom_attribute_builder_string (regexes: ARRAY [SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXCOMPILATIONINFO]; aname: SYSTEM_REFLECTION_ASSEMBLYNAME; attribs: ARRAY [SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER]; resource_file: STRING) is
		external
			"IL static signature (System.Text.RegularExpressions.RegexCompilationInfo[], System.Reflection.AssemblyName, System.Reflection.Emit.CustomAttributeBuilder[], System.String): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"CompileToAssembly"
		end

	frozen match_string_int32 (input: STRING; startat: INTEGER): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL signature (System.String, System.Int32): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen get_group_numbers: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Text.RegularExpressions.Regex"
		alias
			"GetGroupNumbers"
		end

	frozen replace_string_string_string (input: STRING; pattern: STRING; replacement: STRING): STRING is
		external
			"IL static signature (System.String, System.String, System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen matches_string_int32 (input: STRING; startat: INTEGER): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHCOLLECTION is
		external
			"IL signature (System.String, System.Int32): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen replace_string_match_evaluator_int32 (input: STRING; evaluator: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR; count: INTEGER): STRING is
		external
			"IL signature (System.String, System.Text.RegularExpressions.MatchEvaluator, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen replace_string_match_evaluator (input: STRING; evaluator: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR): STRING is
		external
			"IL signature (System.String, System.Text.RegularExpressions.MatchEvaluator): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen replace_string_string_int32 (input: STRING; replacement: STRING; count: INTEGER): STRING is
		external
			"IL signature (System.String, System.String, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen compile_to_assembly (regexes: ARRAY [SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXCOMPILATIONINFO]; aname: SYSTEM_REFLECTION_ASSEMBLYNAME) is
		external
			"IL static signature (System.Text.RegularExpressions.RegexCompilationInfo[], System.Reflection.AssemblyName): System.Void use System.Text.RegularExpressions.Regex"
		alias
			"CompileToAssembly"
		end

	frozen replace_string_string_match_evaluator_regex_options (input: STRING; pattern: STRING; evaluator: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS): STRING is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.MatchEvaluator, System.Text.RegularExpressions.RegexOptions): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen unescape (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Unescape"
		end

	frozen matches (input: STRING): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHCOLLECTION is
		external
			"IL signature (System.String): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen is_match_string_int32 (input: STRING; startat: INTEGER): BOOLEAN is
		external
			"IL signature (System.String, System.Int32): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	frozen replace_string_string_int32_int32 (input: STRING; replacement: STRING; count: INTEGER; startat: INTEGER): STRING is
		external
			"IL signature (System.String, System.String, System.Int32, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen matches_string_string (input: STRING; pattern: STRING): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHCOLLECTION is
		external
			"IL static signature (System.String, System.String): System.Text.RegularExpressions.MatchCollection use System.Text.RegularExpressions.Regex"
		alias
			"Matches"
		end

	frozen replace_string_match_evaluator_int32_int32 (input: STRING; evaluator: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR; count: INTEGER; startat: INTEGER): STRING is
		external
			"IL signature (System.String, System.Text.RegularExpressions.MatchEvaluator, System.Int32, System.Int32): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen split (input: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen replace_string_string_string_regex_options (input: STRING; pattern: STRING; replacement: STRING; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS): STRING is
		external
			"IL static signature (System.String, System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen split_string_string (input: STRING; pattern: STRING): ARRAY [STRING] is
		external
			"IL static signature (System.String, System.String): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen group_number_from_name (name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.RegularExpressions.Regex"
		alias
			"GroupNumberFromName"
		end

	frozen is_match_string_string (input: STRING; pattern: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	frozen split_string_string_regex_options (input: STRING; pattern: STRING; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS): ARRAY [STRING] is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"Split"
		end

	frozen match_string_string_regex_options (input: STRING; pattern: STRING; options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
		external
			"IL static signature (System.String, System.String, System.Text.RegularExpressions.RegexOptions): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.Regex"
		alias
			"Match"
		end

	frozen replace (input: STRING; replacement: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Replace"
		end

	frozen get_group_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Text.RegularExpressions.Regex"
		alias
			"GetGroupNames"
		end

	frozen is_match (input: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"IsMatch"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.RegularExpressions.Regex"
		alias
			"Equals"
		end

	frozen escape (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Text.RegularExpressions.Regex"
		alias
			"Escape"
		end

	frozen match_string_string (input: STRING; pattern: STRING): SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH is
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

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX
