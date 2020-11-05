note
	description: "Summary description for {LINKED_UNDIRECTED_GRAPH_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_UNDIRECTED_GRAPH_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_prune_edge_simple_graph
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [STRING, STRING]
			l_nodes: SET [like {LINKED_UNDIRECTED_GRAPH [STRING, STRING]}.item]
			l_edges: LIST [like {LINKED_UNDIRECTED_GRAPH [STRING, STRING]}.edge_item]
			l_incident_labels: LIST [STRING]
			l_neighbors: SET [STRING]
		do
				-- Create the graph
			create l_graph.make_simple_graph

				-- Put the nodes into the graph.
			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_edge ("a", "b", "a-b")

			assert ("Number of edges", l_graph.edge_count = 1)

			l_graph.search ("a")
			assert ("Expected in_degree (a)", l_graph.degree = 1)

			l_graph.search ("b")
			assert ("Expected in_degree (b)", l_graph.degree = 1)


			create {ARRAYED_LIST [like {LINKED_GRAPH [STRING, STRING]}.edge_item]} l_edges.make (1)
			l_edges.compare_objects
			l_edges.force (create {LINKED_GRAPH_EDGE [STRING, STRING]}.make_directed (create {LINKED_GRAPH_NODE [STRING, STRING]}.make ("a"), create {LINKED_GRAPH_NODE [STRING, STRING]}.make ("b"), "a-b"))

			if attached {like {LINKED_UNDIRECTED_GRAPH [STRING, STRING]}.edges} l_graph.edges as l_graph_edges then
				l_graph_edges.compare_objects
				assert ("All edges exist", ∀ e: l_graph_edges ¦ l_edges.has (e))
			end

			create {ARRAYED_LIST [STRING]} l_incident_labels.make_from_iterable (<<"a-b">>)
			l_graph.search ("a")
			if attached l_graph.incident_edge_labels as l_item_incident_lables then
				l_incident_labels.compare_objects
				assert ("Expected item a", l_graph.item.is_equal ("a"))
				assert ("Expected incient_labels item ", ∀ i: l_item_incident_lables ¦ l_incident_labels.has (i))
			end

			l_graph.search ("b")
			if attached l_graph.incident_edge_labels as l_item_incident_lables then
				l_incident_labels.compare_objects
				assert ("Expected item a", l_graph.item.is_equal ("b"))
				assert ("Expected incient_labels item ", ∀ i: l_item_incident_lables ¦ l_incident_labels.has (i))
			end

			create {ARRAYED_SET [STRING]} l_neighbors.make (1)
			l_neighbors.compare_objects
			l_neighbors.put ("b")
			l_graph.search ("a")
			assert ("All neighbors exist", ∀ n: l_graph.neighbors ¦ l_neighbors.has (n))

			create {ARRAYED_SET [STRING]} l_neighbors.make (1)
			l_neighbors.compare_objects
			l_neighbors.put ("a")
			l_graph.search ("b")
			assert ("All neighbors exist", ∀ n: l_graph.neighbors ¦ l_neighbors.has (n))

			create {ARRAYED_SET [like {LINKED_UNDIRECTED_GRAPH [STRING, STRING]}.item]} l_nodes.make (2)
			l_nodes.compare_objects
			l_nodes.put ("a")
			l_nodes.put ("b")

			assert ("Number of nodes 2", l_graph.node_count = 2)
			assert ("All nodes exist", ∀ n: l_graph.nodes ¦ l_nodes.has (n))

			assert ("Has edge a-b", l_graph.has_edge_between ("a", "b"))
			l_graph.prune_edge_between ("a", "b")
			assert ("Not has edge a-b", not l_graph.has_edge_between ("a", "b"))
		end

	test_prune_edge_simple_graph_2
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
			assert ("Has edge a-b", l_graph.has_edge_between ("a", "b"))
			l_graph.prune_edge_between ("a", "b")
			assert ("Not has edge a-b", not l_graph.has_edge_between ("a", "b"))
		end

	test_prune_edge_multi_graph
		local
			l_graph: LINKED_UNDIRECTED_GRAPH [STRING, STRING]
		do
				-- Create the graph
			create l_graph.make_multi_graph

				-- Put the nodes into the graph.
			l_graph.put_node ("a")
			l_graph.put_node ("b")
			l_graph.put_unlabeled_edge ("a", "b")
			l_graph.put_unlabeled_edge ("a", "b")
			assert ("Has edge a-b", l_graph.has_edge_between ("a", "b"))
			assert ("Has 2 edges", l_graph.edge_count = 2)
			if attached l_graph.edges.at (1) as l_edge then
				l_graph.prune_edge (l_edge)
				assert ("Has 1 edges", l_graph.edge_count = 1)
			end
		end

end
