indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeVariableReferenceExpression"

external class
	SYSTEM_CODEDOM_CODEVARIABLEREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codevariablereferenceexpression,
	make_codevariablereferenceexpression_1

feature {NONE} -- Initialization

	frozen make_codevariablereferenceexpression is
		external
			"IL creator use System.CodeDom.CodeVariableReferenceExpression"
		end

	frozen make_codevariablereferenceexpression_1 (variable_name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeVariableReferenceExpression"
		end

feature -- Access

	frozen get_variable_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeVariableReferenceExpression"
		alias
			"get_VariableName"
		end

feature -- Element Change

	frozen set_variable_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeVariableReferenceExpression"
		alias
			"set_VariableName"
		end

end -- class SYSTEM_CODEDOM_CODEVARIABLEREFERENCEEXPRESSION
