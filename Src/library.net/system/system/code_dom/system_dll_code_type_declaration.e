indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeDeclaration"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_DECLARATION

inherit
	SYSTEM_DLL_CODE_TYPE_MEMBER

create
	make_system_dll_code_type_declaration,
	make_system_dll_code_type_declaration_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_declaration is
		external
			"IL creator use System.CodeDom.CodeTypeDeclaration"
		end

	frozen make_system_dll_code_type_declaration_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeDeclaration"
		end

feature -- Access

	frozen get_base_types: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeReferenceCollection use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_BaseTypes"
		end

	frozen get_is_interface: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_IsInterface"
		end

	frozen get_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeMemberCollection use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_Members"
		end

	frozen get_is_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_IsClass"
		end

	frozen get_type_attributes: TYPE_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.TypeAttributes use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_TypeAttributes"
		end

	frozen get_is_enum: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_IsEnum"
		end

	frozen get_is_struct: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeTypeDeclaration"
		alias
			"get_IsStruct"
		end

feature -- Element Change

	frozen set_is_class (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"set_IsClass"
		end

	frozen set_type_attributes (value: TYPE_ATTRIBUTES) is
		external
			"IL signature (System.Reflection.TypeAttributes): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"set_TypeAttributes"
		end

	frozen set_is_interface (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"set_IsInterface"
		end

	frozen add_populate_members (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"add_PopulateMembers"
		end

	frozen remove_populate_base_types (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"remove_PopulateBaseTypes"
		end

	frozen set_is_enum (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"set_IsEnum"
		end

	frozen remove_populate_members (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"remove_PopulateMembers"
		end

	frozen set_is_struct (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"set_IsStruct"
		end

	frozen add_populate_base_types (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"add_PopulateBaseTypes"
		end

end -- class SYSTEM_DLL_CODE_TYPE_DECLARATION
