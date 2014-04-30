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
				test_simple_insert
				test_insert
				test_update
			end
			disconnect
		end

feature {NONE} -- Implementation

	new_data (a_id: INTEGER; a_uni, a_small_uni: STRING_32; a_ascii, a_small_ascii: STRING_8): UNICODE_DATA
			-- Filled data to put into database
		do
			create Result.make (a_id)
			Result.set_unicode (a_uni)
			Result.set_small_unicode (a_small_uni)
			Result.set_ascii (a_ascii)
			Result.set_small_ascii (a_small_ascii)
		end

	test_load_data
			-- Create table in database with same structure as 'new_data'
		do
			drop_repository (table_name)

			if is_odbc then
				execute_query ("CREATE TABLE db_large_values (unicode nvarchar(max), id int, ascii varchar(max), small_unicode nvarchar(100), small_ascii varchar(100))")
			end

			if is_mysql then
				execute_query ("CREATE TABLE `DB_LARGE_VALUES` (`unicode` VARCHAR(65532) CHARSET ucs2, `id` int, `ascii` varchar(65532),`small_unicode` VARCHAR(100) CHARSET ucs2, `small_ascii` varchar(100))")
			end

			if is_oracle then
				execute_query ("CREATE TABLE DB_LARGE_VALUES (unicode nvarchar2(65535), id int, ascii varchar(65535), small_unicode nvarchar2(100), small_ascii varchar(100))")
			end
		end

	test_simple_insert
			-- Insert and update objects using NULL values.
		local
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
			l_data: like new_data
			l_list: ARRAYED_LIST [like new_data]
			l_ascii, l_small_ascii: STRING_8
			l_unicode, l_small_unicode: STRING_32
		do
				-- Setup repository for adding data.
			create l_repository.make (table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)

				-- Adding a data with Void values directly
			l_unicode := new_unicode (data_size, 'a', 'b', 'c')
			l_small_unicode := new_unicode (small_data_size, 'a', 'b', 'c')
			l_ascii := new_ascii (data_size, 'a', 'b', 'c')
			l_small_ascii := new_ascii (small_data_size, 'a', 'b', 'c')
			l_data := new_data (1, l_unicode, l_small_unicode, l_ascii, l_small_ascii)

			l_db_store.put (l_data)
				-- Check that the stored data is valid.
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name), create {like new_data}.make (0))
			if l_list.count = 1 then
				assert ("1 - Same Unicode", l_list.first.unicode ~ l_unicode)
				assert ("1 - Same ASCII", l_list.first.ascii ~ l_ascii)
				assert ("1 - Same Small Unicode", l_list.first.small_unicode ~ l_small_unicode)
				assert ("1 - Same Small ASCII", l_list.first.small_ascii ~ l_small_ascii)
			else
				assert ("1 - Number of results is not expected", False)
			end
		end

	test_insert
			-- Select books
		local
			l_data: like new_data
			l_list: ARRAYED_LIST [like new_data]
			l_ascii, l_small_ascii: STRING_8
			l_unicode, l_small_unicode: STRING_32
			l_change: DB_DYN_CHANGE
		do
				-- Adding a data with Void values directly
			l_unicode := new_unicode (data_size, 'Z', 'U', 'Y')
			l_small_unicode := new_unicode (small_data_size, 'Z', 'U', 'Y')
			l_ascii := new_ascii (data_size, 'Z', 'U', 'Y')
			l_small_ascii := new_ascii (small_data_size, 'Z', 'U', 'Y')
			l_data := new_data (2, l_unicode, l_small_unicode, l_ascii, l_small_ascii)

				-- We insert first the ID because we discovered a bug where if it was the
				-- first mapped value, the insert statement would not work on ODBC
				-- because we only called SQLDescribParams on the string arguments, but
				-- looks like you have to do it on all arguments.
			create l_change.make
			l_change.set_map_name (l_data.id, "id")
			l_change.set_map_name (l_unicode, "unicode")
			l_change.set_map_name (l_ascii, "ascii")
			l_change.set_map_name (l_small_unicode, "small_unicode")
			l_change.set_map_name (l_small_ascii, "small_ascii")
			l_change.prepare_32 ("insert into " + sql_table_name (table_name) + " (id, unicode, ascii, small_unicode, small_ascii) VALUES (:id, :unicode, :ascii, :small_unicode, :small_ascii)")
			l_change.unset_map_name ("unicode")
			l_change.unset_map_name ("small_unicode")
			l_change.unset_map_name ("ascii")
			l_change.unset_map_name ("small_ascii")
			l_change.execute
			l_change.terminate

				-- Check that the stored data is valid.
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where id = " + l_data.id.out, create {like new_data}.make (0))
			if l_list.count = 1 then
				assert ("1 - Same Unicode", l_list.first.unicode ~ l_unicode)
				assert ("1 - Same ASCII", l_list.first.ascii ~ l_ascii)
				assert ("1 - Same Small Unicode", l_list.first.small_unicode ~ l_small_unicode)
				assert ("1 - Same Small ASCII", l_list.first.small_ascii ~ l_small_ascii)
			else
				assert ("1 - Number of results is not expected", False)
			end
		end

	test_update
			-- Select books
		local
			l_list: ARRAYED_LIST [like new_data]
			l_ascii: STRING_8
			l_unicode: STRING_32
			l_change: DB_DYN_CHANGE
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
			l_data: like new_data
		do
				-- Adding a data with Void values directly
			l_unicode := {STRING_32} "Unicode"
			l_ascii := "ASCII"
			l_data := new_data (3, l_unicode, l_unicode, l_ascii, l_ascii)

				-- Setup repository for adding data.
			create l_repository.make (table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)
			l_db_store.put (l_data)

				-- Perform the update.
				-- Same as in `test_insert', `id' is the first mapped variable.
			create l_change.make
			l_unicode := {STRING_32} "CHANGED"
			l_change.set_map_name (4, "id")
			l_change.set_map_name (l_unicode, "unicode")
			l_change.set_map_name (l_ascii, "ascii")
			l_change.prepare_32 ("update " + sql_table_name (table_name) + " set id = :id, unicode = :unicode where ascii like :ascii")
			l_change.unset_map_name ("unicode")
			l_change.unset_map_name ("id")
			l_change.unset_map_name ("ascii")
			l_change.execute
			l_change.terminate

				-- Check that the stored data is valid.
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where id = 4", create {like new_data}.make (0))
			if l_list.count = 1 then
				assert ("1 - Same Unicode", l_list.first.unicode ~ l_unicode)
				assert ("1 - Same ASCII", l_list.first.ascii ~ l_ascii)
			else
				assert ("1 - Number of results is not expected", False)
			end
		end

	new_unicode (a_size: INTEGER; a_filler, a_start, a_end: CHARACTER_32): STRING_32
			-- New Unicode string of size `a_size' filled with `a_filler' with `a_start' as first
			-- character and `a_end' as last_character.
		require
			a_size_big_enough: a_size >= 2
		do
			create Result.make (a_size - 1)
			Result.fill_character (a_filler)
			Result.put (a_start, 1)
			Result.append_character (a_end)
		end

	new_ascii (a_size: INTEGER; a_filler, a_start, a_end: CHARACTER): STRING
			-- New ASCII string of size `a_size' filled with `a_filler' with `a_start' as first
			-- character and `a_end' as last_character.
		require
			a_size_big_enough: a_size >= 2
		do
			create Result.make (a_size - 1)
			Result.fill_character (a_filler)
			Result.put (a_start, 1)
			Result.append_character (a_end)
		end

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
		end

	table_name: STRING = "DB_LARGE_VALUES"

	data_size: INTEGER = 5000
	small_data_size: INTEGER = 100

end
