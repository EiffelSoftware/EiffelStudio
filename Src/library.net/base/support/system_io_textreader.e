indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.TextReader"

deferred external class
	SYSTEM_IO_TEXTREADER

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_Dispose
		end

feature -- Access

	frozen null: SYSTEM_IO_TEXTREADER is
		external
			"IL static_field signature :System.IO.TextReader use System.IO.TextReader"
		alias
			"Null"
		end

feature -- Basic Operations

	read_line: STRING is
		external
			"IL signature (): System.String use System.IO.TextReader"
		alias
			"ReadLine"
		end

	peek: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.TextReader"
		alias
			"Peek"
		end

	read: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.TextReader"
		alias
			"Read"
		end

	read_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.TextReader"
		alias
			"Read"
		end

	read_block (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.TextReader"
		alias
			"ReadBlock"
		end

	read_to_end: STRING is
		external
			"IL signature (): System.String use System.IO.TextReader"
		alias
			"ReadToEnd"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.TextReader"
		alias
			"Close"
		end

	frozen synchronized (reader: SYSTEM_IO_TEXTREADER): SYSTEM_IO_TEXTREADER is
		external
			"IL static signature (System.IO.TextReader): System.IO.TextReader use System.IO.TextReader"
		alias
			"Synchronized"
		end

feature {NONE} -- Implementation

	frozen disposable_Dispose is
		external
			"IL signature (): System.Void use System.IO.TextReader"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_IO_TEXTREADER
