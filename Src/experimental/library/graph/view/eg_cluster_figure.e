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
			recycle
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current' (synchronize with model).
		local
			l_model: like model
		do
			Precursor {EG_LINKABLE_FIGURE}
			l_model := model
			check l_model /= Void end -- FIXME: Implied by ...?
			l_model.linkable_add_actions.extend (agent on_linkable_add)
			l_model.linkable_remove_actions.extend (agent on_linkable_remove)
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
		local
			l_item: detachable EG_CLUSTER_FIGURE
		do
			from
				create {ARRAYED_LIST [EG_CLUSTER_FIGURE]} Result.make (1)
				start
			until
				after
			loop
				l_item ?= item
				if l_item /= Void then
					Result.extend (l_item)
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT
			-- Xml element representing `Current's state.
		local
			eg_fig: detachable EG_LINKABLE_FIGURE
			fig, elements: XM_ELEMENT
		do
			Result := Precursor {EG_LINKABLE_FIGURE} (node)
			create elements.make (node, once "ELEMENTS", xml_namespace)
			from
				start
			until
				after
			loop
				eg_fig ?= item
				if eg_fig /= Void then
					create fig.make (elements, eg_fig.xml_node_name, xml_namespace)
					elements.put_last (eg_fig.xml_element (fig))
				end
				forth
			end
			Result.put_last (elements)
		end

	set_with_xml_element (node: XM_ELEMENT)
			-- Retrive state from `node'.
		local
			elements: detachable XM_ELEMENT
			l_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			l_item: detachable XM_ELEMENT
			eg_model: detachable EG_LINKABLE
			eg_cluster: detachable EG_CLUSTER
			eg_node: detachable EG_NODE
			fig: detachable EG_FIGURE
			l_world: like world
			l_model: detachable EG_GRAPH
			l_model_2: like model
		do
			Precursor {EG_LINKABLE_FIGURE} (node)
			elements ?= node.item_for_iteration
			node.forth
			check elements /= Void end -- FIXME: Implied by ...?
			l_cursor := elements.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item ?= l_cursor.item
				if l_item /= Void then
					l_world := world
					check l_world /= Void end -- FIXME: Implied by ...?
					eg_model ?= l_world.attached_factory.model_from_xml (l_item)
					if eg_model /= Void then
						l_model := l_world.model
						check l_model /= Void end -- FIXME: Implied by ...?
						if not l_model.has_linkable (eg_model) then
							eg_cluster ?= eg_model
							if eg_cluster /= Void then
								l_model := l_world.model
								check l_model /= Void end -- FIXME: Implied by ...?
								l_model.add_cluster (eg_cluster)
							else
								eg_node ?= eg_model
								if eg_node /= Void then
									l_model := l_world.model
									check l_model /= Void end -- FIXME: Implied by ...?
									l_model.add_node (eg_node)
								else
									check
										node_or_cluster: False
									end
								end
							end
						end
						l_model_2 := model
						check l_model_2 /= Void end -- FIXME: Implied by ...?						
						if not l_model_2.has (eg_model) then
							l_model_2.extend (eg_model)
						end
						fig := l_world.figure_from_model (eg_model)
						check
							eg_model_inserted: eg_model /= Void
						end
						l_item.start
						check fig /= Void end -- FIXME: Implied by ...?
						fig.set_with_xml_element (l_item)
					end
				end
				l_cursor.forth
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
		local
			linkable_figure: detachable EG_LINKABLE_FIGURE
		do
			Precursor {EG_LINKABLE_FIGURE} (b)
			from
				start
			until
				after
			loop
				linkable_figure ?= item
				if linkable_figure /= Void then
					linkable_figure.set_is_fixed (b)
				end
				forth
			end
		end

feature {NONE} -- Implementation

	on_linkable_add (a_linkable: EG_LINKABLE)
			-- `a_linkable' was added to the cluster.
		local
			l_world: like world
			linkable_fig: detachable EG_LINKABLE_FIGURE
		do
			l_world := world
			if l_world /= Void then
				linkable_fig ?= l_world.items_to_figure_lookup_table.item (a_linkable)
				check
					linkable_fig_is_in_view_but_not_in_cluster: linkable_fig /= Void not has (linkable_fig)
				end
				extend (linkable_fig)
				linkable_fig.set_cluster (Current)
			end
			request_update
		end

	on_linkable_remove (a_linkable: EG_LINKABLE)
			-- `a_linkable' was removed from the cluster.
		local
			l_world: like world
			linkable_fig: detachable EG_LINKABLE_FIGURE
		do
			l_world := world
			if l_world /= Void then
				linkable_fig ?= l_world.items_to_figure_lookup_table.item (a_linkable)
				check
					linkable_fig_in_view: linkable_fig /= Void
				end
				linkable_fig.set_cluster (Void)
				prune_all (linkable_fig)
			end
			request_update
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_CLUSTER_FIGURE

