note
	description: "Summary description for {TEST_LARGE_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_LARGE_DATA

inherit
	TEST_BASIC_DATABASE

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

	new_book: BOOK5
			-- Filled book to put into database
		do
			create Result
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_double_value (2.3)
			Result.set_year (1980)
		end

	test_load_data
			-- Create table in database with same structure as 'new_book'
		do
			drop_repository (table_name)

			if is_odbc then
				execute_query ("CREATE TABLE db_large_values (title varchar(MAX), author varchar(80), [year] datetime, quantity int ,[price] float, double_value float)")
			end

			if is_mysql then
				execute_query ("CREATE TABLE `DB_LARGE_VALUES` (`title` varchar(65532), `author` varchar(80), `year` datetime, `quantity` int(11) ,`price` double, `double_value` double)")
			end

			if is_oracle then
				execute_query ("CREATE TABLE DB_LARGE_VALUES (title varchar(65535), author varchar(80), year DATE, quantity int ,price float, double_value float)")
			end
		end

	test_manipulate_data
			-- Insert and update objects using NULL values.
		local
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
			l_dyn_change: DB_DYN_CHANGE
			l_change: DB_CHANGE
			l_book: like new_book
			l_list: ARRAYED_LIST [like new_book]
			l_void_book: like new_book
			l_title: STRING
		do
				-- Setup repository for adding data.
			create l_repository.make (table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)

				-- Adding a book with Void values directly
			l_book := new_book
			create l_title.make (5000)
			l_title.fill_character ('a')
			l_title.put ('b', 1)
			l_title.append_character ('c')
			l_book.set_title (l_title)
			l_db_store.put (l_book)
				-- Check that the stored book is valid.
			db_selection.set_map_name ("Paul", "author_name")
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where author=:author_name", new_book)
			db_selection.unset_map_name ("author_name")
			if l_list.count = 1 then
				assert ("1 - Result is not expected", l_list.first.title ~ l_title)
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
