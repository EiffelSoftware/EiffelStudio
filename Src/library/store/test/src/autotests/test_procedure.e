note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_PROCEDURE

inherit
	TEST_BASIC_DATABASE
		redefine
			on_prepare
		end

feature {NONE} -- Prepare

	on_prepare
			-- On prepare
		do
			Precursor
			set_use_extended_types (True)
			set_is_decimal_used (True)
			set_decimal_functions (agent create_decimal, agent is_decimal, agent decimal_factors, agent decimal_output)
			set_default_decimal_scale (2)
		end

feature -- Test routines

	test_procedure
			-- New test routine
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				extended_select_load_data
				if not is_oracle then
					basic_select_make_selection
				else
					oracle_change
				end
			end
			disconnect
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
			Result.force (create {PROCEDURE_DATA}.make, table_name)
		end

	create_data: PROCEDURE_DATA
			-- Filled book to put into database
		do
			create Result.make
			Result.set_year (create {DATE_TIME}.make (1990, 10, 1, 0, 0, 0))
			Result.set_title ({STRING_32} "面向对象软件构造")
			Result.set_author ("Bertrand Meyer")
			Result.set_int_16 (9999)
			Result.set_int_32 (999999)
			Result.set_int_64 (9999999999999999)
			Result.set_real_32_t (888.888)
			Result.set_real_64_t (88888888.888888)
			Result.set_numeric_t (create {DECIMAL}.make_from_string ("1.00"))
		end

feature {NONE} -- Test procedure

	extended_select_load_data
			-- Create table in database with same structure as 'book'
		local
			l_book: like create_data
		do
			prepare_repository (table_name)

			if attached base_stores.item (table_name) as l_db_store then
				l_book := create_data
				l_db_store.put (l_book)
			end

				-- Put more data using direct SQL
			if is_mysql then
				execute_query ({STRING_32} "insert into DB_TEST_PROCEDURE_TABLE (title, author, year, int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values ('面向对象软件构造', 'Bertrand Meyer', {d '1986-06-07'}, 9999, 999999, 9999999999999999, 888.888, 88888888.888888, 1.00)")
			end

			if is_odbc then
				execute_query ({STRING_32} "insert into " + sql_table_name (table_name) + {STRING_32} " (title, author, year, int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values ('面向对象软件构造', 'Bertrand Meyer', {d '1986-06-07'}, 9999, 999999, 9999999999999999, 888.888, 88888888.888888, 1.00)")
			end

			if is_oracle then
				execute_query ({STRING_32} "insert into DB_TEST_PROCEDURE_TABLE (title, author, year, int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values ('Name to replace', 'Bertrand Meyer', to_date ('1986', 'YYYY'), 9999, 999999, 9999999999999999, 888.888, 88888888.888888, 1.00)")
			end

			if is_sybase then
				execute_query ({STRING_32} "insert into DB_TEST_PROCEDURE_TABLE (title, author, year, int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values ('面向对象软件构造', 'Bertrand Meyer', '1986-06-07', 9999, 999999, 9999999999999999, 888.888, 88888888.888888, 1.00)")
			end
		end

	prepare_procedure (a_name: STRING; a_text: STRING; a_arg_names: like {DB_PROC}.arguments_name_32; a_args_type: like {DB_PROC}.arguments_type): DB_PROC
			-- Initialize procedure
		do
			create Result.make (procedure_name)
			Result.load
			if Result.exists then
				Result.drop
				assert ("Dropping procedure failed", Result.is_ok)
			end

				-- Recreate the procedure
			create Result.make (procedure_name)
			Result.load
			if
				attached a_arg_names and then not a_arg_names.is_empty and
				attached a_args_type and then not a_args_type.is_empty
			then
				Result.set_arguments_32 (a_arg_names, a_args_type)
			end
			Result.store (a_text)
			if Result.is_ok then
				Result.load
			else
				assert ("Procedure creation failed", False)
			end
		end

	basic_select_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like create_data]
			l_proc: DB_PROC
			l_object: like create_data
		do
			l_object := create_data
			l_proc := prepare_procedure (procedure_name, basic_select_select_data,
				 {ARRAY [STRING_32]} <<"a_title", "a_author", "a_year", "a_int_16", "a_int_32", "a_int_64", "a_real_32_t", "a_real_64_t", "a_numeric_t">>,
				 <<l_object.title, l_object.author, l_object.year, l_object.int_16, l_object.int_32, l_object.int_64, l_object.real_32_t, l_object.real_64_t, l_object.numeric_t>>)
			if l_proc.exists then

				db_selection.set_map_name (l_object.title, "a_title")
				db_selection.set_map_name (l_object.author, "a_author")
				db_selection.set_map_name (l_object.year, "a_year")
				db_selection.set_map_name (l_object.int_16, "a_int_16")
				db_selection.set_map_name (l_object.int_32, "a_int_32")
				db_selection.set_map_name (l_object.int_64, "a_int_64")
				db_selection.set_map_name (l_object.real_32_t, "a_real_32_t")
				db_selection.set_map_name (l_object.real_64_t, "a_real_64_t")
				db_selection.set_map_name (l_object.numeric_t, "a_numeric_t")

				l_proc.execute (db_selection)
				assert ("Has no error", l_proc.is_ok)

				l_list := load_list_with_selection (db_selection, l_object)

				assert ("Result is expected", l_list.count = 1)

				db_selection.unset_map_name ("a_title")
				db_selection.unset_map_name ("a_author")
				db_selection.unset_map_name ("a_year")
				db_selection.unset_map_name ("a_int_16")
				db_selection.unset_map_name ("a_int_32")
				db_selection.unset_map_name ("a_int_64")
				db_selection.unset_map_name ("a_real_32_t")
				db_selection.unset_map_name ("a_real_64_t")
				db_selection.unset_map_name ("a_numeric_t")
			else
				assert ("Procedure does not exist.", False)
			end
		end

	oracle_change
			-- Oracle does not support selection in stored procedure.
			-- We test it using a change.
		local
			l_list: ARRAYED_LIST [like create_data]
			l_proc: DB_PROC
			l_object: like create_data
		do
			l_object := create_data
			l_proc := prepare_procedure (procedure_name, basic_select_select_data,
				 <<{STRING_32} "a_title">>,
				 <<l_object.title>>)

					-- Oracle does not support Unicode at the moment.
			l_object.set_title ("Object-Oriented Software Construction")

			if l_proc.exists then

				db_change.set_map_name (l_object.title, "a_title")

				l_proc.execute (db_change)
				assert ("Has no error", l_proc.is_ok)

				db_selection.set_query (oracle_query_string)
				db_selection.execute_query
				l_list := load_list_with_selection (db_selection, l_object)

				assert ("Result is expected", l_list.count = 1)
				if is_oracle then
					assert ("Title changed", l_list.first.title.same_string ("Object-Oriented Software Construction"))
				end
			else
				assert ("Procedure does not exist.", False)
			end
		end

	load_list_with_selection (a_selection: DB_SELECTION; an_obj: ANY): ARRAYED_LIST [like an_obj]
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
		require
			created: session_control_created
		local
			db_actions: DB_ACTION [like an_obj]
			l_session_control: like session_control
			l_result: detachable ARRAYED_LIST [like an_obj]
		do
			l_session_control := session_control
			check
				l_session_control /= Void
			end
			a_selection.object_convert (an_obj)
			create db_actions.make (a_selection, an_obj)
			a_selection.set_action (db_actions)
			if a_selection.is_ok then
				a_selection.load_result
				if a_selection.is_ok then
					l_result := db_actions.list
				end
			end
			a_selection.terminate
			if attached l_result as l_r then
				Result := l_r
			else
				create Result.make (0)
			end
		end

feature {NONE} -- Implementation

	basic_select_select_data: STRING
		once
			if is_mysql then
				Result := "SELECT * from DB_TEST_PROCEDURE_TABLE where title=a_title AND author=a_author AND year=a_year AND int_16=a_int_16 AND int_32=a_int_32 AND int_64=a_int_64 AND real_32_t=a_real_32_t AND real_64_t=a_real_64_t AND numeric_t=a_numeric_t"
			elseif is_oracle then
				Result := "UPDATE DB_TEST_PROCEDURE_TABLE set title=a_title"
			else
				Result := "SELECT * from " + sql_table_name (table_name) + " where title=:a_title AND author=:a_author AND year=:a_year AND int_16=:a_int_16 AND int_32=:a_int_32 AND int_64=:a_int_64 AND real_32_t=:a_real_32_t AND real_64_t=:a_real_64_t AND numeric_t=:a_numeric_t"
			end
		end

	oracle_query_string: STRING = "SELECT * FROM DB_TEST_PROCEDURE_TABLE"

	table_name: STRING = "DB_TEST_PROCEDURE_TABLE"

	procedure_name: STRING = "DB_TEST_PROCEDURE"

end


