indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.TraceListener"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_TRACE_LISTENER

inherit
	MARSHAL_BY_REF_OBJECT
	IDISPOSABLE

feature -- Access

	frozen get_indent_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.TraceListener"
		alias
			"get_IndentSize"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.TraceListener"
		alias
			"get_Name"
		end

	frozen get_indent_level: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.TraceListener"
		alias
			"get_IndentLevel"
		end

feature -- Element Change

	set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"set_Name"
		end

	frozen set_indent_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Diagnostics.TraceListener"
		alias
			"set_IndentSize"
		end

	frozen set_indent_level (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Diagnostics.TraceListener"
		alias
			"set_IndentLevel"
		end

feature -- Basic Operations

	fail (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Fail"
		end

	write_line_string (message: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"WriteLine"
		end

	close is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListener"
		alias
			"Close"
		end

	write_string_string (message: SYSTEM_STRING; category: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	write_string (message: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	write_line_object_string (o: SYSTEM_OBJECT; category: SYSTEM_STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"WriteLine"
		end

	flush is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListener"
		alias
			"Flush"
		end

	fail_string_string (message: SYSTEM_STRING; detail_message: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Fail"
		end

	write_line (o: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Diagnostics.TraceListener"
		alias
			"WriteLine"
		end

	write (o: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	write_object_string (o: SYSTEM_OBJECT; category: SYSTEM_STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListener"
		alias
			"Dispose"
		end

	write_line_string_string (message: SYSTEM_STRING; category: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"WriteLine"
		end

feature {NONE} -- Implementation

	frozen set_need_indent (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.TraceListener"
		alias
			"set_NeedIndent"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.TraceListener"
		alias
			"Dispose"
		end

	write_indent is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListener"
		alias
			"WriteIndent"
		end

	frozen get_need_indent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceListener"
		alias
			"get_NeedIndent"
		end

end -- class SYSTEM_DLL_TRACE_LISTENER
