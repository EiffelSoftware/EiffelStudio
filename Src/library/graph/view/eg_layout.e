indexing
	description: "Objects that can layout nodes and clusters in a given world."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_LAYOUT
	
feature {NONE} -- Initialization

	make_with_world (a_world: like world) is
			-- Make
		require
			a_world /= Void
		do
			default_create
			world := a_world
		ensure
			set: world = a_world
		end
	
feature -- Access

	world: EG_FIGURE_WORLD
			-- The graph to layout.
			
feature -- Element change

	set_world (a_world: like world) is
			-- Set `world' to `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			world := a_world
		ensure
			set: world = a_world
		end

	layout is
			-- Arrange the elements in `graph'.
		local
			cluster_figure: EG_CLUSTER_FIGURE
			root: ARRAYED_LIST [EG_LINKABLE_FIGURE]
		do
			world.update
			from
				root := world.root_cluster
				root.start
			until
				root.after
			loop
				cluster_figure ?= root.item
				if cluster_figure /= Void then
					if cluster_figure.layouter = Void then
						layout_cluster (cluster_figure, 2)
					else
						cluster_figure.layouter.layout_cluster (cluster_figure, 2)
					end
				end
				root.forth
			end
			layout_linkables (world.root_cluster, 1, void)
		end
		
	layout_cluster (cluster: EG_CLUSTER_FIGURE; level: INTEGER) is
			-- Arrange the elements in `cluster' (recursive).
		require
			cluster_not_void: cluster /= Void
			level_greater_zero: level > 0
		local
			figures_in_cluster: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			cluster_figure: EG_CLUSTER_FIGURE
			linkable_figure: EG_LINKABLE_FIGURE
		do
			from
				create figures_in_cluster.make (cluster.count)
				cluster.start
			until
				cluster.after
			loop
				linkable_figure ?= cluster.item
				if linkable_figure /= Void then
					figures_in_cluster.extend (linkable_figure)
					cluster_figure ?= linkable_figure
					if cluster_figure /= Void then
						if cluster_figure.layouter = Void then
							layout_cluster (cluster_figure, level + 1)
						else
							cluster_figure.layouter.layout_cluster (cluster_figure, level + 1)
						end
					end
				end
				cluster.forth
			end
			layout_linkables (figures_in_cluster, level, cluster)
		end
		
	layout_cluster_only (cluster: EG_CLUSTER_FIGURE) is
			-- Arrange the elements in `cluster' (not recursive).
		require
			cluster_not_void: cluster /= Void
		local
			figures_in_cluster: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			linkable_figure: EG_LINKABLE_FIGURE
		do
			from
				create figures_in_cluster.make (cluster.count)
				cluster.start
			until
				cluster.after
			loop
				linkable_figure ?= cluster.item
				if linkable_figure /= Void then
					figures_in_cluster.extend (linkable_figure)
				end
				cluster.forth
			end
			layout_linkables (figures_in_cluster, 1, cluster)
		end
		
feature {NONE} -- Implementation
		
	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE) is
			-- arrange `linkables' that are elements of `clusters' at `level'.
		require
			linkables_not_void: linkables /= Void
			level_greater_zero: level > 0
			level_greater_1_implies_cluster_not_void: level > 1 implies cluster /= Void
		deferred
		end

invariant
	world_not_void: world /= Void

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




end -- class EG_LAYOUT

