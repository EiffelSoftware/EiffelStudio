indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.StringReader"

external class
	SYSTEM_IO_STRINGREADER

inherit
	SYSTEM_IO_TEXTREADER
		redefine
			read_line,
			read_to_end,
			read_array_char,
			read,
			peek,
			dispose,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_stringreader

feature {NONE} -- Initialization

	frozen make_stringreader (s: STRING) is
		external
			"IL creator signature (System.String) use System.IO.StringReader"
		end

feature -- Basic Operations

	read_array_char (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.StringReader"
		alias
			"Read"
		end

	peek: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.StringReader"
		alias
			"Peek"
		end

	read_to_end: STRING is
		external
			"IL signature (): System.String use System.IO.StringReader"
		alias
			"ReadToEnd"
		end

	read: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.StringReader"
		alias
			"Read"
		end

	read_line: STRING is
		external
			"IL signature (): System.String use System.IO.StringReader"
		alias
			"ReadLine"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.StringReader"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.StringReader"
		alias
			"Dispose"
		end

end -- class SYSTEM_IO_STRINGREADER
