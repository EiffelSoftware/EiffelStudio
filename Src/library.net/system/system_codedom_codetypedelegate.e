indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeDelegate"

external class
	SYSTEM_CODEDOM_CODETYPEDELEGATE

inherit
	SYSTEM_CODEDOM_CODETYPEDECLARATION

create
	make_codetypedelegate_1,
	make_codetypedelegate

feature {NONE} -- Initialization

	frozen make_codetypedelegate_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeDelegate"
		end

	frozen make_codetypedelegate is
		external
			"IL creator use System.CodeDom.CodeTypeDelegate"
		end

feature -- Access

	frozen get_return_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeDelegate"
		alias
			"get_ReturnType"
		end

	frozen get_parameters: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeParameterDeclarationExpressionCollection use System.CodeDom.CodeTypeDelegate"
		alias
			"get_Parameters"
		end

feature -- Element Change

	frozen set_return_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeDelegate"
		alias
			"set_ReturnType"
		end

end -- class SYSTEM_CODEDOM_CODETYPEDELEGATE
