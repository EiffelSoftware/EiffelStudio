indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeCastExpression"

external class
	SYSTEM_CODEDOM_CODECASTEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codecastexpression,
	make_codecastexpression_3,
	make_codecastexpression_1,
	make_codecastexpression_2

feature {NONE} -- Initialization

	frozen make_codecastexpression is
		external
			"IL creator use System.CodeDom.CodeCastExpression"
		end

	frozen make_codecastexpression_3 (target_type: SYSTEM_TYPE; expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression) use System.CodeDom.CodeCastExpression"
		end

	frozen make_codecastexpression_1 (target_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression) use System.CodeDom.CodeCastExpression"
		end

	frozen make_codecastexpression_2 (target_type: STRING; expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeCastExpression"
		end

feature -- Access

	frozen get_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeCastExpression"
		alias
			"get_Expression"
		end

	frozen get_target_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeCastExpression"
		alias
			"get_TargetType"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeCastExpression"
		alias
			"set_Expression"
		end

	frozen set_target_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeCastExpression"
		alias
			"set_TargetType"
		end

end -- class SYSTEM_CODEDOM_CODECASTEXPRESSION
