indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.TimeSpan"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	TIME_SPAN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE

feature -- Initialization

	frozen make_time_span (ticks: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.TimeSpan"
		end

	frozen make_time_span_1 (hours: INTEGER; minutes: INTEGER; seconds: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.TimeSpan"
		end

	frozen make_time_span_2 (days: INTEGER; hours: INTEGER; minutes: INTEGER; seconds: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.TimeSpan"
		end

	frozen make_time_span_3 (days: INTEGER; hours: INTEGER; minutes: INTEGER; seconds: INTEGER; milliseconds: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.TimeSpan"
		end

feature -- Access

	frozen get_total_hours: DOUBLE is
		external
			"IL signature (): System.Double use System.TimeSpan"
		alias
			"get_TotalHours"
		end

	frozen get_total_minutes: DOUBLE is
		external
			"IL signature (): System.Double use System.TimeSpan"
		alias
			"get_TotalMinutes"
		end

	frozen get_days: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Days"
		end

	frozen ticks_per_minute: INTEGER_64 is 0x23c34600

	frozen ticks_per_second: INTEGER_64 is 0x989680

	frozen get_ticks: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.TimeSpan"
		alias
			"get_Ticks"
		end

	frozen ticks_per_millisecond: INTEGER_64 is 0x2710

	frozen get_hours: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Hours"
		end

	frozen get_total_milliseconds: DOUBLE is
		external
			"IL signature (): System.Double use System.TimeSpan"
		alias
			"get_TotalMilliseconds"
		end

	frozen min_value: TIME_SPAN is
		external
			"IL static_field signature :System.TimeSpan use System.TimeSpan"
		alias
			"MinValue"
		end

	frozen get_seconds: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Seconds"
		end

	frozen get_total_days: DOUBLE is
		external
			"IL signature (): System.Double use System.TimeSpan"
		alias
			"get_TotalDays"
		end

	frozen zero: TIME_SPAN is
		external
			"IL static_field signature :System.TimeSpan use System.TimeSpan"
		alias
			"Zero"
		end

	frozen ticks_per_hour: INTEGER_64 is 0x861c46800

	frozen get_minutes: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Minutes"
		end

	frozen max_value: TIME_SPAN is
		external
			"IL static_field signature :System.TimeSpan use System.TimeSpan"
		alias
			"MaxValue"
		end

	frozen get_total_seconds: DOUBLE is
		external
			"IL signature (): System.Double use System.TimeSpan"
		alias
			"get_TotalSeconds"
		end

	frozen ticks_per_day: INTEGER_64 is 0xc92a69c000

	frozen get_milliseconds: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Milliseconds"
		end

feature -- Basic Operations

	frozen from_seconds (value: DOUBLE): TIME_SPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromSeconds"
		end

	frozen add (ts: TIME_SPAN): TIME_SPAN is
		external
			"IL signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"Add"
		end

	frozen from_hours (value: DOUBLE): TIME_SPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromHours"
		end

	frozen negate: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.TimeSpan"
		alias
			"Negate"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.TimeSpan"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"GetHashCode"
		end

	frozen equals_time_span (t1: TIME_SPAN; t2: TIME_SPAN): BOOLEAN is
		external
			"IL static signature (System.TimeSpan, System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"Equals"
		end

	frozen from_days (value: DOUBLE): TIME_SPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromDays"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.TimeSpan"
		alias
			"CompareTo"
		end

	frozen from_milliseconds (value: DOUBLE): TIME_SPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromMilliseconds"
		end

	frozen compare (t1: TIME_SPAN; t2: TIME_SPAN): INTEGER is
		external
			"IL static signature (System.TimeSpan, System.TimeSpan): System.Int32 use System.TimeSpan"
		alias
			"Compare"
		end

	frozen from_minutes (value: DOUBLE): TIME_SPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromMinutes"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.TimeSpan"
		alias
			"ToString"
		end

	frozen duration: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.TimeSpan"
		alias
			"Duration"
		end

	frozen parse (s: SYSTEM_STRING): TIME_SPAN is
		external
			"IL static signature (System.String): System.TimeSpan use System.TimeSpan"
		alias
			"Parse"
		end

	frozen subtract (ts: TIME_SPAN): TIME_SPAN is
		external
			"IL signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"Subtract"
		end

	frozen from_ticks (value: INTEGER_64): TIME_SPAN is
		external
			"IL static signature (System.Int64): System.TimeSpan use System.TimeSpan"
		alias
			"FromTicks"
		end

feature -- Unary Operators

	frozen prefix "+": TIME_SPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_UnaryPlus"
		end

	frozen prefix "-": TIME_SPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "+" (t2: TIME_SPAN): TIME_SPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_Addition"
		end

	frozen infix "|=" (t2: TIME_SPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (t2: TIME_SPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (t2: TIME_SPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_Equality"
		end

	frozen infix ">" (t2: TIME_SPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_GreaterThan"
		end

	frozen infix "<=" (t2: TIME_SPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "<" (t2: TIME_SPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_LessThan"
		end

	frozen infix "-" (t2: TIME_SPAN): TIME_SPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_Subtraction"
		end

end -- class TIME_SPAN
