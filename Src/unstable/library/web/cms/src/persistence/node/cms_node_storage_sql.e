note
	description: "Summary description for {CMS_NODE_STORAGE_SQL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_STORAGE_SQL

inherit
	CMS_NODE_STORAGE

	CMS_STORAGE_SQL

	REFACTORING_HELPER

	SHARED_LOGGER

feature -- Access	

	nodes_count: INTEGER_64
			-- Number of items nodes.
		do
			error_handler.reset
			log.write_information (generator + ".nodes_count")
			sql_query (select_nodes_count, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			log.write_information (generator + ".nodes")

			from
				sql_query (select_nodes, Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of recent `a_count' nodes with an offset of `lower'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			log.write_information (generator + ".nodes")

			from
				create l_parameters.make (2)
				l_parameters.put (a_count, "rows")
				l_parameters.put (a_lower, "offset")
				sql_query (select_recent_nodes, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
		end

	node_by_id (a_id: INTEGER_64): detachable CMS_NODE
			-- Retrieve node by id `a_id', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".node")
			create l_parameters.make (1)
			l_parameters.put (a_id,"id")
			sql_query (select_node_by_id, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_node
			end
		end

	node_author (a_id: like {CMS_NODE}.id): detachable CMS_USER
			-- Node's author for the given node id.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".node_author")
			create l_parameters.make (1)
			l_parameters.put (a_id, "node_id")
			sql_query (select_node_author, l_parameters)
			if sql_rows_count >= 1 then
				Result := fetch_author
			end
		end

	last_inserted_node_id: INTEGER_64
			-- Last insert node id.
		do
			error_handler.reset
			log.write_information (generator + ".last_inserted_node_id")
			sql_query (Sql_last_insert_node_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end

feature -- Change: Node

	new_node (a_node: CMS_NODE)
			-- Save node `a_node'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
				-- New node
			error_handler.reset
			log.write_information (generator + ".new_node")
			create l_parameters.make (7)
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.publication_date, "publish")
			l_parameters.put (a_node.creation_date, "created")
			l_parameters.put (a_node.modification_date, "changed")
			if
				attached a_node.author as l_author and then
			 	l_author.id > 0
			then
				l_parameters.put (l_author.id, "author")
			else
				l_parameters.put (0, "author")
			end
			sql_change (sql_insert_node, l_parameters)
			if not error_handler.has_error then
				a_node.set_id (last_inserted_node_id)
			end
		end

	delete_node_by_id (a_id: INTEGER_64)
			-- Remove node by id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			log.write_information (generator + ".delete_node")

			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_id, "id")
			sql_change (sql_delete_node, l_parameters)
		end

	update_node (a_node: CMS_NODE)
			-- Update node content `a_node'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			now: DATE_TIME
		do
			create now.make_now_utc
			error_handler.reset
			log.write_information (generator + ".update_node")
			create l_parameters.make (7)
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.publication_date, "publish")
			l_parameters.put (now, "changed")
			l_parameters.put (a_node.id, "id")
			if attached a_node.author as l_author then
				l_parameters.put (l_author.id, "author")
			else
				l_parameters.put (0, "author")
			end
			sql_change (sql_update_node, l_parameters)
			if not error_handler.has_error then
				a_node.set_modification_date (now)
			end
		end

	update_node_title (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			-- FIXME: unused a_user_id !
			error_handler.reset
			log.write_information (generator + ".update_node_title")
			create l_parameters.make (3)
			l_parameters.put (a_title, "title")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "changed")
			l_parameters.put (a_node_id, "nid")
			sql_change (sql_update_node_title, l_parameters)
		end

	update_node_summary (a_user_id: Like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			-- FIXME: unused a_user_id !
			error_handler.reset
			log.write_information (generator + ".update_node_summary")
			create l_parameters.make (3)
			l_parameters.put (a_summary, "summary")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "changed")
			l_parameters.put (a_node_id, "nid")
			sql_change (sql_update_node_summary, l_parameters)
		end

	update_node_content (a_user_id: Like {CMS_USER}.id;a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			-- FIXME: unused a_user_id !
			error_handler.reset
			log.write_information (generator + ".update_node_content")
			create l_parameters.make (3)
			l_parameters.put (a_content, "content")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "changed")
			l_parameters.put (a_node_id, "nid")
			sql_change (sql_update_node_content, l_parameters)
		end

feature {NONE} -- Queries

	Select_nodes_count: STRING = "select count(*) from Nodes;"

	Select_nodes: STRING = "select * from Nodes;"
		-- SQL Query to retrieve all nodes.

	Select_node_by_id: STRING = "select * from Nodes where nid =:nid order by nid desc, publish desc;"

	Select_recent_nodes: STRING = "select * from Nodes order by nid desc, publish desc LIMIT :rows OFFSET :offset ;"

	SQL_Insert_node: STRING = "insert into nodes (title, summary, content, publish, created, changed, author) values (:title, :summary, :content, :publish, :created, :changed, :author);"
		-- SQL Insert to add a new node.

	SQL_Update_node : STRING = "update nodes SET title=:title, summary=:summary, content=:content, publish=:publish,  changed=:changed, version = version + 1, author=:author where nid=:nid;"
		-- SQL node.

	SQL_Delete_node: STRING = "delete from nodes where nid=:nid;"

	Sql_update_node_author: STRING  = "update nodes SET author=:author where nid=:nid;"

	SQL_Update_node_title: STRING ="update nodes SET title=:title, changed=:changed, version = version + 1 where nid=:nid;"
		-- SQL update node title.

	SQL_Update_node_summary: STRING ="update nodes SET summary=:summary, changed=:changed, version = version + 1 where nid=:nid;"
		-- SQL update node summary.

	SQL_Update_node_content: STRING ="update nodes SET content=:content, changed=:changed, version = version + 1 where nid=:nid;"
		-- SQL node content.

	Sql_last_insert_node_id: STRING = "SELECT MAX(nid) from nodes;"

feature {NONE} -- Sql Queries: USER_ROLES collaborators, author

	Select_user_author: STRING = "SELECT * FROM Nodes INNER JOIN users ON nodes.author=users.uid and users.uid = :uid;"

	Select_node_author: STRING = "SELECT * FROM Users INNER JOIN nodes ON nodes.author=users.uid and nodes.nid =:nid;"

feature {NONE} -- Implementation

	fetch_node: CMS_NODE
		do
			create Result.make ("", "", "")
			if attached sql_read_integer_64 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached sql_read_string_32 (4) as l_title then
				Result.set_title (l_title)
			end
			if attached sql_read_string_32 (5) as l_summary then
				Result.set_summary (l_summary)
			end
			if attached sql_read_string (6) as l_content then
				Result.set_content (l_content)
			end
			if attached sql_read_date_time (8) as l_publication_date then
				Result.set_publication_date (l_publication_date)
			end
			if attached sql_read_date_time (9) as l_creation_date then
				Result.set_creation_date (l_creation_date)
			end
			if attached sql_read_date_time (10) as l_modif_date then
				Result.set_modification_date (l_modif_date)
			end
			if attached sql_read_integer_64 (7) as l_author_id then
				-- access to API ...
			end
		end

	fetch_author: detachable CMS_USER
		do
			if attached sql_read_string_32 (2) as l_name and then not l_name.is_whitespace then
				create Result.make (l_name)
				if attached sql_read_integer_32 (1) as l_id then
					Result.set_id (l_id)
				end
				if attached sql_read_string (3) as l_password then
						-- FIXME: should we return the password here ???
					Result.set_hashed_password (l_password)
				end
				if attached sql_read_string (5) as l_email then
					Result.set_email (l_email)
				end
			else
				check expected_valid_user: False end
			end
		end

end
