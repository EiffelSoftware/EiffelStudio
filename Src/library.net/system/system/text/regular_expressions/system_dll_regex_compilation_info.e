indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.RegexCompilationInfo"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_REGEX_COMPILATION_INFO

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (pattern: SYSTEM_STRING; options: SYSTEM_DLL_REGEX_OPTIONS; name: SYSTEM_STRING; fullnamespace: SYSTEM_STRING; ispublic: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Text.RegularExpressions.RegexOptions, System.String, System.String, System.Boolean) use System.Text.RegularExpressions.RegexCompilationInfo"
		end

feature -- Access

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Namespace"
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_IsPublic"
		end

	frozen get_pattern: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Pattern"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Name"
		end

	frozen get_options: SYSTEM_DLL_REGEX_OPTIONS is
		external
			"IL signature (): System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Options"
		end

feature -- Element Change

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Namespace"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Name"
		end

	frozen set_options (value: SYSTEM_DLL_REGEX_OPTIONS) is
		external
			"IL signature (System.Text.RegularExpressions.RegexOptions): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Options"
		end

	frozen set_pattern (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Pattern"
		end

	frozen set_is_public (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_IsPublic"
		end

end -- class SYSTEM_DLL_REGEX_COMPILATION_INFO
