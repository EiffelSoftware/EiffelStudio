note
	description: "Database access for node uses cases."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a data provider.
		do
			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			create error_handler.make
			post_execution
		end

	db_handler: DATABASE_HANDLER
			-- Db handler.

feature -- Status Report

	is_successful: BOOLEAN
			-- Is the last execution sucessful?
		do
			Result := not error_handler.has_error
		end

feature -- Error Handler

	error_handler: ERROR_HANDLER

feature -- Access

	nodes: DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- List of nodes.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".nodes")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_nodes, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_node)
			post_execution
		end

	recent_nodes (a_lower, a_rows: INTEGER): DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- The most recent `a_rows'.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING
		do
			error_handler.reset
			log.write_information (generator + ".recent_nodes")
			create l_parameters.make (2)
			l_parameters.put (a_rows, "rows")
			create l_query.make_from_string (select_recent_nodes)
			l_query.replace_substring_all ("$offset", a_lower.out)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_node)
			post_execution
		end

	node (a_id: INTEGER_64): detachable CMS_NODE
			-- Node for the given id `a_id', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".node")
			create l_parameters.make (1)
			l_parameters.put (a_id,"id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_node_by_id, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := fetch_node
			end
			post_execution
		end

	count: INTEGER
			-- Number of items nodes.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".count")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_count, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end


	last_inserted_node_id: INTEGER
			-- Last insert node id.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".last_inserted_node_id")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Sql_last_insert_node_id, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end

feature -- Basic operations

	new_node (a_node: CMS_NODE)
			-- Create a new node.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".new_node")
			create l_parameters.make (7)
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.publication_date, "publication_date")
			l_parameters.put (a_node.creation_date, "creation_date")
			l_parameters.put (a_node.modification_date, "modification_date")
			if
				attached a_node.author as l_author and then
			 	l_author.id > 0
			then
				l_parameters.put (l_author.id, "author_id")
			end
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_insert_node, l_parameters))
			db_handler.execute_change

			a_node.set_id (last_inserted_node_id)
			post_execution
		end

	update_node_title (a_id: INTEGER_64; a_title: READABLE_STRING_32)
			-- Update node title for the corresponding the report with id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".update_node_title")
			create l_parameters.make (3)
			l_parameters.put (a_title, "title")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "modification_date")
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_update_node_title, l_parameters))
			db_handler.execute_change
			post_execution
		end

	update_node_summary (a_id: INTEGER_64; a_summary: READABLE_STRING_32)
			-- Update node summary for the corresponding the report with id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".update_node_summary")
			create l_parameters.make (3)
			l_parameters.put (a_summary, "summary")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "modification_date")
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_update_node_summary, l_parameters))
			db_handler.execute_change
			post_execution
		end

	update_node_content (a_id: INTEGER_64; a_content: READABLE_STRING_32)
			-- Update node content for the corresponding the report with id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".update_node_content")
			create l_parameters.make (3)
			l_parameters.put (a_content, "content")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "modification_date")
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_update_node_content, l_parameters))
			db_handler.execute_change
			post_execution
		end

	update_node (a_id: like {CMS_USER}.id; a_node: CMS_NODE)
			-- Update node.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".update_node")
			create l_parameters.make (7)
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.publication_date, "publication_date")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "modification_date")
			l_parameters.put (a_node.id, "id")
			l_parameters.put (a_id, "editor")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_update_node, l_parameters))
			db_handler.execute_change
			post_execution
		end

	delete_node (a_id: INTEGER_64;)
			-- Delete node with id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".delete_node")
			create l_parameters.make (1)
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_delete_node, l_parameters))
			db_handler.execute_change
			post_execution
		end

	delete_from_user_nodes (a_id: INTEGER_64)
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".delete_from_user_nodes")
			create l_parameters.make (1)
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_delete_from_user_node, l_parameters))
			db_handler.execute_change
			post_execution
		end

feature -- Basic Operations: User_Nodes

	add_author (a_user_id: INTEGER_64; a_node_id: INTEGER_64)
			-- Add author `a_user_id' to node `a_node_id'
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".add_author")
			create l_parameters.make (2)
			l_parameters.put (a_user_id,"user_id")
			l_parameters.put (a_node_id,"id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Sql_update_node_author, l_parameters))
			db_handler.execute_change
			post_execution
		end

	add_collaborator (a_user_id: INTEGER_64; a_node_id: INTEGER_64)
			-- Add collaborator `a_user_id' to node `a_node_id'
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".add_collaborator")
			create l_parameters.make (2)
			l_parameters.put (a_user_id,"users_id")
			l_parameters.put (a_node_id,"nodes_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Sql_insert_users_nodes, l_parameters))
			db_handler.execute_change
			post_execution
		end

	update_node_last_editor	(a_user_id: INTEGER_64; a_node_id: INTEGER_64)
			-- Update node last editor.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			log.write_information (generator + ".add_collaborator")
			create l_parameters.make (2)
			l_parameters.put (a_user_id,"users_id")
			l_parameters.put (a_node_id,"nodes_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Slq_update_editor, l_parameters))
			db_handler.execute_change
			post_execution
		end


	author_nodes (a_id:INTEGER_64): DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- List of Nodes for the given user `a_id'. (the user is the author of the node)
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".author_nodes")
			create l_parameters.make (1)
			l_parameters.put (a_id, "user_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_author, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_node)
			post_execution
		end

	collaborator_nodes (a_id:INTEGER_64): DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- List of Nodes for the given user `a_id' as collaborator.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".collaborator_nodes")
			create l_parameters.make (1)
			l_parameters.put (a_id, "user_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_collaborator, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_node)
			post_execution
		end


	node_author (a_id: INTEGER_64): detachable CMS_USER
			-- Node's author for the given node id.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".node_author")
			create l_parameters.make (1)
			l_parameters.put (a_id, "node_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_node_author, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				Result := fetch_user
			end
			post_execution
		end

	node_collaborators (a_id: INTEGER_64): DATABASE_ITERATION_CURSOR [CMS_USER]
			-- List of possible node's collaborator.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".node_collaborators")
			create l_parameters.make (1)
			l_parameters.put (a_id, "node_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_node_collaborators, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent fetch_user)
			post_execution
		end

	is_collaborator (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id): BOOLEAN
			-- Is the user `a_user_id' a collaborator of node `a_node_id'
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".node_collaborators")
			create l_parameters.make (2)
			l_parameters.put (a_user_id, "user_id")
			l_parameters.put (a_node_id, "node_id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_exist_user_node, l_parameters))
			db_handler.execute_query
			if db_handler.count = 1 then
				Result := db_handler.read_integer_32 (1) = 1
			end
			post_execution
		end

feature -- Connection

	connect
			-- Connect to the database.
		do
			if not db_handler.is_connected then
				db_handler.connect
			end
		end

	disconnect
			-- Disconnect to the database.
		do
			if db_handler.is_connected then
				db_handler.disconnect
			end
		end

feature {NONE} -- Queries

	Select_count: STRING = "select count(*) from Nodes;"

	Select_nodes: STRING = "select * from Nodes;"
		-- SQL Query to retrieve all nodes.

	Select_node_by_id: STRING = "select * from Nodes where id =:id order by id desc, publication_date desc;"

	Select_recent_nodes: STRING = "select * from Nodes order by id desc, publication_date desc Limit $offset , :rows "

	SQL_Insert_node: STRING = "insert into nodes (title, summary, content, publication_date, creation_date, modification_date, author_id) values (:title, :summary, :content, :publication_date, :creation_date, :modification_date, :author_id);"
		-- SQL Insert to add a new node.

	SQL_Update_node_title: STRING ="update nodes SET title=:title, modification_date=:modification_date, version = version + 1 where id=:id;"
		-- SQL update node title.

	SQL_Update_node_summary: STRING ="update nodes SET summary=:summary, modification_date=:modification_date, version = version + 1 where id=:id;"
		-- SQL update node summary.

	SQL_Update_node_content: STRING ="update nodes SET content=:content, modification_date=:modification_date, version = version + 1 where id=:id;"
		-- SQL node content.

	Slq_update_editor: STRING ="update nodes SET editor_id=:users_id  where id=:nodes_id;"
		-- SQL node content.	

	SQL_Update_node : STRING = "update nodes SET title=:title, summary=:summary, content=:content, publication_date=:publication_date,  modification_date=:modification_date, version = version + 1, editor_id=:editor where id=:id;"
		-- SQL node.

	SQL_Delete_node: STRING = "delete from nodes where id=:id;"

	Sql_update_node_author: STRING  = "update nodes SET author_id=:user_id where id=:id;"

	Sql_last_insert_node_id: STRING = "SELECT MAX(id) from nodes;"

feature {NONE} -- Sql Queries: USER_ROLES collaborators, author

	Sql_insert_users_nodes: STRING = "insert into users_nodes (users_id, nodes_id) values (:users_id, :nodes_id);"

	select_node_collaborators:  STRING = "SELECT * FROM Users INNER JOIN users_nodes ON users.id=users_nodes.users_id and users_nodes.nodes_id = :node_id;"

	Select_user_author: STRING = "SELECT * FROM Nodes INNER JOIN users ON nodes.author_id=users.id and users.id = :user_id;"

	Select_node_author: STRING = "SELECT * FROM Users INNER JOIN nodes ON nodes.author_id=users.id and nodes.id =:node_id;"

	Select_user_collaborator: STRING = "SELECT * FROM Nodes INNER JOIN users_nodes ON users_nodes.nodes_id = nodes.id and users_nodes.users_id = :user_id;"

	Select_exist_user_node: STRING= "Select Count(*) from Users_nodes where users_id=:user_id and nodes_id=:node_id;"

	sql_delete_from_user_node: STRING = "delete from users_nodes where nodes_id=:id"


feature -- 	


feature -- New Object

	fetch_node: CMS_NODE
		do
			create Result.make ("", "", "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_date_time (2) as l_pd then
				Result.set_publication_date (l_pd)
			end
			if attached db_handler.read_date_time (3) as l_cd then
				Result.set_creation_date (l_cd)
			end
			if attached db_handler.read_date_time (4) as l_md then
				Result.set_modification_date (l_md)
			end
			if attached db_handler.read_string (5) as l_t then
				Result.set_title (l_t)
			end
			if attached db_handler.read_string (6) as l_s then
				Result.set_summary (l_s)
			end
			if attached db_handler.read_string (7) as l_c then
				Result.set_content (l_c)
			end
		end

	fetch_user: CMS_USER
		do
			create Result.make ("")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_u then
				Result.set_name (l_u)
			end
			if attached db_handler.read_string (3) as l_p then
				Result.set_password (l_p)
			end
			if attached db_handler.read_string (5) as l_e then
				Result.set_email (l_e)
			end
		end

feature {NONE} -- Implementation

	post_execution
			-- Post database execution.
		do
			error_handler.add_synchronization (db_handler.database_error_handler)
			if error_handler.has_error then
				log.write_critical (generator + ".post_execution " +  error_handler.as_string_representation)
			end
		end

end
