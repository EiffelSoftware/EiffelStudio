indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.TraceListener"

deferred external class
	SYSTEM_DIAGNOSTICS_TRACELISTENER

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE

feature -- Access

	frozen get_indent_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.TraceListener"
		alias
			"get_IndentSize"
		end

	get_name: STRING is
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

	set_name (value: STRING) is
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

	fail (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Fail"
		end

	write_line_string (message: STRING) is
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

	write_string_string (message: STRING; category: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	write_string (message: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	write_line_object_string (o: ANY; category: STRING) is
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

	fail_string_string (message: STRING; detail_message: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Fail"
		end

	write_line (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Diagnostics.TraceListener"
		alias
			"WriteLine"
		end

	write (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	write_object_string (o: ANY; category: STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Diagnostics.TraceListener"
		alias
			"Write"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListener"
		alias
			"Dispose"
		end

	write_line_string_string (message: STRING; category: STRING) is
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

end -- class SYSTEM_DIAGNOSTICS_TRACELISTENER
