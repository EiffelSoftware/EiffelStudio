note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_GRAPH

create
	make

feature -- Test routines

	make
			-- New test routine
		do
			print ("Test Depth first search%N")
			test_dfs

			print ("Test Breadth first search%N")
			test_bfs

			print ("Build undirected graph with STRINGs%N")
			test_build_undirected_graph_string

			print ("Build undirected graph with STRINGs and Labels%N")
			test_build_undirected_graph_string_with_labels

			print ("Build adj matrix undirected graph with STRINGs and Labels%N")
			test_build_undirected_matrix_graph_string_with_labels

			print ("Build adj matrix  graph with STRINGs and Labels%N")
			test_build_matrix_graph_string_with_labels

			print ("Build undirected graph with STRINGs and Labels Integer%N")
			test_build_undirected_graph_string_with_labels_integer
		end

	test_build_undirected_graph_string_with_labels
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [STRING, STRING]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")
				-- Put the nodes into the graph.
			l_graph.put_edge ("a", "b", "a-b")
			l_graph.put_edge ("a", "c", "a-c")
			l_graph.put_edge ("b", "c", "b-c")
			l_graph.put_edge ("c", "d", "c-d")

			check
				has_cycles: l_graph.has_cycles
			end

			l_graph.find_path ("a", "d")

			check
				has_path: l_graph.path_found
			end

			check
				four_nodes: l_graph.node_count = 4
			end
			check
				four_edges: l_graph.edge_count = 4
			end

			l_graph.search ("z")
			check
				not_exits: l_graph.off
			end

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

			across l_graph.path as ic loop
				if attached ic.item as l_item then
					print (l_item.out)
				end
			end

			across l_graph as ic loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end

				-- BFS walker
			print ("%NBFS walker")
			l_graph.iterate_breadth_first
			across l_graph as ic
			loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			io.put_new_line

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

				-- DFS walker
			print ("%NDFS walker")
			l_graph.iterate_depth_first
			across l_graph as ic
			loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			print ("%N=============================%N")

			l_graph.prune_edge_between ("a", "b")
			l_graph.find_path ("a", "b")
			check
				not_has_edge: not l_graph.has_edge_between ("a", "b")
			end
		end

	test_build_undirected_matrix_graph_string_with_labels
		local
			l_graph: ADJACENCY_MATRIX_UNDIRECTED_GRAPH [STRING, STRING]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")
				-- Put the nodes into the graph.
			l_graph.put_edge ("a", "b", "a-b")
			l_graph.put_edge ("a", "c", "a-c")
			l_graph.put_edge ("b", "c", "b-c")
			l_graph.put_edge ("c", "d", "c-d")

			check
				has_cycles: l_graph.has_cycles
			end

			l_graph.find_path ("a", "d")

			check
				has_path: l_graph.path_found
			end

			check
				four_nodes: l_graph.node_count = 4
			end
			check
				four_edges: l_graph.edge_count = 4
			end

			l_graph.search ("z")
			check
				not_exits: l_graph.off
			end

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

			across l_graph.path as ic loop
				if attached ic.item as l_item then
					print (l_item.out)
				end
			end

				-- BFS walker
			print ("%NBFS walker")
			l_graph.iterate_breadth_first
			across l_graph as ic loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			io.put_new_line

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

				-- DFS walker
			print ("%NDFS walker")
			l_graph.iterate_depth_first
			across l_graph as ic
			loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			print ("%N=============================%N")

			l_graph.prune_edge_between ("a", "b")
			l_graph.find_path ("a", "b")
			check
				not_has_edge: not l_graph.has_edge_between ("a", "b")
			end
		end

	test_build_matrix_graph_string_with_labels
		local
			l_graph: ADJACENCY_MATRIX_GRAPH [STRING, STRING]
		do
				-- Create the graph
			create l_graph.make_symmetric_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")
				-- Put the nodes into the graph.
			l_graph.put_edge ("a", "b", "a-b")
			l_graph.put_edge ("a", "c", "a-c")
			l_graph.put_edge ("b", "c", "b-c")
			l_graph.put_edge ("c", "d", "c-d")

			check
				has_cycles: l_graph.has_cycles
			end

			l_graph.find_path ("a", "d")

			check
				has_path: l_graph.path_found
			end

			check
				four_nodes: l_graph.node_count = 4
			end
			check
				four_edges: l_graph.edge_count = 8
			end

			l_graph.search ("z")
			check
				not_exits: l_graph.off
			end

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

			across l_graph.path as ic loop
				if attached ic.item as l_item then
					print (l_item.out)
				end
			end

				-- BFS walker
			print ("%NBFS walker")
			l_graph.iterate_breadth_first
			across l_graph as ic loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of in degree edges attached to item: " + l_graph.in_degree.out)
				print ("%NNumber of out degree edges attached to item: " + l_graph.out_degree.out)
			end
			io.put_new_line

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

				-- DFS walker
			print ("%NDFS walker")
			l_graph.iterate_depth_first
			across l_graph as ic
			loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of in degree edges attached to item: " + l_graph.in_degree.out)
				print ("%NNumber of out degree edges attached to item: " + l_graph.out_degree.out)
			end
			print ("%N=============================%N")

			l_graph.prune_edge_between ("a", "b")
			l_graph.find_path ("a", "b")
			check
				not_has_edge: not l_graph.has_edge_between ("a", "b")
			end
		end

	test_build_undirected_graph_string_with_labels_integer
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [STRING, INTEGER_REF]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")

				-- Put the nodes into the graph.
			l_graph.put_edge ("a", "b", 1)
			l_graph.put_edge ("a", "c", 2)
			l_graph.put_edge ("b", "c", 3)
			l_graph.put_edge ("c", "d", 4)

			check
				has_cycles: l_graph.has_cycles
			end

			l_graph.find_path ("a", "d")

			check
				has_path: l_graph.path_found
			end

			check
				four_nodes: l_graph.node_count = 4
			end
			check
				four_edges: l_graph.edge_count = 4
			end

			l_graph.search ("z")
			check
				not_exits: l_graph.off
			end

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

			across l_graph.path as ic loop
				if attached ic.item as l_item then
					print (l_item.out)
				end
			end

				-- BFS walker
			print ("%NBFS walker")
			l_graph.iterate_breadth_first
			across l_graph as  ic loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			io.put_new_line

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

				-- DFS walker
			print ("%NDFS walker")
			l_graph.iterate_depth_first
			across l_graph as ic
			loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			print ("%N=============================%N")
		end

	test_build_undirected_graph_string
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [STRING, NONE]
			it2: GRAPH_ITERATION_CURSOR [STRING, NONE]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.

			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_node ("c")
			l_graph.put_node ("d")

				-- Connect the nodes with the edges
			l_graph.put_unlabeled_edge ("a", "b")
			l_graph.put_unlabeled_edge ("a", "c")
			l_graph.put_unlabeled_edge ("b", "c")
			l_graph.put_unlabeled_edge ("c", "d")

			print ("%NIterator DFS%N")
			l_graph.search ("a")
			across l_graph as ic loop
				print (ic.item)
			end
			check Expected_item_a: l_graph.item.is_equal ("a") end

			print ("%NIterator BFS%N")
			l_graph.iterate_breadth_first
			across l_graph as ic loop
				print (ic.item)
			end
			check Expected_item_a: l_graph.item.is_equal ("a") end
			io.put_new_line

			check
				has_cycles: l_graph.has_cycles
			end

			l_graph.find_path ("a", "d")

			check
				has_path: l_graph.path_found
			end

			check
				four_nodes: l_graph.node_count = 4
			end
			check
				four_edges: l_graph.edge_count = 4
			end

			l_graph.search ("z")
			check
				not_exits: l_graph.off
			end

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

			across l_graph.path as ic loop
				if attached ic.item as l_item then
					print (l_item.out)
				end
			end

				-- BFS walker
			print ("%NBFS walker")
			l_graph.search ("a")
			l_graph.iterate_breadth_first
			across l_graph as ic  loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			io.put_new_line

			l_graph.search ("a")
			check
				exits: not l_graph.off
			end

				-- DFS walker
				-- Iterator DFS walker
			print ("%NDFS Iterator")
			l_graph.iterate_depth_first
			across l_graph as ic loop
				print ("%NCurrent item: " + ic.item)
				print ("%NNumber of edges attached to item: " + l_graph.degree.out)
			end
			print ("%N=============================")

		end


	test_dfs
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [INTEGER, NONE]
		do
				--  (8) -- (0) -- (1) -- (7)
				--   |      |             |
				--  (4) -- (3) ----------(2) -- (5)---(6)
			create l_graph.make_simple_graph

				-- Add nodes
			l_graph.put_node (0)
			l_graph.put_node (1)
			l_graph.put_node (2)
			l_graph.put_node (3)
			l_graph.put_node (4)
			l_graph.put_node (5)
			l_graph.put_node (6)
			l_graph.put_node (7)
			l_graph.put_node (8)

				-- Add edges
			l_graph.put_unlabeled_edge (0, 1)
			l_graph.put_unlabeled_edge (0, 3)
			l_graph.put_unlabeled_edge (0, 8)
			l_graph.put_unlabeled_edge (1, 7)
			l_graph.put_unlabeled_edge (3, 2)
			l_graph.put_unlabeled_edge (3, 4)
			l_graph.put_unlabeled_edge (8, 4)
			l_graph.put_unlabeled_edge (2, 5)
			l_graph.put_unlabeled_edge (2, 7)
			l_graph.put_unlabeled_edge (5, 6)

				-- Start at node 0
			l_graph.search (0)

				-- DFS by default
			across l_graph as ic loop
				print (ic.item)
			end

		end


	test_bfs
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [INTEGER, NONE]
		do
				--  (8) -- (0) -- (1) -- (7)
				--   |      |             |
				--  (4) -- (3) ----------(2) -- (5)---(6)
			create l_graph.make_simple_graph

				-- Add nodes
			l_graph.put_node (0)
			l_graph.put_node (1)
			l_graph.put_node (2)
			l_graph.put_node (3)
			l_graph.put_node (4)
			l_graph.put_node (5)
			l_graph.put_node (6)
			l_graph.put_node (7)
			l_graph.put_node (8)

				-- Add edges
			l_graph.put_unlabeled_edge (0, 1)
			l_graph.put_unlabeled_edge (0, 3)
			l_graph.put_unlabeled_edge (0, 8)
			l_graph.put_unlabeled_edge (1, 7)
			l_graph.put_unlabeled_edge (3, 2)
			l_graph.put_unlabeled_edge (3, 4)
			l_graph.put_unlabeled_edge (8, 4)
			l_graph.put_unlabeled_edge (2, 5)
			l_graph.put_unlabeled_edge (2, 7)
			l_graph.put_unlabeled_edge (5, 6)

				-- Start at node 0
			l_graph.search (0)

			l_graph.iterate_breadth_first
			across l_graph as ic loop
				print (ic.item)
			end

		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

