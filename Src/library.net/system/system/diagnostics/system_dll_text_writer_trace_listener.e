indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.TextWriterTraceListener"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TEXT_WRITER_TRACE_LISTENER

inherit
	SYSTEM_DLL_TRACE_LISTENER
		redefine
			flush,
			close,
			dispose_boolean
		end
	IDISPOSABLE

create
	make_system_dll_text_writer_trace_listener_3,
	make_system_dll_text_writer_trace_listener_2,
	make_system_dll_text_writer_trace_listener_1,
	make_system_dll_text_writer_trace_listener,
	make_system_dll_text_writer_trace_listener_6,
	make_system_dll_text_writer_trace_listener_5,
	make_system_dll_text_writer_trace_listener_4

feature {NONE} -- Initialization

	frozen make_system_dll_text_writer_trace_listener_3 (writer: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_system_dll_text_writer_trace_listener_2 (stream: SYSTEM_STREAM; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.Stream, System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_system_dll_text_writer_trace_listener_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_system_dll_text_writer_trace_listener is
		external
			"IL creator use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_system_dll_text_writer_trace_listener_6 (file_name: SYSTEM_STRING; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_system_dll_text_writer_trace_listener_5 (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.TextWriterTraceListener"
		end

	frozen make_system_dll_text_writer_trace_listener_4 (writer: TEXT_WRITER; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.Diagnostics.TextWriterTraceListener"
		end

feature -- Access

	frozen get_writer: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use System.Diagnostics.TextWriterTraceListener"
		alias
			"get_Writer"
		end

feature -- Element Change

	frozen set_writer (value: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Diagnostics.TextWriterTraceListener"
		alias
			"set_Writer"
		end

feature -- Basic Operations

	write_line_string (message: SYSTEM_STRING) is
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

	write_string (message: SYSTEM_STRING) is
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

end -- class SYSTEM_DLL_TEXT_WRITER_TRACE_LISTENER
