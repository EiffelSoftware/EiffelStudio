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
		do
			Precursor;
			(create {GLOBAL_SETTINGS}).set_use_extended_types (True)
		end

feature -- Test routines

	test_numeric_types
			-- Test select using extended type
		do
			establish_connection

			if not session_control.is_connected then
				assert ("Could not connect to database", False)
			else
				numeric_types_load_data
				numeric_types_make_selection
			end
			disconnect
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
		end

	numeric_types_data: NUMERIC_INFO

	numeric_types_load_data
			-- Load data
		local
			l_data: like numeric_types_create_data
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
		do
			drop_repository (numeric_types_table_name)

				-- Put more data using direct SQL
			if is_mysql then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 BIGINT, real_32_t FLOAT, real_64_t REAL, numeric_t DECIMAL(19,10))")
				execute_query ("insert into DB_NUMERIC_TYPES (int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values (1, 10000, 100000000, 7898.34, 999999.999999, -999999999.999999)")
			end

			if is_odbc then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 bigint, real_32_t real, real_64_t float, numeric_t decimal(19,10))")
				execute_query ("insert into DB_NUMERIC_TYPES (int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values (1, 10000, 100000000, 7898.34, 999999.999999, -999999999.999999)")
			end

			if is_oracle then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 NUMBER(19), real_32_t FLOAT, real_64_t FLOAT, numeric_t DECIMAL(19,10))")
				execute_query ("insert into DB_NUMERIC_TYPES (int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values (1, 10000, 100000000, 7898.34, 999999.999999, -999999999.999999)")
			end

			if is_sybase then
				execute_query ("create table DB_NUMERIC_TYPES (int_16 SMALLINT, int_32 INT, int_64 bigint, real_32_t real, real_64_t float, numeric_t decimal(19,10))")
				execute_query ("insert into DB_NUMERIC_TYPES (int_16, int_32, int_64, real_32_t, real_64_t, numeric_t) values (1, 10000, 100000000, 7898.34, 999999.999999, -999999999.999999)")
			end

			create l_repository.make (numeric_types_table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)
			l_data := numeric_types_create_data
			l_db_store.put (l_data)
			numeric_types_data := l_data
		end

	numeric_types_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like numeric_types_create_data]
			l_data: like numeric_types_create_data
		do
			l_data := numeric_types_create_data
			db_selection.set_map_name (l_data.int_16, "int_16")
			db_selection.set_map_name (l_data.int_32, "int_32")
			db_selection.set_map_name (l_data.int_64, "int_64")
			db_selection.set_map_name (l_data.real_32_t, "real_32_t")
			db_selection.set_map_name (l_data.real_64_t, "real_64_t")
			db_selection.set_map_name (l_data.numeric_t, "numeric_t")
			l_list := load_list_with_select (numeric_types_select_data, numeric_types_create_data)
			if l_list.count = 2 then
				assert ("Result is not expected", l_list.i_th (1) ~ l_data)
				assert ("Result is not expected", l_list.i_th (2) ~ l_data)
			else
				assert ("Number of results is not expected", False)
			end
		end

	numeric_types_select_data: STRING =
--		"select * from DB_NUMERIC_TYPES where int_16 = :int_16, int_32 = :int_32, int_64 = :int_64, real_32_t = :real_32_t, real_64_t = :real_64_t, numeric_t = :numeric_t)"
		"select * from DB_NUMERIC_TYPES"

	numeric_types_table_name: STRING = "DB_NUMERIC_TYPES"

end
