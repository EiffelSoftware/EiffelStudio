indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeStatement"

external class
	SYSTEM_CODEDOM_CODESTATEMENT

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codestatement

feature {NONE} -- Initialization

	frozen make_codestatement is
		external
			"IL creator use System.CodeDom.CodeStatement"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_CODEDOM_CODELINEPRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeStatement"
		alias
			"get_LinePragma"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_CODEDOM_CODELINEPRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeStatement"
		alias
			"set_LinePragma"
		end

end -- class SYSTEM_CODEDOM_CODESTATEMENT
