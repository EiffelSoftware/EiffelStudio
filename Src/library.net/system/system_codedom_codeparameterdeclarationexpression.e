indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeParameterDeclarationExpression"

external class
	SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codeparameterdeclarationexpression_2,
	make_codeparameterdeclarationexpression_3,
	make_codeparameterdeclarationexpression_1,
	make_codeparameterdeclarationexpression

feature {NONE} -- Initialization

	frozen make_codeparameterdeclarationexpression_2 (type: STRING; name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.CodeDom.CodeParameterDeclarationExpression"
		end

	frozen make_codeparameterdeclarationexpression_3 (type: SYSTEM_TYPE; name: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.CodeDom.CodeParameterDeclarationExpression"
		end

	frozen make_codeparameterdeclarationexpression_1 (type: SYSTEM_CODEDOM_CODETYPEREFERENCE; name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String) use System.CodeDom.CodeParameterDeclarationExpression"
		end

	frozen make_codeparameterdeclarationexpression is
		external
			"IL creator use System.CodeDom.CodeParameterDeclarationExpression"
		end

feature -- Access

	frozen get_direction: SYSTEM_CODEDOM_FIELDDIRECTION is
		external
			"IL signature (): System.CodeDom.FieldDirection use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_Direction"
		end

	frozen get_custom_attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_CustomAttributes"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_Name"
		end

	frozen get_type_code_type_reference: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_Name"
		end

	frozen set_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_Type"
		end

	frozen set_direction (value: SYSTEM_CODEDOM_FIELDDIRECTION) is
		external
			"IL signature (System.CodeDom.FieldDirection): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_Direction"
		end

	frozen set_custom_attributes (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_CustomAttributes"
		end

end -- class SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION
