indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlDateTime"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLDATETIME

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_DATA_SQLTYPES_INULLABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end



feature -- Initialization

	frozen make_sqldatetime (value: SYSTEM_DATETIME) is
		external
			"IL creator signature (System.DateTime) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_sqldatetime_3 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; millisecond: DOUBLE) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Double) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_sqldatetime_2 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_sqldatetime_1 (year: INTEGER; month: INTEGER; day: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_sqldatetime_4 (year: INTEGER; month: INTEGER; day: INTEGER; hour: INTEGER; minute: INTEGER; second: INTEGER; bilisecond: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32) use System.Data.SqlTypes.SqlDateTime"
		end

	frozen make_sqldatetime_5 (day_ticks: INTEGER; time_ticks: INTEGER) is
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

	frozen max_value: SYSTEM_DATA_SQLTYPES_SQLDATETIME is
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

	frozen get_value: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"get_Value"
		end

	frozen min_value: SYSTEM_DATA_SQLTYPES_SQLDATETIME is
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

	frozen null: SYSTEM_DATA_SQLTYPES_SQLDATETIME is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlDateTime"
		alias
			"ToString"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME; y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"GreaterThan"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME; y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"LessThan"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME; y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"NotEquals"
		end

	frozen equals_sql_date_time (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME; y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"Equals"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlDateTime"
		alias
			"ToSqlString"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME; y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"GreaterThanOrEqual"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"Parse"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME; y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime, System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"LessThanOrEqual"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"Equals"
		end

	frozen compare_to (value: ANY): INTEGER is
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

	frozen infix "+" (t: SYSTEM_TIMESPAN): SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL operator  signature (System.TimeSpan): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Addition"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Equality"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_GreaterThan"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlDateTime): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_LessThan"
		end

	frozen infix "-" (t: SYSTEM_TIMESPAN): SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL operator  signature (System.TimeSpan): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Subtraction"
		end

feature -- Specials

	frozen op_implicit (value: SYSTEM_DATETIME): SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL static signature (System.DateTime): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_date_time (x: SYSTEM_DATA_SQLTYPES_SQLDATETIME): SYSTEM_DATETIME is
		external
			"IL static signature (System.Data.SqlTypes.SqlDateTime): System.DateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLDATETIME is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlDateTime use System.Data.SqlTypes.SqlDateTime"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLDATETIME
