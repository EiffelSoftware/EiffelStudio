indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeNamespace"

external class
	SYSTEM_CODEDOM_CODENAMESPACE

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codenamespace,
	make_codenamespace_1

feature {NONE} -- Initialization

	frozen make_codenamespace is
		external
			"IL creator use System.CodeDom.CodeNamespace"
		end

	frozen make_codenamespace_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeNamespace"
		end

feature -- Access

	frozen get_types: SYSTEM_CODEDOM_CODETYPEDECLARATIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeDeclarationCollection use System.CodeDom.CodeNamespace"
		alias
			"get_Types"
		end

	frozen get_comments: SYSTEM_CODEDOM_CODECOMMENTSTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeCommentStatementCollection use System.CodeDom.CodeNamespace"
		alias
			"get_Comments"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeNamespace"
		alias
			"get_Name"
		end

	frozen get_imports: SYSTEM_CODEDOM_CODENAMESPACEIMPORTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeNamespaceImportCollection use System.CodeDom.CodeNamespace"
		alias
			"get_Imports"
		end

feature -- Element Change

	frozen add_populate_comments (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"add_PopulateComments"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeNamespace"
		alias
			"set_Name"
		end

	frozen remove_populate_comments (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"remove_PopulateComments"
		end

	frozen remove_populate_imports (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"remove_PopulateImports"
		end

	frozen add_populate_imports (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"add_PopulateImports"
		end

	frozen add_populate_types (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"add_PopulateTypes"
		end

	frozen remove_populate_types (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"remove_PopulateTypes"
		end

end -- class SYSTEM_CODEDOM_CODENAMESPACE
