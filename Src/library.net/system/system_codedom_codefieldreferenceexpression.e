indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeFieldReferenceExpression"

external class
	SYSTEM_CODEDOM_CODEFIELDREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codefieldreferenceexpression,
	make_codefieldreferenceexpression_1

feature {NONE} -- Initialization

	frozen make_codefieldreferenceexpression is
		external
			"IL creator use System.CodeDom.CodeFieldReferenceExpression"
		end

	frozen make_codefieldreferenceexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; field_name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeFieldReferenceExpression"
		end

feature -- Access

	frozen get_field_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"get_FieldName"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_field_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"set_FieldName"
		end

end -- class SYSTEM_CODEDOM_CODEFIELDREFERENCEEXPRESSION
