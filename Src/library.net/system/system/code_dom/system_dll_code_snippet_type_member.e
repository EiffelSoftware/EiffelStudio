indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeSnippetTypeMember"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER

inherit
	SYSTEM_DLL_CODE_TYPE_MEMBER

create
	make_system_dll_code_snippet_type_member,
	make_system_dll_code_snippet_type_member_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_snippet_type_member is
		external
			"IL creator use System.CodeDom.CodeSnippetTypeMember"
		end

	frozen make_system_dll_code_snippet_type_member_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetTypeMember"
		end

feature -- Access

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetTypeMember"
		alias
			"get_Text"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetTypeMember"
		alias
			"set_Text"
		end

end -- class SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER
