note
	description: "Interface for accessing user profile contents from SQL database."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_COMMENTS_STORAGE_SQL

inherit
	CMS_COMMENTS_STORAGE_I

	CMS_PROXY_STORAGE_SQL

create
	make

feature -- Access

	comment (a_cid: INTEGER_64): detachable CMS_COMMENT
			-- Comment with id `a_cid`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (1)
			l_parameters.put (a_cid, "cid")
			sql_query (sql_select_comment_by_id, l_parameters)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_comment
			end
			sql_finalize_query (sql_select_comment_by_id)
		end

	comments_for (a_content: CMS_CONTENT): detachable LIST [CMS_COMMENT]
			-- Comments for content `a_content`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_COMMENT]} Result.make (0)
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_content.identifier, "content_id")
			from
				sql_query (sql_select_comments_for_content, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_comment as obj then
					Result.force (obj)
				end
				sql_forth
			end
			sql_finalize_query (sql_select_comments_for_content)
		end

feature -- Change

	save_comment (a_comment: CMS_COMMENT)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (11)

			l_parameters.put (a_comment.content, "content")
			l_parameters.put (a_comment.format, "format")
			if attached a_comment.author as u then
				l_parameters.put (u.id, "author")
				l_parameters.put (u.name, "author_name")
			else
				l_parameters.put (0, "author")
				if attached a_comment.author_name as l_author_name then
					l_parameters.put (l_author_name, "author_name")
				else
					l_parameters.put ("", "author_name")
				end
			end

			l_parameters.put (a_comment.creation_date, "created")
			l_parameters.put (a_comment.modification_date, "changed")
			l_parameters.put (a_comment.status, "status")

			if attached a_comment.parent as p and then p.has_id then
				l_parameters.put (p.id, "parent")
			else
				l_parameters.put (0, "parent")
			end

			if attached a_comment.entity as l_entity then
				l_parameters.put (l_entity.identifier, "entity")
				l_parameters.put (l_entity.content_type, "entity_type")
			else
				l_parameters.put ("", "entity")
				l_parameters.put ("", "entity_type")
			end

			sql_begin_transaction
			if a_comment.has_id then
				l_parameters.put (a_comment.id, "cid")
				sql_modify (sql_update_comment, l_parameters)
				sql_finalize_modify (sql_update_comment)
			else
				sql_insert (sql_insert_comment, l_parameters)
				sql_finalize_insert (sql_insert_comment)
				if not has_error then
					a_comment.set_id (last_inserted_comment_id)
				end
			end
			if has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

feature {NONE} -- Implementation

	fetch_comment: detachable CMS_COMMENT
		local
			cid, uid, pid, l_entity_id: INTEGER_64
			l_entity: detachable CMS_PARTIAL_CONTENT
		do
			cid := sql_read_integer_64 (1)
			if cid > 0 then
				create Result.make
				Result.set_id (cid)
				Result.set_content (sql_read_string_32 (2))
				Result.set_format (sql_read_string (3))
				uid := sql_read_integer_64 (4)
				if uid > 0 then
					Result.set_author (create {CMS_PARTIAL_USER}.make_with_id (uid))
				end
				Result.set_author_name (sql_read_string_32 (5))
				if attached sql_read_date_time (6) as dt then
					Result.set_creation_date (dt)
				end
				if attached sql_read_date_time (7) as dt then
					Result.set_modification_date (dt)
				end

				Result.set_status (sql_read_integer_32 (8))
				pid := sql_read_integer_64 (9)
				if pid > 0 then
					Result.set_parent (create {CMS_PARTIAL_COMMENT}.make_with_id (pid))
				end
				l_entity_id := sql_read_integer_64 (10)
				if
					attached sql_read_string (11) as l_entity_type and
					l_entity_id > 0
				then
					create l_entity.make_empty (l_entity_type)
					l_entity.set_identifier (l_entity_id.out)
					Result.set_entity (l_entity)
				end
--				l_entity_type := sql_read_string_32 (11)
--				if l_entity_type /= Void then
--					Result.set_en
--				end
			end
		end

	last_inserted_comment_id: INTEGER_64
			-- Last insert comment id.
		do
			error_handler.reset
			sql_query (Sql_last_inserted_comment_id, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (Sql_last_inserted_comment_id)
		end

feature {NONE} -- Queries

	Sql_last_inserted_comment_id: STRING = "SELECT MAX(cid) FROM comments;"

	sql_select_comment_by_id: STRING = "SELECT cid, content, format, author, author_name, created, changed, status, parent, entity, entity_type FROM comments WHERE cid=:cid ;"

	sql_select_comments_for_content: STRING = "SELECT cid, content, format, author, author_name, created, changed, status, parent, entity, entity_type FROM comments WHERE entity=:content_id ;"

	sql_insert_comment: STRING = "INSERT INTO comments (content, format, author, author_name, created, changed, status, parent, entity, entity_type) VALUES (:content, :format, :author, :author_name, :created, :changed, :status, :parent, :entity, :entity_type) ;"
	sql_update_comment: STRING = "UPDATE comments SET content=:content, format=:format, author=:author, author_name=:author_name, created=:created, changed=:changed, status=:status, parent=:parent, entity=:entity, entity_type=:entity_type WHERE cid=:cid ;"

end
