note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ERROR_MESSAGE

inherit
	TEST_BASIC_DATABASE

feature -- Test routines

	test_error_message
			-- Test error message
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				prepare_repository (Basic_select_table_name)

				create_error
				check_error

					-- A query should not have error
					-- Test of recovery from query error.
				basic_select_load_data
				basic_select_make_selection
			end
			disconnect
		end

	test_error_recovery
			-- Test error recovery of DATABASE_MANAGER
		do
			if is_odbc then
				reset_database
				establish_connection

				if attached session_control as l_control and then not l_control.is_connected then
					assert ("Could not connect to database", False)
				else
					drop_repository (error_recovery_1_table_name)

					create_error_1

						-- A query should not have error
						-- Test of recovery from query error.
					error_recovery_make_selection
				end
				disconnect
			end
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
			-- [object, table_name]
		do
			create Result.make (1)
			Result.force (create {BOOK2}.make, basic_select_table_name)
		end

	create_error
			-- Create error
		do
			execute_query (
					"insert into A_VEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE%
					%RY_LONG_ERROR (title, author, quantity, price, year, double_value) values___ERROR ('Simula Begin', 'Birtwistle et al.', 12, 4, str_to_date('1973', '%%Y'), 3.5)"
			)
		end

	basic_select_load_data
			-- Execute a query without error
		local
			l_table_name: STRING
		do
				-- Put more data using direct SQL
			if is_mysql then
				execute_query ("insert into DB_BASIC_SELECT_ERROR_TEST (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, str_to_date('1973', '%%Y'), 23.767)")
			end

			if is_odbc then
				l_table_name := sql_table_name (basic_select_table_name)
				execute_query ("insert into " + l_table_name + " (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, " + sql_from_datetime (create {DATE_TIME}.make (1973, 1, 1, 0, 0, 0)) + ", 23.767)")
			end

			if is_oracle then
				execute_query ("insert into DB_BASIC_SELECT_ERROR_TEST (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, to_date('1973', 'YYYY'), 23.767)")
			end

			if is_sybase then
				execute_query ("insert into DB_BASIC_SELECT_ERROR_TEST (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, '01/01/1973', 23.767)")
			end
		end

	basic_select_create_data: BOOK2
			-- Filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_title ("%"Yangzi River\'")
			Result.set_double_value (2.3)
			Result.set_year (1980)
		end

	basic_select_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like basic_select_create_data]
			l_result: DB_TUPLE
		do
			l_list := load_list_with_select (basic_select_select_data, basic_select_create_data)

			if attached db_selection.cursor as l_c then
				create l_result.copy (l_c)
				assert ("Attached DATE_TIME object.", attached {DATE_TIME} l_result.item (3))
			end

			if l_list.count = 1 then
				assert ("Result is not expected", l_list.i_th (1).title ~ "Simula Begin" and then
													l_list.i_th (1).author ~ "Birtwistle et al." and then
													l_list.i_th (1).quantity = 12 and then
													l_list.i_th (1).price = 4 and then
													l_list.i_th (1).year.date.year = 1973 and then
													l_list.i_th (1).double_value = 23.767
													)
			else
				assert ("Number of results is not expected", False)
			end
		end

	basic_select_select_data: STRING
		do
			Result := "select * from " + sql_table_name (basic_select_table_name)
		end

	basic_select_table_name: STRING = "DB_BASIC_SELECT_ERROR_TEST"

	check_error
			-- Check the error
		local
			l_error: STRING_32
		do
			l_error := db_change.error_message_32
			assert ("Caught error message.", not l_error.ends_with ({STRING_32} "......%N"))
		end

feature {NONE} -- Implementation, Error recovery 1

	create_error_1
			-- Create error
		local
			l_table_name: STRING
			l_s: STRING
		do
			l_table_name := error_recovery_1_table_name
			l_s := "[
								CREATE TABLE [dbo].[XXXXXXXX](
									[id] [int] NOT NULL,
									[name] [nchar](10) NULL,
									CONSTRAINT UQ_Error_Rec_1 UNIQUE (id)
								)

						]"
			l_s.replace_substring_all ("XXXXXXXX", l_table_name)

			execute_query (l_s)

			execute_query ("insert into " + l_table_name + " (id, name) values (1, 'my name')")
				-- Insert data with the same id, which triggers an error.
			execute_query ("insert into " + l_table_name + " (id, name) values (1, 'my name')")
		end

	error_recovery_make_selection
			-- Select books
		do
			assert ("No data", attached load_data_with_select (error_recovery_select_data))
		end

	error_recovery_select_data: STRING
		do
			Result := "select * from " + error_recovery_1_table_name
		end

	error_recovery_1_table_name: STRING = "DB_ERROR_RECOVERY_1"

end
