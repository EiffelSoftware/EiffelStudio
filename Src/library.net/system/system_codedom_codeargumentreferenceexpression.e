indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeArgumentReferenceExpression"

external class
	SYSTEM_CODEDOM_CODEARGUMENTREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codeargumentreferenceexpression,
	make_codeargumentreferenceexpression_1

feature {NONE} -- Initialization

	frozen make_codeargumentreferenceexpression is
		external
			"IL creator use System.CodeDom.CodeArgumentReferenceExpression"
		end

	frozen make_codeargumentreferenceexpression_1 (parameter_name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeArgumentReferenceExpression"
		end

feature -- Access

	frozen get_parameter_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeArgumentReferenceExpression"
		alias
			"get_ParameterName"
		end

feature -- Element Change

	frozen set_parameter_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeArgumentReferenceExpression"
		alias
			"set_ParameterName"
		end

end -- class SYSTEM_CODEDOM_CODEARGUMENTREFERENCEEXPRESSION
