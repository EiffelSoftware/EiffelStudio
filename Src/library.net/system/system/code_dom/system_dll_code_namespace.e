indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeNamespace"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_NAMESPACE

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_namespace,
	make_system_dll_code_namespace_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_namespace is
		external
			"IL creator use System.CodeDom.CodeNamespace"
		end

	frozen make_system_dll_code_namespace_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeNamespace"
		end

feature -- Access

	frozen get_types: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeDeclarationCollection use System.CodeDom.CodeNamespace"
		alias
			"get_Types"
		end

	frozen get_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeCommentStatementCollection use System.CodeDom.CodeNamespace"
		alias
			"get_Comments"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeNamespace"
		alias
			"get_Name"
		end

	frozen get_imports: SYSTEM_DLL_CODE_NAMESPACE_IMPORT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeNamespaceImportCollection use System.CodeDom.CodeNamespace"
		alias
			"get_Imports"
		end

feature -- Element Change

	frozen add_populate_comments (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"add_PopulateComments"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeNamespace"
		alias
			"set_Name"
		end

	frozen remove_populate_comments (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"remove_PopulateComments"
		end

	frozen remove_populate_imports (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"remove_PopulateImports"
		end

	frozen add_populate_imports (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"add_PopulateImports"
		end

	frozen add_populate_types (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"add_PopulateTypes"
		end

	frozen remove_populate_types (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeNamespace"
		alias
			"remove_PopulateTypes"
		end

end -- class SYSTEM_DLL_CODE_NAMESPACE
