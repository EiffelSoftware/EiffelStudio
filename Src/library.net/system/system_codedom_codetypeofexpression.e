indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeOfExpression"

external class
	SYSTEM_CODEDOM_CODETYPEOFEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codetypeofexpression_1,
	make_codetypeofexpression_2,
	make_codetypeofexpression_3,
	make_codetypeofexpression

feature {NONE} -- Initialization

	frozen make_codetypeofexpression_1 (type: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference) use System.CodeDom.CodeTypeOfExpression"
		end

	frozen make_codetypeofexpression_2 (type: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeOfExpression"
		end

	frozen make_codetypeofexpression_3 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.CodeDom.CodeTypeOfExpression"
		end

	frozen make_codetypeofexpression is
		external
			"IL creator use System.CodeDom.CodeTypeOfExpression"
		end

feature -- Access

	frozen get_type_code_type_reference: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeOfExpression"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeOfExpression"
		alias
			"set_Type"
		end

end -- class SYSTEM_CODEDOM_CODETYPEOFEXPRESSION
