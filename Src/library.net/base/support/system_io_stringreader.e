indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.StringReader"

external class
	SYSTEM_IO_STRINGREADER

inherit
	SYSTEM_IO_TEXTREADER
		redefine
			read_line,
			read_to_end,
			read_at,
			read,
			peek,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_Dispose
		end

create
	make_string_reader

feature {NONE} -- Initialization

	frozen make_string_reader (s: STRING) is
		external
			"IL creator signature (System.String) use System.IO.StringReader"
		end

feature -- Basic Operations

	close is
		external
			"IL signature (): System.Void use System.IO.StringReader"
		alias
			"Close"
		end

	read_to_end: STRING is
		external
			"IL signature (): System.String use System.IO.StringReader"
		alias
			"ReadToEnd"
		end

	read_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
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

end -- class SYSTEM_IO_STRINGREADER
