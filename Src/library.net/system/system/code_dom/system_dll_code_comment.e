indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeComment"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_COMMENT

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_comment_1,
	make_system_dll_code_comment_2,
	make_system_dll_code_comment

feature {NONE} -- Initialization

	frozen make_system_dll_code_comment_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeComment"
		end

	frozen make_system_dll_code_comment_2 (text: SYSTEM_STRING; doc_comment: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.CodeDom.CodeComment"
		end

	frozen make_system_dll_code_comment is
		external
			"IL creator use System.CodeDom.CodeComment"
		end

feature -- Access

	frozen get_doc_comment: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeComment"
		alias
			"get_DocComment"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeComment"
		alias
			"get_Text"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeComment"
		alias
			"set_Text"
		end

	frozen set_doc_comment (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeComment"
		alias
			"set_DocComment"
		end

end -- class SYSTEM_DLL_CODE_COMMENT
