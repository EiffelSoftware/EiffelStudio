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
		redefine
			nodes_of_type
		end

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access	

	nodes_count: NATURAL_64
			-- Number of items nodes.
		do
			error_handler.reset
			write_information_log (generator + ".nodes_count")
			sql_query (sql_select_nodes_count, Void)
			if not has_error and not sql_after then
				Result := sql_read_natural_64 (1)
			end
			sql_finalize
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
			sql_finalize
		end

	node_revisions (a_node: CMS_NODE): LIST [CMS_NODE]
			-- Revisions of node `a_node'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
			Result.force (a_node)

			error_handler.reset
			write_information_log (generator + ".node_revisions")

			from
				create l_parameters.make (1)
				l_parameters.force (a_node.id, "nid")
				l_parameters.force (a_node.revision, "revision")
				sql_query (sql_select_node_revisions, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

	trashed_nodes (a_user: detachable CMS_USER): LIST [CMS_NODE]
			-- List of nodes.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".trashed_nodes")

			from
				create l_parameters.make (1)
				if a_user /= Void and then a_user.has_id then
					l_parameters.put (a_user.id, "author")
					sql_query (sql_select_trash_nodes_by_author, l_parameters)
				else
					sql_query (sql_select_trash_nodes, Void)
				end
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of recent `a_count' nodes with an offset of `lower'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".recent_nodes")

			from
				create l_parameters.make (2)
				l_parameters.put (a_count, "size")
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
			sql_finalize
		end

	recent_node_changes_before (a_lower: INTEGER; a_count: INTEGER; a_date: DATE_TIME): LIST [CMS_NODE]
			-- List of recent changes, before `a_date', according to `params' settings.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".recent_node_changes_before")

			from
				create l_parameters.make (3)
				l_parameters.put (a_count, "size")
				l_parameters.put (a_lower, "offset")
				l_parameters.put (a_date, "date")

				sql_query (sql_select_recent_node_changes_before, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

	node_by_id (a_id: INTEGER_64): detachable CMS_NODE
			-- Retrieve node by id `a_id', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".node_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_id, "nid")
			sql_query (sql_select_node_by_id, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_node
			end
			sql_finalize
		end

	node_by_id_and_revision (a_node_id, a_revision: INTEGER_64): detachable CMS_NODE
			-- Retrieve node by id `a_id', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".node_by_id_and_revision")
			create l_parameters.make (1)
			l_parameters.put (a_node_id, "nid")
			l_parameters.put (a_revision, "revision")
			sql_query (sql_select_node_by_id_and_revision, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_node
			end
			sql_finalize
		end

	last_inserted_node_id: INTEGER_64
			-- Last insert node id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_node_id")
			sql_query (Sql_last_insert_node_id, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
		end

	last_inserted_node_revision (a_node: detachable CMS_NODE): INTEGER_64
			-- Last insert revision for node of id `nid'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_node_revision")
			if a_node /= Void and then a_node.has_id then
				create l_parameters.make (1)
				l_parameters.force (a_node.id, "nid")
				sql_query (Sql_last_insert_node_revision_for_nid, l_parameters)
				if not has_error and not sql_after then
					if sql_item (1) /= Void then
						Result := sql_read_integer_64 (1)
					end
					sql_forth
					if not sql_after then
						check no_more_than_one: False end
					end
				end
				sql_finalize
			end
--			if Result = 0 and not has_error then --| include the case a_node = Void
--				sql_query (Sql_last_insert_node_revision, Void)
--				if not has_error and not sql_after then
--					if sql_item (1) /= Void then
--						Result := sql_read_integer_64 (1)
--					end
--				end
--			end
		end

	nodes_of_type (a_node_type: CMS_CONTENT_TYPE): LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".nodes_of_type")
			create l_parameters.make (1)
			l_parameters.put (a_node_type.name, "node_type")

			from
				sql_query (sql_select_nodes_of_type, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					check expected_node_type: l_node.content_type.same_string (a_node_type.name) end
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

feature -- Access: outline

	children (a_node: CMS_NODE): detachable LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".children")

			from
				create l_parameters.make (1)
				l_parameters.put (a_node.id, "nid")
				sql_query (sql_select_children_of_node, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

	available_parents_for_node (a_node: CMS_NODE): LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".available_parents_for_node")

			from
				create l_parameters.make (1)
				l_parameters.put (a_node.id, "nid")
				sql_query (sql_select_available_parents_for_node, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
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

	trash_node_by_id (a_id: INTEGER_64)
			-- Remove node by id `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			write_information_log (generator + ".trash_node_by_id {" + a_id.out + "}")

			error_handler.reset
			create l_parameters.make (3)
			l_parameters.put (create {DATE_TIME}.make_now_utc, "changed")
			l_parameters.put ({CMS_NODE_API}.trashed, "status")
			l_parameters.put (a_id, "nid")
			sql_modify (sql_trash_node, l_parameters)
			sql_finalize
		end

	 delete_node_base (a_node: CMS_NODE)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
			l_time: DATE_TIME
		do
			sql_begin_transaction
			create l_time.make_now_utc
			write_information_log (generator + ".delete_node_base {" + a_node.id.out + "}")

			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_node.id, "nid")
			sql_modify (sql_delete_node, l_parameters)
			sql_finalize

				-- we remove node_revisions and pages.
				-- Check: maybe we need a transaction.
			sql_modify (sql_delete_node_revisions, l_parameters)
			sql_finalize

			if not error_handler.has_error then
				extended_delete (a_node)
				sql_commit_transaction
			else
				sql_rollback_transaction
			end
		end

	restore_node_by_id (a_id: INTEGER_64)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
			l_time: DATE_TIME
		do
			create l_time.make_now_utc
			write_information_log (generator + ".restore_node_by_id {" + a_id.out + "}")

			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (l_time, "changed")
			l_parameters.put ({CMS_NODE_API}.published, "status")
			l_parameters.put (a_id, "nid")
			sql_modify (sql_update_node_status, l_parameters)
			sql_finalize
		end


feature {NONE} -- Implementation

	store_node (a_node: CMS_NODE)
		local
			l_copy_parameters: STRING_TABLE [detachable ANY]
			l_parameters: STRING_TABLE [detachable ANY]
			l_rev: like last_inserted_node_revision
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
				l_rev := a_node.revision.max (last_inserted_node_revision (a_node)) + 1 --| starts at (nid, 1)
			else
				l_rev := last_inserted_node_revision (a_node) + 1 --| starts at (nid, 1)
			end
			if a_node.has_id then
					-- Copy existing node data to node_revisions table.
				create l_copy_parameters.make (2)
				l_copy_parameters.force (a_node.id, "nid")
--				l_copy_parameters.force (l_rev - 1, "revision")
				sql_insert (sql_copy_node_to_revision, l_copy_parameters)
				sql_finalize


				if not has_error then
					a_node.set_revision (l_rev)

						-- Update
					l_parameters.put (a_node.id, "nid")
					l_parameters.put (a_node.revision, "revision")
					sql_modify (sql_update_node, l_parameters)
					sql_finalize

					if not error_handler.has_error then
						a_node.set_modification_date (now)
					end
				end
			else
					-- Store new node
				l_parameters.put (a_node.creation_date, "created")
				l_parameters.put (l_rev, "revision")

				sql_insert (sql_insert_node, l_parameters)
				sql_finalize

				if not error_handler.has_error then
					a_node.set_modification_date (now)
					a_node.set_id (last_inserted_node_id)
					a_node.set_revision (l_rev) -- New object.
--					check a_node.revision = last_inserted_node_revision (a_node) end
				end
			end
			if not error_handler.has_error then
				extended_store (a_node) -- Note, `a_node.revision' is updated.
			end
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
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

	sql_select_nodes_count: STRING = "SELECT count(*) FROM nodes WHERE status != -1 ;"
			-- Nodes count (Published and not Published)
			--| note: {CMS_NODE_API}.trashed = -1

	sql_select_nodes: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes WHERE status != -1 ;"
			-- SQL Query to retrieve all nodes.
			--| note: {CMS_NODE_API}.trashed = -1

	sql_select_nodes_of_type: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes WHERE status != -1 AND type=:node_type ;"
			-- SQL Query to retrieve all nodes of type :node_type.
			--| note: {CMS_NODE_API}.trashed = -1		

	sql_select_node_revisions: STRING = "SELECT nodes.nid, node_revisions.revision, nodes.type, node_revisions.title, node_revisions.summary, node_revisions.content, node_revisions.format, node_revisions.author, nodes.publish, nodes.created, node_revisions.changed, node_revisions.status FROM nodes INNER JOIN node_revisions ON nodes.nid = node_revisions.nid WHERE nodes.nid = :nid AND node_revisions.revision < :revision ORDER BY node_revisions.revision DESC;"
			-- SQL query to get node revisions (missing the latest one).

	sql_select_trash_nodes: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes WHERE status = -1 ;"
			-- SQL Query to retrieve all trahsed nodes.
			--| note: {CMS_NODE_API}.trashed = -1		

	sql_select_trash_nodes_by_author: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes WHERE status = -1 and author = :author ;"
			-- SQL Query to retrieve all nodes by a given author.
			--| note: {CMS_NODE_API}.trashed = -1				

	sql_select_node_by_id: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes WHERE nid =:nid ORDER BY revision DESC, publish DESC LIMIT 1;"

	sql_select_node_by_id_and_revision: STRING = "SELECT nodes.nid, node_revisions.revision, nodes.type, node_revisions.title, node_revisions.summary, node_revisions.content, node_revisions.format, node_revisions.author, nodes.publish, nodes.created, node_revisions.changed, node_revisions.status FROM nodes INNER JOIN node_revisions ON nodes.nid = node_revisions.nid WHERE nodes.nid = :nid AND node_revisions.revision = :revision ORDER BY node_revisions.revision DESC;"

	sql_select_recent_nodes: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes ORDER BY nid DESC, publish DESC LIMIT :size OFFSET :offset ;"

	sql_select_recent_node_changes_before: STRING = "SELECT nid, revision, type, title, summary, content, format, author, publish, created, changed, status FROM nodes WHERE changed <= :date ORDER BY changed DESC, nid DESC LIMIT :size OFFSET :offset ;"

	sql_insert_node: STRING = "INSERT INTO nodes (revision, type, title, summary, content, format, publish, created, changed, status, author) VALUES (:revision, :type, :title, :summary, :content, :format, :publish, :created, :changed, :status, :author);"
			-- SQL Insert to add a new node.

	sql_update_node : STRING = "UPDATE nodes SET revision=:revision, type=:type, title=:title, summary=:summary, content=:content, format=:format, publish=:publish, changed=:changed, status=:status, author=:author WHERE nid=:nid;"
			-- SQL update node.

	sql_trash_node: STRING = "UPDATE nodes SET changed=:changed, status =:status WHERE nid=:nid"
			-- Soft deletion with free metadata.

	sql_delete_node: STRING = "DELETE FROM nodes WHERE nid=:nid"
			-- Physical deletion with free metadata.		

	sql_update_node_status: STRING = "UPDATE nodes SET changed=:changed, status =:status WHERE nid=:nid"
			-- Restore node to  {CMS_NODE_API}.published

	sql_last_insert_node_id: STRING = "SELECT MAX(nid) FROM nodes;"

	sql_copy_node_to_revision: STRING = "INSERT INTO node_revisions (nid, revision, title, summary, content, format, author, changed, status) SELECT nid, revision, title, summary, content, format, author, changed, status FROM nodes WHERE nid=:nid;"

	Sql_last_insert_node_revision: STRING = "SELECT MAX(revision) FROM node_revisions;"
	Sql_last_insert_node_revision_for_nid: STRING = "SELECT MAX(revision) FROM node_revisions WHERE nid=:nid;"

	sql_select_available_parents_for_node : STRING = "[
			SELECT node.nid, node.revision, node.type, title, summary, content, format, author, publish, created, changed, status 
			FROM nodes node LEFT JOIN page_nodes pn ON node.nid = pn.nid AND node.nid != :nid 
			WHERE node.nid != :nid AND pn.parent != :nid AND node.status != -1 GROUP BY node.nid, node.revision;
		]"

	sql_select_children_of_node: STRING = "[
			SELECT node.nid, node.revision, node.type, title, summary, content, format, author, publish, created, changed, status
			FROM nodes node LEFT JOIN page_nodes pn ON node.nid = pn.nid
			WHERE pn.parent = :nid AND node.status != -1 GROUP BY node.nid, node.revision;
		]"

	sql_delete_node_revisions: STRING = "DELETE FROM node_revisions WHERE nid=:nid;"



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
				if attached sql_read_string_32 (6) as l_content then
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

end
