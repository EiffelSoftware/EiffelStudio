indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeCompileUnit"

external class
	SYSTEM_CODEDOM_CODECOMPILEUNIT

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codecompileunit

feature {NONE} -- Initialization

	frozen make_codecompileunit is
		external
			"IL creator use System.CodeDom.CodeCompileUnit"
		end

feature -- Access

	frozen get_assembly_custom_attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeCompileUnit"
		alias
			"get_AssemblyCustomAttributes"
		end

	frozen get_referenced_assemblies: SYSTEM_COLLECTIONS_SPECIALIZED_STRINGCOLLECTION is
		external
			"IL signature (): System.Collections.Specialized.StringCollection use System.CodeDom.CodeCompileUnit"
		alias
			"get_ReferencedAssemblies"
		end

	frozen get_namespaces: SYSTEM_CODEDOM_CODENAMESPACECOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeNamespaceCollection use System.CodeDom.CodeCompileUnit"
		alias
			"get_Namespaces"
		end

end -- class SYSTEM_CODEDOM_CODECOMPILEUNIT
