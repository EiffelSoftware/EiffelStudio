indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeCompileUnit"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_COMPILE_UNIT

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_compile_unit

feature {NONE} -- Initialization

	frozen make_system_dll_code_compile_unit is
		external
			"IL creator use System.CodeDom.CodeCompileUnit"
		end

feature -- Access

	frozen get_assembly_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeCompileUnit"
		alias
			"get_AssemblyCustomAttributes"
		end

	frozen get_referenced_assemblies: SYSTEM_DLL_STRING_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.StringCollection use System.CodeDom.CodeCompileUnit"
		alias
			"get_ReferencedAssemblies"
		end

	frozen get_namespaces: SYSTEM_DLL_CODE_NAMESPACE_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeNamespaceCollection use System.CodeDom.CodeCompileUnit"
		alias
			"get_Namespaces"
		end

end -- class SYSTEM_DLL_CODE_COMPILE_UNIT
