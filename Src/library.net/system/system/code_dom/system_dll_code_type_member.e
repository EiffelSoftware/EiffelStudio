indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeMember"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_MEMBER

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_type_member

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_member is
		external
			"IL creator use System.CodeDom.CodeTypeMember"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeTypeMember"
		alias
			"get_LinePragma"
		end

	frozen get_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeTypeMember"
		alias
			"get_CustomAttributes"
		end

	frozen get_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeCommentStatementCollection use System.CodeDom.CodeTypeMember"
		alias
			"get_Comments"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeTypeMember"
		alias
			"get_Name"
		end

	frozen get_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES is
		external
			"IL signature (): System.CodeDom.MemberAttributes use System.CodeDom.CodeTypeMember"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_DLL_CODE_LINE_PRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_LinePragma"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_Name"
		end

	frozen set_custom_attributes (value: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_CustomAttributes"
		end

	frozen set_attributes (value: SYSTEM_DLL_MEMBER_ATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_Attributes"
		end

end -- class SYSTEM_DLL_CODE_TYPE_MEMBER
