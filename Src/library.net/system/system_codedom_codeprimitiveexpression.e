indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodePrimitiveExpression"

external class
	SYSTEM_CODEDOM_CODEPRIMITIVEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codeprimitiveexpression_1,
	make_codeprimitiveexpression

feature {NONE} -- Initialization

	frozen make_codeprimitiveexpression_1 (value: ANY) is
		external
			"IL creator signature (System.Object) use System.CodeDom.CodePrimitiveExpression"
		end

	frozen make_codeprimitiveexpression is
		external
			"IL creator use System.CodeDom.CodePrimitiveExpression"
		end

feature -- Access

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.CodeDom.CodePrimitiveExpression"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.CodePrimitiveExpression"
		alias
			"set_Value"
		end

end -- class SYSTEM_CODEDOM_CODEPRIMITIVEEXPRESSION
