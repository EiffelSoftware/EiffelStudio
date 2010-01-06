note
	description: "Objects that is a view for an EG_GRAPH"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_FIGURE_WORLD

inherit
	EV_MODEL_WORLD
		redefine
			default_create,
			scale,
			wipe_out,
			new_filled_list
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create
		end

	EG_XML_STORABLE
		undefine
			default_create
		end

create
	make_with_model_and_factory,
	make_with_model

create {EG_FIGURE_WORLD}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Create an EG_FIGURE_WORLD
		do
			Precursor {EV_MODEL_WORLD}
			scale_factor := 1.0
			create items_to_figure_lookup_table.make (50)
			create root_cluster.make (10)
			create nodes.make (50)
			create selected_figures.make (5)
			create links.make (50)
			create clusters.make (10)
			create figure_change_end_actions
			create figure_change_start_actions
			pointer_button_press_actions.extend (agent on_pointer_button_press_on_world)
			pointer_button_release_actions.extend (agent on_pointer_button_release_on_world)
			pointer_motion_actions.extend (agent on_pointer_motion_on_world)
			is_multiple_selection_enabled := True
			xml_routines.reset_valid_tags
			real_grid_x := default_grid_x
			real_grid_y := default_grid_y
		end

	make_with_model (a_model: like model)
			-- Create a view for `a_model' using EG_SIMPLE_FACTORY.
		require
			a_model_not_void: a_model /= Void
		do
			make_with_model_and_factory (a_model, create {EG_SIMPLE_FACTORY})
		ensure
			set: model = a_model
		end

	make_with_model_and_factory (a_model: like model; a_factory: like factory)
			-- Create a view for `a_model' using `a_factory'.
		require
			a_model_not_void: a_model /= Void
			a_factory_not_void: a_factory /= Void
		local
			i_cluster: EG_CLUSTER
		do
			default_create

			model := a_model
			set_factory (a_factory)
			default_create
			-- create all views in model

			if a_model.clusters.is_empty then
				from
					a_model.nodes.start
				until
					a_model.nodes.after
				loop
					add_node (a_model.nodes.item)
					a_model.nodes.forth
				end
			else
				from
					a_model.clusters.start
				until
					a_model.clusters.after
				loop
					i_cluster := a_model.clusters.item
					if i_cluster.cluster = Void then
						insert_cluster (i_cluster)
					end
					a_model.clusters.forth
				end
			end
			from
				a_model.links.start
			until
				a_model.links.after
			loop
				add_link (a_model.links.item)
				a_model.links.forth
			end

			-- create new views when required
			attached_model.node_add_actions.extend (agent add_node)
			attached_model.link_add_actions.extend (agent add_link)
			attached_model.cluster_add_actions.extend (agent add_cluster)

			attached_model.link_remove_actions.extend (agent remove_link)
			attached_model.node_remove_actions.extend (agent remove_node)
			attached_model.cluster_remove_actions.extend (agent remove_cluster)
		ensure
			model_set: model = a_model
			factory_set: factory = a_factory
		end

	new_filled_list (n: INTEGER): like Current
			-- <Precursor>
		do
			create Result.make_filled (n)
		end

feature -- Status Report

	has_linkable_figure (a_linkable: EG_LINKABLE): BOOLEAN
			-- Does `a_linkable' have a view in `Current'?
		require
			a_linkable_not_void: a_linkable /= Void
		local
			a_linkable_figure: detachable EG_LINKABLE_FIGURE
		do
			a_linkable_figure ?= items_to_figure_lookup_table.item (a_linkable)
			Result := a_linkable_figure /= Void
		end

	has_node_figure (a_node: EG_NODE): BOOLEAN
			-- Does `a_node' have a view in `Current'?
		require
			a_node_not_void: a_node /= Void
		do
			Result := has_linkable_figure (a_node)
		end

	has_link_figure (a_link: EG_LINK): BOOLEAN
			-- Does `a_link' have a view in `Current'?
		require
			a_link_not_void: a_link /= Void
		local
			a_link_figure: detachable EG_LINK_FIGURE
		do
			a_link_figure ?= items_to_figure_lookup_table.item (a_link)
			Result := a_link_figure /= Void
		end

	has_cluster_figure (a_cluster: EG_CLUSTER): BOOLEAN
			-- Does `a_cluster' have a view in `Current'?
		require
			a_cluster_not_void: a_cluster /= Void
		local
			a_cluster_figure: detachable EG_CLUSTER_FIGURE
		do
			a_cluster_figure ?= items_to_figure_lookup_table.item (a_cluster)
			Result := a_cluster_figure /= Void
		end

	is_multiple_selection_enabled: BOOLEAN
			-- Can the user select multiple figures with a rectangle?

	selected_figures_in_world: BOOLEAN
			-- Are all figures in `selected_figures' part of `Current'?
		do
			Result := True
			from
				selected_figures.start
			until
				selected_figures.after or else Result = False
			loop
				Result := has_deep (selected_figures.item)
				selected_figures.forth
			end
		end

feature -- Access

	figure_from_model (an_item: EG_ITEM): detachable EG_FIGURE
			-- Return the view vor `an_item' if any.
		require
			an_item_not_void: an_item /= Void
		do
			Result := items_to_figure_lookup_table.item (an_item)
		end

	model: detachable EG_GRAPH
			-- Model for `Current'.

	attached_model: EG_GRAPH
			-- Attached `model'
		require
			set: attached model
		local
			l_result: like model
		do
			l_result := model
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	factory: detachable EG_FIGURE_FACTORY
			-- Factory used to create new figures.

	attached_factory: EG_FIGURE_FACTORY
			-- Attached `factory'
		require
			set: attached factory
		local
			l_result: like factory
		do
			l_result := factory
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	flat_links: like links
			-- All links in the view.
		do
			Result := links.twin
		ensure
			result_not_void: Result /= Void
		end

	flat_nodes: like nodes
			-- All nodes in the view.
		do
			Result := nodes.twin
		ensure
			result_not_void: Result /= Void
		end

	flat_clusters: like clusters
			-- All clusters in the view.
		do
			Result := clusters.twin
		ensure
			result_not_void: Result /= Void
		end

	selected_figures: ARRAYED_LIST [EG_FIGURE]
			-- All currently selected figures.

	scale_factor: DOUBLE
			-- `Current' has been scaled for `scale_factor'.

	root_clusters: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			-- All clusters in `Current' not having a parent.
		local
			l_root: like root_cluster
			l_item: detachable EG_CLUSTER_FIGURE
		do
			from
				l_root := root_cluster
				create Result.make (l_root.count)
				l_root.start
			until
				l_root.after
			loop
				l_item ?= l_root.item
				if l_item /= Void then
					Result.extend (l_item)
				end
				l_root.forth
			end
		ensure
			Result_not_Void: Result /= Void
		end

	smallest_common_supercluster (fig1, fig2: EG_LINKABLE_FIGURE): detachable EG_CLUSTER_FIGURE
			-- Smallest common supercluster of `fig1' and `fig2'.
		require
			fig1_not_void: fig1 /= Void
			fig2_not_void: fig2 /= Void
		local
			p, q: detachable EG_CLUSTER_FIGURE
		do
			if fig1.cluster /= Void and then fig2.cluster /= Void then
				if fig1.cluster = fig2.cluster then
					Result := fig1.cluster
				else
					from
						p := fig1.cluster
					until
						p = Void or else Result /= Void
					loop
						from
							q := fig2.cluster
						until
							q = Void or else Result /= Void
						loop
							if p = q then
								Result := p
							end
							q := q.cluster
						end
						p := p.cluster
					end
				end
			end
		end

	figure_change_start_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- A figure will be moved or changed by the user.

	figure_change_end_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- A figure is not moved or changed anymore by user.

feature -- Status settings

	disable_multiple_selection
			-- Set `is_multiple_selection_enabed' to False.
		do
			is_multiple_selection_enabled := False
		ensure
			set: not is_multiple_selection_enabled
		end

	enable_multiple_selection
			-- Set `is_multiple_selection_enabled' to True.
		do
			is_multiple_selection_enabled := True
		ensure
			set: is_multiple_selection_enabled
		end

feature -- List change

	wipe_out
			-- Remove all items.
		do
			Precursor {EV_MODEL_WORLD}
			from
				nodes.start
			until
				nodes.after
			loop
				nodes.item.recycle
				nodes.forth
			end
			from
				links.start
			until
				links.after
			loop
				links.item.recycle
				links.forth
			end
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.recycle
				clusters.forth
			end

			nodes.wipe_out
			clusters.wipe_out
			links.wipe_out
			selected_figures.wipe_out
			root_cluster.wipe_out
		end

feature -- Element change

	recycle
			-- Free `Current's resources and leave it in an unstable state.
		do
			wipe_out

			pointer_button_press_actions.prune_all (agent on_pointer_button_press_on_world)
			pointer_button_release_actions.prune_all (agent on_pointer_button_release_on_world)
			pointer_motion_actions.prune_all (agent on_pointer_motion_on_world)

			attached_model.node_add_actions.prune_all (agent add_node)
			attached_model.link_add_actions.prune_all (agent add_link)
			attached_model.cluster_add_actions.prune_all (agent add_cluster)

			attached_model.link_remove_actions.prune_all (agent remove_link)
			attached_model.node_remove_actions.prune_all (agent remove_node)
			attached_model.cluster_remove_actions.prune_all (agent remove_cluster)
		end


	set_factory (a_factory: like factory)
			-- Set `factory' to `a_factory'.
		require
			a_factory_not_Void: a_factory /= Void
		do
			factory := a_factory
			a_factory.set_world (Current)
		ensure
			set: factory = a_factory
		end

	deselect_all
			-- Deselect all Figures.
		do
			from
				selected_figures.start
			until
				selected_figures.after
			loop
				set_figure_selection_state (selected_figures.item, False)
				selected_figures.forth
			end
			selected_figures.wipe_out
		ensure
			selected_figures_is_empty: selected_figures.is_empty
		end

	add_node (a_node: like node_type)
			-- `a_node' was added to the model.
		require
			a_node_not_void: a_node /= Void
			model_has_node: attached_model.has_node (a_node)
			not_has_a_node: not has_node_figure (a_node)
		local
			node_figure: EG_LINKABLE_FIGURE
		do
			node_figure := attached_factory.new_node_figure (a_node)
			extend (node_figure)
			root_cluster.extend (node_figure)
			nodes.extend (node_figure)
			linkable_add (node_figure)

			items_to_figure_lookup_table.put (node_figure, a_node)
			figure_added (node_figure)
		ensure
			has_node_figure: has_node_figure (a_node)
		end

	add_link (a_link: EG_LINK)
			-- `a_link' was added to the model.
		require
			a_link_not_void: a_link /= Void
			model_has_link: attached_model.has_link (a_link)
			not_has_a_link: not has_link_figure (a_link)
			a_link.source /= Void
			a_link.target /= Void
			has_source_figure: has_linkable_figure (a_link.source)
			has_target_figure: has_linkable_figure (a_link.target)
		local
			link_figure: EG_LINK_FIGURE
			source, target: detachable EG_LINKABLE_FIGURE
		do
			link_figure := attached_factory.new_link_figure (a_link)
			put_front (link_figure)
			links.extend (link_figure)

			source ?= items_to_figure_lookup_table.item (a_link.source)
			check source /= Void end --FIXME: Implied by...?
			link_figure.set_source (source)
			source.add_link (link_figure)

			target ?= items_to_figure_lookup_table.item (a_link.target)
			check target /= Void end --FIXME: Implied by...?
			link_figure.set_target (target)
			target.add_link (link_figure)

			items_to_figure_lookup_table.put (link_figure, a_link)
			figure_added (link_figure)
		ensure
			has_a_link: has_link_figure (a_link)
		end

	add_cluster (a_cluster: EG_CLUSTER)
			-- `a_cluster' was added to the model.
		require
			a_cluster_not_void: a_cluster /= Void
			model_has_cluster: attached_model.has_cluster (a_cluster)
			not_has_a_cluster: not has_cluster_figure (a_cluster)
			a_cluster.flat_linkables.for_all (agent has_linkable_figure)
		local
			cluster_figure: EG_CLUSTER_FIGURE
			l_model: detachable EG_CLUSTER
		do
			cluster_figure := attached_factory.new_cluster_figure (a_cluster)
			extend (cluster_figure)
			root_cluster.extend (cluster_figure)
			linkable_add (cluster_figure)
			clusters.extend (cluster_figure)

			from
				a_cluster.linkables.start
			until
				a_cluster.linkables.after
			loop
				l_model := cluster_figure.model
				check l_model /= Void end -- FIXME: Implied by ...?				
				l_model.linkable_add_actions.call ([a_cluster.linkables.item])
				a_cluster.linkables.forth
			end

			cluster_figure.request_update

			items_to_figure_lookup_table.put (cluster_figure, a_cluster)
			figure_added (cluster_figure)
		ensure
			has_cluster: has_cluster_figure (a_cluster)
		end

	remove_link (a_link: EG_LINK)
			-- Remove `a_link' from view.
		require
			a_link_not_void: a_link /= Void
			has_a_link: has_link_figure (a_link)
		local
			link_figure: detachable EG_LINK_FIGURE
		do
			link_figure ?= items_to_figure_lookup_table.item (a_link)
			check
				link_figure_not_void: link_figure /= Void
			end
			if attached link_figure.source as l_source then
				l_source.remove_link (link_figure)
			end
			if attached link_figure.target as l_target then
				l_target.remove_link (link_figure)
			end
			if attached link_figure.group as l_group then
				l_group.prune_all (link_figure)
			end
			links.prune_all (link_figure)
			items_to_figure_lookup_table.remove (a_link)
			if selected_figures.has (link_figure) then
				selected_figures.start
				selected_figures.search (link_figure)
				selected_figures.remove
				set_figure_selection_state (link_figure, False)
			end
			figure_removed (link_figure)
		ensure
			not_has_a_link: not has_link_figure (a_link)
			selected_figures_in_world: selected_figures_in_world
		end

	remove_node (a_node: EG_NODE)
			-- Remove `a_node' from view and all its links.
		require
			a_node_not_void: a_node /= Void
			has_node: has_node_figure (a_node)
		local
			node_figure: detachable EG_LINKABLE_FIGURE
			l_links: ARRAYED_LIST [EG_LINK]
			l_item: detachable EG_LINK
		do
			node_figure ?= items_to_figure_lookup_table.item (a_node)
			check
				a_node_not_void: a_node /= Void
			end
			check node_figure /= Void end -- Implied by precondition `has_node'
			if attached node_figure.cluster as l_cluster then
				l_cluster.prune_all (node_figure)
			else
				root_cluster.prune_all (node_figure)
			end
			from
				l_links := a_node.links.twin
				l_links.start
			until
				l_links.after
			loop
				l_item ?= l_links.item
				if l_item /= Void then
					remove_link (l_item)
				end
				l_links.forth
			end
			prune_all (node_figure)
			nodes.prune_all (node_figure)
			items_to_figure_lookup_table.remove (a_node)
			if selected_figures.has (node_figure) then
				selected_figures.start
				selected_figures.search (node_figure)
				selected_figures.remove
				set_figure_selection_state (node_figure, False)
			end
			figure_removed (node_figure)
		ensure
			not_has_a_node: not has_node_figure (a_node)
			selected_figures_in_world: selected_figures_in_world
		end

	remove_cluster (a_cluster: EG_CLUSTER)
			-- Remove `a_cluster' from view and elements in it and all links.
		require
			a_cluster_not_void: a_cluster /= Void
			has_cluster: has_cluster_figure (a_cluster)
		local
			cluster_figure: detachable EG_CLUSTER_FIGURE
			linkables: ARRAYED_LIST [EG_LINKABLE]
			l_item: EG_LINKABLE
			l_cluster: detachable EG_CLUSTER
			l_node: detachable EG_NODE
			l_links: ARRAYED_LIST [EG_LINK]
			l_link: detachable EG_LINK
		do
			cluster_figure ?= items_to_figure_lookup_table.item (a_cluster)
			check
				cluster_figure_not_void: cluster_figure /= Void
			end
			from
				linkables := a_cluster.linkables.twin
				linkables.start
			until
				linkables.after
			loop
				l_item := linkables.item
				if l_item /= Void then
					l_cluster ?= l_item
					if l_cluster /= Void then
						remove_cluster (l_cluster)
					else
						l_node ?= l_item
						if l_node /= Void then
							remove_node (l_node)
						end
					end
				end
				linkables.forth
			end
			if attached cluster_figure.cluster as l_cluster_2 then
				l_cluster_2.prune_all (cluster_figure)
			else
				root_cluster.prune_all (cluster_figure)
			end
			from
				l_links := a_cluster.links.twin
				l_links.start
			until
				l_links.after
			loop
				l_link ?= l_links.item
				if l_link /= Void then
					remove_link (l_link)
				end
				l_links.forth
			end
			prune_all (cluster_figure)
			clusters.prune_all (cluster_figure)
			items_to_figure_lookup_table.remove (a_cluster)
			if selected_figures.has (cluster_figure) then
				selected_figures.start
				selected_figures.search (cluster_figure)
				selected_figures.remove
				set_figure_selection_state (cluster_figure, False)
			end
			figure_removed (cluster_figure)
		ensure
			not_has_cluster: not has_cluster_figure (a_cluster)
			selected_figures_in_world: selected_figures_in_world
		end

	update
			-- Update all figures with `is_update_required' in `Current'.
		local
			l_linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			i, nb: INTEGER
			cluster: detachable EG_CLUSTER_FIGURE
			l_item: EG_FIGURE
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			l_link: EG_LINK_FIGURE
		do
			from
				l_linkables := root_cluster
				i := 1
				nb := l_linkables.count
			until
				i > nb
			loop
				l_item := l_linkables.i_th (i)
				cluster ?= l_item
				if cluster /= Void and then cluster.is_update_required then
					update_cluster (cluster)
				end
				if l_item.is_update_required then
					l_item.update
				end
				i := i + 1
			end
			from
				l_links := links
				i := 1
				nb := l_links.count
			until
				i > nb
			loop
				l_link := l_links.i_th (i)
				if l_link.is_update_required then
					l_link.update
				end
				i := i + 1
			end
		end

	scale (a_scale: DOUBLE)
			-- Scale to x and y direction for `a_scale'.
		local
			l_scale: REAL
		do
			l_scale := a_scale.truncated_to_real
			Precursor {EV_MODEL_WORLD} (a_scale)
			scale_factor := scale_factor * a_scale
			real_grid_x := real_grid_x * l_scale
			if grid_x /= as_integer (real_grid_x) then
				grid_x := as_integer (real_grid_x)
			end
			real_grid_y := real_grid_y * l_scale
			if grid_y /= as_integer (real_grid_y) then
				grid_y := as_integer (real_grid_y)
			end
		ensure then
			new_scale_factor: scale_factor = old scale_factor * a_scale
		end

feature -- Save/Restore

	store (ptf: RAW_FILE)
			-- Freeze state of `Current'.
		require
			ptf_not_Void: ptf /= Void
		local
			diagram_output: XM_DOCUMENT
			view_output: XM_ELEMENT
			root: XM_ELEMENT
		do
			create diagram_output.make_with_root_named (xml_node_name, create {XM_NAMESPACE}.make_default)

			create root.make_root (create {XM_DOCUMENT}.make, "VIEW", xml_namespace)
			view_output := xml_element (root)
			diagram_output.root_element.force_first (view_output)
			Xml_routines.save_xml_document (ptf.name, diagram_output)
		end

	retrieve (f: RAW_FILE)
			-- Reload former state of `Current'.
		require
			f_not_Void: f /= Void
		local
			diagram_input: detachable XM_DOCUMENT
			view_input: detachable XM_ELEMENT
		do
			diagram_input := Xml_routines.deserialize_document (f.name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.name.is_equal (xml_node_name)
				end
				view_input ?= diagram_input.root_element.first
				if view_input /= Void then
					xml_routines.valid_tags_read
					view_input.start
					set_with_xml_element (view_input)
				end
			end
		end

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		do
			Result := "EG_FIGURE_WORLD"
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT
			-- Xml node representing `Current's state.
		local
			l_root_cluster: like root_cluster
			l_links: like links
			fig: XM_ELEMENT
			l_item: EG_FIGURE
			root_elements: XM_ELEMENT
		do
			node.put_last (Xml_routines.xml_node (node, "SCALE_FACTOR", scale_factor.out))

			create root_elements.make (node, "ROOT_ELEMENTS", xml_namespace)
			from
				l_root_cluster := root_cluster
				l_root_cluster.start
			until
				l_root_cluster.after
			loop
				l_item := l_root_cluster.item
				if l_item.is_storable then
					create fig.make (root_elements, l_item.xml_node_name, xml_namespace)
					root_elements.put_last (l_item.xml_element (fig))
				end
				l_root_cluster.forth
			end
			from
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				l_item := l_links.item
				if l_item.is_storable then
					create fig.make (root_elements, l_item.xml_node_name, xml_namespace)
					root_elements.put_last (l_item.xml_element (fig))
				end
				l_links.forth
			end
			node.put_last (root_elements)

			Result := node
		end

	set_with_xml_element (node: XM_ELEMENT)
			-- Retrive state from `node'.
		local
			l_item: detachable XM_ELEMENT
			sf: DOUBLE
			l_cursor: detachable DS_LINKED_LIST_CURSOR [XM_NODE]
			eg_item: detachable EG_ITEM
			eg_node: detachable EG_NODE
			eg_cluster: detachable EG_CLUSTER
			eg_link: detachable EG_LINK
			eg_fig: detachable EG_FIGURE

			l_nodes: like nodes
			l_node: EG_LINKABLE_FIGURE
			l_links: like links
			l_link: EG_LINK_FIGURE
			l_clusters: like clusters
			l_cluster: EG_LINKABLE_FIGURE
		do
			sf := xml_routines.xml_double (node, "SCALE_FACTOR")
			if sf = 0.0 then
				sf := 1.0
			end
			scale (sf / scale_factor)
			from
				l_item ?= node.item_for_iteration
				check l_item /= Void end -- FIXME: Implied by ...?
				l_cursor ?= l_item.new_cursor
				node.forth
				check l_cursor /= Void end -- Implied by inheritance relation of {XM_NODE} and {XM_ELEMENT}
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item ?= l_cursor.item
				if l_item /= Void then
					eg_item := attached_factory.model_from_xml (l_item)
					if eg_item /= Void then
						eg_cluster ?= eg_item
						if eg_cluster /= Void then
							if not attached_model.has_cluster (eg_cluster) then
								attached_model.add_cluster (eg_cluster)
							end
						else
							eg_node ?= eg_item
							if eg_node /= Void then
								if not attached_model.has_node (eg_node) then
									attached_model.add_node (eg_node)
								end
							else
								eg_link ?= eg_item
								if eg_link /= Void then
									if not attached_model.has_link (eg_link) then
										attached_model.add_link (eg_link)
									end
								else
									check
										is_cluster_link_or_node: False
									end
								end
							end
						end
						eg_fig := figure_from_model (eg_item)
						check
							figure_inserted: eg_fig /= Void
						end
						l_item.start
						eg_fig.set_with_xml_element (l_item)
					end
				end
				l_cursor.forth
			end
			from
				l_nodes := nodes
				l_nodes.start
			until
				l_nodes.after
			loop
				l_node := l_nodes.item
				if l_node.is_selected then
					selected_figures.extend (l_node)
				end
				l_nodes.forth
			end
			from
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				l_link := l_links.item
				if l_link.is_selected then
					selected_figures.extend (l_link)
				end
				l_links.forth
			end
			from
				l_clusters := clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				l_cluster := l_clusters.item
				if l_cluster.is_selected then
					selected_figures.extend (l_cluster)
				end
				l_clusters.forth
			end
		end

feature {EG_FIGURE, EG_LAYOUT} -- Implementation

	items_to_figure_lookup_table: HASH_TABLE [EG_FIGURE, EG_ITEM]
			-- The table maps EG_ITEM objects to EG_FIGURE objects (model to view).

	root_cluster: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			-- All linkables not beeing part of a cluster.

	nodes: ARRAYED_LIST [EG_LINKABLE_FIGURE]
			-- All nodes in `Current'.

	clusters: ARRAYED_LIST [EG_CLUSTER_FIGURE]
			-- All clusters in `Current'.

	links: ARRAYED_LIST [EG_LINK_FIGURE]
			-- All links in `Current'.

feature {NONE} -- Implementation

	real_grid_x: REAL
			-- Real grid width in x direction.

	real_grid_y: REAL
			-- Real grid width in y direction.

	insert_cluster (a_cluster: EG_CLUSTER)
			-- Insert `a_cluster' to view and all its containing subclusters (recursive)
		require
			a_cluster_not_void: a_cluster /= Void
			not_has_cluster: not has_cluster_figure (a_cluster)
			non_linkable_already_part_of_view: not a_cluster.flat_linkables.there_exists (agent has_linkable_figure)
		local
			cur_cluster: detachable EG_CLUSTER
			cur_node: detachable like node_type
		do
			from
				a_cluster.linkables.start
			until
				a_cluster.linkables.after
			loop
				cur_cluster ?= a_cluster.linkables.item
				if cur_cluster /= Void then
					insert_cluster (cur_cluster)
				else
					cur_node ?= a_cluster.linkables.item
					check
						cur_node /= Void
					end
					add_node (cur_node)
				end
				a_cluster.linkables.forth
			end
			add_cluster (a_cluster)
		ensure
			has_cluster: has_cluster_figure (a_cluster)
			all_linkables_part_of_view: a_cluster.flat_linkables.for_all (agent has_linkable_figure)
		end

	linkable_add (a_linkable: EG_LINKABLE_FIGURE)
			-- `a_linkable' was added to `Current'.
		require
			a_linkable_not_void: a_linkable /= Void
		do
			a_linkable.pointer_button_press_actions.extend (agent on_pointer_button_press (a_linkable, ?, ?, ?, ?, ?, ?, ?, ?))
			a_linkable.move_actions.extend (agent on_linkable_move (a_linkable, ?, ?, ?, ?, ?, ?, ?))
		end

	selected_figure: detachable EV_MODEL
			-- The figure the user clicked on. (Void if none)

	on_pointer_button_press (figure: EG_LINKABLE_FIGURE; ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Pointer button was pressed on `figure'.
		require
			figure_not_void: figure /= Void
		local
			cluster_figure: detachable EG_CLUSTER_FIGURE
		do
			if attached figure.cluster as l_cluster then
				l_cluster.bring_to_front (figure)
			else
				bring_to_front (figure)
			end
			cluster_figure ?= figure
			if cluster_figure = Void then
				if not ev_application.ctrl_pressed and then not selected_figures.has (figure) then
					deselect_all
				end
				if not figure_was_selected and then button = 1 then --and then not ev_application.ctrl_pressed then
					if figure.is_selected and then ev_application.ctrl_pressed then
						selected_figures.prune_all (figure)
						set_figure_selection_state (figure, False)
					elseif not selected_figures.has (figure) then
						selected_figures.extend (figure)
						set_figure_selection_state (figure, True)
					end
					figure_was_selected := True
				end
			end
			selected_figure := figure
		end

	set_figure_selection_state (a_figure: EG_FIGURE; a_selection_state: BOOLEAN)
			-- Set `is_selected' state of `a_figure' to `a_selection_state'.
		local
		do
			if a_selection_state then
				a_figure.enable_selected
			else
				a_figure.disable_selected
			end
		end

	on_linkable_move (figure: EG_LINKABLE_FIGURE; ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- `figure' was moved for `ax' `ay'.
			-- | Move all `selected_figures' as well.
		require
			figure_not_void: figure /= Void
		local
			l_selected_figures: like selected_figures
			l_item: EG_FIGURE
			i, nb: INTEGER
			cf: detachable EG_CLUSTER_FIGURE
			l_linkable: detachable EG_LINKABLE_FIGURE
		do
			cf ?= figure
			if cf = Void and then not selected_figures.is_empty then
				check
					when_figures_selected_move_only_a_selected_figure: selected_figures.has (figure)
				end
				from
					l_selected_figures := selected_figures
					i := 1
					nb := l_selected_figures.count
				until
					i > nb
				loop
					l_item := l_selected_figures.i_th (i)
					if l_item /= figure then
						l_item.set_point_position (l_item.point_x + ax, l_item.point_y + ay)
						l_linkable ?= l_item
						if l_linkable /= Void then
							l_linkable.set_is_fixed (True)
						end
					end
					i := i + 1
				end
			end
		end

	figure_was_selected: BOOLEAN
			-- Was a figure allready selected?

	is_figure_moved: BOOLEAN
			-- Is a figure moved?

	on_pointer_button_press_on_world (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Pointer button was pressed somewhere in the world.
			-- | Used for starting multiple selection.
		local
			l_rect: like multi_select_rectangle
		do
			if button = 1 and then not figure_was_selected and then ev_application.ctrl_pressed and then is_multiple_selection_enabled then
				if is_multiselection_mode then
					l_rect := multi_select_rectangle
					check l_rect /= Void end -- Implied by `is_multiselection_mode'
					prune_all (l_rect)
				end
				create l_rect.make_with_positions (ax, ay, ax, ay)
				multi_select_rectangle := l_rect
				l_rect.enable_dashed_line_style
				extend (l_rect)
				is_multiselection_mode := True
				selected_figure := multi_select_rectangle
				enable_capture
			elseif button = 1 and then selected_figure /= Void then
				is_figure_moved := True
				figure_change_start_actions.call (Void)
			else
					-- If there is a selection and we click in a blank area
					-- then deselect all figures.
				deselect_all
			end
			figure_was_selected := False
		end

	on_pointer_motion_on_world (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Pointer was moved in world.
		local
			l_bbox: EV_RECTANGLE
			l_rect: like multi_select_rectangle
		do
			if is_multiselection_mode then
				l_rect := multi_select_rectangle
				check l_rect /= Void end -- Implied by `is_multiselection_mode'
				l_rect.set_point_b_position (ax, ay)
				l_bbox := l_rect.bounding_box
				if not ev_application.ctrl_pressed then
					deselect_all
				end
				from
					nodes.start
				until
					nodes.after
				loop
					if nodes.item.bounding_box.intersects (l_bbox) then
						if not selected_figures.has (nodes.item) then
							selected_figures.extend (nodes.item)
							set_figure_selection_state (nodes.item, True)
							figure_was_selected := True
						end
					end
					nodes.forth
				end
			end
		end

	on_pointer_button_release_on_world (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Pointer was released over world.
		local
			l_rect: like multi_select_rectangle
		do
			if is_multiselection_mode then
				l_rect := multi_select_rectangle
				check l_rect /= Void end -- Implied by `is_multiselection_mode'
				prune_all (l_rect)
				full_redraw
				is_multiselection_mode := False
				disable_capture
			end
			if is_figure_moved then
				figure_change_end_actions.call (Void)
				is_figure_moved := False
			end
			selected_figure := Void
		end

	multi_select_rectangle: detachable EV_MODEL_RECTANGLE
			-- Rectangle used to multiselect nodes.

	is_multiselection_mode: BOOLEAN
			-- Is `Current' in multiselction mode?

	figure_added (a_figure: EG_FIGURE)
			-- `a_figure' was added to the world. Redefine this to do your
			-- own initialisation.
		require
			a_figure_not_void: a_figure /= Void
		do
			if scale_factor /= 1.0 then
				a_figure.scale (scale_factor)
				a_figure.request_update
			end
		ensure
			a_figure_not_removed: items_to_figure_lookup_table.has_item (a_figure)
		end

	figure_removed (a_figure: EG_FIGURE)
			-- `a_figure' was removed from the world.
		require
			a_figure_not_Void: a_figure /= Void
		do
			a_figure.recycle
		ensure
			a_figure_not_added: not items_to_figure_lookup_table.has_item (a_figure)
		end

	update_cluster (cluster: EG_CLUSTER_FIGURE)
			-- Update all figures with `is_update_required' in `cluster'.
		require
			cluster_not_void: cluster /= Void
		local
			l_item: EV_MODEL
			l_cluster: detachable EG_CLUSTER_FIGURE
			l_fig: detachable EG_FIGURE
			i: INTEGER
		do
			from
				i := cluster.count
			until
				i < 1
			loop
				l_item := cluster.i_th (i)
				l_fig ?= l_item
				if l_fig /= Void then
					l_cluster ?= l_item
					if l_cluster /= Void and then l_cluster.is_update_required then
						update_cluster (l_cluster)
					end
					if l_fig.is_update_required then
						l_fig.update
					end
				end
				i := i - 1
			end
		end

feature {NONE} -- Implementation

	node_type: EG_NODE
			-- Type for nodes.
		local
			l_result: detachable like node_type
		do
			check anchor_type_only: False end
			check l_result /= Void end -- Satisfy void-safe compiler
			Result := l_result
		end

invariant
	model_not_void: model /= Void
	factory_not_void: factory /= Void
	items_to_figure_lookup_table_not_void: items_to_figure_lookup_table /= Void
	root_cluster_not_void: root_cluster /= Void
	selected_figures_not_void: selected_figures /= Void

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




end -- class EG_FIGURE_WORLD

