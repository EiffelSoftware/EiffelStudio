indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlDateTime"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_DATE_TIME

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	DATA_INULLABLE
	ICOMPARABLE

feature -- Initialization

	frozen make_data_sql_date_time (value: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.DateTime) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_data_sql_date_time_1 (year: INTEGER; month: INTEGER; day: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_data_sql_date_time_2 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_data_sql_date_time_3 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: DOUBLE) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Double) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_data_sql_date_time_4 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; bilisecond: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_data_sql_date_time_5 (day_ticks: INTEGER; time_ticks: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

feature -- Access

	frozen get_day_ticks: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"get_DayTicks"
		end

	frozen sqlticks_per_second: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"SQLTicksPerSecond"
		end

	frozen max_value: DATA_SQL_DATE_TIME is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"MaxValue"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"get_IsNull"
		end

	frozen get_value: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"get_Value"
		end

	frozen min_value: DATA_SQL_DATE_TIME is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"MinValue"
		end

	frozen sqlticks_per_minute: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"SQLTicksPerMinute"
		end

	frozen get_time_ticks: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"get_TimeTicks"
		end

	frozen null: DATA_SQL_DATE_TIME is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"Null"
		end

	frozen sqlticks_per_hour: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"SQLTicksPerHour"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlDateTime"
		alias
			"ToString"
		end

	frozen greater_than (x: DATA_SQL_DATE_TIME; y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"GreaterThan"
		end

	frozen less_than (x: DATA_SQL_DATE_TIME; y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"LessThan"
		end

	frozen not_equals (x: DATA_SQL_DATE_TIME; y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"NotEquals"
		end

	frozen equals_sql_date_time (x: DATA_SQL_DATE_TIME; y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"Equals"
		end

	frozen to_sql_string: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlDateTime"
		alias
			"ToSqlString"
		end

	frozen greater_than_or_equal (x: DATA_SQL_DATE_TIME; y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"GreaterThanOrEqual"
		end

	frozen parse (s: SYSTEM_STRING): DATA_SQL_DATE_TIME is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"Parse"
		end

	frozen less_than_or_equal (x: DATA_SQL_DATE_TIME; y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"LessThanOrEqual"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"Equals"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"CompareTo"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlDateTime"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix "+" (t: TIME_SPAN): DATA_SQL_DATE_TIME is
		external
			"IL operator signature (System.TimeSpan): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Addition"
		end

	frozen infix "|=" (y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Equality"
		end

	frozen infix ">" (y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_GreaterThan"
		end

	frozen infix "<=" (y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "<" (y: DATA_SQL_DATE_TIME): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_LessThan"
		end

	frozen infix "-" (t: TIME_SPAN): DATA_SQL_DATE_TIME is
		external
			"IL operator signature (System.TimeSpan): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Subtraction"
		end

feature -- Specials

	frozen op_implicit (value: SYSTEM_DATE_TIME): DATA_SQL_DATE_TIME is
		external
			"IL static signature (System.DateTime): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_date_time (x: DATA_SQL_DATE_TIME): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime): System.DateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: DATA_SQL_STRING): DATA_SQL_DATE_TIME is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Explicit"
		end

end -- class DATA_SQL_DATE_TIME
