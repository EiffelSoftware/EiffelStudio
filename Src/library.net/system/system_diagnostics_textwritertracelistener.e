indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.TextWriterTraceListener"

external class
	SYSTEM_DIAGNOSTICS_TEXTWRITERTRACELISTENER

inherit
	SYSTEM_IDISPOSABLE
	SYSTEM_DIAGNOSTICS_TRACELISTENER
		redefine
			flush,
			close,
			dispose_boolean
		end

create
	make_textwritertracelistener_3,
	make_textwritertracelistener_2,
	make_textwritertracelistener_5,
	make_textwritertracelistener,
	make_textwritertracelistener_4,
	make_textwritertracelistener_6,
	make_textwritertracelistener_1

feature {NONE} -- Initialization

	frozen make_textwritertracelistener_3 (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_textwritertracelistener_2 (stream: SYSTEM_IO_STREAM; name: STRING) is
		external
			"IL creator signature (System.IO.Stream, System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_textwritertracelistener_5 (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_textwritertracelistener is
		external
			"IL creator use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_textwritertracelistener_4 (writer: SYSTEM_IO_TEXTWRITER; name: STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_textwritertracelistener_6 (file_name: STRING; name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_textwritertracelistener_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Diagnostics.TextWriterTraceListener"
		end

feature -- Access

	frozen get_writer: SYSTEM_IO_TEXTWRITER is
		external
			"IL signature (): System.IO.TextWriter use System.Diagnostics.TextWriterTraceListener"
		alias
			"get_Writer"
		end

feature -- Element Change

	frozen set_writer (value: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"set_Writer"
		end

feature -- Basic Operations

	write_line_string (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"WriteLine"
		end

	flush is
		external
			"IL signature (): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"Flush"
		end

	write_string (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"Dispose"
		end

end -- class SYSTEM_DIAGNOSTICS_TEXTWRITERTRACELISTENER
