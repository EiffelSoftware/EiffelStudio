note
	description: "Storage extension for Page nodes."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_STORAGE_SQL_PAGE_EXTENSION

inherit
	CMS_NODE_STORAGE_EXTENSION [CMS_PAGE]

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
			Result := {CMS_PAGE_NODE_TYPE}.name
		end

feature -- Persistence

	store (a_node: CMS_PAGE)
			-- <Precursor>.	
		local
			l_parameters: STRING_TABLE [ANY]
			l_new_parent_id, l_previous_parent_id: INTEGER_64
			l_update: BOOLEAN
			l_has_modif: BOOLEAN
		do
			debug ("cms")
				if attached api as l_api then
					l_api.logger.put_information (generator + ".store", Void)
				end
			end

			error_handler.reset
				-- Check existing record, if any.
			if attached node_data (a_node) as d then
				l_update := a_node.revision = d.revision
				l_previous_parent_id := d.parent_id
			end
			if not has_error then
				if attached a_node.parent as l_parent then
					l_new_parent_id := l_parent.id
				else
					l_new_parent_id := 0
				end
				l_has_modif := l_has_modif or (l_new_parent_id /= l_previous_parent_id)

				create l_parameters.make (3)
				l_parameters.put (a_node.id, "nid")
				l_parameters.put (a_node.revision, "revision")
				l_parameters.force (l_new_parent_id, "parent")

				if l_update then
					if l_has_modif then
						sql_modify (sql_update_node_data, l_parameters)
						sql_finalize_modify (sql_update_node_data)
					end
				else
					if l_has_modif then
						sql_insert (sql_insert_node_data, l_parameters)
						sql_finalize_insert (sql_insert_node_data)
					else
						-- no page data, means everything is empty.
						-- FOR NOW: always record row
						sql_insert (sql_insert_node_data, l_parameters)
						sql_finalize_insert (sql_insert_node_data)
					end
				end
			end
		end

	load (a_node: CMS_PAGE)
			-- <Precursor>.
		local
			ct: CMS_PAGE_NODE_TYPE
			l_parent_id: INTEGER_64
		do
			if attached node_data (a_node) as d then
				l_parent_id := d.parent_id
				if
					l_parent_id > 0 and then
					l_parent_id /= a_node.id and then
					attached node_storage.node_by_id (l_parent_id) as l_parent
				then
					if attached {CMS_PAGE_NODE_TYPE} node_api.node_type (l_parent.content_type) as l_parent_ct then
						ct := l_parent_ct
					else
						create ct
					end
					a_node.set_parent (ct.new_node (l_parent))
				else
					write_debug_log ("Invalid parent node id!")
				end
			end
		end


	delete_node (a_node: CMS_PAGE)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			if a_node.has_id then
				create l_parameters.make (1)
				l_parameters.put (a_node.id, "nid")
				sql_modify (sql_delete_node_data, l_parameters)
				sql_finalize_modify (sql_delete_node_data)
			end
		end

feature {NONE} -- Implementation

	node_data (a_node: CMS_NODE): detachable TUPLE [revision: INTEGER_64; parent_id: INTEGER_64]
			-- Node extension data for node `a_node' as tuple.
		local
			l_parameters: STRING_TABLE [ANY]
			n: INTEGER
		do
			error_handler.reset
			create l_parameters.make (2)
			l_parameters.put (a_node.id, "nid")
			l_parameters.put (a_node.revision, "revision")
			sql_query (sql_select_node_data, l_parameters)
			if not has_error then
				if not sql_after then
						-- nid, revision, parent
					Result := [sql_read_integer_64 (2), sql_read_integer_64 (3)]
					sql_forth
					if not sql_after then
						check unique_data: n = 0 end
						Result := Void
					end
				else
					check unique_data: n = 0 end
				end
			end
			sql_finalize_query (sql_select_node_data)
		ensure
			accepted_revision: Result /= Void implies Result.revision <= a_node.revision
		end

feature -- SQL

	sql_select_node_data: STRING = "SELECT nid, revision, parent FROM page_nodes WHERE nid=:nid AND revision<=:revision ORDER BY revision DESC LIMIT 1;"
	sql_insert_node_data: STRING = "INSERT INTO page_nodes (nid, revision, parent) VALUES (:nid, :revision, :parent);"
	sql_update_node_data: STRING = "UPDATE page_nodes SET nid=:nid, revision=:revision, parent=:parent WHERE nid=:nid AND revision=:revision;"
	sql_delete_node_data: STRING = "DELETE FROM page_nodes WHERE nid=:nid;"

end
