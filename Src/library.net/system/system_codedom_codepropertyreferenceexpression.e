indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodePropertyReferenceExpression"

external class
	SYSTEM_CODEDOM_CODEPROPERTYREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codepropertyreferenceexpression,
	make_codepropertyreferenceexpression_1

feature {NONE} -- Initialization

	frozen make_codepropertyreferenceexpression is
		external
			"IL creator use System.CodeDom.CodePropertyReferenceExpression"
		end

	frozen make_codepropertyreferenceexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; property_name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodePropertyReferenceExpression"
		end

feature -- Access

	frozen get_property_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"get_PropertyName"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_property_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"set_PropertyName"
		end

end -- class SYSTEM_CODEDOM_CODEPROPERTYREFERENCEEXPRESSION
