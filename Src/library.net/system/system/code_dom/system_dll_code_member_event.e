indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMemberEvent"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_MEMBER_EVENT

inherit
	SYSTEM_DLL_CODE_TYPE_MEMBER

create
	make_system_dll_code_member_event

feature {NONE} -- Initialization

	frozen make_system_dll_code_member_event is
		external
			"IL creator use System.CodeDom.CodeMemberEvent"
		end

feature -- Access

	frozen get_implementation_types: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeReferenceCollection use System.CodeDom.CodeMemberEvent"
		alias
			"get_ImplementationTypes"
		end

	frozen get_private_implementation_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberEvent"
		alias
			"get_PrivateImplementationType"
		end

	frozen get_type_code_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberEvent"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberEvent"
		alias
			"set_Type"
		end

	frozen set_private_implementation_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberEvent"
		alias
			"set_PrivateImplementationType"
		end

end -- class SYSTEM_DLL_CODE_MEMBER_EVENT
