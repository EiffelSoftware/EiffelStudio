indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.Debug"

frozen external class
	SYSTEM_DIAGNOSTICS_DEBUG

create {NONE}

feature -- Access

	frozen get_indent_level: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Diagnostics.Debug"
		alias
			"get_IndentLevel"
		end

	frozen get_listeners: SYSTEM_DIAGNOSTICS_TRACELISTENERCOLLECTION is
		external
			"IL static signature (): System.Diagnostics.TraceListenerCollection use System.Diagnostics.Debug"
		alias
			"get_Listeners"
		end

	frozen get_indent_size: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Diagnostics.Debug"
		alias
			"get_IndentSize"
		end

	frozen get_auto_flush: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Diagnostics.Debug"
		alias
			"get_AutoFlush"
		end

feature -- Element Change

	frozen set_indent_size (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Diagnostics.Debug"
		alias
			"set_IndentSize"
		end

	frozen set_auto_flush (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Diagnostics.Debug"
		alias
			"set_AutoFlush"
		end

	frozen set_indent_level (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Diagnostics.Debug"
		alias
			"set_IndentLevel"
		end

feature -- Basic Operations

	frozen write_line_if_boolean_object_string (condition: BOOLEAN; value: ANY; category: STRING) is
		external
			"IL static signature (System.Boolean, System.Object, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLineIf"
		end

	frozen close is
		external
			"IL static signature (): System.Void use System.Diagnostics.Debug"
		alias
			"Close"
		end

	frozen write_line_string (message: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLine"
		end

	frozen write_line_if_boolean_string (condition: BOOLEAN; message: STRING) is
		external
			"IL static signature (System.Boolean, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLineIf"
		end

	frozen write_line_string_string (message: STRING; category: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLine"
		end

	frozen assert_boolean_string (condition: BOOLEAN; message: STRING) is
		external
			"IL static signature (System.Boolean, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Assert"
		end

	frozen write (value: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Diagnostics.Debug"
		alias
			"Write"
		end

	frozen write_if_boolean_string_string (condition: BOOLEAN; message: STRING; category: STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteIf"
		end

	frozen fail_string_string (message: STRING; detail_message: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Fail"
		end

	frozen write_line (value: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLine"
		end

	frozen write_line_if (condition: BOOLEAN; value: ANY) is
		external
			"IL static signature (System.Boolean, System.Object): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLineIf"
		end

	frozen write_if (condition: BOOLEAN; value: ANY) is
		external
			"IL static signature (System.Boolean, System.Object): System.Void use System.Diagnostics.Debug"
		alias
			"WriteIf"
		end

	frozen indent is
		external
			"IL static signature (): System.Void use System.Diagnostics.Debug"
		alias
			"Indent"
		end

	frozen unindent is
		external
			"IL static signature (): System.Void use System.Diagnostics.Debug"
		alias
			"Unindent"
		end

	frozen flush is
		external
			"IL static signature (): System.Void use System.Diagnostics.Debug"
		alias
			"Flush"
		end

	frozen write_line_object_string (value: ANY; category: STRING) is
		external
			"IL static signature (System.Object, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLine"
		end

	frozen write_if_boolean_object_string (condition: BOOLEAN; value: ANY; category: STRING) is
		external
			"IL static signature (System.Boolean, System.Object, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteIf"
		end

	frozen write_object_string (value: ANY; category: STRING) is
		external
			"IL static signature (System.Object, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Write"
		end

	frozen write_line_if_boolean_string_string (condition: BOOLEAN; message: STRING; category: STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteLineIf"
		end

	frozen write_string (message: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Write"
		end

	frozen assert (condition: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Diagnostics.Debug"
		alias
			"Assert"
		end

	frozen fail (message: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Fail"
		end

	frozen assert_boolean_string_string (condition: BOOLEAN; message: STRING; detail_message: STRING) is
		external
			"IL static signature (System.Boolean, System.String, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Assert"
		end

	frozen write_string_string (message: STRING; category: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"Write"
		end

	frozen write_if_boolean_string (condition: BOOLEAN; message: STRING) is
		external
			"IL static signature (System.Boolean, System.String): System.Void use System.Diagnostics.Debug"
		alias
			"WriteIf"
		end

end -- class SYSTEM_DIAGNOSTICS_DEBUG
