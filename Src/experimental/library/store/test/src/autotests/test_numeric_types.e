note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_NUMERIC_TYPES

inherit
	TEST_BASIC_DATABASE
		redefine
			on_prepare
		end

feature {NONE} -- Prepare

	on_prepare
			-- Prepare
		local
		do
			Precursor;
			set_use_extended_types (True)
			set_default_decimal_scale (10)
			set_default_decimal_presicion (19)
		end

feature -- Test routines

	test_numeric_types
			-- Test select using extended type
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				numeric_types_load_data
				numeric_types_make_selection
			end
			disconnect
		end

	test_numeric_types_use_decimal_mode
			-- Test select using extended type
		do
			set_is_decimal_used (True)
			set_decimal_functions (agent create_decimal, agent is_decimal, agent decimal_factors, agent decimal_output)

			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				numeric_types_load_data
				numeric_types_with_decimal_make_selection
			end
			disconnect
			set_is_decimal_used (False)
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
				-- Do not create any object for the table to prevent table creation.
				-- We create the table directly by SQL in this test.
		end

feature {NONE} -- Basic select

	numeric_types_create_data: NUMERIC_INFO
			-- Filled data to put into database
		do
			create Result
			Result.set_int_16 ({INTEGER_16} 1)
			Result.set_int_32 ({INTEGER_32} 10000)
			Result.set_int_64 ({INTEGER_64} 100000000)
			Result.set_real_32_t ({REAL_32} 7898.34)
			Result.set_real_64_t ({REAL_64} 999999.999999)
			Result.set_numeric_t ({REAL_64} -999999999.999999)
			Result.set_other_numeric_t ({REAL_32} 88888.88)
		end

	numeric_types_create_data_with_decimal: NUMERIC_INFO_WITH_DECIMAL
			-- Filled data to put into database
		do
			create Result.make
			Result.set_int_16 ({INTEGER_16} 1)
			Result.set_int_32 ({INTEGER_32} 10000)
			Result.set_int_64 ({INTEGER_64} 100000000)
			Result.set_real_32_t ({REAL_32} 7898.34)
			Result.set_real_64_t ({REAL_64} 999999.999999)
			Result.set_numeric_t (create {DECIMAL}.make_from_string ("-999999999.999999"))
			Result.set_other_numeric_t (create {DECIMAL}.make_from_string ("88888.88"))
		end

	numeric_types_load_data
			-- Load data
		local
			l_data: like numeric_types_create_data
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
			l_change: DB_DYN_CHANGE
		do
			drop_repository (numeric_types_table_name)

				-- Put more data using direct SQL
			if is_mysql then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 BIGINT, real_32_t FLOAT, real_64_t DOUBLE, numeric_t DECIMAL(19,10), other_numeric_t DECIMAL(19,2))")
			end

			if is_oracle then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 NUMBER(19), real_32_t FLOAT, real_64_t FLOAT, numeric_t DECIMAL(19,10), other_numeric_t DECIMAL(19,2))")
			end

			if is_odbc or is_sybase then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 bigint, real_32_t real, real_64_t float, numeric_t DECIMAL(19,10), other_numeric_t DECIMAL(19,2))")
			end
			execute_query ("insert into DB_NUMERIC_TYPES (int_16, int_32, int_64, real_32_t, real_64_t, numeric_t, other_numeric_t) values (1, 10000, 100000000, 7898.34, 999999.999999, -999999999.999999, 88888.88)")

			create l_repository.make (numeric_types_table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)
			l_data := numeric_types_create_data
			l_db_store.put (l_data)

			create l_change.make
			l_change.set_map_name (l_data.int_16, "int_16")
			l_change.set_map_name (l_data.int_32, "int_32")
			l_change.set_map_name (l_data.int_64, "int_64")
			l_change.set_map_name (l_data.real_32_t, "real_32_t")
			l_change.set_map_name (l_data.real_64_t, "real_64_t")
			l_change.set_map_name (l_data.numeric_t, "numeric_t")
			l_change.set_map_name (l_data.other_numeric_t, "other_numeric_t")
			l_change.prepare_32 ("insert into DB_NUMERIC_TYPES (int_16, int_32, int_64, real_32_t, real_64_t, numeric_t, other_numeric_t) values (:int_16, :int_32, :int_64, :real_32_t, :real_64_t, :numeric_t, :other_numeric_t)")
			l_change.execute
			l_change.terminate
		end

	numeric_types_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like numeric_types_create_data]
			l_data: like numeric_types_create_data
		do
			l_data := numeric_types_create_data
			l_list := load_list_with_select (numeric_types_select_data, numeric_types_create_data)
			if l_list.count = 3 then
				assert ("Result is not expected", l_list.i_th (1) ~ l_data)
				assert ("Result is not expected", l_list.i_th (2) ~ l_data)
				assert ("Result is not expected", l_list.i_th (3) ~ l_data)
			else
				assert ("Number of results is not expected", False)
			end
		end

	numeric_types_with_decimal_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like numeric_types_create_data_with_decimal]
			l_data: like numeric_types_create_data_with_decimal
		do
			l_data := numeric_types_create_data_with_decimal
			l_list := load_list_with_select (numeric_types_select_data, numeric_types_create_data_with_decimal)
			if l_list.count = 3 then
				assert ("Result is not expected", l_list.i_th (1) ~ l_data)
					-- We slightly change the value here because when inserting "-999999999.999999" as a REAL_64 into
					-- a decimal fields, the actual REAL_64 value from the string is "-999999999.9999990500" and because
					-- the database stores a decimal and not a REAL_64 it keeps the digits as is.
				l_data.set_numeric_t (create {DECIMAL}.make_from_string ("-999999999.9999990500"))
				assert ("Result is not expected", l_list.i_th (2) ~ l_data)
				assert ("Result is not expected", l_list.i_th (3) ~ l_data)
			else
				assert ("Number of results is not expected", False)
			end
		end

	numeric_types_select_data: STRING
		once
			Result := "select * from " + numeric_types_table_name
		end

	numeric_types_table_name: STRING = "DB_NUMERIC_TYPES"

end
