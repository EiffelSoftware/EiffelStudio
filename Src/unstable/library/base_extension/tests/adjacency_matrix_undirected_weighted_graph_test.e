note
	description: "Summary description for {ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_shortest_path
		local
			l_graph: ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]
			l_shortest_path : LIST [ like {ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]}.edge_item]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")
			l_graph.put_node ("e")

				-- Put the nodes into the graph.
			l_graph.put_edge ("a", "b", "a-b", 4.8)
			l_graph.put_edge ("a", "c", "a-c", 3.4)
			l_graph.put_edge ("a", "d", "a-d", 2.6)
			l_graph.put_edge ("b", "c", "b-c", 0.7)
			l_graph.put_edge ("b", "d", "b-d", 4.7)
			l_graph.put_edge ("b", "e", "b-e", 1.2)
			l_graph.put_edge ("c", "d", "c-d", 7.1)
			l_graph.put_edge ("d", "e", "d-e", 2.9)


			create {ARRAYED_LIST [ like {ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]}.edge_item]} l_shortest_path.make (3)
			l_shortest_path.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("b", "c", "b-c", 0.7))
			l_shortest_path.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("b", "e", "b-e", 1.2))
			l_shortest_path.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("d", "e", "d-e", 2.9))
			l_shortest_path.compare_objects

				-- Shortes path c to d.
			l_graph.find_path ("c", "d")
			assert ("Path c-d found", l_graph.path_found)

			assert ("All elements in the shortest_path ", ∀ i: l_graph.path ¦ l_shortest_path.has (i))

		end


	test_minimum_spanning_tree
		local
			l_graph: ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]
			l_minimum: ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]
			l_edges: LIST [ like {ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]}.edge_item]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")
			l_graph.put_node ("e")

				-- Put the nodes into the graph.
			l_graph.put_edge ("a", "b", "a-b", 4.8)
			l_graph.put_edge ("a", "c", "a-c", 3.4)
			l_graph.put_edge ("a", "d", "a-d", 2.6)
			l_graph.put_edge ("b", "c", "b-c", 0.7)
			l_graph.put_edge ("b", "d", "b-d", 4.7)
			l_graph.put_edge ("b", "e", "b-e", 1.2)
			l_graph.put_edge ("c", "d", "c-d", 7.1)
			l_graph.put_edge ("d", "e", "d-e", 2.9)


			l_minimum := l_graph.minimum_spanning_tree

			create {ARRAYED_LIST [ like {ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [STRING, STRING]}.edge_item]} l_edges.make (3)
			l_edges.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("a", "d", "a-d", 2.6))
			l_edges.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("b", "c", "b-c", 0.7))
			l_edges.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("b", "e", "b-e", 1.2))
			l_edges.force (create {WEIGHTED_EDGE [STRING, STRING]}.make_undirected ("d", "e", "d-e", 2.9))
			l_edges.compare_objects

			assert ("Same edges ", ∀ i: l_minimum.edges ¦ l_edges.has (i))

		end

end
