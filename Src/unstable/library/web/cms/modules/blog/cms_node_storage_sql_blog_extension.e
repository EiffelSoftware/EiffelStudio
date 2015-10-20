note
	description: "Storage extension for Blog nodes."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_STORAGE_SQL_BLOG_EXTENSION

inherit
	CMS_NODE_STORAGE_EXTENSION [CMS_BLOG]

	CMS_PROXY_STORAGE_SQL
		rename
			make as make_proxy,
			sql_storage as node_storage
		redefine
			node_storage
		end

create
	make

feature {NONE} -- Initialization

	make (a_node_api: CMS_NODE_API; a_sql_storage: CMS_NODE_STORAGE_SQL)
		do
			set_node_api (a_node_api)
			make_proxy (a_sql_storage)
		end

	node_storage: CMS_NODE_STORAGE_SQL
			-- <Precursor>

feature -- Access

	content_type: STRING
		once
			Result := {CMS_BLOG_NODE_TYPE}.name
		end

feature -- Persistence

	store (a_node: CMS_BLOG)
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_new_tags: detachable STRING_32
			l_previous_tags: detachable STRING_32
			l_update: BOOLEAN
			l_has_modif: BOOLEAN
		do
			if attached api as l_api then
				l_api.logger.put_information (generator + ".store", Void)
			end

			error_handler.reset
				-- Check existing record, if any.
			if attached node_data (a_node) as d then
				l_update := d.revision = a_node.revision
				l_previous_tags := d.tags
			end
			if not has_error then
				if attached a_node.tags as l_tags and then not l_tags.is_empty then
					create l_new_tags.make (0)
					across
						l_tags as ic
					loop
						if not l_new_tags.is_empty then
							l_new_tags.append_character (',')
						end
						l_new_tags.append (ic.item)
					end
				else
					l_new_tags := Void
				end

				l_has_modif := l_has_modif or (l_new_tags /~ l_previous_tags)

				create l_parameters.make (3)
				l_parameters.put (a_node.id, "nid")
				l_parameters.put (a_node.revision, "revision")
				l_parameters.force (l_new_tags, "tags")

				if l_update then
					if l_has_modif then
						sql_modify (sql_update_node_data, l_parameters)
					end
				else
					if l_has_modif then
						sql_insert (sql_insert_node_data, l_parameters)
					else
						-- no page data, means everything is empty.
						-- FOR NOW: always record row
--						sql_change (sql_insert_node_data, l_parameters)
					end
				end
				sql_finalize
			end
		end

	load (a_node: CMS_BLOG)
			-- <Precursor>.
		local
			l_tags: READABLE_STRING_32
		do
			if attached node_data (a_node) as d then
				l_tags := d.tags
				a_node.set_tags_from_string (l_tags)
			end
		end

	delete_node (a_node: CMS_BLOG)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			if a_node.has_id then
				create l_parameters.make (1)
				l_parameters.put (a_node.id, "nid")
				sql_modify (sql_delete_node_data, l_parameters)
				sql_finalize
			end
		end

feature {NONE} -- Implementation		

	node_data (a_node: CMS_NODE): detachable TUPLE [revision: INTEGER_64; tags: READABLE_STRING_32]
			-- Node extension data for node `a_node' as tuple.
		local
			l_parameters: STRING_TABLE [ANY]
			l_rev: INTEGER_64
			l_tags: detachable READABLE_STRING_32
			n: INTEGER
		do
			error_handler.reset
			create l_parameters.make (2)
			l_parameters.put (a_node.id, "nid")
			l_parameters.put (a_node.revision, "revision")
			sql_query (sql_select_node_data, l_parameters)
			if not has_error then
				if not sql_after then
						-- nid, revision, tags
					l_rev := sql_read_integer_64 (2)
					l_tags := sql_read_string_32 (3)
					if l_tags /= Void then
						Result := [l_rev, l_tags]
					end
					sql_forth
					if not sql_after then
						check unique_data: n = 0 end
						Result := Void
					end
				end
			end
			sql_finalize
		ensure
			accepted_revision: Result /= Void implies Result.revision <= a_node.revision
		end

feature -- SQL

	sql_select_node_data: STRING = "SELECT nid, revision, tags FROM blog_post_nodes WHERE nid=:nid AND revision<=:revision ORDER BY revision DESC LIMIT 1;"
	sql_insert_node_data: STRING = "INSERT INTO blog_post_nodes (nid, revision, tags) VALUES (:nid, :revision, :tags);"
	sql_update_node_data: STRING = "UPDATE blog_post_nodes SET nid=:nid, revision=:revision, tags=:tags WHERE nid=:nid AND revision=:revision;"
	sql_delete_node_data: STRING = "DELETE FROM blog_post_nodes WHERE nid=:nid;"

end
