indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.FormatterTypeStyle"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FORMATTER_TYPE_STYLE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen types_always: FORMATTER_TYPE_STYLE is
		external
			"IL enum signature :System.Runtime.Serialization.Formatters.FormatterTypeStyle use System.Runtime.Serialization.Formatters.FormatterTypeStyle"
		alias
			"1"
		end

	frozen types_when_needed: FORMATTER_TYPE_STYLE is
		external
			"IL enum signature :System.Runtime.Serialization.Formatters.FormatterTypeStyle use System.Runtime.Serialization.Formatters.FormatterTypeStyle"
		alias
			"0"
		end

	frozen xsd_string: FORMATTER_TYPE_STYLE is
		external
			"IL enum signature :System.Runtime.Serialization.Formatters.FormatterTypeStyle use System.Runtime.Serialization.Formatters.FormatterTypeStyle"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class FORMATTER_TYPE_STYLE
