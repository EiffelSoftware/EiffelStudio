note
	description: "Summary description for {TEST_LARGE_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_LARGE_DATA

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

feature -- Testing

	test_large_string
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				test_load_data
				test_manipulate_data
			end
			disconnect
		end

feature {NONE} -- Implementation

	new_data: UNICODE_DATA
			-- Filled data to put into database
		do
			create Result.make
		end

	test_load_data
			-- Create table in database with same structure as 'new_data'
		do
			drop_repository (table_name)

			if is_odbc then
				execute_query ("CREATE TABLE db_large_values (unicode nvarchar(MAX), ascii varchar(MAX))")
			end

			if is_mysql then
				execute_query ("CREATE TABLE `DB_LARGE_VALUES` (`unicode` VARCHAR(65532) CHARSET ucs2, `ascii` varchar(65532))")
			end

			if is_oracle then
				execute_query ("CREATE TABLE DB_LARGE_VALUES (unicode nvarchar2(65535), ascii varchar(80))")
			end
		end

	test_manipulate_data
			-- Insert and update objects using NULL values.
		local
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
			l_dyn_change: DB_DYN_CHANGE
			l_change: DB_CHANGE
			l_data: like new_data
			l_list: ARRAYED_LIST [like new_data]
			l_ascii: STRING_8
			l_unicode: STRING_32
		do
				-- Setup repository for adding data.
			create l_repository.make (table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)

				-- Adding a data with Void values directly
			create l_unicode.make (5000)
			l_unicode.fill_character ('a')
			l_unicode.put ('b', 1)
			l_unicode.append_character ('c')
			create l_ascii.make (5000)
			l_ascii.fill_character ('a')
			l_ascii.put ('b', 1)
			l_ascii.append_character ('c')
			l_data := new_data
			l_data.set_ascii (l_ascii)
			l_data.set_unicode (l_unicode)
			l_db_store.put (l_data)
				-- Check that the stored data is valid.
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name), new_data)
			if l_list.count = 1 then
				assert ("1 - Same Unicode", l_list.first.unicode ~ l_unicode)
				assert ("1 - Same ASCII", l_list.first.ascii ~ l_ascii)
			else
				assert ("1 - Number of results is not expected", False)
			end
		end

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
		end

	table_name: STRING = "DB_LARGE_VALUES"

end
