note
	description: "MySQL BIT Value"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_BIT_VALUE

inherit
	MYSQLI_VALUE

create
	make

feature{NONE} -- Initialization

	make (a_value: NATURAL_64)
			-- Set `value' to `a_value'.
		do
			value := a_value
		end

feature -- Access (Value)

	value: NATURAL_64

feature{MYSQLI_EXTERNALS} -- Internals

	bind (a_bind: POINTER; a_buffer, a_is_null, a_length: MANAGED_POINTER)
			-- Fill in the BIND struct
		do
			c_struct_mysql_bind_set_buffer_type (a_bind, MYSQL_TYPE_LONGLONG)
			a_buffer.put_natural_64 (value, 0)
			c_struct_mysql_bind_set_buffer (a_bind, a_buffer.item)
		end

feature -- Access (Field Type)

	is_tinyint_value: BOOLEAN = False
			-- Is this value a MySQL TINYINT value?

	is_smallint_value: BOOLEAN = False
			-- Is this value a MySQL SMALLINT value?

	is_integer_value: BOOLEAN = False
			-- Is this value a MySQL INTEGER value?

	is_mediumint_value: BOOLEAN = False
			-- Is this value a MySQL MEDIUMINT value?

	is_bigint_value: BOOLEAN = False
			-- Is this value a MySQL BIGINT value?

	is_decimal_value: BOOLEAN = False
			-- Is this value a MySQL DECIMAL or NUMERIC value?

	is_newdecimal_value: BOOLEAN = False
			-- Is this value a MySQL Precision math DECIMAL or NUMERIC?

	is_float_value: BOOLEAN = False
			-- Is this value a MySQL FLOAT value?

	is_double_value: BOOLEAN = False
			-- Is this value a MySQL DOUBLE or REAL value?

	is_bit_value: BOOLEAN = True
			-- Is this value a MySQL BIT value?

	is_timestamp_value: BOOLEAN = False
			-- Is this value a MySQL TIMESTAMP value?

	is_date_value: BOOLEAN = False
			-- Is this value a MySQL DATE value?

	is_time_value: BOOLEAN = False
			-- Is this value a MySQL TIME value?

	is_datetime_value: BOOLEAN = False
			-- Is this value a MySQL DATETIME value?

	is_year_value: BOOLEAN = False
			-- Is this value a MySQL YEAR value?

	is_char_value: BOOLEAN = False
			-- Is this value a MySQL CHAR or BINARY value?

	is_varchar_value: BOOLEAN = False
			-- Is this value a MySQL VARCHAR or VARBINARY value?

	is_text_value: BOOLEAN = False
			-- Is this value a MySQL BLOB or TEXT value?

	is_set_value: BOOLEAN = False
			-- Is this value a MySQL SET value?

	is_enum_value: BOOLEAN = False
			-- Is this value a MySQL ENUM value?

	is_geometry_value: BOOLEAN = False
			-- Is this value a MySQL Spatial value?

	is_null_value: BOOLEAN = False
			-- Is this value a MySQL NULL-type value?

feature -- Access (Type Conformance)

	is_representable_as_boolean: BOOLEAN
			-- Is this value representable as a BOOLEAN?
		do
			Result := True
		end

	is_representable_as_character_8: BOOLEAN
			-- Is this value representable as a CHARACTER_8?
		do
			Result := value.is_valid_character_8_code
		end

	is_representable_as_character_32: BOOLEAN
			-- Is this value representable as a CHARACTER_32?
		do
			Result := value.is_valid_character_32_code
		end

	is_representable_as_natural_8: BOOLEAN
			-- Is this value representable as a NATURAL_8?
		do
			Result := True
		end

	is_representable_as_natural_16: BOOLEAN
			-- Is this value representable as a NATURAL_16?
		do
			Result := True
		end

	is_representable_as_natural_32: BOOLEAN
			-- Is this value representable as a NATURAL_32?
		do
			Result := True
		end

	is_representable_as_natural_64: BOOLEAN
			-- Is this value representable as a NATURAL_64?
		do
			Result := True
		end

	is_representable_as_integer_8: BOOLEAN
			-- Is this value representable as a INTEGER_8?
		do
			Result := True
		end

	is_representable_as_integer_16: BOOLEAN
			-- Is this value representable as a INTEGER_16?
		do
			Result := True
		end

	is_representable_as_integer_32: BOOLEAN
			-- Is this value representable as a INTEGER_32?
		do
			Result := True
		end

	is_representable_as_integer_64: BOOLEAN
			-- Is this value representable as a INTEGER_64?
		do
			Result := True
		end

	is_representable_as_real_32: BOOLEAN
			-- Is this value representable as a REAL_32?
		do
			Result := True
		end

	is_representable_as_real_64: BOOLEAN
			-- Is this value representable as a REAL_64?
		do
			Result := True
		end

	is_representable_as_string_8: BOOLEAN
			-- Is this value representable as a STRING_8?
		do
			Result := True
		end

	is_representable_as_string_32: BOOLEAN
			-- Is this value representable as a STRING_32?
		do
			Result := True
		end

feature -- Access (Date and Time Type Conformance)

	is_representable_as_date_and_time_tuple: BOOLEAN
			-- Is this value representable as a TUPLE?
		do
			Result := False
		end

	is_representable_as_timestamp: BOOLEAN
			-- Is this value representable as a TIMESTAMP?
		do
				Result := False
		end

	is_representable_as_date: BOOLEAN
			-- Is this value representable as a DATE?
		do
				Result := False
		end

	is_representable_as_time: BOOLEAN
			-- Is this value representable as a TIME?
		do
				Result := False
		end

	is_representable_as_datetime: BOOLEAN
			-- Is this value representable as a DATETIME?
		do
				Result := False
		end

	is_representable_as_year: BOOLEAN
			-- Is this value representable as a YEAR?
		do
				Result := False
		end

feature -- Access (Set Conformance)

	is_representable_as_set: BOOLEAN
			-- Is this value representable as a SET?
		do
				Result := False
		end

feature -- Access (Types)

	as_boolean: BOOLEAN
			-- This value as a BOOLEAN
		do
			if value > 0 then
				Result := True
			else
				Result := False
			end
		end

	as_character_8: CHARACTER_8
			-- This value as a CHARACTER_8
		do
			Result := value.to_character_8
		end

	as_character_32: CHARACTER_32
			-- This value as a CHARACTER_32
		do
			Result := value.to_character_32
		end

	as_natural_8: NATURAL_8
			-- This value as a NATURAL_8
		do
			Result := value.as_natural_8
		end

	as_natural_16: NATURAL_16
			-- This value as a NATURAL_16
		do
			Result := value.as_natural_16
		end

	as_natural_32: NATURAL_32
			-- This value as a NATURAL_32
		do
			Result := value.as_natural_32
		end

	as_natural_64: NATURAL_64
			-- This value as a NATURAL_64
		do
			Result := value
		end

	as_integer_8: INTEGER_8
			-- This value as a INTEGER_8
		do
			Result := value.as_integer_8
		end

	as_integer_16: INTEGER_16
			-- This value as a INTEGER_16
		do
			Result := value.as_integer_16
		end

	as_integer_32: INTEGER_32
			-- This value as a INTEGER_32
		do
			Result := value.as_integer_32
		end

	as_integer_64: INTEGER_64
			-- This value as a INTEGER_64
		do
			Result := value.as_integer_64
		end

	as_real_32: REAL_32
			-- This value as a REAL_32
		do
			Result := value.as_integer_32
		end

	as_real_64: REAL_64
			-- This value as a REAL_64
		do
			Result := value.as_integer_32
		end

	as_string_8: STRING_8
			-- This value as a STRING_8
		do
			Result := as_integer.out
		end

	as_string_32: STRING_32
			-- This value as a STRING_32
		do
			Result := as_integer.out
		end

feature -- Access (Date and Time Types)

	as_date_and_time_tuple: TUPLE [years, months, days, hours, minutes, seconds: INTEGER_32]
			-- This value as a TUPLE
		do
			create Result.default_create
			raise ("MYSQLI_BIT_VALUE.as_date_and_time_tuple: current 'value' is not representable as a date and time tuple.")
		end

	as_timestamp: DATE_TIME
			-- This value as a DATE_TIME
		do
			create Result.make_now
			raise ("MYSQLI_BIT_VALUE.as_timestamp: current 'value' is not representable as a timestamp.")
		end

	as_date: DATE
			-- This value as a DATE
		do
			create Result.make_now
			raise ("MYSQLI_BIT_VALUE.as_date: current 'value' is not representable as a date.")
		end

	as_time: TIME
			-- This value as a TIME
		do
			create Result.make_now
			raise ("MYSQLI_BIT_VALUE.as_time: current 'value' is not representable as a time.")
		end

	as_datetime: DATE_TIME
			-- This value as a DATE_TIME
		do
			create Result.make_now
			raise ("MYSQLI_BIT_VALUE.as_datetime: current 'value' is not representable as a datetime.")
		end

	as_year: INTEGER
			-- This value as a INTEGER
		do
			raise ("MYSQLI_BIT_VALUE.as_year: current 'value' is not representable as a year.")
		end

feature -- Access (Set Type)

	as_set: SET [STRING]
			-- This value as a SET [STRING]
		local
			l_linked_set: LINKED_SET [STRING]
		do
			create l_linked_set.make
			Result := l_linked_set
			raise ("MYSQLI_BIT_VALUE.as_set: current 'value' is not representable as a set.")
		end

end
