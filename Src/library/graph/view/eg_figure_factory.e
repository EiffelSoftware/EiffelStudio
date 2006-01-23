indexing
	description: "Objects that produces views for given models."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_FIGURE_FACTORY

feature -- Access

	world: EG_FIGURE_WORLD
			-- World `Current' is a factory for.

	new_node_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE is
			-- Create a node figure for `a_node'.
		require
			a_node_not_void: a_node /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
	new_cluster_figure (a_cluster: EG_CLUSTER): EG_CLUSTER_FIGURE is
			-- Create a cluster figure for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
	new_link_figure (a_link: EG_LINK): EG_LINK_FIGURE is
			-- Create a link figure for `a_link'.
		require
			a_link_not_void: a_link /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
	model_from_xml (node: XM_ELEMENT): EG_ITEM is
			-- Create an EG_ITEM from `node' if possible.
		require
			node_not_void: node /= Void
		deferred
		end
		
feature {EG_FIGURE_WORLD} -- Implementation

	set_world (a_world: like world) is
			-- Set `world' to `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			world := a_world
		ensure
			set: world = a_world
		end
		
feature {NONE} -- Implementation

	linkable_with_name (a_name: STRING): EG_LINKABLE is
			-- Linkable with name `a_name' in graph if any
		require
			a_name_not_void: a_name /= Void
			world_not_void: world /= Void
		local
			nodes: LIST [EG_NODE]
			clusters: LIST [EG_CLUSTER]
		do
			from
				nodes := world.model.flat_nodes
				nodes.start
			until
				nodes.after or else Result /= Void
			loop
				if nodes.item.name.is_equal (a_name) then
					Result := nodes.item
				end
				nodes.forth
			end
			if Result = Void then
				from
					clusters := world.model.flat_clusters
					clusters.start
				until
					clusters.after or else Result /= Void
				loop
					if clusters.item.name.is_equal (a_name) then
						Result := clusters.item
					end
					clusters.forth
				end
			end
		end

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




end -- class EG_FIGURE_FACTORY

