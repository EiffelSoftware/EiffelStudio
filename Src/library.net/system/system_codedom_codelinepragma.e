indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeLinePragma"

external class
	SYSTEM_CODEDOM_CODELINEPRAGMA

create
	make

feature {NONE} -- Initialization

	frozen make (file_name: STRING; line_number: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.CodeDom.CodeLinePragma"
		end

feature -- Access

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeLinePragma"
		alias
			"get_LineNumber"
		end

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeLinePragma"
		alias
			"get_FileName"
		end

feature -- Element Change

	frozen set_file_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeLinePragma"
		alias
			"set_FileName"
		end

	frozen set_line_number (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeLinePragma"
		alias
			"set_LineNumber"
		end

end -- class SYSTEM_CODEDOM_CODELINEPRAGMA
