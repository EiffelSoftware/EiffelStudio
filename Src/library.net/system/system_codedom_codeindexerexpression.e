indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeIndexerExpression"

external class
	SYSTEM_CODEDOM_CODEINDEXEREXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codeindexerexpression,
	make_codeindexerexpression_1

feature {NONE} -- Initialization

	frozen make_codeindexerexpression is
		external
			"IL creator use System.CodeDom.CodeIndexerExpression"
		end

	frozen make_codeindexerexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; indices: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeIndexerExpression"
		end

feature -- Access

	frozen get_indices: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeIndexerExpression"
		alias
			"get_Indices"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeIndexerExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeIndexerExpression"
		alias
			"set_TargetObject"
		end

end -- class SYSTEM_CODEDOM_CODEINDEXEREXPRESSION
