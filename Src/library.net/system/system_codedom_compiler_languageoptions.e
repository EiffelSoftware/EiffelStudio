indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.LanguageOptions"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_CODEDOM_COMPILER_LANGUAGEOPTIONS

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen none: SYSTEM_CODEDOM_COMPILER_LANGUAGEOPTIONS is
		external
			"IL enum signature :System.CodeDom.Compiler.LanguageOptions use System.CodeDom.Compiler.LanguageOptions"
		alias
			"0"
		end

	frozen case_insensitive: SYSTEM_CODEDOM_COMPILER_LANGUAGEOPTIONS is
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

end -- class SYSTEM_CODEDOM_COMPILER_LANGUAGEOPTIONS
