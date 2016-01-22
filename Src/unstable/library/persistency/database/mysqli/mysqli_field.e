note
	description: "MySQL Field Class"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_FIELD

inherit
	MYSQLI_EXTERNALS
		redefine
			out
		end

create{MYSQLI_EXTERNALS}
	make

feature{NONE} -- Initialization

	make (a_field: POINTER)
			-- Initialize field
		do
			create name.make_from_c (c_struct_mysql_field_name (a_field))
			create org_name.make_from_c (c_struct_mysql_field_org_name (a_field))
			create table.make_from_c (c_struct_mysql_field_table (a_field))
			create org_table.make_from_c (c_struct_mysql_field_org_table (a_field))
			create db.make_from_c (c_struct_mysql_field_db (a_field))
			create catalog.make_from_c (c_struct_mysql_field_catalog (a_field))
--			create def.make_from_c (c_struct_mysql_field_def (a_field))
			length := c_struct_mysql_field_length (a_field)
			max_length := c_struct_mysql_field_max_length (a_field)
			name_length := c_struct_mysql_field_name_length (a_field)
			org_name_length := c_struct_mysql_field_org_name_length (a_field)
			table_length := c_struct_mysql_field_table_length (a_field)
			org_table_length := c_struct_mysql_field_org_table_length (a_field)
			db_length := c_struct_mysql_field_db_length (a_field)
			catalog_length := c_struct_mysql_field_catalog_length (a_field)
			def_length := c_struct_mysql_field_def_length (a_field)
			flags := c_struct_mysql_field_flags (a_field)
			decimals := c_struct_mysql_field_decimals (a_field)
			charsetnr := c_struct_mysql_field_charsetnr (a_field)
			type := c_struct_mysql_field_type (a_field)
		end

feature -- Access

	name: STRING
		-- The name of the field, as a null-terminated string.
		-- If the field was given an alias with an AS clause, the value of name is the alias.

	org_name: STRING
		-- The name of the field, as a null-terminated string.
		-- Aliases are ignored.

	table: STRING
		-- The name of the table containing this field, if it isn't a calculated field.
		-- For calculated fields, the table value is an empty string.
		-- If the column is selected from a view, table names the view.
		-- If the table or view was given an alias with an AS clause, the value of table is the alias.
		-- For a UNION, the value is the empty string.

	org_table: STRING
		-- The name of the table, as a null-terminated string.
		-- Aliases are ignored.
		-- If the column is selected from a view, org_table names the underlying table.
		-- For a UNION, the value is the empty string.

	db: STRING
		-- The name of the database that the field comes from, as a null-terminated string.
		-- If the field is a calculated field, db is an empty string.
		-- For a UNION, the value is the empty string.

	catalog: STRING
		-- The catalog name. This value is always "def".

	def: detachable STRING
		-- The default value of this field, as a null-terminated string.
		-- This is set only if you use mysql_list_fields().

	length: NATURAL_32
		-- The width of the field. This corresponds to the display length, in bytes.
		-- The server determines the length value before it generates the result set,
		-- so this is the minimum length required for a data type capable of holding the largest possible value from the result column,
		-- without knowing in advance the actual values that will be produced by the query for the result set.

	max_length: NATURAL_32
		-- The maximum width of the field for the result set (the length in bytes of the longest field value for the rows actually in the result set).
		-- If you use mysql_store_result() or mysql_list_fields(), this contains the maximum length for the field.
		-- If you use mysql_use_result(), the value of this variable is zero.
		-- The value of max_length is the length of the string representation of the values in the result set.
		-- For example, if you retrieve a FLOAT column and the "widest" value is -12.345, max_length is 7 (the length of '-12.345').
		-- If you are using prepared statements, max_length is not set by default because for the binary protocol the lengths of the values depend on the types of the values in the result set.
		-- (See Section 20.9.5, "C API Prepared Statement Data Structures".)
		-- If you want the max_length values anyway, enable the STMT_ATTR_UPDATE_MAX_LENGTH option with mysql_stmt_attr_set() and the lengths will be set when you call mysql_stmt_store_result().
		-- (See Section 20.9.7.3, "mysql_stmt_attr_set()", and Section 20.9.7.27, "mysql_stmt_store_result()".)

	name_length: NATURAL_32
		-- The length of name.

	org_name_length: NATURAL_32
		-- The length of org_name.

	table_length: NATURAL_32
		-- The length of table.

	org_table_length: NATURAL_32
		-- The length of org_table.

	db_length: NATURAL_32
		-- The length of db.

	catalog_length: NATURAL_32
		-- The length of catalog.

	def_length: NATURAL_32
		-- The length of def.

	flags: NATURAL_32
		-- Bit-flags that describe the field.
		-- The flags value may have zero or more of the following bits set.

	decimals: NATURAL_32
		-- The number of decimals for numeric fields.

	charsetnr: NATURAL_32
		-- An ID number that indicates the character set/collation pair for the field.
		-- To distinguish between binary and nonbinary data for string data types, check whether the charsetnr value is 63.
		-- If so, the character set is binary, which indicates binary rather than nonbinary data.
		-- This enables you to distinguish BINARY from CHAR, VARBINARY from VARCHAR, and the BLOB types from the TEXT types.
		-- charsetnr values are the same as those displayed in the Id column of the SHOW COLLATION statement or the ID column of the INFORMATION_SCHEMA COLLATIONS table.
		-- You can use those information sources to see which character set and collation specific charsetnr values indicate:

	type: INTEGER_32
		-- The type of the field. The type value may be one of the MYSQLI_TYPE_ symbols shown in the following table.

feature -- Access

	is_not_null: BOOLEAN
			-- True if this field is defined as NOT NULL
		do
			Result := c_is_not_null (flags.as_integer_32) /= 0
		end

	is_primary_key: BOOLEAN
			-- True if this field is a primary key
		do
			Result := c_is_pri_key (flags.as_integer_32) /= 0
		end

	is_blob: BOOLEAN
			-- True if this field is a BLOB or TEXT
		do
			Result := c_is_blob (flags.as_integer_32) /= 0
		end

	is_numeric: BOOLEAN
			-- Whether a field has a numeric type
		do
			Result := c_is_num (flags.as_integer_32) /= 0
		end

	is_unsigned: BOOLEAN
			-- Field has the UNSIGNED attribute
		do
			Result := (flags.as_integer_32 & UNSIGNED_FLAG) /= 0
		end

	is_unique_key: BOOLEAN
			-- Field is part of a unique key
		do
			Result := (flags.as_integer_32 & UNIQUE_KEY_FLAG) /= 0
		end

	is_multiple_key: BOOLEAN
			-- Field is part of a nonunique key
		do
			Result := (flags.as_integer_32 & MULTIPLE_KEY_FLAG) /= 0
		end

	is_zerofill: BOOLEAN
			-- Field has the ZEROFILL attribute
		do
			Result := (flags.as_integer_32 & ZEROFILL_FLAG) /= 0
		end

	is_binary: BOOLEAN
			-- Field has the BINARY attribute
		do
			Result := (flags.as_integer_32 & BINARY_FLAG) /= 0
		end

	is_auto_increment: BOOLEAN
			-- Field has the AUTO_INCREMENT attribute
		do
			Result := (flags.as_integer_32 & AUTO_INCREMENT_FLAG) /= 0
		end

	is_enum: BOOLEAN
			-- Field is an ENUM
		do
			Result := (flags.as_integer_32 & ENUM_FLAG) /= 0
		end

	is_set: BOOLEAN
			-- Field is a SET
		do
			Result := (flags.as_integer_32 & SET_FLAG) /= 0
		end

	is_timestamp: BOOLEAN
			-- Field is a TIMESTAMP
		do
			Result := (flags.as_integer_32 & TIMESTAMP_FLAG) /= 0
		end

	is_no_default: BOOLEAN
			-- Field has no default value
		do
			Result := (flags.as_integer_32 & NO_DEFAULT_VALUE_FLAG) /= 0
		end

	is_date_time: BOOLEAN
			-- Is this field a MySQL TIMESTAMP/DATETIME/DATE/TIME field?
		do
			Result := is_timestamp_field or is_datetime_field or is_date_field or is_time_field
		end

feature -- Access

	is_tinyint_field: BOOLEAN
			-- Is this field a MySQL TINYINT field?
		do
			Result := (type = MYSQL_TYPE_TINY)
		end

	is_smallint_field: BOOLEAN
			-- Is this field a MySQL SMALLINT field?
		do
			Result := (type = MYSQL_TYPE_SHORT)
		end

	is_integer_field: BOOLEAN
			-- Is this field a MySQL INTEGER field?
		do
			Result := (type = MYSQL_TYPE_LONG)
		end

	is_mediumint_field: BOOLEAN
			-- Is this field a MySQL MEDIUMINT field?
		do
			Result := (type = MYSQL_TYPE_INT24)
		end

	is_bigint_field: BOOLEAN
			-- Is this field a MySQL BIGINT field?
		do
			Result := (type = MYSQL_TYPE_LONGLONG)
		end

	is_decimal_field: BOOLEAN
			-- Is this field a MySQL DECIMAL or NUMERIC field?
		do
			Result := (type = MYSQL_TYPE_DECIMAL)
		end

	is_newdecimal_field: BOOLEAN
			-- Is this field a MySQL Precision math DECIMAL or NUMERIC?
		do
			Result := (type = MYSQL_TYPE_NEWDECIMAL)
		end

	is_float_field: BOOLEAN
			-- Is this field a MySQL FLOAT field?
		do
			Result := (type = MYSQL_TYPE_FLOAT)
		end

	is_double_field: BOOLEAN
			-- Is this field a MySQL DOUBLE or REAL field?
		do
			Result := (type = MYSQL_TYPE_DOUBLE)
		end

	is_bit_field: BOOLEAN
			-- Is this field a MySQL BIT field?
		do
			Result := (type = MYSQL_TYPE_BIT)
		end

	is_timestamp_field: BOOLEAN
			-- Is this field a MySQL TIMESTAMP field?
		do
			Result := (type = MYSQL_TYPE_TIMESTAMP)
		end

	is_date_field: BOOLEAN
			-- Is this field a MySQL DATE field?
		do
			Result := (type = MYSQL_TYPE_DATE)
		end

	is_time_field: BOOLEAN
			-- Is this field a MySQL TIME field?
		do
			Result := (type = MYSQL_TYPE_TIME)
		end

	is_datetime_field: BOOLEAN
			-- Is this field a MySQL DATETIME field?
		do
			Result := (type = MYSQL_TYPE_DATETIME)
		end

	is_year_field: BOOLEAN
			-- Is this field a MySQL YEAR field?
		do
			Result := (type = MYSQL_TYPE_YEAR)
		end

	is_char_field: BOOLEAN
			-- Is this field a MySQL CHAR or BINARY field?
		do
			Result := (type = MYSQL_TYPE_STRING)
		end

	is_varchar_field: BOOLEAN
			-- Is this field a MySQL VARCHAR or VARBINARY field?
		do
			Result := (type = MYSQL_TYPE_VAR_STRING)
		end

	is_text_field: BOOLEAN
			-- Is this field a MySQL BLOB or TEXT field?
		do
			Result := (type = MYSQL_TYPE_BLOB)
		end

	is_set_field: BOOLEAN
			-- Is this field a MySQL SET field?
		do
			Result := (type = MYSQL_TYPE_SET)
		end

	is_enum_field: BOOLEAN
			-- Is this field a MySQL ENUM field?
		do
			Result := (type = MYSQL_TYPE_ENUM)
		end

	is_geometry_field: BOOLEAN
			-- Is this field a MySQL Spatial field?
		do
			Result := (type = MYSQL_TYPE_GEOMETRY)
		end

	is_null_field: BOOLEAN
			-- Is this field a MySQL NULL-type field?
		do
			Result := (type = MYSQL_TYPE_NULL)
		end

feature -- Access

	out: STRING
			-- Returns the name and the max_length of this field
		once ("OBJECT")
			create Result.make_empty
			Result.append (table)
			Result.append_character ('.')
			Result.append (name)
			Result.append (once " (max_length in this result: ")
			Result.append_natural_32 (max_length)
			Result.append_character (')')
		end

end
