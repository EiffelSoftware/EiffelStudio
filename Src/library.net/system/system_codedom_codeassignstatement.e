indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeAssignStatement"

external class
	SYSTEM_CODEDOM_CODEASSIGNSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codeassignstatement_1,
	make_codeassignstatement

feature {NONE} -- Initialization

	frozen make_codeassignstatement_1 (left: SYSTEM_CODEDOM_CODEEXPRESSION; right: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeExpression) use System.CodeDom.CodeAssignStatement"
		end

	frozen make_codeassignstatement is
		external
			"IL creator use System.CodeDom.CodeAssignStatement"
		end

feature -- Access

	frozen get_right: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAssignStatement"
		alias
			"get_Right"
		end

	frozen get_left: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAssignStatement"
		alias
			"get_Left"
		end

feature -- Element Change

	frozen set_right (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAssignStatement"
		alias
			"set_Right"
		end

	frozen set_left (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAssignStatement"
		alias
			"set_Left"
		end

end -- class SYSTEM_CODEDOM_CODEASSIGNSTATEMENT
