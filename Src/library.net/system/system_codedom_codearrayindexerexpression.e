indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeArrayIndexerExpression"

external class
	SYSTEM_CODEDOM_CODEARRAYINDEXEREXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codearrayindexerexpression_1,
	make_codearrayindexerexpression

feature {NONE} -- Initialization

	frozen make_codearrayindexerexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; indices: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayIndexerExpression"
		end

	frozen make_codearrayindexerexpression is
		external
			"IL creator use System.CodeDom.CodeArrayIndexerExpression"
		end

feature -- Access

	frozen get_indices: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeArrayIndexerExpression"
		alias
			"get_Indices"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeArrayIndexerExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeArrayIndexerExpression"
		alias
			"set_TargetObject"
		end

end -- class SYSTEM_CODEDOM_CODEARRAYINDEXEREXPRESSION
