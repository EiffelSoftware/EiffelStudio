indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeGotoStatement"

external class
	SYSTEM_CODEDOM_CODEGOTOSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codegotostatement

feature {NONE} -- Initialization

	frozen make_codegotostatement (label: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeGotoStatement"
		end

feature -- Access

	frozen get_label: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeGotoStatement"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_label (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeGotoStatement"
		alias
			"set_Label"
		end

end -- class SYSTEM_CODEDOM_CODEGOTOSTATEMENT
