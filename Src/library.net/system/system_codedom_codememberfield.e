indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeMemberField"

external class
	SYSTEM_CODEDOM_CODEMEMBERFIELD

inherit
	SYSTEM_CODEDOM_CODETYPEMEMBER

create
	make_codememberfield_3,
	make_codememberfield_2,
	make_codememberfield_1,
	make_codememberfield

feature {NONE} -- Initialization

	frozen make_codememberfield_3 (type: SYSTEM_TYPE; name: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.CodeDom.CodeMemberField"
		end

	frozen make_codememberfield_2 (type: STRING; name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.CodeDom.CodeMemberField"
		end

	frozen make_codememberfield_1 (type: SYSTEM_CODEDOM_CODETYPEREFERENCE; name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String) use System.CodeDom.CodeMemberField"
		end

	frozen make_codememberfield is
		external
			"IL creator use System.CodeDom.CodeMemberField"
		end

feature -- Access

	frozen get_type_code_type_reference: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberField"
		alias
			"get_Type"
		end

	frozen get_init_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeMemberField"
		alias
			"get_InitExpression"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberField"
		alias
			"set_Type"
		end

	frozen set_init_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeMemberField"
		alias
			"set_InitExpression"
		end

end -- class SYSTEM_CODEDOM_CODEMEMBERFIELD
