indexing
	description: "EG_CLUSTER can be connectet to other EG_LINKABLEs and contains any number of EG_LINKABLEs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_CLUSTER

inherit
	EG_LINKABLE
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create an empty cluster.
		do
			Precursor {EG_LINKABLE}
			create linkables.make (0)
			
			create linkable_add_actions
			linkable_add_actions.compare_objects
			create linkable_remove_actions
			linkable_remove_actions.compare_objects
		end

feature -- Access

	flat_linkables: like linkables is
			-- Return all linkables containing in `Current'
			-- including all linkables containing in sub clusters.
		local
			l_cluster: like Current
		do
			Result := linkables.twin
			from
				linkables.start
			until
				linkables.after
			loop
				l_cluster ?= linkables.item
				if l_cluster /= Void then
					Result.append (l_cluster.flat_linkables)
				end
				linkables.forth
			end
		ensure
			result_not_void: Result /= Void
		end
		
	linkable_add_actions: EG_LINKABLE_ACTION
			-- a linkable was added to `Current'.
			
	linkable_remove_actions: EG_LINKABLE_ACTION
			-- a linkable was removed from `Current'.
		
feature -- Status report

	has (a_linkable: EG_LINKABLE): BOOLEAN is
			-- Is `a_linkable' part of the cluster (without subclusters)?
		require
			a_linkable_not_void: a_linkable /= Void
		do
			Result := linkables.has (a_linkable)
		end
		
feature -- Element change

	extend (a_linkable: EG_LINKABLE) is
			-- add `a_linkable' to `Current'.
		require
			a_linkable_not_void: a_linkable /= Void
			not_has_a_linkable: not has (a_linkable)
		local
			a_cluster: EG_CLUSTER
			a_node: EG_NODE
		do
			if a_linkable.cluster /= Void then
				a_linkable.cluster.prune_all (a_linkable)
			end
			linkables.extend (a_linkable)
			a_linkable.set_cluster (Current)
			
			if graph /= Void and then not graph.has_linkable (a_linkable) then
				a_cluster ?= a_linkable
				if a_cluster /= Void then
					graph.add_cluster (a_cluster)
				else
					a_node ?= a_linkable
					if a_node /= Void then
						graph.add_node (a_node)
					end
				end
			end
			linkable_add_actions.call ([a_linkable])
		ensure
			has_a_linkable: has (a_linkable)
			a_linkable_cluster_equal_current: a_linkable.cluster = Current
		end
		
	prune_all (a_linkable: EG_LINKABLE) is
			-- remove all occurrences of `a_linkable' from `Current'.
		require
			a_linkable_not_void: a_linkable /= Void
			has_a_linkable: has (a_linkable)
		do
			linkables.prune_all (a_linkable)
			a_linkable.remove_cluster
			linkable_remove_actions.call ([a_linkable])
		ensure
			not_has_a_linkable: not has (a_linkable)
			a_linkable_cluster_equal_void: a_linkable.cluster = Void
		end

feature {EG_GRAPH, EG_FIGURE_WORLD, EG_FIGURE_FACTORY} -- Implementation

	linkables: ARRAYED_LIST [EG_LINKABLE];
			-- linkable elements of `Current'.

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




end -- class EG_CLUSTER

