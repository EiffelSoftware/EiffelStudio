indexing
	description: "[
					Objects that is a model for a graph
					Use EG_FIGURE_WORLD to create a view.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_GRAPH

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create an empty graph.
		do
			create node_add_actions
			create link_add_actions
			create cluster_add_actions
			node_add_actions.compare_objects
			link_add_actions.compare_objects
			cluster_add_actions.compare_objects

			create link_remove_actions
			create node_remove_actions
			create cluster_remove_actions
			link_remove_actions.compare_objects
			node_remove_actions.compare_objects
			cluster_remove_actions.compare_objects

			create nodes.make (0)
			create clusters.make (0)
			create links.make (0)
		end

feature -- Access

	flat_nodes: like nodes is
			-- All nodes in the graph.
		do
			Result := nodes.twin
		ensure
			result_not_void: Result /= Void
		end

	flat_clusters: like clusters is
			-- All clusters in the graph.
		do
			Result := clusters.twin
		ensure
			result_not_void: Result /= Void
		end

	flat_links: like links is
			-- All links in the graph.
		do
			Result := links.twin
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	has_node (a_node: like node_type): BOOLEAN is
			-- Is `a_node' part of the model?
		require
			a_node_not_void: a_node /= Void
		do
			Result := nodes.has (a_node)
		end

	has_link (a_link: EG_LINK): BOOLEAN is
			-- Is `a_link' part of the model?
		require
			a_link_not_void: a_link /= Void
		do
			Result := links.has (a_link)
		end

	has_linkable (a_linkable: EG_LINKABLE): BOOLEAN is
			-- Is `a_linkable' part of the model?
		local
			node: like node_type
			cluster: EG_CLUSTER
		do
			node ?= a_linkable
			if node /= Void then
				Result := has_node (node)
			else
				cluster ?= a_linkable
				if cluster /= Void then
					Result := has_cluster (cluster)
				end
			end
		end

	has_cluster (a_cluster: EG_CLUSTER): BOOLEAN is
			-- Is `a_cluster' part of the model?
		require
			a_cluster_not_void: a_cluster /= Void
		do
			Result := clusters.has (a_cluster)
		end

	is_empty: BOOLEAN is
			-- Is `Current' empty?
		do
			Result := links.is_empty and then nodes.is_empty and then clusters.is_empty
		end


feature -- Element change

	add_node (a_node: EG_NODE) is
			-- Add `a_node' to the model.
		require
			a_node_not_void: a_node /= Void
			has_not_a_node: not has_node (a_node)
		do
			nodes.extend (a_node)
			a_node.set_graph (Current)
			node_add_actions.call ([a_node])
		ensure
			has_a_node: has_node (a_node)
		end

	add_link (a_link: EG_LINK) is
			-- Add `a_link' to the model.
		require
			a_link_not_void: a_link /= Void
			has_not_a_link: not has_link (a_link)
			has_source: has_linkable (a_link.source)
			has_target: has_linkable (a_link.target)
		do
			links.extend (a_link)
			a_link.set_graph (Current)
			link_add_actions.call ([a_link])
		ensure
			has_a_link: has_link (a_link)
		end

	add_cluster (a_cluster: EG_CLUSTER) is
			-- Add `a_cluster' to the model.
		require
			a_cluster_not_void: a_cluster /= Void
			not_has_cluster: not has_cluster (a_cluster)
			has_all_linkables: a_cluster.flat_linkables.for_all (agent has_linkable)
		do
			clusters.extend (a_cluster)
			a_cluster.set_graph (Current)
			cluster_add_actions.call ([a_cluster])
		ensure
			has_cluster: has_cluster (a_cluster)
		end

	remove_link (a_link: EG_LINK) is
			-- Remove `a_link' from the model.
		require
			a_link_not_void: a_link /= Void
			has_a_link: has_link (a_link)
		do
			links.prune_all (a_link)
			if a_link.source /= Void then
				a_link.source.remove_link (a_link)
			end
			if a_link.target /= Void and then a_link.source /= a_link.target then
				a_link.target.remove_link (a_link)
			end
			a_link.set_graph (Void)
			link_remove_actions.call ([a_link])
		ensure
			not_has_a_link: not has_link (a_link)
			link_removed_from_source: a_link.source /= Void implies not a_link.source.links.has (a_link)
			link_removed_from_target: a_link.target /= Void implies not a_link.target.links.has (a_link)
		end

	remove_node (a_node: EG_NODE) is
			-- Remove `a_node' from the model.
		require
			a_node_not_void: a_node /= Void
			a_node_no_links: a_node.links.is_empty
		do
			nodes.prune_all (a_node)
			if a_node.cluster /= Void then
				a_node.cluster.prune_all (a_node)
			end
			node_remove_actions.call ([a_node])
		ensure
			not_has_a_node: not has_node (a_node)
			removed_from_cluster: a_node.cluster /= Void implies not a_node.cluster.flat_linkables.has (a_node)
		end

	remove_cluster (a_cluster: EG_CLUSTER) is
			-- Remove `a_cluster' from the model.
		require
			a_cluster_not_void: a_cluster /= Void
			has_a_cluster: has_cluster (a_cluster)
			a_cluster_is_empty: a_cluster.flat_linkables.is_empty
		do
			clusters.prune_all (a_cluster)
			if a_cluster.cluster /= Void then
				a_cluster.cluster.prune_all (a_cluster)
			end
			cluster_remove_actions.call ([a_cluster])
		ensure
			not_has_a_cluster: not has_cluster (a_cluster)
			removed_from_cluster: old (a_cluster.cluster) /= Void implies not (old (a_cluster.cluster)).flat_linkables.has (a_cluster)
		end

	wipe_out is
			-- Remove all elements.
		local
			i, nb: INTEGER
			l_clusters: like clusters
			l_item: EG_CLUSTER
		do
			from
				i := 1
				nb := links.count
			until
				i > nb
			loop
				remove_link (links.i_th (1))
				i := i + 1
			end
			from
				i := 1
				nb := nodes.count
			until
				i > nb
			loop
				remove_node (nodes.i_th (1))
				i := i + 1
			end
			from
				l_clusters := clusters
				i := 1
			until
				i > l_clusters.count
			loop
				l_item := l_clusters.i_th (i)
				if l_item /= Void and then l_item.cluster = Void then
					remove_all (l_item)
				else
					i := i + 1
				end
			end
		ensure
			wiped_out: flat_links.is_empty and flat_nodes.is_empty and flat_clusters.is_empty
		end

feature -- Events

	node_add_actions: EG_NODE_ACTION
			-- Called when a node is added to the model.

	node_remove_actions: EG_NODE_ACTION
			-- Called when a node was removed from the model.

	link_add_actions: EG_LINK_ACTION
			-- Called when a link is added to the model.

	link_remove_actions: EG_LINK_ACTION
			-- Called when a link is removed from the model.

	cluster_add_actions: EG_CLUSTER_ACTION
			-- Called when a cluster is added to the model.

	cluster_remove_actions: EG_CLUSTER_ACTION
			-- Called when a cluster is removed from the model.

feature {EG_FIGURE_WORLD} -- Implementation

	nodes: ARRAYED_LIST [like node_type]
			-- All nodes in the graph.

	clusters: ARRAYED_LIST [EG_CLUSTER]
			-- All clusters in the graph.

	links: ARRAYED_LIST [EG_LINK]
			-- All links in the graph.

	node_type: EG_NODE is
			-- Type of nodes in `nodes'.
		do
		end

feature {EG_ITEM} -- Implementation

	remove_all (a_cluster: EG_CLUSTER) is
			-- Remove `a_cluster' and all its elements (recursive).
		require
			a_cluster /= Void
		local
			l_cluster: EG_CLUSTER
			l_node: like node_type
			l_linkables: ARRAYED_LIST [EG_LINKABLE]
			i: INTEGER
		do
			from
				l_linkables := a_cluster.linkables
				i := 1
			until
				i > l_linkables.count
			loop
				l_cluster ?= l_linkables.i_th (i)
				if l_cluster /= Void then
					remove_all (l_cluster)
				else
					l_node ?= l_linkables.i_th (i)
					remove_links (l_node.links)
					remove_node (l_node)
					i := i + 1
				end
			end
			remove_cluster (a_cluster)
		end

	remove_links (a_links: LIST [EG_LINK]) is
			-- Remove all links in `links'.
		require
			links_not_void: a_links /= Void
		do
			from
				a_links.start
			until
				a_links.after
			loop
				remove_link (a_links.item)
				a_links.forth
			end
		end

invariant
	nodes_not_void: nodes /= Void
	clusters_not_void: clusters /= Void
	links_not_void: links /= Void
	node_add_actions_not_void: node_add_actions /= Void
	cluster_add_actions_not_void: cluster_add_actions /= Void
	link_add_actions_not_void: link_add_actions /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_GRAPH

