indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeObjectCreateExpression"

external class
	SYSTEM_CODEDOM_CODEOBJECTCREATEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codeobjectcreateexpression_3,
	make_codeobjectcreateexpression_1,
	make_codeobjectcreateexpression,
	make_codeobjectcreateexpression_2

feature {NONE} -- Initialization

	frozen make_codeobjectcreateexpression_3 (create_type: SYSTEM_TYPE; parameters: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeObjectCreateExpression"
		end

	frozen make_codeobjectcreateexpression_1 (create_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; parameters: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeObjectCreateExpression"
		end

	frozen make_codeobjectcreateexpression is
		external
			"IL creator use System.CodeDom.CodeObjectCreateExpression"
		end

	frozen make_codeobjectcreateexpression_2 (create_type: STRING; parameters: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeObjectCreateExpression"
		end

feature -- Access

	frozen get_parameters: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeObjectCreateExpression"
		alias
			"get_Parameters"
		end

	frozen get_create_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeObjectCreateExpression"
		alias
			"get_CreateType"
		end

feature -- Element Change

	frozen set_create_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeObjectCreateExpression"
		alias
			"set_CreateType"
		end

end -- class SYSTEM_CODEDOM_CODEOBJECTCREATEEXPRESSION
