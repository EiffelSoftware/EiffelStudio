note
	description: "Summary description for {CMS_NODE_STORAGE_SQLITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_STORAGE_SQLITE

inherit
	CMS_NODE_STORAGE_SQL
		redefine
			nodes, recent_nodes
		end

feature {NONE} -- Implementation

	db_handler: DATABASE_HANDLER
		deferred
		end

feature -- Access		

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
			across nodes_iterator as ic loop
				Result.force (ic.item)
			end
		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of recent `a_count' nodes with an offset of `lower'.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (a_count)
			across recent_nodes_iterator (a_lower, a_count) as c loop
				Result.force (c.item)
			end
		end

feature -- Access: iterator		

	nodes_iterator: DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- List of nodes.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			log.write_information (generator + ".nodes_iterator")
			create l_parameters.make (0)
			sql_query (select_nodes, l_parameters)
			sql_post_execution
			create Result.make (db_handler, agent fetch_node)
		end

	recent_nodes_iterator (a_lower, a_rows: INTEGER): DATABASE_ITERATION_CURSOR [CMS_NODE]
			-- The most recent `a_rows'.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING
		do
			-- FIXME: check implementation...
			error_handler.reset
			log.write_information (generator + ".recent_nodes_iterator")
			create l_parameters.make (2)
			l_parameters.put (a_rows, "rows")
			l_parameters.put (a_lower, "offset")
			create l_query.make_from_string (select_recent_nodes)
			sql_query (l_query, l_parameters)
			create Result.make (db_handler, agent fetch_node)
			sql_post_execution
		end

end
