indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeSnippetTypeMember"

external class
	SYSTEM_CODEDOM_CODESNIPPETTYPEMEMBER

inherit
	SYSTEM_CODEDOM_CODETYPEMEMBER

create
	make_codesnippettypemember,
	make_codesnippettypemember_1

feature {NONE} -- Initialization

	frozen make_codesnippettypemember is
		external
			"IL creator use System.CodeDom.CodeSnippetTypeMember"
		end

	frozen make_codesnippettypemember_1 (text: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetTypeMember"
		end

feature -- Access

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetTypeMember"
		alias
			"get_Text"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetTypeMember"
		alias
			"set_Text"
		end

end -- class SYSTEM_CODEDOM_CODESNIPPETTYPEMEMBER
