indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.TextReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	TEXT_READER

inherit
	MARSHAL_BY_REF_OBJECT
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	frozen null: TEXT_READER is
		external
			"IL static_field signature :System.IO.TextReader use System.IO.TextReader"
		alias
			"Null"
		end

feature -- Basic Operations

	read: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.TextReader"
		alias
			"Read"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.TextReader"
		alias
			"Close"
		end

	read_block (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.TextReader"
		alias
			"ReadBlock"
		end

	read_line: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.TextReader"
		alias
			"ReadLine"
		end

	read_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.TextReader"
		alias
			"Read"
		end

	read_to_end: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.TextReader"
		alias
			"ReadToEnd"
		end

	frozen synchronized (reader: TEXT_READER): TEXT_READER is
		external
			"IL static signature (System.IO.TextReader): System.IO.TextReader use System.IO.TextReader"
		alias
			"Synchronized"
		end

	peek: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.TextReader"
		alias
			"Peek"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.TextReader"
		alias
			"Dispose"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.IO.TextReader"
		alias
			"System.IDisposable.Dispose"
		end

end -- class TEXT_READER
