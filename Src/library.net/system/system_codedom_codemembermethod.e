indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeMemberMethod"

external class
	SYSTEM_CODEDOM_CODEMEMBERMETHOD

inherit
	SYSTEM_CODEDOM_CODETYPEMEMBER

create
	make_codemembermethod

feature {NONE} -- Initialization

	frozen make_codemembermethod is
		external
			"IL creator use System.CodeDom.CodeMemberMethod"
		end

feature -- Access

	frozen get_return_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberMethod"
		alias
			"get_ReturnType"
		end

	frozen get_parameters: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeParameterDeclarationExpressionCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_Parameters"
		end

	frozen get_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_Statements"
		end

	frozen get_private_implementation_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberMethod"
		alias
			"get_PrivateImplementationType"
		end

	frozen get_implementation_types: SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeReferenceCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_ImplementationTypes"
		end

	frozen get_return_type_custom_attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_ReturnTypeCustomAttributes"
		end

feature -- Element Change

	frozen remove_populate_implementation_types (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"remove_PopulateImplementationTypes"
		end

	frozen remove_populate_parameters (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"remove_PopulateParameters"
		end

	frozen set_private_implementation_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"set_PrivateImplementationType"
		end

	frozen add_populate_statements (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"add_PopulateStatements"
		end

	frozen add_populate_implementation_types (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"add_PopulateImplementationTypes"
		end

	frozen set_return_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"set_ReturnType"
		end

	frozen remove_populate_statements (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"remove_PopulateStatements"
		end

	frozen add_populate_parameters (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"add_PopulateParameters"
		end

end -- class SYSTEM_CODEDOM_CODEMEMBERMETHOD
