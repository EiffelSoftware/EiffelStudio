indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeVariableDeclarationStatement"

external class
	SYSTEM_CODEDOM_CODEVARIABLEDECLARATIONSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codevariabledeclarationstatement_6,
	make_codevariabledeclarationstatement,
	make_codevariabledeclarationstatement_5,
	make_codevariabledeclarationstatement_2,
	make_codevariabledeclarationstatement_3,
	make_codevariabledeclarationstatement_1,
	make_codevariabledeclarationstatement_4

feature {NONE} -- Initialization

	frozen make_codevariabledeclarationstatement_6 (type: SYSTEM_TYPE; name: STRING; init_expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.Type, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_codevariabledeclarationstatement is
		external
			"IL creator use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_codevariabledeclarationstatement_5 (type: STRING; name: STRING; init_expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.String, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_codevariabledeclarationstatement_2 (type: STRING; name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_codevariabledeclarationstatement_3 (type: SYSTEM_TYPE; name: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_codevariabledeclarationstatement_1 (type: SYSTEM_CODEDOM_CODETYPEREFERENCE; name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_codevariabledeclarationstatement_4 (type: SYSTEM_CODEDOM_CODETYPEREFERENCE; name: STRING; init_expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeVariableDeclarationStatement"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"get_Name"
		end

	frozen get_type_code_type_reference: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"get_Type"
		end

	frozen get_init_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"get_InitExpression"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"set_Name"
		end

	frozen set_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"set_Type"
		end

	frozen set_init_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"set_InitExpression"
		end

end -- class SYSTEM_CODEDOM_CODEVARIABLEDECLARATIONSTATEMENT
