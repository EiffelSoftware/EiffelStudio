indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.LanguageOptions"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_LANGUAGE_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen none: SYSTEM_DLL_LANGUAGE_OPTIONS is
		external
			"IL enum signature :System.CodeDom.Compiler.LanguageOptions use System.CodeDom.Compiler.LanguageOptions"
		alias
			"0"
		end

	frozen case_insensitive: SYSTEM_DLL_LANGUAGE_OPTIONS is
		external
			"IL enum signature :System.CodeDom.Compiler.LanguageOptions use System.CodeDom.Compiler.LanguageOptions"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DLL_LANGUAGE_OPTIONS
