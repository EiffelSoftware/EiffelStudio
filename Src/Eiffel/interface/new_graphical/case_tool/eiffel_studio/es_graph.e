note
	description: "Base class graphs showing a representation of eiffel code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRAPH

inherit
	EG_GRAPH
		redefine
			add_node,
			remove_node,
			add_link,
			remove_link,
			default_create,
			node_type
		end

	SHARED_ERROR_HANDLER
		undefine
			default_create
		end

	EV_STOCK_PIXMAPS
		undefine
			default_create
		end

	SHARED_WORKBENCH
		undefine
			default_create
		end

	SHARED_BENCH_NAMES
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create an EIFFEL_GRAPH.
		local
			l_comparer: AGENT_BASED_EQUALITY_TESTER [like link_type]
		do
			Precursor {EG_GRAPH}
			create class_name_to_node_lookup.make (50)
			create l_comparer.make (agent link_comparer)
			create inheritance_links_lookup.make_with_key_tester (50, l_comparer)
			create client_supplier_links_lookup.make_with_key_tester (100, l_comparer)
			feature_name_number := 0
		end

feature -- Access

	context_editor: ES_DIAGRAM_TOOL_PANEL
			-- Container of `Current'.
			-- Used to access surface on which `Current' is displayed.

	class_of_name (a_name: STRING): ES_CLASS
			-- Class of `a_name'
		require
			a_name_not_void: a_name /= Void
		local
			l_nodes: like nodes
			l_class: ES_CLASS
		do
			from
				l_nodes := nodes
				l_nodes.start
			until
				l_nodes.after or Result /= Void
			loop
				l_class ?= l_nodes.item
				if l_class /= Void and then l_class.name.is_equal (a_name) then
					Result := l_class
				end
				l_nodes.forth
			end
		end

	class_from_interface (class_i: CLASS_I): ARRAYED_LIST [ES_CLASS]
			-- Representation of `class_i', Void if none exists.
		require
			class_i_not_void: class_i /= Void
		local
			l_nodes: like nodes
			l_class: ES_CLASS
		do
			create Result.make (5)
			l_nodes := nodes
			from
				l_nodes.start
			until
				l_nodes.after
			loop
				l_class ?= l_nodes.item
				if l_class /= Void then
					if l_class.class_i = class_i then
						Result.extend (l_class)
					end
				end
				l_nodes.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	top_level_clusters : ARRAYED_LIST [ES_CLUSTER]
			-- Top level clusters.
		local
			l_clusters : like clusters
			es_cluster: ES_CLUSTER
		do
			create Result.make (5)
			from
				l_clusters := clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				es_cluster ?= l_clusters.item
				if es_cluster /= Void then
					if es_cluster.cluster = Void then
						Result.extend (es_cluster)
					end
				end
				l_clusters.forth
			end
		ensure
			top_level_clusters_not_void: Result /= Void
		end

	top_level_classes : ARRAYED_LIST [ES_CLASS]
			-- Top level classes.
		local
			l_classes: like nodes
			l_class: ES_CLASS
		do
			create Result.make (50)
			from
				l_classes := nodes
				l_classes.start
			until
				l_classes.after
			loop
				l_class ?= l_classes.item
				if l_class /= Void then
					if l_class.cluster = Void then
						Result.extend (l_class)
					end
				end
				l_classes.forth
			end
		ensure
			top_level_classes_not_void: Result /= Void
		end

	possible_linkable_node (a_class: ES_CLASS): ARRAYED_LIST [ES_CLASS]
			-- Possible linkable node within `a_cluster'
			-- Top level nodes of `a_cluster' and top level nodes of its libraries.
		require
			a_class_not_void: a_class /= Void
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_cluster, l_a_class_cluster : ES_CLUSTER
			sub_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_target: CONF_TARGET
			l_nodes: like nodes
			l_group: CONF_GROUP
			top_most_cluster: ES_CLUSTER
			l_lib: CONF_LIBRARY
		do
			l_a_class_cluster := a_class.cluster
			l_group := a_class.class_i.group
			create Result.make (10)
			if l_a_class_cluster = Void then
				l_target := a_class.class_i.group.target
				from
					l_nodes := nodes
					l_nodes.start
				until
					l_nodes.after
				loop
					if not l_group.class_by_name (l_nodes.item.class_i.name, True).is_empty then
						Result.extend (l_nodes.item)
					end
					l_nodes.forth
				end
			else
				if l_a_class_cluster.group.target = universe.target then
					l_clusters := top_level_clusters
					l_target := universe.target
				else
					top_most_cluster := top_most_scope (l_a_class_cluster)
					if top_most_cluster.group.is_library then
						l_lib ?= top_most_cluster.group
						l_target := l_lib.library_target
						l_clusters := top_most_cluster.sub_clusters
					else
						l_target := top_most_cluster.group.target
						create l_clusters.make (1)
						l_clusters.extend (top_most_cluster)
					end
				end
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					l_cluster := l_clusters.item
					if l_cluster.group.is_cluster then
						if l_cluster.group.target = l_target then
							Result.append (l_cluster.sub_nodes_recursive)
						end
					elseif l_cluster.group.is_library then
						if l_cluster.group.target = l_target then
							sub_clusters := l_cluster.sub_clusters
							from
								sub_clusters.start
							until
								sub_clusters.after
							loop
								if sub_clusters.item.group.is_cluster then
									Result.append (sub_clusters.item.sub_nodes_recursive)
								end
								sub_clusters.forth
							end
						end
					end
					l_clusters.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	cluster_from_interface (a_group: CONF_GROUP): ARRAYED_LIST [ES_CLUSTER]
			-- Representation of `a_group', Void if none exists.
		require
			a_group_not_void: a_group /= Void
		local
			l_clusters: like clusters
			es_cluster: ES_CLUSTER
		do
			create Result.make (5)
			from
				l_clusters := clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				es_cluster ?= l_clusters.item
				if es_cluster /= Void then
					if es_cluster.group = a_group then
						Result.extend (es_cluster)
					end
				end
				l_clusters.forth
			end
		ensure
			cluster_from_interface_not_void: Result /= Void
		end

	inheritance_link_connecting (a_descendant, an_ancestor: EG_LINKABLE; is_non_conforming: BOOLEAN): ES_INHERITANCE_LINK
			-- Inheritance link connection `a_descendant' with `an_ancestor' if any.
		require
			a_descendant_not_void: a_descendant /= Void
			an_ancestor_not_void: an_ancestor /= Void
		local
			l_tuple: like link_type
		do
			l_tuple := [a_descendant, an_ancestor]
			inheritance_links_lookup.search (l_tuple)
			if inheritance_links_lookup.found then
				Result := inheritance_links_lookup.found_item
				if Result /= Void and then Result.is_non_conforming /= is_non_conforming then
					Result := Void
				end
			end
		end

	client_supplier_link_connecting (a_client, a_supplier: EG_LINKABLE): ES_CLIENT_SUPPLIER_LINK
			-- Client supplier link connecting `a_client' with `a_supplier' if any.
		require
			a_client_not_void: a_client /= Void
			a_supplier_not_void: a_supplier /= Void
		local
			l_tuple: like link_type
		do
			l_tuple := [a_client, a_supplier]
			client_supplier_links_lookup.search (l_tuple)
			if client_supplier_links_lookup.found then
				Result := client_supplier_links_lookup.found_item
			end
		end

feature -- Element change

	add_node (a_node: ES_CLASS)
			-- Add `a_node' to the model.
		local
			class_i: CLASS_I
		do
			Precursor {EG_GRAPH} (a_node)
			class_i := a_node.class_i
			class_name_to_node_lookup.put (a_node, lookup_name_of_class (class_i))
		end

	add_node_relations (a_node: ES_CLASS)
			-- Add relations of `a_node'
		require
			a_node_not_void: a_node /= Void
		do
			if a_node.class_i.is_compiled then
				add_ancestor_relations (a_node)
				add_descendant_relations (a_node)
				add_client_relations (a_node)
				add_supplier_relations (a_node)
			end
		end

	remove_node (a_node: ES_CLASS)
			-- Remove `a_node' from the model.
		do
			Precursor {EG_GRAPH} (a_node)
			class_name_to_node_lookup.remove (lookup_name_of_class (a_node.class_i))
		end

	add_link (a_link: EG_LINK)
			-- Add `a_link' to the model.
		local
			eil: ES_INHERITANCE_LINK
			ecsl: ES_CLIENT_SUPPLIER_LINK
		do
			Precursor {EG_GRAPH} (a_link)
			eil ?= a_link
			if eil /= Void then
				inheritance_links_lookup.force (eil, [eil.descendant, eil.ancestor])
			end
			ecsl ?= a_link
			if ecsl /= Void then
				client_supplier_links_lookup.force (ecsl, [ecsl.client, ecsl.supplier])
			end
		end

	remove_link (a_link: EG_LINK)
			-- Remove `a_link' from the model.
		local
			eil: ES_INHERITANCE_LINK
			ecsl: ES_CLIENT_SUPPLIER_LINK
		do
			Precursor {EG_GRAPH} (a_link)
			eil ?= a_link
			if eil /= Void then
				inheritance_links_lookup.remove ([eil.descendant, eil.ancestor])
			end
			ecsl ?= a_link
			if ecsl /= Void then
				client_supplier_links_lookup.remove ([ecsl.client, ecsl.supplier])
			end
		end

feature {ES_DIAGRAM_TOOL_PANEL} -- Synchronization

	synchronize
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchronization.
		local
			l_progress_bar: EB_PERCENT_PROGRESS_BAR
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			nr_of_items: INTEGER
			is_cancelled: BOOLEAN
			l_retried: BOOLEAN
		do
			if not l_retried then
				context_editor.develop_window.window.set_pointer_style (wait_cursor)
				if not is_cancelled then
					l_status_bar := context_editor.develop_window.status_bar

					nr_of_items := 1 + nodes.count + clusters.count + links.count + 1 + 1
					l_status_bar.reset_progress_bar_with_range (0 |..| nr_of_items)
					l_status_bar.display_progress_value (0)
					l_status_bar.display_message (names.l_synchronizing_diagram_tool.as_string_32 + names.l_removing_unneeded_items)
					remove_unneeded_items

					l_status_bar.display_progress_value (1)
					l_status_bar.display_message (names.l_synchronizing_diagram_tool.as_string_32 + names.l_synchronizing_clusters)
					synchronize_clusters (l_progress_bar)

					l_status_bar.display_message (names.l_synchronizing_diagram_tool.as_string_32 + names.l_synchronizing_classes)
					synchronize_classes (l_progress_bar)

					l_status_bar.display_message (names.l_synchronizing_diagram_tool.as_string_32 + names.l_synchronizing_links)
					synchronize_links (l_progress_bar)

					l_status_bar.display_progress_value (nr_of_items - 1)
					l_status_bar.display_message (names.l_synchronizing_diagram_tool.as_string_32 + names.l_synchronizing_class_relations)
					add_classes_relations

					l_status_bar.display_progress_value (nr_of_items)
					l_status_bar.display_message (names.l_synchronizing_diagram_tool.as_string_32 + names.l_synchronizing_clusters_relations)
					add_clusters_relations

					l_status_bar.reset
				end
				context_editor.develop_window.window.set_pointer_style (standard_cursor)
			end
		rescue
			if not l_retried then
				l_retried := True
				context_editor.clear_area
				is_cancelled := True
				error_handler.error_list.wipe_out
				l_status_bar.reset
				retry
			end
		end

feature {EIFFEL_WORLD, EB_CONTEXT_DIAGRAM_COMMAND} -- Insert

	add_classes_relations
			-- Add relation between classes in `Current'.
		local
			l_classes: like nodes
			es_class: ES_CLASS
			i, nb: INTEGER
		do
			from
				l_classes := nodes
				i := 1
				nb := l_classes.count
			until
				i > nb
			loop
				es_class ?= l_classes.i_th (i)
				if es_class /= Void and then es_class.class_i.is_compiled then
					add_ancestor_relations (es_class)
					if es_class.is_queries_changed then
						add_supplier_relations (es_class)
					end
				end
				i := i + 1
			end
		end

	add_clusters_relations
			-- Add relation between clusters in `Current'.
		local
			l_clusters: like clusters
			es_cluster: ES_CLUSTER
			i, nb: INTEGER
		do
			from
				l_clusters := clusters
				i := 1
				nb := l_clusters.count
			until
				i > nb
			loop
				es_cluster ?= l_clusters.i_th (i)
				if es_cluster /= Void then
					add_children_relations (es_cluster, es_cluster.cluster)
					add_parent_relations (es_cluster, es_cluster.cluster)
				end
				i := i + 1
			end
		end

	add_children_relations (a_cluster: ES_CLUSTER; a_parent: ES_CLUSTER)
			-- Add all `a_cluster''s childrens appear in top level of `a_parent'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_clusters: like flat_clusters
			l_top_possibles: ARRAYED_LIST [ES_CLUSTER]
			l_child: ES_CLUSTER
			l_lib: CONF_LIBRARY
			l_lib_a: CONF_LIBRARY
			l_cluster: CONF_CLUSTER
			l_chuster_a: CONF_CLUSTER
		do
			l_top_possibles := top_level_clusters
			if a_parent /= Void then
				l_clusters := l_top_possibles
				l_clusters.append (a_parent.sub_clusters)
			else
				l_clusters := l_top_possibles
			end
			if a_cluster.group.is_cluster then
				l_cluster ?= a_cluster.group
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					l_child ?= l_clusters.item
					if l_child /= Void and then l_child.cluster = Void and then l_child.is_needed_on_diagram and then l_child.group.is_cluster then
						l_chuster_a ?= l_child.group
						if l_cluster.children /= Void and then l_cluster.children.has (l_chuster_a) then
							a_cluster.extend (l_child)
						end
					end
					l_clusters.forth
				end
			elseif a_cluster.group.is_library then
				l_lib ?= a_cluster.group
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					l_child ?= l_clusters.item
					if l_child /= Void and then l_child.cluster = Void and then l_child.is_needed_on_diagram then
						if l_child.group.is_cluster then
							if l_lib.library_target.clusters.has (l_child.group.name) then
								a_cluster.extend (l_child)
							end
						elseif l_child.group.is_library then
							l_lib_a ?= l_child.group
							if l_lib.library_target.libraries.has_item (l_lib_a) then
								a_cluster.extend (l_child)
							end
						end
					end
					l_clusters.forth
				end
			end
		end

	add_parent_relations (a_cluster: ES_CLUSTER; a_parent: ES_CLUSTER)
			-- Add `a_cluster' to possible `a_parent'.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			parent_cluster: ES_CLUSTER
			l_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
			l_libs_tar: STRING_TABLE [CONF_LIBRARY]
			l_parent_found: BOOLEAN
		do
			if a_parent /= Void then
				l_group := a_cluster.group
				if l_group.is_cluster then
					l_cluster ?= l_group
					if l_cluster.parent = a_parent.group then
						a_parent.extend (a_cluster)
						l_parent_found := True
					end
					if not l_parent_found then
						if l_cluster.target.system.used_in_libraries /= Void then
							l_libs := l_cluster.target.system.used_in_libraries.twin
						end
						if l_libs /= Void then
							from
								l_libs.start
							until
								l_libs.after or l_parent_found
							loop
								parent_cluster := a_parent
								if a_parent.group = l_libs.item then
									a_parent.extend (a_cluster)
									l_parent_found := True
								end
								l_libs.forth
							end
						end
					end
				elseif l_group.is_library then
					if a_parent.group.is_library then
						l_lib ?= a_parent.group
						l_libs_tar := l_lib.library_target.libraries
						if l_libs_tar.has_key (l_group.name) then
							if l_libs_tar.found_item = l_group then
								a_parent.extend (a_cluster)
							end
						end
					end
				end
			end
		end

	add_ancestor_relations (a_class: ES_CLASS)
			-- Add links to ancestors classes of `a_class' in the graph.
		do
			add_ancestor_relations_internal (a_class, False)
			add_ancestor_relations_internal (a_class, True)
		end

	add_descendant_relations (a_class: ES_CLASS)
			-- Add links to descendants of `a_class' in the graph.
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.class_i.is_compiled
		local
			l: LINEAR [CLASS_C]
			cl: CLASS_I
			es_class: ES_CLASS
			es_classes: ARRAYED_LIST [ES_CLASS]
			l_link: ES_INHERITANCE_LINK
			l_is_non_conforming: BOOLEAN
		do
			l := a_class.class_i.compiled_class.direct_descendants
			if l /= Void then
				from l.start until l.after loop
					cl := l.item.original_class
					if cl /= Void then
						es_classes := possible_linkable_node (a_class)
						from
							es_classes.start
						until
							es_classes.after
						loop
							es_class := es_classes.item
							if es_class.class_i = cl and then es_class.is_needed_on_diagram then
								l_is_non_conforming := es_class.class_c.non_conforming_parents /= Void and then es_class.class_c.non_conforming_parents_classes.has (a_class.class_c)
								l_link := inheritance_link_connecting (es_class, a_class, l_is_non_conforming)
								if l_link = Void then
									create {ES_INHERITANCE_LINK} l_link.make (es_class, a_class, False)
									l_link.set_is_non_conforming (l_is_non_conforming)
									add_link (l_link)
								elseif not l_link.is_needed_on_diagram then
									l_link.enable_needed_on_diagram
								end
							end
							es_classes.forth
						end
					end
					l.forth
				end
			end
		end

	add_client_relations (a_class: ES_CLASS)
			-- Add links to classes in the graph that are clients of `a_class'
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.class_i.is_compiled
		local
			cf: ES_CLASS
			l_nodes: like nodes
			cs_link: ES_CLIENT_SUPPLIER_LINK
		do
			from
				l_nodes := possible_linkable_node (a_class)
				l_nodes.start
			until
				l_nodes.after
			loop
				cf ?= l_nodes.item
				if cf.is_needed_on_diagram and then cf.has_supplier (a_class) then
					cs_link ?= client_supplier_link_connecting (cf, a_class)
					if cs_link = Void then
						create cs_link.make (cf, a_class)
						add_link (cs_link)
					elseif not cs_link.is_needed_on_diagram then
						cs_link.enable_needed_on_diagram
					end
				end
				l_nodes.forth
			end
		end

	add_supplier_relations (a_class: ES_CLASS)
			-- Add links to classes in the graph that are suppliers of `a_class'.
		local
			cf: ES_CLASS
			l_nodes: like nodes
			cs_link: ES_CLIENT_SUPPLIER_LINK
		do
			from
				l_nodes := possible_linkable_node (a_class)
				l_nodes.start
			until
				l_nodes.after
			loop
				cf ?= l_nodes.item
				if cf.is_needed_on_diagram and then a_class.has_supplier (cf) then
					cs_link ?= client_supplier_link_connecting (a_class, cf)
					if cs_link = Void then
						create cs_link.make (a_class, cf)
						add_link (cs_link)
					elseif not cs_link.is_needed_on_diagram then
						cs_link.enable_needed_on_diagram
					end
				end
				l_nodes.forth
			end
		end

feature {CLASS_TEXT_MODIFIER} -- Status report

	next_feature_name_number: INTEGER
			-- Number to append to next created feature.
		do
			Result := feature_name_number
			feature_name_number := feature_name_number + 1
		ensure
			feature_name_number_incremented:
				feature_name_number = old feature_name_number + 1
		end

feature {NONE} -- Implementation


	add_ancestor_relations_internal (a_class: ES_CLASS; is_non_conforming: BOOLEAN)
			-- Add links to ancestors classes of `a_class' in the graph.
			-- If `is_non_conforming' then iterate the non-conforming parents.
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.class_i.is_compiled
		local
			l: FIXED_LIST [CL_TYPE_A]
			cl: CLASS_I
			es_class: ES_CLASS
			es_classes: ARRAYED_LIST [ES_CLASS]
			l_link: ES_INHERITANCE_LINK
		do
			if not is_non_conforming then
				l := a_class.class_i.compiled_class.conforming_parents
			else
				l := a_class.class_i.compiled_class.non_conforming_parents
			end

			if l /= Void then
				from l.start until l.after loop
					cl := l.item.base_class.original_class
					if cl /= Void then
						es_classes := possible_linkable_node (a_class)
						from
							es_classes.start
						until
							es_classes.after
						loop
							es_class := es_classes.item
							if es_class.class_i = cl and then es_class.is_needed_on_diagram then
								l_link := inheritance_link_connecting (a_class, es_class, is_non_conforming)
								if l_link = Void then
									create {ES_INHERITANCE_LINK} l_link.make (a_class, es_class, False)
									l_link.set_is_non_conforming (is_non_conforming)
									add_link (l_link)
								elseif not l_link.is_needed_on_diagram then
									l_link.enable_needed_on_diagram
								end
							end
							es_classes.forth
						end
					end
					l.forth
				end
			end
		end

	lookup_name_of_class (a_class: CLASS_I): READABLE_STRING_32
			-- Unique lookup name of `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			Result := a_class.group.target.name + "." + a_class.name
		ensure
			Result_not_void: Result /= Void
		end

	remove_unneeded_items
			-- Remove all EIFFEL_ITEMS in `Current' with is_needed_on_diagram False.
		local
			l_nodes: like nodes
			l_links: like links
			l_clusters: like clusters
			l_item: ES_ITEM
			i: INTEGER
			l_linkables: LIST [EG_LINKABLE]
			l_cluster: EG_CLUSTER
			es_class: ES_CLASS
		do
			from
				l_links := links
				i := 1
			until
				i > l_links.count
			loop
				l_item ?= l_links.i_th (i)
				if l_item /= Void and then not l_item.is_needed_on_diagram then
					remove_link (l_links.i_th (i))
				else
					i := i + 1
				end
			end
			from
				l_nodes := nodes
				i := 1
			until
				i > l_nodes.count
			loop
				l_item ?= l_nodes.i_th (i)
				if l_item /= Void and then not l_item.is_needed_on_diagram then
					check
						no_link_was_needed_on_diagram: l_nodes.i_th (i).links.is_empty
					end
					es_class ?= l_nodes.i_th (i)
					remove_node (es_class)
				else
					i := i + 1
				end
			end
			from
				l_clusters := clusters
				i := 1
			until
				i > l_clusters.count
			loop
				l_cluster := l_clusters.i_th (i)
				l_item ?= l_cluster
				if l_item /= Void and then not l_item.is_needed_on_diagram then
					from
						l_linkables := l_cluster.linkables
					until
						l_linkables.is_empty
					loop
						l_cluster.prune_all (l_linkables.item)
					end
					remove_cluster (l_cluster)
				else
					i := i + 1
				end
			end
		end

	synchronize_clusters (a_progress_bar: EB_PERCENT_PROGRESS_BAR)
			-- Synchronize all clusters in `Current'.
		local
			l_clusters: like flat_clusters
			es_cluster: ES_CLUSTER
		do
			from
				l_clusters := flat_clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				es_cluster ?= l_clusters.item
				if es_cluster /= Void then
					es_cluster.synchronize
				end
				l_clusters.forth
				if a_progress_bar /= Void then
					a_progress_bar.set_value (a_progress_bar.value + 1)
				end
			end
		end

	synchronize_classes (a_progress_bar: EB_PERCENT_PROGRESS_BAR)
			-- Synchronize all classes in `Current'.
		local
			l_classes: like flat_nodes
			es_class: ES_CLASS
		do
			from
				l_classes := flat_nodes
				l_classes.start
			until
				l_classes.after
			loop
				es_class ?= l_classes.item
				if es_class /= Void then
					es_class.synchronize
				end
				l_classes.forth
				if a_progress_bar /= Void then
					a_progress_bar.set_value (a_progress_bar.value + 1)
				end
			end
		end

	synchronize_links (a_progress_bar: EB_PERCENT_PROGRESS_BAR)
			-- Synchronize all links in `Current'.
		local
			l_links: like flat_links
			es_item: ES_ITEM
		do
			from
				l_links := flat_links
				l_links.start
			until
				l_links.after
			loop
				es_item ?= l_links.item
				if es_item /= Void then
					es_item.synchronize
				end
				l_links.forth
				if a_progress_bar /= Void then
					a_progress_bar.set_value (a_progress_bar.value + 1)
				end
			end
		end

	explore_relations
			-- Explore relations.
		deferred
		end

	top_most_scope (a_cluster: ES_CLUSTER): ES_CLUSTER
			-- Possible top most cluster in the graph that contains dependent relations among classes in `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			if a_cluster.cluster = Void then
				Result := a_cluster
			elseif a_cluster.cluster.group.is_cluster then
				Result := top_most_scope (a_cluster.cluster)
			elseif a_cluster.cluster.group.is_library then
				Result := a_cluster.cluster
			end
		ensure
			Result_not_void: Result /= Void
		end

	feature_name_number: INTEGER
			-- Number to append to next created feature.

	class_name_to_node_lookup: STRING_TABLE [ES_CLASS]
			-- Lookup tables to speed up `class_from_interface'.

	inheritance_links_lookup: HASH_TABLE_EX [ES_INHERITANCE_LINK, like link_type]
			-- Lookup tables to speed up `inheritance_link_connecting'.

	client_supplier_links_lookup: HASH_TABLE_EX [ES_CLIENT_SUPPLIER_LINK, like link_type]
			-- Lookup tables to speed up `client_supplier_link_connecting'.

	link_comparer (u, v: like link_type): BOOLEAN
			-- Comparison agent used in `client_supplier_links_lookup' and in
			-- `inheritance_links_lookup'.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := (u.left = v.left) and (u.right = v.right)
		end

	link_type: TUPLE [left: EG_LINKABLE; right: EG_LINKABLE]
			-- For typing purposes only
		do
		end

	node_type: ES_CLASS
			-- Type of nodes in `nodes'.
		do
		end

invariant
	context_editor_not_void: context_editor /= Void
	class_name_to_node_lookup_not_void: class_name_to_node_lookup /= Void
	inheritance_links_lookup_not_void: inheritance_links_lookup /= Void
	client_supplier_links_lookup_not_void: client_supplier_links_lookup /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
