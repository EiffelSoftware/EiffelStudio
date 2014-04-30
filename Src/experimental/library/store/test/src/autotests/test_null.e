note
	description: "Summary description for {TEST_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_NULL

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

	test_null
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				test_null_load_data
				test_null_manipulate_data
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
			Result.set_text_value ("test")
		end

	test_null_load_data
			-- Create table in database with same structure as 'new_book'
		do
			drop_repository (table_name)

			if is_odbc or is_sybase then
				execute_query ("CREATE TABLE DB_NULL_VALUES (title varchar(255), author varchar(80), text_value varchar(max), [year] datetime, quantity int ,[price] float, double_value float)")
			end

			if is_mysql then
				execute_query ("CREATE TABLE `DB_NULL_VALUES` (`title` varchar(255), `author` varchar(80), `text_value` varchar(65532), `year` datetime, `quantity` int(11) ,`price` double, `double_value` double)")
			end

			if is_oracle then
				execute_query ("CREATE TABLE DB_NULL_VALUES (title varchar(255), author varchar(80), text_value varchar(65535), year DATE, quantity int ,price float, double_value float)")
			end
		end

	test_null_manipulate_data
			-- Insert and update objects using NULL values.
		local
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
			l_dyn_change: DB_DYN_CHANGE
			l_change: DB_CHANGE
			l_book: like new_book
			l_list: ARRAYED_LIST [like new_book]
			l_void_book: like new_book
		do
				-- Setup repository for adding data.
			create l_repository.make (table_name)
			l_repository.load
			create l_db_store.make
			l_db_store.set_repository (l_repository)

				-- Adding a book with Void values directly
			l_book := new_book
			l_db_store.put (l_book)
				-- Check that the stored book is valid.
			db_selection.set_map_name ("Paul", "author_name")
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where author=:author_name", new_book)
			db_selection.unset_map_name ("author_name")
			if l_list.count = 1 then
				assert ("1 - Result is not expected", l_list.first ~ new_book)
			else
				assert ("1 - Number of results is not expected", False)
			end


			if not is_mysql then
					-- Insert a book with a non-void title
				l_book := new_book
				l_book.set_author ("Alfred")
				l_book.set_title ("There is a title")
				l_db_store.put (l_book)
					-- Chec that the stored book is valid
				db_selection.set_map_name ("Alfred", "author_name")
				l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where author=:author_name", new_book)
				db_selection.unset_map_name ("author_name")
				if l_list.count = 1 then
					assert ("2 - Result is not expected", l_list.first ~ l_book)
				else
					assert ("2 - Number of results is not expected", False)
				end

					-- Update the book with all NULL attributes, except for `author' using a dynamic query
				create l_dyn_change.make
				l_dyn_change.set_map_name (Void, "quantity_name")
				l_dyn_change.set_map_name (Void, "title_name")
				l_dyn_change.set_map_name (Void, "year_name")
				l_dyn_change.set_map_name (Void, "price_name")
				l_dyn_change.set_map_name (Void, "double_value_name")
				l_dyn_change.set_map_name (Void, "text_name")
				l_dyn_change.set_map_name ("Alfred", "author_name")

				l_dyn_change.prepare_32 ("update " + sql_table_name (table_name) + "[
					 set quantity = :quantity_name, title = :title_name, year = :year_name,
					 	price = :price_name, double_value = :double_value_name, text_value = :text_name where author=:author_name
					 ]")

				l_dyn_change.unset_map_name ("quantity_name")
				l_dyn_change.unset_map_name ("title_name")
				l_dyn_change.unset_map_name ("year_name")
				l_dyn_change.unset_map_name ("price_name")
				l_dyn_change.unset_map_name ("double_value_name")
				l_dyn_change.unset_map_name ("text_name")
				l_dyn_change.unset_map_name ("author_name")

				l_dyn_change.execute
				l_dyn_change.terminate

				db_selection.set_map_name ("Alfred", "author_name")
				l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where author=:author_name", new_book)
				db_selection.unset_map_name ("author_name")
				if l_list.count = 1 and attached l_list.first as l_retrieved_book then
					create l_void_book
					l_void_book.set_author (l_retrieved_book.author)
					assert ("3 - Result is not expected", l_retrieved_book ~ l_void_book)
				else
					assert ("3 - Number of results is not expected", False)
				end

				execute_query ("DELETE FROM " + table_name + " WHERE author='Alfred'")
			end

				-- Insert a book with a non-void title
			l_book := new_book
			l_book.set_author ("Alfredo")
			l_book.set_title ("There is a title")
			l_db_store.put (l_book)
				-- Chec that the stored book is valid
			db_selection.set_map_name ("Alfredo", "author_name")
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where author=:author_name", new_book)
			db_selection.unset_map_name ("author_name")
			if l_list.count = 1 then
				assert ("2 - Result is not expected", l_list.first ~ l_book)
			else
				assert ("2 - Number of results is not expected", False)
			end

				-- Update the book with all NULL attributes, except for `author' using a dynamic query
			create l_change.make
			l_change.set_map_name (Void, "quantity_name")
			l_change.set_map_name (Void, "title_name")
			l_change.set_map_name (Void, "year_name")
			l_change.set_map_name (Void, "price_name")
			l_change.set_map_name (Void, "double_value_name")
			l_change.set_map_name ("Alfredo", "author_name")

			l_change.set_query ("update " + sql_table_name (table_name) + " set quantity=:quantity_name,title=:title_name,year=:year_name, price=:price_name,double_value=:double_value_name where author=:author_name")
			l_change.execute_query

			l_change.unset_map_name ("quantity_name")
			l_change.unset_map_name ("title_name")
			l_change.unset_map_name ("year_name")
			l_change.unset_map_name ("price_name")
			l_change.unset_map_name ("double_value_name")
			l_change.unset_map_name ("author_name")


			db_selection.set_map_name ("Alfredo", "author_name")
			l_list := load_list_with_select ("select * from " + sql_table_name (table_name) + " where author=:author_name", new_book)
			db_selection.unset_map_name ("author_name")
			if l_list.count = 1 and attached l_list.first as l_retrieved_book then
				create l_void_book
				l_void_book.set_author (l_retrieved_book.author)
				assert ("4 - Result is not expected", l_retrieved_book ~ l_void_book)
			else
				assert ("4 - Number of results is not expected", False)
			end
		end

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
		end

	table_name: STRING = "DB_NULL_VALUES"

end
