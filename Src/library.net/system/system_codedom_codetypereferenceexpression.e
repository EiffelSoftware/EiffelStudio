indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeReferenceExpression"

external class
	SYSTEM_CODEDOM_CODETYPEREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codetypereferenceexpression_1,
	make_codetypereferenceexpression_2,
	make_codetypereferenceexpression,
	make_codetypereferenceexpression_3

feature {NONE} -- Initialization

	frozen make_codetypereferenceexpression_1 (type: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference) use System.CodeDom.CodeTypeReferenceExpression"
		end

	frozen make_codetypereferenceexpression_2 (type: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeReferenceExpression"
		end

	frozen make_codetypereferenceexpression is
		external
			"IL creator use System.CodeDom.CodeTypeReferenceExpression"
		end

	frozen make_codetypereferenceexpression_3 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.CodeDom.CodeTypeReferenceExpression"
		end

feature -- Access

	frozen get_type_code_type_reference: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeReferenceExpression"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceExpression"
		alias
			"set_Type"
		end

end -- class SYSTEM_CODEDOM_CODETYPEREFERENCEEXPRESSION
