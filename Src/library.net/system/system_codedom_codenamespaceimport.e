indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeNamespaceImport"

external class
	SYSTEM_CODEDOM_CODENAMESPACEIMPORT

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codenamespaceimport_1,
	make_codenamespaceimport

feature {NONE} -- Initialization

	frozen make_codenamespaceimport_1 (name_space: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeNamespaceImport"
		end

	frozen make_codenamespaceimport is
		external
			"IL creator use System.CodeDom.CodeNamespaceImport"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_CODEDOM_CODELINEPRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeNamespaceImport"
		alias
			"get_LinePragma"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeNamespaceImport"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_CODEDOM_CODELINEPRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeNamespaceImport"
		alias
			"set_LinePragma"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeNamespaceImport"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_CODEDOM_CODENAMESPACEIMPORT
