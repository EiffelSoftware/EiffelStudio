indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeSnippetStatement"

external class
	SYSTEM_CODEDOM_CODESNIPPETSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codesnippetstatement_1,
	make_codesnippetstatement

feature {NONE} -- Initialization

	frozen make_codesnippetstatement_1 (value: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetStatement"
		end

	frozen make_codesnippetstatement is
		external
			"IL creator use System.CodeDom.CodeSnippetStatement"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetStatement"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetStatement"
		alias
			"set_Value"
		end

end -- class SYSTEM_CODEDOM_CODESNIPPETSTATEMENT
