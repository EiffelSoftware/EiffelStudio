indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeDeclaration"

external class
	SYSTEM_CODEDOM_CODETYPEDECLARATION

inherit
	SYSTEM_CODEDOM_CODETYPEMEMBER

create
	make_codetypedeclaration,
	make_codetypedeclaration_1

feature {NONE} -- Initialization

	frozen make_codetypedeclaration is
		external
			"IL creator use System.CodeDom.CodeTypeDeclaration"
		end

	frozen make_codetypedeclaration_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeDeclaration"
		end

feature -- Access

	frozen get_base_types: SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION is
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

	frozen get_members: SYSTEM_CODEDOM_CODETYPEMEMBERCOLLECTION is
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

	frozen get_type_attributes: SYSTEM_REFLECTION_TYPEATTRIBUTES is
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

	frozen set_type_attributes (value: SYSTEM_REFLECTION_TYPEATTRIBUTES) is
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

	frozen add_populate_members (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"add_PopulateMembers"
		end

	frozen remove_populate_base_types (value: SYSTEM_EVENTHANDLER) is
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

	frozen remove_populate_members (value: SYSTEM_EVENTHANDLER) is
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

	frozen add_populate_base_types (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeTypeDeclaration"
		alias
			"add_PopulateBaseTypes"
		end

end -- class SYSTEM_CODEDOM_CODETYPEDECLARATION
