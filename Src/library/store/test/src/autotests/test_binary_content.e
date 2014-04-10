note
	description: "Testing that insertion of binary content is done properly."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BINARY_CONTENT

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

	test_upload_file
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				test_load_data
				test_insert
			end
			disconnect
		end

feature {NONE} -- Implementation

	test_load_data
			-- Create table in database with same structure as 'new_data'
		do
			drop_repository (table_name)

			if is_odbc then
				execute_query ("CREATE TABLE " + table_name + " (id int, item varbinary(max))")
			end

			if is_mysql then
				execute_query ("CREATE TABLE " + table_name + " (`id` int, `item` BLOB)")
			end

			if is_oracle then
				execute_query ("CREATE TABLE " + table_name + " (id int, item BLOB)")
			end
		end

	test_insert
			-- Insert binary data using a prepared statement. It should take the data as is,
			-- no prior modification should be done to the binary data we want to store.
		local
			l_list: ARRAYED_LIST [CELL [STRING_8]]
			l_file: STRING_8
			l_change: DB_DYN_CHANGE
			l_binary_file: STRING_8
		do
				-- Insertion to a binary content requires by default hexa decimal input.
			create l_file.make (data_size)
			l_file.append_string ("aab0010203")

			create l_binary_file.make (10)
			l_binary_file.append_character ('%/0xaa/')
			l_binary_file.append_character ('%/0xb0/')
			l_binary_file.append_character ('%/0x01/')
			l_binary_file.append_character ('%/0x02/')
			l_binary_file.append_character ('%/0x03/')

			create l_change.make
			l_change.set_map_name (1, "id")
			l_change.set_map_name (l_file, "image")
			l_change.prepare_32 ("insert into " + table_name + " (id, item) VALUES (:id, :image)")
			l_change.clear_all
			l_change.execute

			l_change.set_map_name (2, "id")
			l_change.set_map_name (l_binary_file, "image")
			l_change.rebind_arguments
			l_change.execute
			l_change.terminate

				-- Check that the stored data is valid.
			l_list := load_list_with_select ("select * from " + table_name + " where id = 1", create {CELL [STRING_8]}.put (""))
			if l_list.count = 1 then
				assert ("1 - Same content", l_list.first.item ~ l_file)
			else
				assert ("1 - Number of results is not expected", False)
			end

				-- Check that the stored data is valid.
			l_list := load_list_with_select ("select * from " + table_name + " where id = 2", create {CELL [STRING_8]}.put (""))
			if l_list.count = 1 then
				assert ("2 - Same content", l_list.first.item ~ l_binary_file)
			else
				assert ("2 - Number of results is not expected", False)
			end
		end

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
		end

	table_name: STRING = "DB_BINARY_CONTENT"

	data_size: INTEGER = 10

end
