indexing
	description: "DATABASE Manager"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_MANAGER

inherit
	DATABASE_APPL [ORACLE]
 
feature -- Connections

	try_to_connect (a_name, a_psswd: STRING):BOOLEAN is
			-- Try to connect the database
		require
			not_void: a_name /= Void and a_psswd /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				login(a_name, a_psswd)
				Result := TRUE
			end
		rescue
			rescued := TRUE
			retry
		end

	establish_connection: BOOLEAN is
			-- Establish Connection
		local
			rescued: BOOLEAN
		do
			if not rescued then
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
				Result := TRUE
			end
		ensure
			not_void: session_control /= Void
		rescue
			rescued := TRUE
			retry
		end

	disconnect is
		do
			session_control.disconnect
		end

feature -- Transactions

	load_list(s: STRING;an_obj: ANY): LINKED_LIST[like an_obj] is
			-- Load list of objects whose type are the same as 'an_obj',
			-- with as criterion 'criterion', the associated value 'value' and
			-- from the set 'set'.
		require
			not_void: an_obj /= Void
			meaningfull_select: s /= Void
		local
			db_actions: DB_ACTION[like an_obj]
			rescued: BOOLEAN
		do
			if not rescued then
				Create selection.make
				selection.object_convert (an_obj)
				selection.set_query (s)
				Create db_actions.make (selection, an_obj)
				selection.set_action (db_actions)
				selection.execute_query
				selection.load_result

				selection.terminate
				if db_actions.list.count>=1 then
					Result := db_actions.list
				else
					Create Result.make 
				end
			else
				--application.popup_warning(application.first_window,"Failed :"+s)
			end
		ensure
			Result_exists: Result /= Void
		rescue
			rescued := TRUE
			retry
		end

	execute_query(a_query: STRING) is
			-- Load list of objects whose type are the same as 'an_obj',
			-- with as criterion 'criterion', the associated value 'value' and
			-- from the set 'set'.
		require
			not_void: a_query /= Void
		local
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				Create selection.make
				selection.set_query (a_query)
				selection.execute_query
				selection.load_result

				selection.terminate
				
				session_control.commit		

			else
				--application.popup_warning(application.first_window,"Failed :"+s)
			end
		rescue
			rescued := TRUE
			retry
		end

feature -- Creations

	Create_item(an_obj: ANY;rep: DB_REPOSITORY) is
			--	Store in the DB object 'an_obj'
		local
			store_objects: DB_STORE
		do
			Create store_objects.make
			store_objects.set_repository(rep)
			store_objects.put(an_obj)	
			session_control.commit
		end

feature -- Implementation

	session_control: DB_CONTROL
		-- Session Control

	selection: DB_SELECTION

end -- class DATABASE_MANAGER
