indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeLinePragma"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_LINE_PRAGMA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (file_name: SYSTEM_STRING; line_number: INTEGER) is
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

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeLinePragma"
		alias
			"get_FileName"
		end

feature -- Element Change

	frozen set_file_name (value: SYSTEM_STRING) is
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

end -- class SYSTEM_DLL_CODE_LINE_PRAGMA
