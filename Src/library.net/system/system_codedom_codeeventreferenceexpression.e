indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeEventReferenceExpression"

external class
	SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codeeventreferenceexpression,
	make_codeeventreferenceexpression_1

feature {NONE} -- Initialization

	frozen make_codeeventreferenceexpression is
		external
			"IL creator use System.CodeDom.CodeEventReferenceExpression"
		end

	frozen make_codeeventreferenceexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; event_name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeEventReferenceExpression"
		end

feature -- Access

	frozen get_event_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeEventReferenceExpression"
		alias
			"get_EventName"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeEventReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeEventReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_event_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeEventReferenceExpression"
		alias
			"set_EventName"
		end

end -- class SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION
