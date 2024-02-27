note
	description: "Access to the sql database for the page module"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_STORAGE_SQL

inherit
	CMS_NODE_STORAGE_SQL

	CMS_PAGE_STORAGE_I

create
	make

feature -- Access

	children (a_node: CMS_NODE): detachable LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			from
				create l_parameters.make (1)
				l_parameters.put (a_node.id, "nid")
				sql_query (sql_select_children_of_node, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize_query (sql_select_children_of_node)
		end

	available_parents_for_node (a_node: CMS_NODE): LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			from
				create l_parameters.make (1)
				l_parameters.put (a_node.id, "nid")
				sql_query (sql_select_available_parents_for_node, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize_query (sql_select_available_parents_for_node)
		end


feature {NONE} -- Queries

	sql_select_available_parents_for_node : STRING = "[
			SELECT node.nid, node.revision, node.type, title, summary, content, format, author, editor, publish, created, changed, status
			FROM nodes node LEFT JOIN page_nodes pn ON node.nid = pn.nid AND node.nid != :nid
			WHERE node.nid != :nid AND pn.parent != :nid AND node.status != -1 GROUP BY node.nid, node.revision;
		]"

	sql_select_children_of_node: STRING = "[
			SELECT node.nid, node.revision, node.type, title, summary, content, format, author, editor, publish, created, changed, status
			FROM nodes node LEFT JOIN page_nodes pn ON node.nid = pn.nid
			WHERE pn.parent = :nid AND node.status != -1 GROUP BY node.nid, node.revision;
		]"

end
