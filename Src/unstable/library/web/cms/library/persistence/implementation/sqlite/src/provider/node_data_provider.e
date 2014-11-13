note
	description: "Database access for node uses cases."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	SHARED_ERROR

	REFACTORING_HELPER

create
	make

feature -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a data provider.
		do
			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			post_execution
		end

	db_handler: DATABASE_HANDLER
			-- Db handler.

feature -- Status Report

	is_successful: BOOLEAN
			-- Is the last execution sucessful?
		do
			Result := db_handler.successful
		end

feature -- Access

	nodes: DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- List of nodes.
		local
			l_parameters: STRING_TABLE [ANY]
		do
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
			log.write_information (generator + ".count")
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_count, l_parameters))
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
			log.write_information (generator + ".new_node")
			create l_parameters.make (6)
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.publication_date, "publication_date")
			l_parameters.put (a_node.creation_date, "creation_date")
			l_parameters.put (a_node.modification_date, "modification_date")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_insert_node, l_parameters))
			db_handler.execute_change
			post_execution
		end

	update_node_title (a_id: INTEGER_64; a_title: READABLE_STRING_32)
			-- Update node title for the corresponding the report with id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
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
			log.write_information (generator + ".update_node_content")
			create l_parameters.make (3)
			l_parameters.put (a_content, "content")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "modification_date")
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_update_node_content, l_parameters))
			db_handler.execute_change
			post_execution
		end

	update_node (a_node: CMS_NODE)
			-- Update node.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".update_node")
			create l_parameters.make (7)
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.publication_date, "publication_date")
			l_parameters.put (a_node.creation_date, "creation_date")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "modification_date")
			l_parameters.put (a_node.id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_update_node, l_parameters))
			db_handler.execute_change
			post_execution
		end

	delete_node (a_id: INTEGER_64;)
			-- Delete node with id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".delete_node")
			create l_parameters.make (1)
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (sql_delete_node, l_parameters))
			db_handler.execute_change
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

	SQL_Insert_node: STRING = "insert into nodes (title, summary, content, publication_date, creation_date, modification_date) values (:title, :summary, :content, :publication_date, :creation_date, :modification_date);"
		-- SQL Insert to add a new node.

	SQL_Update_node_title: STRING ="update nodes SET title=:title, modification_date=:modification_date where id=:id;"
		-- SQL update node title.

	SQL_Update_node_summary: STRING ="update nodes SET summary=:summary, modification_date=:modification_date where id=:id;"
		-- SQL update node summary.

	SQL_Update_node_content: STRING ="update nodes SET content=:content, modification_date=:modification_date where id=:id;"
		-- SQL node content.

	SQL_Update_node : STRING = "update nodes SET title=:title, summary=:summary, content=:content, publication_date=:publication_date, creation_date=:creation_date, modification_date=:modification_date where id=:id;"
		-- SQL node.

	SQL_Delete_node: STRING = "delete from nodes where id=:id;"


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

feature {NONE} -- Implementation

	post_execution
			-- Post database execution.
		do
			if db_handler.successful then
				set_successful
			else
				if attached db_handler.last_error then
					set_last_error_from_handler (db_handler.last_error)
				end
			end
		end

end
