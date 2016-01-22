note
	description: "MYSQLI Library AutoTest Class"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_TEST_CLASS

inherit
	EQA_TEST_SET

feature -- Test Routines (General)

	my_test_commands
		do
			client.execute_query ("DROP TABLE IF EXISTS `test_eiffel_mysql`")
			assert ("simple_last_results_one_after_drop", client.last_results.count = 1)
			assert ("simple_last_result_empty_after_drop", client.last_result.count = 0)
			assert ("simple_last_result_fields_empty_after_drop", client.last_result.fields.count = 0)
			client.execute_query ("CREATE TABLE `test_eiffel_mysql` ( `a_primary_key_integer` INTEGER NOT NULL AUTO_INCREMENT, `a_unique_key_integer` INTEGER, `a_multiple_key_integer_1` INTEGER, `a_multiple_key_integer_2` INTEGER UNSIGNED, `a_zerofill_integer` INTEGER ZEROFILL, `a_tinyint` TINYINT, `a_tinyint_unsigned` TINYINT UNSIGNED, `a_smallint` SMALLINT, `a_smallint_unsigned` SMALLINT UNSIGNED, `a_mediumint` MEDIUMINT, `a_mediumint_unsigned` MEDIUMINT UNSIGNED, `a_bigint` BIGINT, `a_bigint_unsigned` BIGINT UNSIGNED, `a_decimal` DECIMAL(5,2), `a_float` FLOAT, `a_double` DOUBLE, `a_bit` BIT, `a_timestamp` TIMESTAMP, `a_date` DATE, `a_time` TIME, `a_datetime` DATETIME, `a_year` YEAR, `a_char` CHAR(10), `a_binary_char` CHAR(10) BINARY, `a_varchar` VARCHAR(10), `a_text` TEXT, `a_set` SET('a', 'b', 'c'), `a_enum` ENUM('a', 'b', 'c'), `a_default_value_integer` INTEGER DEFAULT 42, PRIMARY KEY (`a_primary_key_integer`), UNIQUE KEY (`a_unique_key_integer`), KEY (`a_multiple_key_integer_1`, `a_multiple_key_integer_2`)) ENGINE=MyISAM DEFAULT CHARSET=latin1")
			assert ("simple_last_results_one_after_create", client.last_results.count = 1)
			assert ("simple_last_result_empty_after_create", client.last_result.count = 0)
			assert ("simple_last_result_fields_empty_after_create", client.last_result.fields.count = 0)
			client.execute_query ("INSERT INTO `test_eiffel_mysql` (`a_primary_key_integer`) VALUES (NULL), (NULL), (NULL), (NULL), (NULL)")
			assert ("simple_last_results_one_after_insert", client.last_results.count = 1)
			assert ("simple_last_result_empty_after_insert", client.last_result.count = 0)
			assert ("simple_last_result_fields_empty_after_insert", client.last_result.fields.count = 0)
			assert ("simple_insert_id", client.last_result.last_insert_id = 1)
			client.execute_query ("DELETE FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 5")
			assert ("simple_last_results_one_after_delete", client.last_results.count = 1)
			assert ("simple_last_result_empty_after_delete", client.last_result.count = 0)
			assert ("simple_last_result_fields_empty_after_delete", client.last_result.fields.count = 0)
			assert ("simple_affected_rows", client.last_result.affected_rows = 1)
		end

	my_test_simple_last_result
		do
			client.execute_query ("SELECT * FROM `test_eiffel_mysql`")
			assert ("simple_last_result_not_void_after_select", client.last_result /= Void)
			assert ("simple_last_results_not_void_after_select", client.last_results /= Void)
			assert ("simple_last_results_one_after_select", client.last_results.count = 1)
			assert ("simple_last_results_first_same_as_last_result", client.last_results.at (1) = client.last_result)
			assert ("simple_last_result_column_count", client.last_result.fields.count = 29)
			assert ("simple_last_result_row_count", client.last_result.count = 4)

			assert ("simple_last_result_column_1", client.last_result.fields.at (1) = client.last_result.field_by_name ("a_primary_key_integer"))
			assert ("simple_last_result_column_29", client.last_result.fields.at (29) = client.last_result.field_by_name ("a_default_value_integer"))

			assert ("simple_last_result_column_1_name", client.last_result.fields.at (1).name.same_string ("a_primary_key_integer"))
			assert ("simple_last_result_column_29_name", client.last_result.fields.at (29).name.same_string ("a_default_value_integer"))

			assert ("simple_last_result_value_1_1", client.last_result.at (1).at (1) = client.last_result.at (1).at_field ("a_primary_key_integer"))
			assert ("simple_last_result_value_1_29", client.last_result.at (1).at (29) = client.last_result.at (1).at_field ("a_default_value_integer"))

			assert ("simple_last_result_value_1_1_value", client.last_result.at (1).at (1).as_string.same_string ("1"))
			assert ("simple_last_result_value_1_29_value", client.last_result.at (1).at (29).as_string.same_string ("42"))

			assert ("simple_last_result_value_1_2_null", client.last_result.at (1).at (2).is_null_value)
			assert ("simple_last_result_value_1_2_value", client.last_result.at (1).at (2).as_string.same_string ("NULL"))

			assert ("simple_last_result_field_1_is_not_null", client.last_result.fields.at (1).is_not_null = True)
			assert ("simple_last_result_field_2_is_null", client.last_result.fields.at (2).is_not_null = False)

			assert ("simple_last_result_field_1_is_primary_key", client.last_result.fields.at (1).is_primary_key = True)
			assert ("simple_last_result_field_2_is_not_primary_key", client.last_result.fields.at (2).is_primary_key = False)
		end

		my_test_simple_multi_query
			do
				client.execute_query ("SELECT 1 AS one; SELECT 2 AS two, 3 AS three;")
				assert ("simple_last_result_not_void_after_select", client.last_result /= Void)
				assert ("simple_last_results_not_void_after_select", client.last_results /= Void)
				assert ("simple_last_results_one_after_select", client.last_results.count = 2)
				assert ("simple_last_results_second_same_as_last_result", client.last_results.at (2) = client.last_result)
				assert ("simple_last_results_1_column_count", client.last_results.at (1).fields.count = 1)
				assert ("simple_last_results_1_row_count", client.last_results.at (1).count = 1)
				assert ("simple_last_results_2_column_count", client.last_results.at (2).fields.count = 2)
				assert ("simple_last_results_2_row_count", client.last_results.at (2).count = 1)
				assert ("simple_last_results_1_1_field", client.last_results.at (1).fields.at (1).name.same_string ("one"))
				assert ("simple_last_results_1_1_field", client.last_results.at (2).fields.at (1).name.same_string ("two"))
				assert ("simple_last_results_1_1_field", client.last_results.at (2).fields.at (2).name.same_string ("three"))
				assert ("simple_last_results_1_1_value", client.last_results.at (1).at (1).at (1).as_integer = 1)
				assert ("simple_last_results_2_2_value", client.last_results.at (2).at (1).at (1).as_integer = 2)
				assert ("simple_last_results_2_3_value", client.last_results.at (2).at (1).at (2).as_integer = 3)
			end

		my_test_prepared_statement_last_result
			local
				a_prepared_statement: STRING
			do
				create a_prepared_statement.make_from_string ("SELECT * FROM `test_eiffel_mysql`")
				client.prepare_statement (a_prepared_statement)
				if attached client.last_prepared_statement as prep
				then
					assert ("prepared_statement_last_statement_no_parameters", prep.parameters.count = 0)
					assert ("prepared_statement_last_statement_parameter_count_is_zero", prep.parameter_count = 0)
					prep.execute

					assert ("prepared_statement_last_result_column_count", prep.last_result.fields.count = 29)
					assert ("prepared_statement_last_result_row_count", prep.last_result.count = 4)

					assert ("prepared_statement_last_result_column_1", prep.last_result.fields.at (1) = prep.last_result.field_by_name ("a_primary_key_integer"))
					assert ("prepared_statement_last_result_column_29", prep.last_result.fields.at (29) = prep.last_result.field_by_name ("a_default_value_integer"))

					assert ("prepared_statement_last_result_column_1_name", prep.last_result.fields.at (1).name.same_string ("a_primary_key_integer"))
					assert ("prepared_statement_last_result_column_29_name", prep.last_result.fields.at (29).name.same_string ("a_default_value_integer"))

					assert ("prepared_statement_last_result_value_1_1", prep.last_result.at (1).at (1) = prep.last_result.at (1).at_field ("a_primary_key_integer"))
					assert ("prepared_statement_last_result_value_1_29", prep.last_result.at (1).at (29) = prep.last_result.at (1).at_field ("a_default_value_integer"))

					assert ("prepared_statement_last_result_value_1_1_value", prep.last_result.at (1).at (1).as_string.same_string ("1"))
					assert ("prepared_statement_last_result_value_1_29_value", prep.last_result.at (1).at (29).as_string.same_string ("42"))

					assert ("prepared_statement_last_result_value_1_2_null", prep.last_result.at (1).at (2).is_null_value)
					assert ("prepared_statement_last_result_value_1_2_value", prep.last_result.at (1).at (2).as_string.same_string ("NULL"))

					assert ("prepared_statement_last_result_value_1_1_long", prep.last_result.at (1).at (1).is_integer_value)
					assert ("prepared_statement_last_result_value_1_29_long", prep.last_result.at (1).at (29).is_integer_value)

					assert ("prepared_statement_last_result_value_1_1_long_value", prep.last_result.at (1).at (1).as_integer = 1)
					assert ("prepared_statement_last_result_value_1_29_long_value", prep.last_result.at (1).at (29).as_integer = 42)
				else
					print ("Prepared statement: '" + a_prepared_statement + "' failed.")
				end
			end

	my_test_virtual_fields
		do
			client.execute_query ("SELECT NULL, 2+3, 4 AS four")
			assert ("virtual_fields_null_column", client.last_result.fields.at (1).is_null_field)
			assert ("virtual_fields_expression_column", client.last_result.fields.at (2).name.same_string ("2+3"))
			assert ("virtual_fields_renamed_column", client.last_result.fields.at (3).name.same_string ("four"))
		end

feature -- Test Routines (Values)

	my_test_value_a_multiple_key_integer_1_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = '-2147483648' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_multiple_key_integer_1_value_set_to_-2147483648_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-2147483648"))
		end

	my_test_value_a_multiple_key_integer_1_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-2147483648"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_multiple_key_integer_1_value_set_to_-2147483648_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-2147483648"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_1_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_multiple_key_integer_1_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_multiple_key_integer_1_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_multiple_key_integer_1_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_1_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = '2147483647' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_multiple_key_integer_1_value_set_to_2147483647_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("2147483647"))
		end

	my_test_value_a_multiple_key_integer_1_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("2147483647"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_multiple_key_integer_1_value_set_to_2147483647_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("2147483647"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_2_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_multiple_key_integer_2_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_multiple_key_integer_2_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_multiple_key_integer_2_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_32.out.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_2_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = '4294967295' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_multiple_key_integer_2_value_set_to_4294967295_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("4294967295"))
		end

	my_test_value_a_multiple_key_integer_2_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("4294967295"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_multiple_key_integer_2_value_set_to_4294967295_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_32.out.same_string ("4294967295"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_zerofill_integer_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = '0000000000' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_zerofill_integer_value_set_to_0000000000_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0000000000"))
		end

	my_test_value_a_zerofill_integer_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0000000000"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_zerofill_integer_value_set_to_0000000000_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_32.out.same_string ("0000000000"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_zerofill_integer_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = '4294967295' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_zerofill_integer_value_set_to_4294967295_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("4294967295"))
		end

	my_test_value_a_zerofill_integer_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("4294967295"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_zerofill_integer_value_set_to_4294967295_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_32.out.same_string ("4294967295"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = '-128' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_tinyint_value_set_to_-128_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-128"))
		end

	my_test_value_a_tinyint_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-128"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_tinyint_value_set_to_-128_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-128"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_tinyint_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_tinyint_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_tinyint_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = '127' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_tinyint_value_set_to_127_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("127"))
		end

	my_test_value_a_tinyint_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("127"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_tinyint_value_set_to_127_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("127"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_unsigned_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_tinyint_unsigned_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_tinyint_unsigned_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_tinyint_unsigned_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_8.out.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_unsigned_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = '255' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_tinyint_unsigned_value_set_to_255_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("255"))
		end

	my_test_value_a_tinyint_unsigned_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("255"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_tinyint_unsigned_value_set_to_255_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_8.out.same_string ("255"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint` = '-32768' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_smallint_value_set_to_-32768_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-32768"))
		end

	my_test_value_a_smallint_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-32768"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_smallint_value_set_to_-32768_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-32768"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_smallint_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_smallint_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_smallint_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint` = '32767' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_smallint_value_set_to_32767_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("32767"))
		end

	my_test_value_a_smallint_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("32767"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallin` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_smallint_value_set_to_32767_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("32767"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_unsigned_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_smallint_unsigned_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_smallint_unsigned_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_smallint_unsigned_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_16.out.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_unsigned_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = '65535' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_smallint_unsigned_value_set_to_65535_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("65535"))
		end

	my_test_value_a_smallint_unsigned_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("65535"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_smallint_unsigned_value_set_to_65535_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_16.out.same_string ("65535"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = '-8388608' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_mediumint_value_set_to_-8388608_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-8388608"))
		end

	my_test_value_a_mediumint_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-8388608"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_mediumint_value_set_to_-8388608_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-8388608"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_mediumint_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_mediumint_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_mediumint_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = '8388607' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_mediumint_value_set_to_8388607_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("8388607"))
		end

	my_test_value_a_mediumint_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("8388607"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_mediumint_value_set_to_8388607_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("8388607"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_unsigned_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_mediumint_unsigned_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_mediumint_unsigned_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_mediumint_unsigned_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_64.out.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_unsigned_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = '16777215' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_mediumint_unsigned_value_set_to_16777215_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("16777215"))
		end

	my_test_value_a_mediumint_unsigned_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("16777215"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_mediumint_unsigned_value_set_to_16777215_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_64.out.same_string ("16777215"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint` = '-9223372036854775808' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_bigint_value_set_to_-9223372036854775808_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-9223372036854775808"))
		end

	my_test_value_a_bigint_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-9223372036854775808"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_bigint_value_set_to_-9223372036854775808_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-9223372036854775808"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_bigint_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_bigint_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_bigint_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint` = '9223372036854775807' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_bigint_value_set_to_9223372036854775807_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("9223372036854775807"))
		end

	my_test_value_a_bigint_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("9223372036854775807"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_bigint_value_set_to_9223372036854775807_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("9223372036854775807"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_unsigned_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_bigint_unsigned_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_bigint_unsigned_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_bigint_unsigned_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_64.out.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_unsigned_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = '18446744073709551615' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_bigint_unsigned_value_set_to_18446744073709551615_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("18446744073709551615"))
		end

	my_test_value_a_bigint_unsigned_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("18446744073709551615"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_bigint_unsigned_value_set_to_18446744073709551615_as_string_prepared_statement", prep.last_result.at (1).at (1).as_natural_64.out.same_string ("18446744073709551615"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = '-999.99' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_decimal_value_set_to_-999.99_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-999.99"))
		end

	my_test_value_a_decimal_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-999.99"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_decimal_value_set_to_-999.99_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-999.99"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = '0.00' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_decimal_value_set_to_0.00_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0.00"))
		end

	my_test_value_a_decimal_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0.00"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_decimal_value_set_to_0.00_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0.00"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = '999.99' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_decimal_value_set_to_999.99_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("999.99"))
		end

	my_test_value_a_decimal_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("999.99"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_decimal_value_set_to_999.99_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("999.99"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_float_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_float` = '-1.2' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_float_value_set_to_-1.2_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-1.2"))
		end

	my_test_value_a_float_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_float` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-1.2"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_float_value_set_to_-1.2_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-1.2"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_float_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_float` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_float_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_float_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_float` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_float_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_float_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_float` = '1.2' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_float_value_set_to_1.2_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1.2"))
		end

	my_test_value_a_float_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_float` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1.2"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_float_value_set_to_1.2_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1.2"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_double_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_double` = '-1.2' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_double_value_set_to_-1.2_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("-1.2"))
		end

	my_test_value_a_double_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_double` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("-1.2"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_double_value_set_to_-1.2_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("-1.2"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_double_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_double` = '0' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_double_value_set_to_0_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0"))
		end

	my_test_value_a_double_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_double` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_double_value_set_to_0_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_double_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_double` = '1.2' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_double_value_set_to_1.2_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1.2"))
		end

	my_test_value_a_double_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_double` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1.2"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_double_value_set_to_1.2_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1.2"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_timestamp_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_timestamp` = '1970-01-01 00:00:01' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_timestamp` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_timestamp_value_set_to_1970-01-01 00:00:01_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1970-01-01 00:00:01"))
		end

	my_test_value_a_timestamp_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_timestamp` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1970-01-01 00:00:01"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_timestamp` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_timestamp_value_set_to_1970-01-01 00:00:01_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1970-01-01 00:00:01"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_timestamp_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_timestamp` = '2038-01-18 03:14:07' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_timestamp` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_timestamp_value_set_to_2038-01-18 03:14:07_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("2038-01-18 03:14:07"))
		end

	my_test_value_a_timestamp_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_timestamp` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("2038-01-18 03:14:07"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_timestamp` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_timestamp_value_set_to_2038-01-18 03:14:07_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("2038-01-18 03:14:07"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_date_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_date` = '1000-01-01' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_date` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_date_value_set_to_1000-01-01_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1000-01-01"))
		end

	my_test_value_a_date_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_date` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1000-01-01"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_date` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_date_value_set_to_1000-01-01_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1000-01-01"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_date_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_date` = '9999-12-31' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_date` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_date_value_set_to_9999-12-31_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("9999-12-31"))
		end

	my_test_value_a_date_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_date` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("9999-12-31"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_date` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_date_value_set_to_9999-12-31_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("9999-12-31"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_time_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_time` = '12:59:59' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_time` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_time_value_set_to_12:59:59_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("12:59:59"))
		end

	my_test_value_a_time_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_time` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("12:59:59"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_time` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_time_value_set_to_12:59:59_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("12:59:59"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_datetime_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_datetime` = '1000-01-01 00:00:00' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_datetime` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_datetime_value_set_to_1000-01-01 00:00:00_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1000-01-01 00:00:00"))
		end

	my_test_value_a_datetime_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_datetime` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1000-01-01 00:00:00"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_datetime` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_datetime_value_set_to_1000-01-01 00:00:00_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1000-01-01 00:00:00"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_datetime_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_datetime` = '9999-12-31 23:59:59' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_datetime` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_datetime_value_set_to_9999-12-31 23:59:59_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("9999-12-31 23:59:59"))
		end

	my_test_value_a_datetime_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_datetime` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("9999-12-31 23:59:59"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_datetime` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_datetime_value_set_to_9999-12-31 23:59:59_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("9999-12-31 23:59:59"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_year_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_year` = '1901' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_year_value_set_to_1901_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1901"))
		end

	my_test_value_a_year_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_year` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1901"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_year_value_set_to_1901_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1901"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_year_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_year` = '0000' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_year_value_set_to_0000_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("0000"))
		end

	my_test_value_a_year_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_year` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("0000"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_year_value_set_to_0000_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("0"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_year_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_year` = '2155' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_year_value_set_to_2155_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("2155"))
		end

	my_test_value_a_year_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_year` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("2155"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_year_value_set_to_2155_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("2155"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_char_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_char` = '' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_char_value_set_to__as_string_simple", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_char_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_char` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_char_value_set_to__as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_char_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_char` = '1234567890' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_char_value_set_to_1234567890_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_char_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_char` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_char_value_set_to_1234567890_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_binary_char_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = '' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_binary_char_value_set_to__as_string_simple", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_binary_char_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_binary_char_value_set_to__as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_binary_char_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = '1234567890' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_binary_char_value_set_to_1234567890_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_binary_char_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_binary_char_value_set_to_1234567890_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_varchar_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_varchar` = '' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_varchar_value_set_to__as_string_simple", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_varchar_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_varchar` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_varchar_value_set_to__as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_varchar_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_varchar` = '1234567890' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_varchar_value_set_to_1234567890_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_varchar_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_varchar` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_varchar_value_set_to_1234567890_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_text_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_text` = '' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_text_value_set_to__as_string_simple", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_text_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_text` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_text_value_set_to__as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_text_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_text` = '1234567890' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_text_value_set_to_1234567890_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_text_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_text` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_text_value_set_to_1234567890_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_set_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_set` = '' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_set_value_set_to__as_string_simple", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_set_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_set` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_set_value_set_to__as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_set_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_set` = 'a,b' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_set_value_set_to_a,b_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("a,b"))
		end

	my_test_value_a_set_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_set` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("a,b"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_set_value_set_to_a,b_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("a,b"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_set_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_set` = 'a,c' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_set_value_set_to_a,c_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("a,c"))
		end

	my_test_value_a_set_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_set` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("a,c"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_set_value_set_to_a,c_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("a,c"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_enum_simple_with_string_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_enum` = '' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_enum_value_set_to__as_string_simple", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_enum_prepared_statement_with_string_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_enum` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_enum_value_set_to__a_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_enum_simple_with_string_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_enum` = 'a' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_enum_value_set_to_a_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("a"))
		end

	my_test_value_a_enum_prepared_statement_with_string_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_enum` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("a"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_enum_value_set_to_a_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("a"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_enum_simple_with_string_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_enum` = 'b' WHERE `a_primary_key_integer` = 1")
			client.execute_query ("SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 1")
			assert ("a_enum_value_set_to_b_as_string_simple", client.last_result.at (1).at (1).as_string.same_string ("b"))
		end

	my_test_value_a_enum_prepared_statement_with_string_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_enum` = ? WHERE `a_primary_key_integer` = 2")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("b"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 2"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("a_enum_value_set_to_b_as_string_prepared_statement", prep.last_result.at (1).at (1).as_string.same_string ("b"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_1_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = -2147483648 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_multiple_key_integer_1_value_set_to_-2147483648", client.last_result.at (1).at (1).as_integer_32 = -2147483648)
		end

	my_test_value_a_multiple_key_integer_1_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_integer_32 (-2147483648), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_multiple_key_integer_1_value_set_to_-2147483648", prep.last_result.at (1).at (1).as_integer_32 = -2147483648)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_1_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_multiple_key_integer_1_value_set_to_0", client.last_result.at (1).at (1).as_integer_32 = 0)
		end

	my_test_value_a_multiple_key_integer_1_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_multiple_key_integer_1_value_set_to_0", prep.last_result.at (1).at (1).as_natural_32 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_1_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = 2147483647 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_multiple_key_integer_1_value_set_to_2147483647", client.last_result.at (1).at (1).as_integer_32 = 2147483647)
		end

	my_test_value_a_multiple_key_integer_1_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_1` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (2147483647), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_1` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_multiple_key_integer_1_value_set_to_2147483647", prep.last_result.at (1).at (1).as_natural_32 = 2147483647)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_2_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_multiple_key_integer_2_value_set_to_0", client.last_result.at (1).at (1).as_natural_32 = 0)
		end

	my_test_value_a_multiple_key_integer_2_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_multiple_key_integer_2_value_set_to_0", prep.last_result.at (1).at (1).as_natural_32 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_multiple_key_integer_2_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = 4294967295 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_multiple_key_integer_2_value_set_to_4294967295", client.last_result.at (1).at (1).as_natural_32 = 4294967295)
		end

	my_test_value_a_multiple_key_integer_2_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_multiple_key_integer_2` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (4294967295), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_multiple_key_integer_2` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_multiple_key_integer_2_value_set_to_4294967295", prep.last_result.at (1).at (1).as_natural_32 = 4294967295)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_zerofill_integer_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_zerofill_integer_value_set_to_0", client.last_result.at (1).at (1).as_natural_32 = 0)
		end

	my_test_value_a_zerofill_integer_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_zerofill_integer_value_set_to_0", prep.last_result.at (1).at (1).as_natural_32 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_zerofill_integer_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = 4294967295 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_zerofill_integer_value_set_to_4294967295", client.last_result.at (1).at (1).as_natural_32 = 4294967295)
		end

	my_test_value_a_zerofill_integer_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_zerofill_integer` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (4294967295), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_zerofill_integer` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_zerofill_integer_value_set_to_4294967295", prep.last_result.at (1).at (1).as_natural_32 = 4294967295)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = -128 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_tinyint_value_set_to_-128", client.last_result.at (1).at (1).as_integer_8 = -128)
		end

	my_test_value_a_tinyint_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TINYINT_VALUE}.make_as_integer_8 (-128), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_tinyint_value_set_to_-128", prep.last_result.at (1).at (1).as_integer_32 = -128)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_tinyint_value_set_to_0", client.last_result.at (1).at (1).as_integer_8 = 0)
		end

	my_test_value_a_tinyint_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TINYINT_VALUE}.make_as_natural_8 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_tinyint_value_set_to_0", prep.last_result.at (1).at (1).as_integer_32 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = 127 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_tinyint_value_set_to_127", client.last_result.at (1).at (1).as_integer_32 = 127)
		end

	my_test_value_a_tinyint_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TINYINT_VALUE}.make_as_natural_8 (127), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_tinyint_value_set_to_127", prep.last_result.at (1).at (1).as_integer_32 = 127)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_unsigned_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_tinyint_unsigned_value_set_to_0", client.last_result.at (1).at (1).as_natural_8 = 0)
		end

	my_test_value_a_tinyint_unsigned_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TINYINT_VALUE}.make_as_natural_8 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_tinyint_unsigned_value_set_to_0", prep.last_result.at (1).at (1).as_natural_8 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_tinyint_unsigned_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = 255 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_tinyint_unsigned_value_set_to_255", client.last_result.at (1).at (1).as_natural_8 = 255)
		end

	my_test_value_a_tinyint_unsigned_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_tinyint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TINYINT_VALUE}.make_as_natural_8 (255), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_tinyint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_tinyint_unsigned_value_set_to_255", prep.last_result.at (1).at (1).as_natural_8 = 255)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint` = -32768 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_smallint_value_set_to_-32768", client.last_result.at (1).at (1).as_integer_16 = -32768)
		end

	my_test_value_a_smallint_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SMALLINT_VALUE}.make_as_integer_16 (-32768), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_smallint_value_set_to_-32768", prep.last_result.at (1).at (1).as_integer_16 = -32768)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_smallint_value_set_to_0", client.last_result.at (1).at (1).as_integer_16 = 0)
		end

	my_test_value_a_smallint_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SMALLINT_VALUE}.make_as_integer_16 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_smallint_value_set_to_0", prep.last_result.at (1).at (1).as_integer_16 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint` = 32767 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_smallint_value_set_to_32767", client.last_result.at (1).at (1).as_integer_16 = 32767)
		end

	my_test_value_a_smallint_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SMALLINT_VALUE}.make_as_integer_16 (32767), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_smallint_value_set_to_32767", prep.last_result.at (1).at (1).as_integer_16 = 32767)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_unsigned_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_smallint_unsigned_value_set_to_0", client.last_result.at (1).at (1).as_natural_16 = 0)
		end

	my_test_value_a_smallint_unsigned_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SMALLINT_VALUE}.make_as_natural_16 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_smallint_unsigned_value_set_to_0", prep.last_result.at (1).at (1).as_natural_16 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_smallint_unsigned_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = 65535 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_smallint_unsigned_value_set_to_65535", client.last_result.at (1).at (1).as_natural_16 = 65535)
		end

	my_test_value_a_smallint_unsigned_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_smallint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SMALLINT_VALUE}.make_as_natural_16 (65535), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_smallint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_smallint_unsigned_value_set_to_65535", prep.last_result.at (1).at (1).as_natural_16 = 65535)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = -8388608 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_mediumint_value_set_to_-8388608", client.last_result.at (1).at (1).as_integer_32 = -8388608)
		end

	my_test_value_a_mediumint_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_MEDIUMINT_VALUE}.make_as_integer_32 (-8388608), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_mediumint_value_set_to_-8388608", prep.last_result.at (1).at (1).as_integer_32 = -8388608)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_mediumint_value_set_to_0", client.last_result.at (1).at (1).as_integer_32 = 0)
		end

	my_test_value_a_mediumint_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_MEDIUMINT_VALUE}.make_as_integer_32 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_mediumint_value_set_to_0", prep.last_result.at (1).at (1).as_integer_32 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = 8388607 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_mediumint_value_set_to_8388607", client.last_result.at (1).at (1).as_integer_32 = 8388607)
		end

	my_test_value_a_mediumint_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_MEDIUMINT_VALUE}.make_as_integer_32 (8388607), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_mediumint_value_set_to_8388607", prep.last_result.at (1).at (1).as_integer_32 = 8388607)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_unsigned_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_mediumint_unsigned_value_set_to_0", client.last_result.at (1).at (1).as_natural_32 = 0)
		end

	my_test_value_a_mediumint_unsigned_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_MEDIUMINT_VALUE}.make_as_natural_32 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_mediumint_unsigned_value_set_to_0", prep.last_result.at (1).at (1).as_natural_32 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_mediumint_unsigned_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = 16777215 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_mediumint_unsigned_value_set_to_16777215", client.last_result.at (1).at (1).as_natural_32 = 16777215)
		end

	my_test_value_a_mediumint_unsigned_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_mediumint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_MEDIUMINT_VALUE}.make_as_natural_32 (16777215), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_mediumint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_mediumint_unsigned_value_set_to_16777215", prep.last_result.at (1).at (1).as_natural_32 = 16777215)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint` = -9223372036854775808 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bigint_value_set_to_-9223372036854775808", client.last_result.at (1).at (1).as_integer_64 = -9223372036854775808)
		end

	my_test_value_a_bigint_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIGINT_VALUE}.make_as_integer_64 (-9223372036854775808), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bigint_value_set_to_-9223372036854775808", prep.last_result.at (1).at (1).as_integer_64 = -9223372036854775808)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bigint_value_set_to_0", client.last_result.at (1).at (1).as_integer_64 = 0)
		end

	my_test_value_a_bigint_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIGINT_VALUE}.make_as_integer_64 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bigint_value_set_to_0", prep.last_result.at (1).at (1).as_integer_64 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint` = 9223372036854775807 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bigint_value_set_to_9223372036854775807", client.last_result.at (1).at (1).as_integer_64 = 9223372036854775807)
		end

	my_test_value_a_bigint_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIGINT_VALUE}.make_as_integer_64 (9223372036854775807), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bigint_value_set_to_9223372036854775807", prep.last_result.at (1).at (1).as_integer_64 = 9223372036854775807)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_unsigned_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bigint_unsigned_value_set_to_0", client.last_result.at (1).at (1).as_natural_64 = 0)
		end

	my_test_value_a_bigint_unsigned_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIGINT_VALUE}.make_as_natural_64 (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bigint_unsigned_value_set_to_0", prep.last_result.at (1).at (1).as_natural_64 = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bigint_unsigned_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = 18446744073709551615 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bigint_unsigned_value_set_to_18446744073709551615", client.last_result.at (1).at (1).as_natural_64 = 18446744073709551615)
		end

	my_test_value_a_bigint_unsigned_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bigint_unsigned` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIGINT_VALUE}.make_as_natural_64 (18446744073709551615), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bigint_unsigned` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bigint_unsigned_value_set_to_18446744073709551615", prep.last_result.at (1).at (1).as_natural_64 = 18446744073709551615)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = %"-999.99%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_decimal_value_set_to_-999.99", client.last_result.at (1).at (1).as_string.same_string ("-999.99"))
		end

	my_test_value_a_decimal_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_NEWDECIMAL_VALUE}.make ("-999.99"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_decimal_value_set_to_-999.99", prep.last_result.at (1).at (1).as_string.same_string ("-999.99"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = %"0.00%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_decimal_value_set_to_0.00", client.last_result.at (1).at (1).as_string.same_string ("0.00"))
		end

	my_test_value_a_decimal_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_NEWDECIMAL_VALUE}.make ("0.00"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_decimal_value_set_to_0.00", prep.last_result.at (1).at (1).as_string.same_string ("0.00"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = %"999.99%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_decimal_value_set_to_999.99", client.last_result.at (1).at (1).as_string.same_string ("999.99"))
		end

	my_test_value_a_decimal_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_NEWDECIMAL_VALUE}.make ("999.99"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_decimal_value_set_to_999.99", prep.last_result.at (1).at (1).as_string.same_string ("999.99"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_decimal_simple_4
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_decimal` = 123.45 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_decimal_value_set_to_123.45", client.last_result.at (1).at (1).as_double = 123.45)
		end

	my_test_value_a_decimal_prepared_statement_4
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_decimal` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DOUBLE_VALUE}.make (123.45), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_decimal` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
			assert ("prepared_statement_a_decimal_value_set_to_123.45", prep.last_result.at (1).at (1).as_double = 123.45)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_float_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_float` = -1.2 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_float_value_set_to_-1.2", client.last_result.at (1).at (1).as_real = -1.2)
		end

	my_test_value_a_float_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_float` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_FLOAT_VALUE}.make (-1.2), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_float_value_set_to_-1.2", prep.last_result.at (1).at (1).as_real = -1.2)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_float_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_float` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_float_value_set_to_0", client.last_result.at (1).at (1).as_real = 0)
		end

	my_test_value_a_float_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_float` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_FLOAT_VALUE}.make (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_float_value_set_to_0", prep.last_result.at (1).at (1).as_real = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_float_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_float` = 1.2 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_float_value_set_to_1.2", client.last_result.at (1).at (1).as_real = 1.2)
		end

	my_test_value_a_float_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_float` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_FLOAT_VALUE}.make (1.2), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_float` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_float_value_set_to_1.2", prep.last_result.at (1).at (1).as_real = 1.2)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_double_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_double` = -1.2 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_double_value_set_to_-1.2", client.last_result.at (1).at (1).as_double = -1.2)
		end

	my_test_value_a_double_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_double` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DOUBLE_VALUE}.make (-1.2), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_double_value_set_to_-1.2", prep.last_result.at (1).at (1).as_double = -1.2)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_double_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_double` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_double_value_set_to_0", client.last_result.at (1).at (1).as_double = 0)
		end

	my_test_value_a_double_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_double` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DOUBLE_VALUE}.make (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_double_value_set_to_0", prep.last_result.at (1).at (1).as_double = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_double_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_double` = 1.2 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_double_value_set_to_1.2", client.last_result.at (1).at (1).as_double = 1.2)
		end

	my_test_value_a_double_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_double` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DOUBLE_VALUE}.make (1.2), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_double` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_double_value_set_to_1.2", prep.last_result.at (1).at (1).as_double = 1.2)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bit_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bit` = 1 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bit` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bit_value_set_to_1", client.last_result.at (1).at (1).as_string.at (1).code = 1)
		end

	my_test_value_a_bit_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bit` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIT_VALUE}.make (1), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bit` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bit_value_set_to_1", prep.last_result.at (1).at (1).as_integer = 1)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_bit_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_bit` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_bit` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_bit_value_set_to_0", client.last_result.at (1).at (1).as_string.at (1).code = 0)
		end

	my_test_value_a_bit_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_bit` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_BIT_VALUE}.make (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_bit` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_bit_value_set_to_0", prep.last_result.at (1).at (1).as_integer = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_timestamp_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_timestamp` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DATETIME_VALUE}.make_as_date_time (datetime), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_timestamp` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
			assert ("prepared_statement_a_timestamp_value_set_to_datetime", prep.last_result.at (1).at (1).as_string.same_string(datetime.formatted_out (once "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss")))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_date_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_date` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DATE_VALUE}.make_as_date (datetime.date), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_date` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				assert ("prepared_statement_a_date_value_set_to_datetime.date", prep.last_result.at (1).at (1).as_string.same_string(datetime.formatted_out (once "yyyy-[0]mm-[0]dd")))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_time_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_time` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TIME_VALUE}.make_as_time (datetime.time), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_time` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.execute
				io.put_string ("Value: "+ prep.last_result.at (1).at (1).as_string + "%N")
				assert ("prepared_statement_a_time_value_set_to_datetime.time", prep.last_result.at (1).at (1).as_string.same_string(datetime.formatted_out (once "[0]hh:[0]mi:[0]ss")))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_datetime_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_datetime` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_DATETIME_VALUE}.make_as_date_time (datetime), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_datetime` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_datetime_value_set_to_datetime", prep.last_result.at (1).at (1).as_string.same_string(datetime.formatted_out (once "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss")))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_year_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_year` = 1901 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_year_value_set_to_1901", client.last_result.at (1).at (1).as_integer = 1901)
		end

	my_test_value_a_year_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_year` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_YEAR_VALUE}.make (1901), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_year_value_set_to_1901", prep.last_result.at (1).at (1).as_integer = 1901)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_year_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_year` = 0 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_year_value_set_to_0", client.last_result.at (1).at (1).as_integer = 0)
		end

	my_test_value_a_year_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_year` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_YEAR_VALUE}.make (0), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_year_value_set_to_0", prep.last_result.at (1).at (1).as_integer = 0)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_year_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_year` = 2155 WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_year_value_set_to_2155", client.last_result.at (1).at (1).as_integer = 2155)
		end

	my_test_value_a_year_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_year` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_YEAR_VALUE}.make (2155), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_year` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_year_value_set_to_2155", prep.last_result.at (1).at (1).as_integer = 2155)
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_char_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_char` = %"%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_char_value_set_to_", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_char_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_char` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_CHAR_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_char_value_set_to_", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_char_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_char` = %"1234567890%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_char_value_set_to_1234567890", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_char_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_char` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_CHAR_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_char_value_set_to_1234567890", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_binary_char_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = %"%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_binary_char_value_set_to_", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_binary_char_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_CHAR_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_binary_char_value_set_to_", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_binary_char_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = %"1234567890%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_binary_char_value_set_to_1234567890", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_binary_char_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_binary_char` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_CHAR_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_binary_char` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_binary_char_value_set_to_1234567890", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_varchar_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_varchar` = %"%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_varchar_value_set_to_", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_varchar_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_varchar` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_VARCHAR_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_varchar_value_set_to_", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_varchar_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_varchar` = %"1234567890%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_varchar_value_set_to_1234567890", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_varchar_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_varchar` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_VARCHAR_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_varchar` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_varchar_value_set_to_1234567890", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_text_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_text` = %"%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_text_value_set_to_", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_text_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_text` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_text_value_set_to_", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_text_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_text` = %"1234567890%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_text_value_set_to_1234567890", client.last_result.at (1).at (1).as_string.same_string ("1234567890"))
		end

	my_test_value_a_text_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_text` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_TEXT_VALUE}.make ("1234567890"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_text` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_text_value_set_to_1234567890", prep.last_result.at (1).at (1).as_string.same_string ("1234567890"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_set_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_set` = %"%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_set_value_set_to_", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_set_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_set` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SET_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_set_value_set_to_", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_set_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_set` = %"a,b%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_set_value_set_to_a,b", client.last_result.at (1).at (1).as_string.same_string ("a,b"))
		end

	my_test_value_a_set_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_set` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SET_VALUE}.make ("a,b"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_set_value_set_to_a,b", prep.last_result.at (1).at (1).as_string.same_string ("a,b"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_set_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_set` = %"a,c%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_set_value_set_to_a,c", client.last_result.at (1).at (1).as_string.same_string ("a,c"))
		end

	my_test_value_a_set_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_set` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_SET_VALUE}.make ("a,c"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_set` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_set_value_set_to_a,c", prep.last_result.at (1).at (1).as_string.same_string ("a,c"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_enum_simple_1
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_enum` = %"%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_enum_value_set_to_", client.last_result.at (1).at (1).as_string.same_string (""))
		end

	my_test_value_a_enum_prepared_statement_1
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_enum` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_ENUM_VALUE}.make (""), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_enum_value_set_to_", prep.last_result.at (1).at (1).as_string.same_string (""))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_enum_simple_2
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_enum` = %"a%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_enum_value_set_to_a", client.last_result.at (1).at (1).as_string.same_string ("a"))
		end

	my_test_value_a_enum_prepared_statement_2
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_enum` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_ENUM_VALUE}.make ("a"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_enum_value_set_to_a", prep.last_result.at (1).at (1).as_string.same_string ("a"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

	my_test_value_a_enum_simple_3
		do
			client.execute_query ("UPDATE `test_eiffel_mysql` SET `a_enum` = %"b%" WHERE `a_primary_key_integer` = 3")
			client.execute_query ("SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 3")
			assert ("a_enum_value_set_to_b", client.last_result.at (1).at (1).as_string.same_string ("b"))
		end

	my_test_value_a_enum_prepared_statement_3
		local
			a_prepared_statement: STRING
		do
			create a_prepared_statement.make_from_string ("UPDATE `test_eiffel_mysql` SET `a_enum` = ? WHERE `a_primary_key_integer` = 4")
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
				prep.parameters.put_i_th (create {MYSQLI_ENUM_VALUE}.make ("b"), 1)
				prep.execute
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
			a_prepared_statement := "SELECT `a_enum` FROM `test_eiffel_mysql` WHERE `a_primary_key_integer` = 4"
			client.prepare_statement (a_prepared_statement)
			if attached client.last_prepared_statement as prep then
					prep.execute
					assert ("prepared_statement_a_enum_value_set_to_b", prep.last_result.at (1).at (1).as_string.same_string ("b"))
			else
				print ("Prepared statement: '" + a_prepared_statement + "' failed.")
			end
		end

feature{NONE} -- Helpers

	client: MYSQLI_CLIENT
		once
			create Result.make
			Result.set_password ("pollo")
			Result.connect
			Result.execute_query ("DROP TABLE IF EXISTS `test_eiffel_mysql`")
			Result.execute_query ("CREATE TABLE `test_eiffel_mysql` ( `a_primary_key_integer` INTEGER NOT NULL AUTO_INCREMENT, `a_unique_key_integer` INTEGER, `a_multiple_key_integer_1` INTEGER, `a_multiple_key_integer_2` INTEGER UNSIGNED, `a_zerofill_integer` INTEGER ZEROFILL, `a_tinyint` TINYINT, `a_tinyint_unsigned` TINYINT UNSIGNED, `a_smallint` SMALLINT, `a_smallint_unsigned` SMALLINT UNSIGNED, `a_mediumint` MEDIUMINT, `a_mediumint_unsigned` MEDIUMINT UNSIGNED, `a_bigint` BIGINT, `a_bigint_unsigned` BIGINT UNSIGNED, `a_decimal` DECIMAL(5,2), `a_float` FLOAT, `a_double` DOUBLE, `a_bit` BIT, `a_timestamp` TIMESTAMP, `a_date` DATE, `a_time` TIME, `a_datetime` DATETIME, `a_year` YEAR, `a_char` CHAR(10), `a_binary_char` CHAR(10) BINARY, `a_varchar` VARCHAR(10), `a_text` TEXT, `a_set` SET('a', 'b', 'c'), `a_enum` ENUM('a', 'b', 'c'), `a_default_value_integer` INTEGER DEFAULT 42, PRIMARY KEY (`a_primary_key_integer`), UNIQUE KEY (`a_unique_key_integer`), KEY (`a_multiple_key_integer_1`, `a_multiple_key_integer_2`)) ENGINE=MyISAM DEFAULT CHARSET=latin1")
			Result.execute_query ("INSERT INTO `test_eiffel_mysql` (`a_primary_key_integer`) VALUES (NULL), (NULL), (NULL), (NULL)")
		end

	datetime: DATE_TIME
	  once
	    create Result.make_fine (1987, 6, 5, 4, 3, 2.0)
	  end

end
