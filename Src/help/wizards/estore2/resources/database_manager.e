indexing
	description: "All the useful feature to manage your Database"
	author: "David Solal"
	date: "$Date$"
	revision: "$Revision$"


class 
	DATABASE_MANAGER

inherit
	DATABASE_APPL [<FL_HANDLE>]
 
feature -- Connections

 	log_and_connect (a_name, a_psswd, data_source: STRING) is
 			-- Try to connect the database using <FL_HANDLE>
 			-- with a username 'a_name',a password 'a_psswd'
 		require
 			not_void: a_name /= Void and a_psswd /= Void
 		do
 			login (a_name, a_psswd)
			set_data_source (data_source)
			connect
		end
 		 
 	connect is
 			-- Establish Connection
 		do
 				-- Initialization of the Relational Database:
 				-- This will set various informations to perform a correct
 				-- connection to the Relational database
 			set_base
 	
 				-- Create useful classes
 				-- 'session_control' provides informations control access and 
 				--  the status of the database.
 			create session_control.make
			session_control.reset
 	
				-- Start session
 			session_control.connect

  		ensure
 			not_void: session_control /= Void
 		end
 
 	disconnect is
			-- Disconnect from the Database
		require
			is_connected: session_control.is_connected
 		do
 			session_control.disconnect
 		end
 
 feature -- Loadings
 
 	load_list_from_select (s: STRING; an_obj: ANY): LINKED_LIST [like an_obj] is
 			-- Load list of objects whose type are the same as 'an_obj',
 			-- Using the Sql Query 's'
			-- The Result is a list of 'an_obj' 
 		require
 			is_connected: session_control.is_connected
 			not_void: an_obj /= Void
 			meaningfull_select: s /= Void and then s.count > 0
 		local
 			db_actions: DB_ACTION [like an_obj]
 			selection: DB_SELECTION
  		do
			create selection.make
				-- The following option helps debugging
			-- selection.set_trace
			selection.object_convert (an_obj)
			selection.set_query (s)
			create db_actions.make (selection, an_obj)
			selection.set_action (db_actions)
			selection.execute_query
			selection.load_result
 			selection.terminate

			if db_actions.list.count > 0 then
				Result := db_actions.list
			else
				create Result.make 
			end
		ensure
			Result_exists: Result /= Void
  		end

  	retrieve (s: STRING): LINKED_LIST [DB_TUPLE] is
  			-- Load a list of DB_TUPLE from the query 's' 
  			-- in which one can retrieve any data for each tuple
  			-- Using this function, you don't need to create an Object to retrieve the data.
		require
			is_connected: session_control.is_connected
			meaningfull_select: s /= Void and s.count > 0
		local
			db_actions: DB_ACTION_DYN
			selection: DB_SELECTION
		do
			create selection.make
			selection.set_query (s)
			create db_actions.make (selection)
			selection.set_action (db_actions)
			selection.execute_query
			selection.load_result
			selection.terminate

			if db_actions.list.count > 0 then
				Result := db_actions.list
			else
				create Result.make
			end
		ensure
			Result_exists: Result /= Void
		end

 
 	execute_query(a_query: STRING) is
 			-- Execute the query 'a_query' to the Database.
 		require
  			is_connected: session_control.is_connected
 			meaningfull_query: a_query /= Void and then a_query.count >0
 		local
			selection_change: DB_CHANGE
 			s: STRING
 		do
 			create selection_change.make
 			selection_change.set_query (a_query)
 			selection_change.execute_query
 
 			session_control.commit		
  		end
 
 
 	Insert_row(an_obj: ANY; rep: DB_REPOSITORY) is
 			-- Insert Into the Database a new row of type 'an_obj'
			-- Using the repository 'rep'
			-- The repositories of every table are once functions defined
			-- in class REPOSITORIES
		require
 			is_connected: session_control.is_connected
			repository_exists: rep /= Void
			object_exist: an_obj /= Void
 		local
 			store_objects: DB_STORE
 		do
 			create store_objects.make
 			store_objects.set_repository (rep)
 			store_objects.put (an_obj)	
 			session_control.commit
 		end

feature -- Implementation

	session_control: DB_CONTROL
		-- Session Control

end -- class DATABASE_MANAGER
