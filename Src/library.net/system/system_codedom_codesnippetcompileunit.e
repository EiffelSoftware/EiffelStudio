indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeSnippetCompileUnit"

external class
	SYSTEM_CODEDOM_CODESNIPPETCOMPILEUNIT

inherit
	SYSTEM_CODEDOM_CODECOMPILEUNIT

create
	make_codesnippetcompileunit

feature {NONE} -- Initialization

	frozen make_codesnippetcompileunit (value: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetCompileUnit"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_CODEDOM_CODELINEPRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"get_LinePragma"
		end

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_CODEDOM_CODELINEPRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"set_LinePragma"
		end

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"set_Value"
		end

end -- class SYSTEM_CODEDOM_CODESNIPPETCOMPILEUNIT
