indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeRemoveEventStatement"

external class
	SYSTEM_CODEDOM_CODEREMOVEEVENTSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_coderemoveeventstatement_2,
	make_coderemoveeventstatement,
	make_coderemoveeventstatement_1

feature {NONE} -- Initialization

	frozen make_coderemoveeventstatement_2 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; event_name: STRING; listener: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeRemoveEventStatement"
		end

	frozen make_coderemoveeventstatement is
		external
			"IL creator use System.CodeDom.CodeRemoveEventStatement"
		end

	frozen make_coderemoveeventstatement_1 (event_ref: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION; listener: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeEventReferenceExpression, System.CodeDom.CodeExpression) use System.CodeDom.CodeRemoveEventStatement"
		end

feature -- Access

	frozen get_listener: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeRemoveEventStatement"
		alias
			"get_Listener"
		end

	frozen get_event: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeEventReferenceExpression use System.CodeDom.CodeRemoveEventStatement"
		alias
			"get_Event"
		end

feature -- Element Change

	frozen set_event (value: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeEventReferenceExpression): System.Void use System.CodeDom.CodeRemoveEventStatement"
		alias
			"set_Event"
		end

	frozen set_listener (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeRemoveEventStatement"
		alias
			"set_Listener"
		end

end -- class SYSTEM_CODEDOM_CODEREMOVEEVENTSTATEMENT
