class
   OTHER_NESTED
   
inherit
   DATABASE_APPL [ORACLE]
   ACTION
      redefine
	 execute
      end
	 
creation
   make
   
feature 
   make is
      
      do
	 -- Connect to Database
	 initialize_connection

	 -- Create the example Table
	 io.put_string ("%N%NDo you want to create the Table you need to test this example  ? (y/n) : ")
	 io.readline
	 if io.last_string.is_equal("y") then
		initialize_database
	 end
	 io.put_string("%N%N")

	 -- First query...uses this object for the action.
	 create selection_1.make
	 selection_1.set_query ("select key_of_table as item_1 from example_table")
	 create data_1

	 -- Specify that data_1 will be the object where the Result of the selection will be store
	 selection_1.object_convert (data_1)

	 -- Set the object which contains the execute feature which will be execute if the result of the query 
	 -- is successfull. Here the object is the current object TEST. This object must inherit ACTION .
	 selection_1.set_action (Current)

	 -- Second query...uses SIMPLE_LOAD_ACTION that just converts 
	 -- the object.
	 create selection_2.make
	 selection_2.set_query ("select value as item_2 from example_table where key_of_table= :key")
	 create data_2
	 selection_2.object_convert (data_2)
	 create simple_load_action.make (selection_2)

	 -- Set the object which contains the execute feature which will be execute if the result of the query 
	 -- is successfull. Here the object is SIMPLE_LOAD_ACTION. This Object must inherit ACTION .
	 selection_2.set_action (simple_load_action)

	 -- Do the query
	 selection_1.execute_query
	 selection_1.load_result
	 selection_1.terminate
	 session_control.disconnect

	 io.put_string ("%N%N%NPress any key to finish the application .........")
	 io.readline
      end
   
   execute is
		-- Execute this code if selection_1.load_result was successfull
      do
	 -- Store the Result of selection_1 into the object data_1 previously specify.
	 selection_1.cursor_to_object

	 -- Map the Result of selection_1 in selection_2 query
	 -- to retrieve the value.
	 selection_2.set_map_name (data_1.item_1, "key")
	 selection_2.execute_query
	 selection_2.load_result

	 -- Terminate the query. Free the current cursor
	 selection_2.terminate

	 -- Remove all mapped keys.
	 selection_2.clear_all

	 -- Print the result of the test
	 io.put_string ("Key is: ")
	 io.put_string (data_1.item_1)
	 io.put_string (", value is: ")
	 io.put_double (data_2.item_2)
	 io.put_string (" .%N")
      end


feature {NONE}

initialize_connection is
			-- Initialize the session.
		local
			tmp_string: STRING
		do

			io.putstring ("Database user authentication:%N")

			-- Ask user's Data source Name (Only for ODBC)
--			io.putstring("Data Source Name: ")
--			io.readline
--			set_data_source(io.laststring)

			-- Ask for user's name and password

			io.putstring ("Name: ")
			io.readline
			tmp_string := clone (io.laststring)
			io.putstring ("Password: ")
			io.readline

			-- Set user's name and password
			login (tmp_string, io.laststring)

			-- Initialization of the Relational Database:
			-- This will set various informations to perform a correct
			-- connection to the Relational database
			set_base


			-- Create usefull classes
			-- 'session_control' provides informations control access and 
			--  the status of the database.
			create session_control.make


			-- Start session
			session_control.connect

		ensure
			not (session_control = Void)
		end

initialize_database is
		-- Create a filled Table to use this example
	do
		-- Create the table example_table in the current Database
		create selection_init.make
		selection_init.set_query ("create table example_table (key_of_table VARCHAR2(15) PRIMARY KEY, value NUMBER)")
		selection_init.execute_query
		selection_init.load_result
		selection_init.terminate

		-- Insert data in the example_table
		selection_init.set_query ("insert into example_table (key_of_table, value) values ('key_1', 1)")
		selection_init.execute_query
		selection_init.load_result
		selection_init.terminate 
		selection_init.set_query ("insert into example_table (key_of_table, value) values ('key_2', 2)")
		selection_init.execute_query
		selection_init.load_result
		selection_init.terminate 
		
	end	

feature

   selection_1, selection_2, selection_init: DB_SELECTION
   
   simple_load_action: SIMPLE_LOAD_ACTION

   data_1: DATA_1
	
   data_2: DATA_2

   session_control: DB_CONTROL



end
	 
