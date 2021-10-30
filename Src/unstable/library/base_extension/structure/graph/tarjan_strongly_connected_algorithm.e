note
	description: "Tarjan's strongly connected components algorithm"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Tarjan's Strongly Connected Components Algorithm", "protocol=URI", "src=http://en.wikipedia.org/wiki/Tarjan's_strongly_connected_components_algorithm"

class
	TARJAN_STRONGLY_CONNECTED_ALGORITHM [V -> HASHABLE]

create
	make_with_graph

feature {NONE} -- Initialization

	make_with_graph (a_graph: like graph)
			-- Initialization
		do
			graph := a_graph
			create vertices_info.make (5)
			create strongly_connected_components.make (0)
		end

feature -- Access

	graph: DIRECTED_GRAPH [V]
			-- The graph

	compute_cycle
			-- Compute cycle
		local
			l_stack: ARRAYED_STACK [V]
			l_index: INTEGER
			l_info: TARJAN_VERTEX_INFO
		do
			vertices_info.wipe_out
			strongly_connected_components.wipe_out
			create l_stack.make (5)
			l_index := {TARJAN_VERTEX_INFO}.start_index

			across
				graph.vertices as l_c
			loop
				l_info := fetch_vertex_info (l_c)
				if not l_info.is_index_defined then
					strong_connect (graph, l_c, l_stack, l_index)
				end
			end
		end

	cycles: ARRAYED_LIST [SEARCH_TABLE [V]]
			-- Computed cycles
		do
			Result := strongly_connected_components
		end

feature -- Element Change

	set_graph (a_graph: like graph)
			-- Set `graph' with `a_graph'.
		do
			graph := a_graph
		ensure
			graph_set: graph = a_graph
		end

feature {NONE} -- Implementation

	strong_connect (a_graph: like graph; a_vertex: V; a_stack: ARRAYED_STACK [V]; a_index: INTEGER)
			-- Recursively get strong connected components.
		local
			l_info, l_adjacent_info: like fetch_vertex_info
			l_v: detachable V
			l_component: SEARCH_TABLE [V]
		do
			l_info := fetch_vertex_info (a_vertex)
			l_info.set_index (a_index)
			l_info.set_low_link (a_index)

			a_stack.put (a_vertex)

			across
				a_graph.out_bound_vertices (a_vertex) as l_c
			loop
				l_v := l_c
				l_adjacent_info := fetch_vertex_info (l_v)
				if not l_adjacent_info.is_index_defined then
					strong_connect (graph, l_v, a_stack, a_index + 1)
					l_info.set_low_link (l_info.low_link.min (l_adjacent_info.low_link))
				elseif a_stack.has (l_v) then
					l_info.set_low_link (l_info.low_link.min (l_adjacent_info.low_link))
				end
			end

			if l_info.low_link = l_info.index then
				create l_component.make (5)
				from
					if not a_stack.is_empty then
						l_v := a_stack.item
						a_stack.remove
						l_component.force (l_v)
					end
				until
					a_stack.is_empty or else l_v = a_vertex
				loop
					l_v := a_stack.item
					a_stack.remove
					l_component.force (l_v)
				end
					-- Drop independent vertex
				if l_component.count > 1 then
					strongly_connected_components.extend (l_component)
				end
			end
		end

	fetch_vertex_info (v: V): TARJAN_VERTEX_INFO
			-- Vertex info
		local
			l_vertices_info: like vertices_info
		do
			l_vertices_info := vertices_info
			l_vertices_info.search (v)
			if vertices_info.found and then attached l_vertices_info.found_item as l_found_item then
				Result := l_found_item
			else
				create Result
				l_vertices_info.put (Result, v)
			end
		end

	vertices_info: HASH_TABLE [TARJAN_VERTEX_INFO, V]
				-- Vertices info

	strongly_connected_components: ARRAYED_LIST [SEARCH_TABLE [V]];
				-- Strongly connected components

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
