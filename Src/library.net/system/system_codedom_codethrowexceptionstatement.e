indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeThrowExceptionStatement"

external class
	SYSTEM_CODEDOM_CODETHROWEXCEPTIONSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codethrowexceptionstatement,
	make_codethrowexceptionstatement_1

feature {NONE} -- Initialization

	frozen make_codethrowexceptionstatement is
		external
			"IL creator use System.CodeDom.CodeThrowExceptionStatement"
		end

	frozen make_codethrowexceptionstatement_1 (to_throw: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeThrowExceptionStatement"
		end

feature -- Access

	frozen get_to_throw: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeThrowExceptionStatement"
		alias
			"get_ToThrow"
		end

feature -- Element Change

	frozen set_to_throw (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeThrowExceptionStatement"
		alias
			"set_ToThrow"
		end

end -- class SYSTEM_CODEDOM_CODETHROWEXCEPTIONSTATEMENT
