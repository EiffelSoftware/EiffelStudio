indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.TimeSpan"

frozen expanded external class
	SYSTEM_TIMESPAN

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICOMPARABLE



feature {NONE} -- Initialization

	frozen make_timespan (ticks: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.TimeSpan"
		end

	frozen make_timespan_1 (hours: INTEGER; minutes: INTEGER; seconds: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.TimeSpan"
		end

	frozen make_timespan_3 (days: INTEGER; hours: INTEGER; minutes: INTEGER; seconds: INTEGER; milliseconds: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.TimeSpan"
		end

	frozen make_timespan_2 (days: INTEGER; hours: INTEGER; minutes: INTEGER; seconds: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.TimeSpan"
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

	frozen ticks_per_minute: INTEGER_64 is
		external
			"IL static_field signature :System.Int64 use System.TimeSpan"
		alias
			"TicksPerMinute"
		end

	frozen ticks_per_second: INTEGER_64 is
		external
			"IL static_field signature :System.Int64 use System.TimeSpan"
		alias
			"TicksPerSecond"
		end

	frozen get_ticks: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.TimeSpan"
		alias
			"get_Ticks"
		end

	frozen ticks_per_millisecond: INTEGER_64 is
		external
			"IL static_field signature :System.Int64 use System.TimeSpan"
		alias
			"TicksPerMillisecond"
		end

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

	frozen min_value: SYSTEM_TIMESPAN is
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

	frozen zero: SYSTEM_TIMESPAN is
		external
			"IL static_field signature :System.TimeSpan use System.TimeSpan"
		alias
			"Zero"
		end

	frozen ticks_per_hour: INTEGER_64 is
		external
			"IL static_field signature :System.Int64 use System.TimeSpan"
		alias
			"TicksPerHour"
		end

	frozen get_minutes: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Minutes"
		end

	frozen max_value: SYSTEM_TIMESPAN is
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

	frozen ticks_per_day: INTEGER_64 is
		external
			"IL static_field signature :System.Int64 use System.TimeSpan"
		alias
			"TicksPerDay"
		end

	frozen get_milliseconds: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"get_Milliseconds"
		end

feature -- Basic Operations

	frozen from_seconds (value: DOUBLE): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromSeconds"
		end

	frozen add (ts: SYSTEM_TIMESPAN): SYSTEM_TIMESPAN is
		external
			"IL signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"Add"
		end

	frozen from_hours (value: DOUBLE): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromHours"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.TimeSpan"
		alias
			"Equals"
		end

	frozen negate: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.TimeSpan"
		alias
			"Negate"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.TimeSpan"
		alias
			"GetHashCode"
		end

	frozen equals_time_span (t1: SYSTEM_TIMESPAN; t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL static signature (System.TimeSpan, System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"Equals"
		end

	frozen from_days (value: DOUBLE): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromDays"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.TimeSpan"
		alias
			"CompareTo"
		end

	frozen from_milliseconds (value: DOUBLE): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromMilliseconds"
		end

	frozen compare (t1: SYSTEM_TIMESPAN; t2: SYSTEM_TIMESPAN): INTEGER is
		external
			"IL static signature (System.TimeSpan, System.TimeSpan): System.Int32 use System.TimeSpan"
		alias
			"Compare"
		end

	frozen from_minutes (value: DOUBLE): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.Double): System.TimeSpan use System.TimeSpan"
		alias
			"FromMinutes"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.TimeSpan"
		alias
			"ToString"
		end

	frozen duration: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.TimeSpan"
		alias
			"Duration"
		end

	frozen parse (s: STRING): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.String): System.TimeSpan use System.TimeSpan"
		alias
			"Parse"
		end

	frozen subtract (ts: SYSTEM_TIMESPAN): SYSTEM_TIMESPAN is
		external
			"IL signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"Subtract"
		end

	frozen from_ticks (value: INTEGER_64): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.Int64): System.TimeSpan use System.TimeSpan"
		alias
			"FromTicks"
		end

feature -- Unary Operators

	frozen prefix "+": SYSTEM_TIMESPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_UnaryPlus"
		end

	frozen prefix "-": SYSTEM_TIMESPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "+" (t2: SYSTEM_TIMESPAN): SYSTEM_TIMESPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_Addition"
		end

	frozen infix "|=" (t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_Equality"
		end

	frozen infix ">" (t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_GreaterThan"
		end

	frozen infix "<=" (t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "<" (t2: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL operator signature (System.TimeSpan): System.Boolean use System.TimeSpan"
		alias
			"op_LessThan"
		end

	frozen infix "-" (t2: SYSTEM_TIMESPAN): SYSTEM_TIMESPAN is
		external
			"IL operator signature (System.TimeSpan): System.TimeSpan use System.TimeSpan"
		alias
			"op_Subtraction"
		end

end -- class SYSTEM_TIMESPAN
