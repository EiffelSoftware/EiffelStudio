indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeMemberEvent"

external class
	SYSTEM_CODEDOM_CODEMEMBEREVENT

inherit
	SYSTEM_CODEDOM_CODETYPEMEMBER

create
	make_codememberevent

feature {NONE} -- Initialization

	frozen make_codememberevent is
		external
			"IL creator use System.CodeDom.CodeMemberEvent"
		end

feature -- Access

	frozen get_implementation_types: SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeReferenceCollection use System.CodeDom.CodeMemberEvent"
		alias
			"get_ImplementationTypes"
		end

	frozen get_private_implementation_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberEvent"
		alias
			"get_PrivateImplementationType"
		end

	frozen get_type_code_type_reference: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberEvent"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberEvent"
		alias
			"set_Type"
		end

	frozen set_private_implementation_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberEvent"
		alias
			"set_PrivateImplementationType"
		end

end -- class SYSTEM_CODEDOM_CODEMEMBEREVENT
