indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeLabeledStatement"

external class
	SYSTEM_CODEDOM_CODELABELEDSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codelabeledstatement,
	make_codelabeledstatement_2,
	make_codelabeledstatement_1

feature {NONE} -- Initialization

	frozen make_codelabeledstatement is
		external
			"IL creator use System.CodeDom.CodeLabeledStatement"
		end

	frozen make_codelabeledstatement_2 (label: STRING; statement: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeStatement) use System.CodeDom.CodeLabeledStatement"
		end

	frozen make_codelabeledstatement_1 (label: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeLabeledStatement"
		end

feature -- Access

	frozen get_statement: SYSTEM_CODEDOM_CODESTATEMENT is
		external
			"IL signature (): System.CodeDom.CodeStatement use System.CodeDom.CodeLabeledStatement"
		alias
			"get_Statement"
		end

	frozen get_label: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeLabeledStatement"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_label (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeLabeledStatement"
		alias
			"set_Label"
		end

	frozen set_statement (value: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeLabeledStatement"
		alias
			"set_Statement"
		end

end -- class SYSTEM_CODEDOM_CODELABELEDSTATEMENT
