indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeAttributeDeclaration"

external class
	SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: STRING; arguments: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeAttributeArgument[]) use System.CodeDom.CodeAttributeDeclaration"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.CodeAttributeDeclaration"
		end

	frozen make_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeAttributeDeclaration"
		end

feature -- Access

	frozen get_arguments: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeArgumentCollection use System.CodeDom.CodeAttributeDeclaration"
		alias
			"get_Arguments"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeAttributeDeclaration"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeAttributeDeclaration"
		alias
			"set_Name"
		end

end -- class SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION
