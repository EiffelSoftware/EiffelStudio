indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeAttachEventStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_attach_event_statement_1,
	make_system_dll_code_attach_event_statement,
	make_system_dll_code_attach_event_statement_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_attach_event_statement_1 (event_ref: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION; listener: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeEventReferenceExpression, System.CodeDom.CodeExpression) use System.CodeDom.CodeAttachEventStatement"
		end

	frozen make_system_dll_code_attach_event_statement is
		external
			"IL creator use System.CodeDom.CodeAttachEventStatement"
		end

	frozen make_system_dll_code_attach_event_statement_2 (target_object: SYSTEM_DLL_CODE_EXPRESSION; event_name: SYSTEM_STRING; listener: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeAttachEventStatement"
		end

feature -- Access

	frozen get_listener: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAttachEventStatement"
		alias
			"get_Listener"
		end

	frozen get_event: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeEventReferenceExpression use System.CodeDom.CodeAttachEventStatement"
		alias
			"get_Event"
		end

feature -- Element Change

	frozen set_event (value: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeEventReferenceExpression): System.Void use System.CodeDom.CodeAttachEventStatement"
		alias
			"set_Event"
		end

	frozen set_listener (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAttachEventStatement"
		alias
			"set_Listener"
		end

end -- class SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT
