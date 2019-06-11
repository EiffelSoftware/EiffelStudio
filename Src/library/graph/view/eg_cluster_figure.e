note
	description: "Object is a view for an EG_CLUSTER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_CLUSTER_FIGURE

inherit
	EG_LINKABLE_FIGURE
		redefine
			model,
			initialize,
			set_is_fixed,
			xml_node_name,
			xml_element,
			set_with_xml_element,
			recycle,
			process
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current' (synchronize with model).
		do
			Precursor {EG_LINKABLE_FIGURE}
			if attached model as l_model then
					-- Implied by precondition so this always holds.
				l_model.linkable_add_actions.extend (agent on_linkable_add)
				l_model.linkable_remove_actions.extend (agent on_linkable_remove)
			end
		end

feature -- Access

	model: detachable EG_CLUSTER
			-- The model for `Current'.

	layouter: detachable EG_LAYOUT
			-- Layouter used for this `Cluster' if not Void

	xml_node_name: STRING
			-- Name of the xml node returned by `xml_element'.
		do
			Result := once "EG_CLUSTER_FIGURE"
		end

	subclusters: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			-- Clusters with parent `Current'.
		do
			from
				create {ARRAYED_LIST [EG_CLUSTER_FIGURE]} Result.make (1)
				start
			until
				after
			loop
				if attached {EG_CLUSTER_FIGURE} item as l_cluster_fig then
					Result.extend (l_cluster_fig)
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml element representing `Current's state.
		local
			fig, elements: like xml_element
		do
			Result := Precursor {EG_LINKABLE_FIGURE} (node)
			create elements.make (node, once "ELEMENTS", xml_namespace)
			from
				start
			until
				after
			loop
				if attached {EG_LINKABLE_FIGURE} item as eg_fig then
					create fig.make (elements, eg_fig.xml_node_name, xml_namespace)
					elements.put_last (eg_fig.xml_element (fig))
				end
				forth
			end
			Result.put_last (elements)
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		local
			l_cursor: XML_COMPOSITE_CURSOR
		do
			Precursor {EG_LINKABLE_FIGURE} (node)
			if
				attached {XML_ELEMENT} node.item_for_iteration as elements
				and then attached world as l_world
				and then attached l_world.model as l_world_model
				and then attached model as l_model
			then
				node.forth
				l_cursor := elements.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					if
						attached {like xml_element} l_cursor.item as l_item and then
						attached l_world.factory as l_world_factory and then
						attached {EG_LINKABLE} l_world_factory.model_from_xml (l_item) as eg_model
					then
						if not l_world_model.has_linkable (eg_model) then
							if attached {EG_CLUSTER} eg_model as eg_cluster then
								l_world_model.add_cluster (eg_cluster)
							elseif attached {EG_NODE} eg_model as eg_node then
								l_world_model.add_node (eg_node)
							else
								check node_or_cluster: False end
							end
						end
						if not l_model.has (eg_model) then
							l_model.extend (eg_model)
						end
						if attached l_world.figure_from_model (eg_model) as l_fig then
							l_item.start
							l_fig.set_with_xml_element (l_item)
						end
					end
					l_cursor.forth
				end
			end
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EG_LINKABLE_FIGURE}
			if attached model as l_model then
				l_model.linkable_add_actions.prune_all (agent on_linkable_add)
				l_model.linkable_remove_actions.prune_all (agent on_linkable_remove)
			end
		end

	set_layouter (a_layouter: like layouter)
			-- Set `layouter' to `a_layouter'.
		do
			layouter := a_layouter
		ensure
			set: layouter = a_layouter
		end

feature -- Status settings

	set_is_fixed (b: BOOLEAN)
			-- Set `is_fixed' to `b'
		do
			Precursor {EG_LINKABLE_FIGURE} (b)
			from
				start
			until
				after
			loop
				if attached {EG_LINKABLE_FIGURE} item as l_linkable_figure then
					l_linkable_figure.set_is_fixed (b)
				end
				forth
			end
		end

feature -- Visitor

	process (v: EG_FIGURE_VISITOR)
			-- Visitor feature.
		do
			v.process_cluster_figure (Current)
		end

feature {NONE} -- Implementation

	on_linkable_add (a_linkable: EG_LINKABLE)
			-- `a_linkable' was added to the cluster.
		local
			l_world: like world
		do
			l_world := world
			if l_world /= Void then
				if attached {EG_LINKABLE_FIGURE} l_world.items_to_figure_lookup_table.item (a_linkable) as l_linkable_fig then
					check linkable_fig_is_in_view_but_not_in_cluster: not has (l_linkable_fig) end
					extend (l_linkable_fig)
					l_linkable_fig.set_cluster (Current)
				end
			end
			request_update
		end

	on_linkable_remove (a_linkable: EG_LINKABLE)
			-- `a_linkable' was removed from the cluster.
		local
			l_world: like world
		do
			l_world := world
			if l_world /= Void then
				if attached {EG_LINKABLE_FIGURE} l_world.items_to_figure_lookup_table.item (a_linkable) as l_linkable_fig then
					l_linkable_fig.set_cluster (Void)
					prune_all (l_linkable_fig)
				end
			end
			request_update
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
