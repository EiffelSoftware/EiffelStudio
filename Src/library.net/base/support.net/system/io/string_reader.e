indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.StringReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STRING_READER

inherit
	TEXT_READER
		redefine
			read_line,
			read_to_end,
			read_array_char,
			read,
			peek,
			dispose,
			close
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_string_reader

feature {NONE} -- Initialization

	frozen make_string_reader (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.StringReader"
		end

feature -- Basic Operations

	read_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
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

	read_to_end: SYSTEM_STRING is
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

	read_line: SYSTEM_STRING is
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

end -- class STRING_READER
