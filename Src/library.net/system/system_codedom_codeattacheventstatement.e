indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeAttachEventStatement"

external class
	SYSTEM_CODEDOM_CODEATTACHEVENTSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codeattacheventstatement,
	make_codeattacheventstatement_2,
	make_codeattacheventstatement_1

feature {NONE} -- Initialization

	frozen make_codeattacheventstatement is
		external
			"IL creator use System.CodeDom.CodeAttachEventStatement"
		end

	frozen make_codeattacheventstatement_2 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; event_name: STRING; listener: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeAttachEventStatement"
		end

	frozen make_codeattacheventstatement_1 (event_ref: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION; listener: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeEventReferenceExpression, System.CodeDom.CodeExpression) use System.CodeDom.CodeAttachEventStatement"
		end

feature -- Access

	frozen get_listener: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAttachEventStatement"
		alias
			"get_Listener"
		end

	frozen get_event: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeEventReferenceExpression use System.CodeDom.CodeAttachEventStatement"
		alias
			"get_Event"
		end

feature -- Element Change

	frozen set_event (value: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeEventReferenceExpression): System.Void use System.CodeDom.CodeAttachEventStatement"
		alias
			"set_Event"
		end

	frozen set_listener (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAttachEventStatement"
		alias
			"set_Listener"
		end

end -- class SYSTEM_CODEDOM_CODEATTACHEVENTSTATEMENT
