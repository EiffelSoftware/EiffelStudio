indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeAttributeArgument"

external class
	SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: STRING; value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeAttributeArgument"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.CodeAttributeArgument"
		end

	frozen make_1 (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeAttributeArgument"
		end

feature -- Access

	frozen get_value: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAttributeArgument"
		alias
			"get_Value"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeAttributeArgument"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeAttributeArgument"
		alias
			"set_Name"
		end

	frozen set_value (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAttributeArgument"
		alias
			"set_Value"
		end

end -- class SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT
