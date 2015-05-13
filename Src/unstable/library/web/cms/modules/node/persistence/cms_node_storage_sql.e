note
	description: "[
			CMS NODE Storage based on SQL statements.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_STORAGE_SQL

inherit
	CMS_PROXY_STORAGE_SQL

	CMS_NODE_STORAGE_I

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access	

	nodes_count: INTEGER_64
			-- Number of items nodes.
		do
			error_handler.reset
			write_information_log (generator + ".nodes_count")
			sql_query (sql_select_nodes_count, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".nodes")

			from
				sql_query (sql_select_nodes, Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
--			across
--				Result as ic
--			loop
--				fill_node (ic.item)
--			end
		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of recent `a_count' nodes with an offset of `lower'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".nodes")

			from
				create l_parameters.make (2)
				l_parameters.put (a_count, "rows")
				l_parameters.put (a_lower, "offset")
				sql_query (sql_select_recent_nodes, l_parameters)
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
			write_information_log (generator + ".node")
			create l_parameters.make (1)
			l_parameters.put (a_id, "nid")
			sql_query (sql_select_node_by_id, l_parameters)
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
			write_information_log (generator + ".node_author")
			create l_parameters.make (1)
			l_parameters.put (a_id, "nid")
			sql_query (Select_user_author, l_parameters)
			if sql_rows_count >= 1 then
				Result := fetch_author
			end
		end

	last_inserted_node_id: INTEGER_64
			-- Last insert node id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_node_id")
			sql_query (Sql_last_insert_node_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end

feature -- Change: Node

	new_node (a_node: CMS_NODE)
			-- Save node `a_node'.
		do
			store_node (a_node)
		end

	update_node (a_node: CMS_NODE)
			-- Update node content `a_node'.
		do
			store_node (a_node)
		end

	delete_node_by_id (a_id: INTEGER_64)
			-- Remove node by id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
			l_time: DATE_TIME
		do
			create l_time.make_now_utc
			write_information_log (generator + ".delete_node")

			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (l_time, "changed")
			l_parameters.put ({CMS_NODE_API}.trashed, "status")
			l_parameters.put (a_id, "nid")
			sql_change (sql_delete_node, l_parameters)
		end

feature {NONE} -- Implementation

	store_node (a_node: CMS_NODE)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			now: DATE_TIME
		do
			create now.make_now_utc
			error_handler.reset

			write_information_log (generator + ".store_node")
			create l_parameters.make (9)
			l_parameters.put (a_node.content_type, "type")
			l_parameters.put (a_node.title, "title")
			l_parameters.put (a_node.summary, "summary")
			l_parameters.put (a_node.content, "content")
			l_parameters.put (a_node.format, "format")
			l_parameters.put (a_node.publication_date, "publish")
			l_parameters.put (now, "changed")
			l_parameters.put (a_node.status, "status")
			if attached a_node.author as l_author then
				check valid_author: l_author.has_id end
				l_parameters.put (l_author.id, "author")
			else
				l_parameters.put (0, "author")
			end
			sql_begin_transaction
			if a_node.has_id then
					-- Update
				l_parameters.put (a_node.id, "nid")
				sql_change (sql_update_node, l_parameters)
				if not error_handler.has_error then
					-- FIXED: FOR NOW  no revision
--					a_node.set_revision (a_node.revision + 1) -- FIXME: Should be incremented by one, in same transaction...but check!
					a_node.set_modification_date (now)
				end
			else
					-- Store new node
				l_parameters.put (a_node.creation_date, "created")
				sql_change (sql_insert_node, l_parameters)
				if not error_handler.has_error then
					a_node.set_modification_date (now)
					a_node.set_id (last_inserted_node_id)
					a_node.set_revision (1) -- New object.
				end
			end
			extended_store (a_node)
			sql_commit_transaction
		end

feature -- Helpers

	fill_node (a_node: CMS_NODE)
			-- Fill `a_node' with extra information from database.
			-- i.e: specific to each content type data.
		do
			error_handler.reset
			write_information_log (generator + ".fill_node")
			extended_load (a_node)
		end

feature {NONE} -- Queries

	sql_select_nodes_count: STRING = "SELECT count(*) FROM Nodes WHERE status != -1 ;"
			-- Nodes count (Published and not Published)
			--| note: {CMS_NODE_API}.trashed = -1

	sql_select_nodes: STRING = "SELECT * FROM Nodes WHERE status != -1 ;"
			-- SQL Query to retrieve all nodes.
			--| note: {CMS_NODE_API}.trashed = -1

	sql_select_node_by_id: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM Nodes WHERE nid =:nid ORDER BY revision DESC, publish DESC LIMIT 1;"

	sql_select_recent_nodes: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM Nodes ORDER BY nid DESC, publish DESC LIMIT :rows OFFSET :offset ;"

	sql_insert_node: STRING = "INSERT INTO nodes (revision, type, title, summary, content, format, publish, created, changed, status, author) VALUES (1, :type, :title, :summary, :content, :format, :publish, :created, :changed, :status, :author);"
			-- SQL Insert to add a new node.

	sql_update_node : STRING = "UPDATE nodes SET revision = revision, type=:type, title=:title, summary=:summary, content=:content, format=:format, publish=:publish, changed=:changed, status=:status, author=:author WHERE nid=:nid;"
-- FIXME: for now no revision inc.!
--	sql_update_node : STRING = "UPDATE nodes SET revision = revision + 1, type=:type, title=:title, summary=:summary, content=:content, format=:format, publish=:publish, changed=:changed, revision = revision + 1, author=:author WHERE nid=:nid;"
			-- SQL node.

	sql_delete_node: STRING = "UPDATE nodes SET changed=:changed, status =:status WHERE nid=:nid"
			-- Soft deletion with free metadata.

--	sql_update_node_author: STRING  = "UPDATE nodes SET author=:author WHERE nid=:nid;"

--	sql_update_node_title: STRING ="UPDATE nodes SET title=:title, changed=:changed, revision = revision + 1 WHERE nid=:nid;"
--			-- SQL update node title.

--	sql_update_node_summary: STRING ="UPDATE nodes SET summary=:summary, changed=:changed, revision = revision + 1 WHERE nid=:nid;"
--			-- SQL update node summary.

--	sql_update_node_content: STRING ="UPDATE nodes SET content=:content, changed=:changed, revision = revision + 1 WHERE nid=:nid;"
--			-- SQL node content.

	sql_last_insert_node_id: STRING = "SELECT MAX(nid) FROM nodes;"

feature {NONE} -- Sql Queries: USER_ROLES collaborators, author

	Select_user_author: STRING = "SELECT uid, name, password, salt, email, users.status, users.created, signed FROM Nodes INNER JOIN users ON nodes.author=users.uid AND nodes.nid = :nid;"

	Select_node_author: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed FROM users INNER JOIN nodes ON nodes.author=users.uid AND nodes.nid =:nid;"

feature {NONE} -- Implementation

	fetch_node: detachable CMS_PARTIAL_NODE
		do
			if attached sql_read_string (3) as l_type then
				create Result.make_empty (l_type)

				if attached sql_read_integer_64 (1) as l_id then
					Result.set_id (l_id)
				end
				if attached sql_read_integer_64 (2) as l_revision then
					Result.set_revision (l_revision)
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
				if attached sql_read_string (7) as l_format then
					Result.set_format (l_format)
				end
				if attached sql_read_integer_64 (8) as l_author_id then
					Result.set_author (create {CMS_PARTIAL_USER}.make_with_id (l_author_id))
				end
				if attached sql_read_date_time (9) as l_publication_date then
					Result.set_publication_date (l_publication_date)
				end
				if attached sql_read_date_time (10) as l_creation_date then
					Result.set_creation_date (l_creation_date)
				end
				if attached sql_read_date_time (11) as l_modif_date then
					Result.set_modification_date (l_modif_date)
				end
				if attached sql_read_integer_32 (12) as l_status then
					Result.set_status (l_status)
				end
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
