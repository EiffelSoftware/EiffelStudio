note
	description: "Abstract MySQL Value"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MYSQLI_VALUE

inherit
	MYSQLI_EXTERNALS
	EXCEPTIONS

feature{MYSQLI_EXTERNALS} -- Internals

	bind (a_bind: POINTER; a_buffer, a_is_null, a_length: MANAGED_POINTER)
			-- Fill in the BIND struct
		deferred
		end

feature -- Access (Field Type)

	is_tinyint_value: BOOLEAN
			-- Is this value a MySQL TINYINT value?
		deferred
		end

	is_smallint_value: BOOLEAN
			-- Is this value a MySQL SMALLINT value?
		deferred
		end

	is_integer_value: BOOLEAN
			-- Is this value a MySQL INTEGER value?
		deferred
		end

	is_mediumint_value: BOOLEAN
			-- Is this value a MySQL MEDIUMINT value?
		deferred
		end

	is_bigint_value: BOOLEAN
			-- Is this value a MySQL BIGINT value?
		deferred
		end

	is_decimal_value: BOOLEAN
			-- Is this value a MySQL DECIMAL or NUMERIC value?
		deferred
		end

	is_newdecimal_value: BOOLEAN
			-- Is this value a MySQL Precision math DECIMAL or NUMERIC?
		deferred
		end

	is_float_value: BOOLEAN
			-- Is this value a MySQL FLOAT value?
		deferred
		end

	is_double_value: BOOLEAN
			-- Is this value a MySQL DOUBLE or REAL value?
		deferred
		end

	is_bit_value: BOOLEAN
			-- Is this value a MySQL BIT value?
		deferred
		end

	is_timestamp_value: BOOLEAN
			-- Is this value a MySQL TIMESTAMP value?
		deferred
		end

	is_date_value: BOOLEAN
			-- Is this value a MySQL DATE value?
		deferred
		end

	is_time_value: BOOLEAN
			-- Is this value a MySQL TIME value?
		deferred
		end

	is_datetime_value: BOOLEAN
			-- Is this value a MySQL DATETIME value?
		deferred
		end

	is_year_value: BOOLEAN
			-- Is this value a MySQL YEAR value?
		deferred
		end

	is_char_value: BOOLEAN
			-- Is this value a MySQL CHAR or BINARY value?
		deferred
		end

	is_varchar_value: BOOLEAN
			-- Is this value a MySQL VARCHAR or VARBINARY value?
		deferred
		end

	is_text_value: BOOLEAN
			-- Is this value a MySQL BLOB or TEXT value?
		deferred
		end

	is_set_value: BOOLEAN
			-- Is this value a MySQL SET value?
		deferred
		end

	is_enum_value: BOOLEAN
			-- Is this value a MySQL ENUM value?
		deferred
		end

	is_geometry_value: BOOLEAN
			-- Is this value a MySQL Spatial value?
		deferred
		end

	is_null_value: BOOLEAN
			-- Is this value a MySQL NULL-type value?
		deferred
		end

feature -- Access (Type Conformance)

	is_representable_as_boolean: BOOLEAN
			-- Is this value representable as a BOOLEAN?
		deferred
		end

	is_representable_as_character_8: BOOLEAN
			-- Is this value representable as a CHARACTER_8?
		deferred
		end

	is_representable_as_character_32: BOOLEAN
			-- Is this value representable as a CHARACTER_32?
		deferred
		end

	is_representable_as_natural_8: BOOLEAN
			-- Is this value representable as a NATURAL_8?
		deferred
		end

	is_representable_as_natural_16: BOOLEAN
			-- Is this value representable as a NATURAL_16?
		deferred
		end

	is_representable_as_natural_32: BOOLEAN
			-- Is this value representable as a NATURAL_32?
		deferred
		end

	is_representable_as_natural_64: BOOLEAN
			-- Is this value representable as a NATURAL_64?
		deferred
		end

	is_representable_as_integer_8: BOOLEAN
			-- Is this value representable as a INTEGER_8?
		deferred
		end

	is_representable_as_integer_16: BOOLEAN
			-- Is this value representable as a INTEGER_16?
		deferred
		end

	is_representable_as_integer_32: BOOLEAN
			-- Is this value representable as a INTEGER_32?
		deferred
		end

	is_representable_as_integer_64: BOOLEAN
			-- Is this value representable as a INTEGER_64?
		deferred
		end

	is_representable_as_real_32: BOOLEAN
			-- Is this value representable as a REAL_32?
		deferred
		end

	is_representable_as_real_64: BOOLEAN
			-- Is this value representable as a REAL_64?
		deferred
		end

	is_representable_as_string_8: BOOLEAN
			-- Is this value representable as a STRING_8?
		deferred
		end

	is_representable_as_string_32: BOOLEAN
			-- Is this value representable as a STRING_32?
		deferred
		end

feature -- Access (Basic Type Conformance)

	is_representable_as_character: BOOLEAN
			-- Is this value representable as a CHARACTER?
		do
			Result := is_representable_as_character_8
		end

	is_representable_as_natural: BOOLEAN
			-- Is this value representable as a NATURAL?
		do
			Result := is_representable_as_natural_32
		end

	is_representable_as_integer: BOOLEAN
			-- Is this value representable as a INTEGER?
		do
			Result := is_representable_as_integer_32
		end

	is_representable_as_real: BOOLEAN
			-- Is this value representable as a REAL?
		do
			Result := is_representable_as_real_32
		end

	is_representable_as_double: BOOLEAN
			-- Is this value representable as a DOUBLE?
		do
			Result := is_representable_as_real_64
		end

	is_representable_as_string: BOOLEAN
			-- Is this value representable as a STRING?
		do
			Result := is_representable_as_string_8
		end

feature -- Access (Date and Time Type Conformance)

	is_representable_as_date_and_time_tuple: BOOLEAN
			-- Is this value representable as a TUPLE?
		deferred
		end

	is_representable_as_timestamp: BOOLEAN
			-- Is this value representable as a TIMESTAMP?
		deferred
		end

	is_representable_as_date: BOOLEAN
			-- Is this value representable as a DATE?
		deferred
		end

	is_representable_as_time: BOOLEAN
			-- Is this value representable as a TIME?
		deferred
		end

	is_representable_as_datetime: BOOLEAN
			-- Is this value representable as a DATETIME?
		deferred
		end

	is_representable_as_year: BOOLEAN
			-- Is this value representable as a YEAR?
		deferred
		end

feature -- Access (Set Conformance)

	is_representable_as_set: BOOLEAN
			-- Is this value representable as a SET?
		deferred
		end

feature -- Access (Bit Sequence Conformance)

	is_representable_as_bit_sequence: BOOLEAN
		do
			Result := is_representable_as_natural_64
		end

feature -- Access (Types)

	as_boolean: BOOLEAN
			-- This value as a BOOLEAN
		require
			is_representable_as_boolean: is_representable_as_boolean
		deferred
		end

	as_character_8: CHARACTER_8
			-- This value as a CHARACTER_8
		require
			is_representable_as_character_8: is_representable_as_character_8
		deferred
		end

	as_character_32: CHARACTER_32
			-- This value as a CHARACTER_32
		require
			is_representable_as_character_32: is_representable_as_character_32
		deferred
		end

	as_natural_8: NATURAL_8
			-- This value as a NATURAL_8
		require
			is_representable_as_natural_8: is_representable_as_natural_8
		deferred
		end

	as_natural_16: NATURAL_16
			-- This value as a NATURAL_16
		require
			is_representable_as_natural_16: is_representable_as_natural_16
		deferred
		end

	as_natural_32: NATURAL_32
			-- This value as a NATURAL_32
		require
			is_representable_as_natural_32: is_representable_as_natural_32
		deferred
		end

	as_natural_64: NATURAL_64
			-- This value as a NATURAL_64
		require
			is_representable_as_natural_64: is_representable_as_natural_64
		deferred
		end

	as_integer_8: INTEGER_8
			-- This value as a INTEGER_8
		require
			is_representable_as_integer_8: is_representable_as_integer_8
		deferred
		end

	as_integer_16: INTEGER_16
			-- This value as a INTEGER_16
		require
			is_representable_as_integer_16: is_representable_as_integer_16
		deferred
		end

	as_integer_32: INTEGER_32
			-- This value as a INTEGER_32
		require
			is_representable_as_integer_32: is_representable_as_integer_32
		deferred
		end

	as_integer_64: INTEGER_64
			-- This value as a INTEGER_64
		require
			is_representable_as_integer_64: is_representable_as_integer_64
		deferred
		end

	as_real_32: REAL_32
			-- This value as a REAL_32
		require
			is_representable_as_real_32: is_representable_as_real_32
		deferred
		end

	as_real_64: REAL_64
			-- This value as a REAL_64
		require
			is_representable_as_real_64: is_representable_as_real_64
		deferred
		end

	as_string_8: STRING_8
			-- This value as a STRING_8
		require
			is_representable_as_string_8: is_representable_as_string_8
		deferred
		end

	as_string_32: STRING_32
			-- This value as a STRING_32
		require
			is_representable_as_string_32: is_representable_as_string_32
		deferred
		end

feature -- Access (Basic Types)

	as_character: CHARACTER
			-- This value as a CHARACTER
		require
			is_representable_as_character: is_representable_as_character
		do
			Result := as_character_8
		end

	as_natural: NATURAL
			-- This value as a NATURAL
		require
			is_representable_as_natural: is_representable_as_natural
		do
			Result := as_natural_32
		end

	as_integer: INTEGER
			-- This value as a INTEGER
		require
			is_representable_as_integer: is_representable_as_integer
		do
			Result := as_integer_32
		end

	as_real: REAL
			-- This value as a REAL
		require
			is_representable_as_real: is_representable_as_real
		do
			Result := as_real_32
		end

	as_double: DOUBLE
			-- This value as a DOUBLE
		require
			is_representable_as_double: is_representable_as_double
		do
			Result := as_real_64
		end

	as_string: STRING
			-- This value as a STRING
		require
			is_representable_as_string: is_representable_as_string
		do
			Result := as_string_8
		end

feature -- Access (Date and Time Types)

	as_date_and_time_tuple: TUPLE [years, months, days, hours, minutes, seconds: INTEGER_32]
			-- This value as a TUPLE
		require
			is_representable_as_date_and_time_tuple: is_representable_as_date_and_time_tuple
		deferred
		end

	as_timestamp: DATE_TIME
			-- This value as a DATE_TIME
		require
			is_representable_as_timestamp: is_representable_as_timestamp
		deferred
		end

	as_date: DATE
			-- This value as a DATE
		require
			is_representable_as_date: is_representable_as_date
		deferred
		end

	as_time: TIME
			-- This value as a TIME
		require
			is_representable_as_time: is_representable_as_time
		deferred
		end

	as_datetime: DATE_TIME
			-- This value as a DATE_TIME
		require
			is_representable_as_datetime: is_representable_as_datetime
		deferred
		end

	as_year: INTEGER
			-- This value as a INTEGER
		require
			is_representable_as_year: is_representable_as_year
		deferred
		end

feature{MYSQLI_VALUE} -- Access (MySQL Date and Time Converters)

	date_time_tuple_as_date_time (a_tuple: like as_date_and_time_tuple): DATE_TIME
		do
			create Result.make (a_tuple.years, a_tuple.months, a_tuple.days, a_tuple.hours, a_tuple.minutes, a_tuple.seconds)
		end

	date_time_tuple_as_date (a_tuple: like as_date_and_time_tuple): DATE
		do
			create Result.make (a_tuple.years, a_tuple.months, a_tuple.days)
		end

	date_time_tuple_as_time (a_tuple: like as_date_and_time_tuple): TIME
		do
			create Result.make (a_tuple.hours, a_tuple.minutes, a_tuple.seconds)
		end

feature -- Access (MySQL Date and Time Formatters)

	default_timestamp_format_string: STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			Result := "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss"
		end

	default_datetime_format_string: STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			Result := "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss"
		end

	default_date_format_string: STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			Result := "yyyy-[0]mm-[0]dd"
		end

	default_time_format_string: STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			Result := "[0]hh:[0]mi:[0]ss"
		end

	default_timestamp_format_code_string: DATE_TIME_CODE_STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			create Result.make (default_timestamp_format_string)
		end

	default_datetime_format_code_string: DATE_TIME_CODE_STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			create Result.make (default_datetime_format_string)
		end

	default_date_format_code_string: DATE_TIME_CODE_STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			create Result.make (default_date_format_string)
		end

	default_time_format_code_string: DATE_TIME_CODE_STRING
			-- http://dev.mysql.com/doc/refman/5.0/en/datetime.html
		once
			create Result.make (default_time_format_string)
		end

feature -- Access (Set Type)

	as_set: SET [STRING]
			-- This value as a SET [STRING]
		require
			is_representable_as_set: is_representable_as_set
		deferred
		end

feature -- Access (Bit Sequence Type)

	as_bit_sequence: NATURAL_64
			-- This value as a NATURAL_64
		require
			is_representable_as_bit_sequence: is_representable_as_bit_sequence
		do
			Result := as_natural_64
		end

end
