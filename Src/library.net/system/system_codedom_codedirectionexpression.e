indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeDirectionExpression"

external class
	SYSTEM_CODEDOM_CODEDIRECTIONEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codedirectionexpression_1,
	make_codedirectionexpression

feature {NONE} -- Initialization

	frozen make_codedirectionexpression_1 (direction: SYSTEM_CODEDOM_FIELDDIRECTION; expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.FieldDirection, System.CodeDom.CodeExpression) use System.CodeDom.CodeDirectionExpression"
		end

	frozen make_codedirectionexpression is
		external
			"IL creator use System.CodeDom.CodeDirectionExpression"
		end

feature -- Access

	frozen get_direction: SYSTEM_CODEDOM_FIELDDIRECTION is
		external
			"IL signature (): System.CodeDom.FieldDirection use System.CodeDom.CodeDirectionExpression"
		alias
			"get_Direction"
		end

	frozen get_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeDirectionExpression"
		alias
			"get_Expression"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeDirectionExpression"
		alias
			"set_Expression"
		end

	frozen set_direction (value: SYSTEM_CODEDOM_FIELDDIRECTION) is
		external
			"IL signature (System.CodeDom.FieldDirection): System.Void use System.CodeDom.CodeDirectionExpression"
		alias
			"set_Direction"
		end

end -- class SYSTEM_CODEDOM_CODEDIRECTIONEXPRESSION
