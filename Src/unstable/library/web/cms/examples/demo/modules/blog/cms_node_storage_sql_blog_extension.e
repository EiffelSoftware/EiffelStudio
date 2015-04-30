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
			sql_storage as node_storage
		redefine
			node_storage
		end

create
	make

feature {NONE} -- Initialization

	node_storage: CMS_NODE_STORAGE_SQL
			-- <Precursor>

feature -- Access

	content_type: STRING
		once
			Result := {CMS_BLOG_NODE_TYPE}.name
		end

feature -- Persistence

	store (a_node: CMS_BLOG)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_new_tags: detachable STRING_32
			l_previous_tags: detachable STRING_32
			l_update: BOOLEAN
		do
			error_handler.reset
			if attached api as l_api then
				l_api.logger.put_information (generator + ".store", Void)
			end

			create l_parameters.make (2)
			l_parameters.put (a_node.id, "nid")
			l_parameters.put (a_node.revision, "revision")

			sql_query (sql_select_blog_data, l_parameters)
			if not has_error then
				if sql_rows_count = 1 then
					l_previous_tags := sql_read_string_32 (3)
					l_update := True
				end
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
				l_parameters.put (l_new_tags, "tags")
				if l_update and l_new_tags /~ l_previous_tags then
					sql_change (sql_update_blog_data, l_parameters)
				elseif l_new_tags /= Void then
					sql_change (sql_insert_blog_data, l_parameters)
				else
					-- no blog data, means everything is empty.
				end
			end
		end

	load (a_node: CMS_BLOG)
		local
			l_parameters: STRING_TABLE [ANY]
			n: INTEGER
		do
			error_handler.reset
			create l_parameters.make (2)
			l_parameters.put (a_node.id, "nid")
			l_parameters.put (a_node.revision, "revision")
			sql_query (sql_select_blog_data, l_parameters)
			if not has_error then
				n := sql_rows_count
				if n = 1 then
						-- nid, revision, parent
					if
						attached sql_read_string_32 (3) as l_tags and then
						not l_tags.is_whitespace
					then
							-- FIXME: find a simple way to access the declared content types.
						a_node.set_tags_from_string (l_tags)
					end
				else
					check unique_data: n = 0 end
				end
			end
		end

feature -- SQL

	sql_select_blog_data: STRING = "SELECT nid, revision, tags FROM blog_post_nodes WHERE nid =:nid AND revision=:revision;"
	sql_insert_blog_data: STRING = "INSERT INTO blog_post_nodes (nid, revision, tags) VALUES (:nid, :revision, :tags);"
	sql_update_blog_data: STRING = "UPDATE blog_post_nodes SET nid=:nid, revision=:revision, tags=:tags WHERE nid=:nid AND revision=:revision;"

end
