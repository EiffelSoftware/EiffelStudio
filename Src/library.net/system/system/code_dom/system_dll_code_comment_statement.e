indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeCommentStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_COMMENT_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_comment_statement_2,
	make_system_dll_code_comment_statement,
	make_system_dll_code_comment_statement_3,
	make_system_dll_code_comment_statement_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_comment_statement_2 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeCommentStatement"
		end

	frozen make_system_dll_code_comment_statement is
		external
			"IL creator use System.CodeDom.CodeCommentStatement"
		end

	frozen make_system_dll_code_comment_statement_3 (text: SYSTEM_STRING; doc_comment: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.CodeDom.CodeCommentStatement"
		end

	frozen make_system_dll_code_comment_statement_1 (comment: SYSTEM_DLL_CODE_COMMENT) is
		external
			"IL creator signature (System.CodeDom.CodeComment) use System.CodeDom.CodeCommentStatement"
		end

feature -- Access

	frozen get_comment: SYSTEM_DLL_CODE_COMMENT is
		external
			"IL signature (): System.CodeDom.CodeComment use System.CodeDom.CodeCommentStatement"
		alias
			"get_Comment"
		end

feature -- Element Change

	frozen set_comment (value: SYSTEM_DLL_CODE_COMMENT) is
		external
			"IL signature (System.CodeDom.CodeComment): System.Void use System.CodeDom.CodeCommentStatement"
		alias
			"set_Comment"
		end

end -- class SYSTEM_DLL_CODE_COMMENT_STATEMENT
