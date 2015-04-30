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
			Result := {CMS_PAGE_NODE_TYPE}.name
		end

feature -- Persistence

	store (a_node: CMS_PAGE)
		local
			l_parameters: STRING_TABLE [ANY]
			l_new_parent_id, l_previous_parent_id: INTEGER_64
			l_update: BOOLEAN
		do
			error_handler.reset
			write_information_log (generator + ".store_page_data")
			create l_parameters.make (2)
			l_parameters.put (a_node.id, "nid")
			l_parameters.put (a_node.revision, "revision")

			sql_query (sql_select_page_data, l_parameters)
			if not has_error then
				if sql_rows_count = 1 then
					l_previous_parent_id := sql_read_integer_64 (3)
					l_update := True
				end
				if attached a_node.parent as l_parent then
					l_new_parent_id := l_parent.id
				else
					l_new_parent_id := 0
				end
				l_parameters.put (l_new_parent_id, "parent")
				if l_update and l_new_parent_id /= l_previous_parent_id then
					sql_change (sql_update_page_data, l_parameters)
				elseif l_new_parent_id > 0 then
					sql_change (sql_insert_page_data, l_parameters)
				else
					-- no page data, means everything is empty.
				end
			end
		end

	load (a_node: CMS_PAGE)
		local
			l_parameters: STRING_TABLE [ANY]
			n: INTEGER
			ct: CMS_PAGE_NODE_TYPE
		do
			error_handler.reset
			write_information_log (generator + ".fill_page")
			create l_parameters.make (2)
			l_parameters.put (a_node.id, "nid")
			l_parameters.put (a_node.revision, "revision")
			sql_query (sql_select_page_data, l_parameters)
			if not has_error then
				n := sql_rows_count
				if n = 1 then
						-- nid, revision, parent
					if
						attached sql_read_integer_64 (3) as l_parent_id and then
						l_parent_id /= a_node.id and then
						attached node_storage.node_by_id (l_parent_id) as l_parent
					then
							-- FIXME: find a simple way to access the declared content types.
						create ct
						a_node.set_parent (ct.new_node (l_parent))
					else
						write_debug_log ("Invalid parent node id!")
					end
				else
					check unique_data: n = 0 end
				end
			end
		end

feature -- SQL

	sql_select_page_data: STRING = "SELECT nid, revision, parent FROM page_nodes WHERE nid =:nid AND revision=:revision;"
	sql_insert_page_data: STRING = "INSERT INTO page_nodes (nid, revision, parent) VALUES (:nid, :revision, :parent);"
	sql_update_page_data: STRING = "UPDATE page_nodes SET nid=:nid, revision=:revision, parent=:parent WHERE nid=:nid AND revision=:revision;"


end
