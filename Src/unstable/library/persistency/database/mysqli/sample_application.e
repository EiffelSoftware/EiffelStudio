note
	description : "Summary description for {SAMPLE_APPLICATION}."
	date        : "$Date$"
	revision    : "$Revision$"

class
	SAMPLE_APPLICATION

inherit
	ARGUMENTS
	MYSQLI_EXTERNALS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local

			examples: MYSQLI_EXAMPLES
		do
			create examples
			examples.run_segfaulting_query
			examples.run_simple_example
			examples.run_prepared_statement_example
			examples.run_hash_table_example
			examples.run_transaction_example
		end

	classes
			-- To compile everything
		local
			a_test: MYSQLI_TEST_CLASS
			a_tinyint: MYSQLI_TINYINT_VALUE
			a_smallint: MYSQLI_SMALLINT_VALUE
			a_mediumint: MYSQLI_MEDIUMINT_VALUE
			a_bigint: MYSQLI_BIGINT_VALUE
			a_decimal: MYSQLI_DECIMAL_VALUE
			a_newdecimal: MYSQLI_NEWDECIMAL_VALUE
			a_float: MYSQLI_FLOAT_VALUE
			a_double: MYSQLI_DOUBLE_VALUE
			a_bit: MYSQLI_BIT_VALUE
			a_timestamp: MYSQLI_TIMESTAMP_VALUE
			a_date: MYSQLI_DATE_VALUE
			a_time: MYSQLI_TIME_VALUE
			a_datetime: MYSQLI_DATETIME_VALUE
			a_year: MYSQLI_YEAR_VALUE
			a_varchar: MYSQLI_VARCHAR_VALUE
			a_text: MYSQLI_TEXT_VALUE
			a_set: MYSQLI_SET_VALUE
			a_enum: MYSQLI_ENUM_VALUE
		do
		end

end
