note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_NESTED_TRANSACTION

inherit
	ACTION
		undefine
			default_create
		redefine
			execute
		end

	TEST_BASIC_DATABASE
		redefine
			on_prepare
		end

feature {NONE} -- Prepare

	on_prepare
		do
			Precursor
			create book.make
			create authors.make (10)
		end

feature -- Test routines

	test
		do
			reset_database
			establish_connection
			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				load_data

				make_selection

				disconnect
			end

			assert ("Data in database is not correct.", authors.item ("Paul") = False)
			assert ("Data in database is not correct.", authors.item ("Mike") = False)
			assert ("Data in database is not correct.", authors.item ("Neal") = False)
			assert ("Data in database is not correct.", authors.item ("Lily") = False)
			assert ("Data in database is not correct.", authors.item ("Linda") = True)
			assert ("Data in database is not correct.", authors.item ("Olive") = False)
		end


feature {NONE} -- Implementation

	book: BOOK2

	filled_book: BOOK2
			-- Filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_title ("Yangzi River")
			Result.set_double_value (2.3)
		end

	authors: HASH_TABLE [BOOLEAN, STRING]
			-- Authors of the result of execution

feature {NONE}

	load_data
			-- Load data in nested transaction
		local
			l_book: like filled_book
		do
			prepare_repository (table_name)

			if attached base_stores.item (table_name) as l_store and then attached session_control as l_control then
					-- Transaction 1
				l_control.begin
				l_book := filled_book
				l_book.set_author ("Neal")
				l_store.put (l_book)
				assert ("An database error occurred.", db_change.is_ok)

					-- Transaction 2, Nested
				l_control.begin
				l_book := filled_book
				l_book.set_author ("Lily")
				l_store.put (l_book)
				db_change.modify ("SQL to raise Error")
				assert ("An database error did not ocurr.", not db_change.is_ok)
				if db_change.is_ok then
					l_control.commit
				else
					l_control.rollback
					l_control.reset
				end

				l_book := filled_book
				l_book.set_author ("Linda")
				l_store.put (l_book)
				assert ("An database error occurred.", db_change.is_ok)
				l_control.commit
			else
				assert ("DB_STORE or DB_CONTROL is not ready", False)
			end
		end

	make_selection
			-- Select books whose author's name match
			-- a specific name.
			-- The name must be written in upper-case letters, and
			-- enclosed in '%' (This caracter is used by SQL to match
			-- any string of zero or more character)
		do
				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			db_selection.set_action (Current)

				-- Query database.
				-- The reference ":author_name" will be changed to the value of
				-- the Eiffel object referred to by the key "author_name".
			db_selection.query (Select_data)
				-- Iterate through resulting data, and display them
			db_selection.load_result

			db_selection.terminate
		end

	execute
			-- This method is also  used by the class RDB_SELECTION, and is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it converts a tuple in an eiffel object of type 'book' and
			-- display it using a method of its own class.
		do
			db_selection.object_convert (book)
			db_selection.cursor_to_object

			authors.force (True, book.author.to_string_8)
		end

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
			-- [object, table_name]
		do
			create Result.make (0)
			Result.force (create {BOOK2}.make, table_name)
		end

feature {NONE} -- Constants

	Select_data: STRING
		do
			Result := "select * from " + sql_table_name (Table_name)
		end

	Table_name: STRING =
		"DB_BOOK_NESTED_TRANSACTION"

end
