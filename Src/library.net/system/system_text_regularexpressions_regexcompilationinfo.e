indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.RegexCompilationInfo"

external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXCOMPILATIONINFO

create
	make

feature {NONE} -- Initialization

	frozen make (pat: STRING; opts: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS; n: STRING; ns: STRING; pub: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Text.RegularExpressions.RegexOptions, System.String, System.String, System.Boolean) use System.Text.RegularExpressions.RegexCompilationInfo"
		end

feature -- Access

	frozen get_namespace: STRING is
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

	frozen get_pattern: STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Pattern"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Name"
		end

	frozen get_options: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS is
		external
			"IL signature (): System.Text.RegularExpressions.RegexOptions use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"get_Options"
		end

feature -- Element Change

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Namespace"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Name"
		end

	frozen set_options (value: SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXOPTIONS) is
		external
			"IL signature (System.Text.RegularExpressions.RegexOptions): System.Void use System.Text.RegularExpressions.RegexCompilationInfo"
		alias
			"set_Options"
		end

	frozen set_pattern (value: STRING) is
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

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_REGEXCOMPILATIONINFO
