indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeMember"

external class
	SYSTEM_CODEDOM_CODETYPEMEMBER

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codetypemember

feature {NONE} -- Initialization

	frozen make_codetypemember is
		external
			"IL creator use System.CodeDom.CodeTypeMember"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_CODEDOM_CODELINEPRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeTypeMember"
		alias
			"get_LinePragma"
		end

	frozen get_custom_attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeTypeMember"
		alias
			"get_CustomAttributes"
		end

	frozen get_comments: SYSTEM_CODEDOM_CODECOMMENTSTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeCommentStatementCollection use System.CodeDom.CodeTypeMember"
		alias
			"get_Comments"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeTypeMember"
		alias
			"get_Name"
		end

	frozen get_attributes: SYSTEM_CODEDOM_MEMBERATTRIBUTES is
		external
			"IL signature (): System.CodeDom.MemberAttributes use System.CodeDom.CodeTypeMember"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_CODEDOM_CODELINEPRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_LinePragma"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_Name"
		end

	frozen set_custom_attributes (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_CustomAttributes"
		end

	frozen set_attributes (value: SYSTEM_CODEDOM_MEMBERATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.CodeTypeMember"
		alias
			"set_Attributes"
		end

end -- class SYSTEM_CODEDOM_CODETYPEMEMBER
