indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeArrayCreateExpression"

external class
	SYSTEM_CODEDOM_CODEARRAYCREATEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codearraycreateexpression_8,
	make_codearraycreateexpression_9,
	make_codearraycreateexpression_2,
	make_codearraycreateexpression_3,
	make_codearraycreateexpression_1,
	make_codearraycreateexpression_6,
	make_codearraycreateexpression_7,
	make_codearraycreateexpression_4,
	make_codearraycreateexpression_5,
	make_codearraycreateexpression

feature {NONE} -- Initialization

	frozen make_codearraycreateexpression_8 (create_type: STRING; size: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_9 (create_type: SYSTEM_TYPE; size: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_2 (create_type: STRING; initializers: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_3 (create_type: SYSTEM_TYPE; initializers: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_1 (create_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; initializers: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_6 (create_type: SYSTEM_TYPE; size: INTEGER) is
		external
			"IL creator signature (System.Type, System.Int32) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_7 (create_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; size: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_4 (create_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; size: INTEGER) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.Int32) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression_5 (create_type: STRING; size: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_codearraycreateexpression is
		external
			"IL creator use System.CodeDom.CodeArrayCreateExpression"
		end

feature -- Access

	frozen get_size_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_SizeExpression"
		end

	frozen get_initializers: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_Initializers"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_Size"
		end

	frozen get_create_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_CreateType"
		end

feature -- Element Change

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeArrayCreateExpression"
		alias
			"set_Size"
		end

	frozen set_size_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeArrayCreateExpression"
		alias
			"set_SizeExpression"
		end

	frozen set_create_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeArrayCreateExpression"
		alias
			"set_CreateType"
		end

end -- class SYSTEM_CODEDOM_CODEARRAYCREATEEXPRESSION
