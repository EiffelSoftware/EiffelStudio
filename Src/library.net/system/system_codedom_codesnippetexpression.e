indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeSnippetExpression"

external class
	SYSTEM_CODEDOM_CODESNIPPETEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codesnippetexpression_1,
	make_codesnippetexpression

feature {NONE} -- Initialization

	frozen make_codesnippetexpression_1 (value: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetExpression"
		end

	frozen make_codesnippetexpression is
		external
			"IL creator use System.CodeDom.CodeSnippetExpression"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetExpression"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetExpression"
		alias
			"set_Value"
		end

end -- class SYSTEM_CODEDOM_CODESNIPPETEXPRESSION
