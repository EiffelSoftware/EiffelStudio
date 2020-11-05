note
	description: "Set of test cases for GRAPH_ITERATION_CURSOR"
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPH_ITERATION_CURSOR_TEST

inherit
	EQA_TEST_SET

feature -- Tests

	test_dfs_linked_undirected_graphs
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [INTEGER, NONE]
			expected_result: LIST [INTEGER]
			dfs_result: LIST [INTEGER]
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

			create {ARRAYED_LIST [INTEGER]} expected_result.make_from_array (<<0, 3, 2, 5, 6, 7, 1, 4, 8>>)
			expected_result.compare_objects

			create {ARRAYED_LIST [INTEGER]} dfs_result.make (9)
			dfs_result.compare_objects

				-- DFS by default
			across l_graph as ic loop
				dfs_result.force (ic.item)
			end

			assert ("Same List", expected_result.is_equal (dfs_result))

		end

	test_bfs_linked_undirected_graphs
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [INTEGER, NONE]
			expected_result: LIST [INTEGER]
			bfs_result: LIST [INTEGER]
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

			create {ARRAYED_LIST [INTEGER]} expected_result.make_from_array (<<0, 1, 8, 3, 7, 4, 2, 5, 6>>)
			expected_result.compare_objects

			create {ARRAYED_LIST [INTEGER]} bfs_result.make (9)
			bfs_result.compare_objects

				-- Set bdf iteration
			l_graph.iterate_breadth_first
			across l_graph as ic loop
				bfs_result.force (ic.item)
			end

			assert ("Same List", expected_result.is_equal (bfs_result))

		end

	test_dfs_adjacency_matrix_undirected_graphs
		local
			l_graph: ADJACENCY_MATRIX_UNDIRECTED_GRAPH [INTEGER, NONE]
			expected_result: LIST [INTEGER]
			dfs_result: LIST [INTEGER]
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

			create {ARRAYED_LIST [INTEGER]} expected_result.make_from_array (<<0, 3, 2, 5, 6, 7, 1, 4, 8>>)
			expected_result.compare_objects

			create {ARRAYED_LIST [INTEGER]} dfs_result.make (9)
			dfs_result.compare_objects

				-- DFS by default
			across l_graph as ic loop
				dfs_result.force (ic.item)
			end

			assert ("Same List", expected_result.is_equal (dfs_result))

		end

	test_bfs_adjacency_matrix_undirected_graphs
		local
			l_graph: ADJACENCY_MATRIX_UNDIRECTED_GRAPH [INTEGER, NONE]
			expected_result: LIST [INTEGER]
			bfs_result: LIST [INTEGER]
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

			create {ARRAYED_LIST [INTEGER]} expected_result.make_from_array (<<0, 1, 8, 3, 7, 4, 2, 5, 6>>)
			expected_result.compare_objects

			create {ARRAYED_LIST [INTEGER]} bfs_result.make (9)
			bfs_result.compare_objects

				-- Set bdf iteration
			l_graph.iterate_breadth_first
			across l_graph as ic loop
				bfs_result.force (ic.item)
			end

			assert ("Same List", expected_result.is_equal (bfs_result))

		end

end
