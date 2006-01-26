indexing
	description: "Base class graphs showing a representation of eiffel code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
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

feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_GRAPH.
		local
			l_comparer: AGENT_BASED_EQUALITY_TESTER [like link_type]
		do
			Precursor {EG_GRAPH}
			create class_name_to_node_lookup.make (50)
			create l_comparer.make (agent link_comparer)
			create inheritance_links_lookup.make_with_equality_testers (50, Void, l_comparer)
			create client_supplier_links_lookup.make_with_equality_testers (100, Void, l_comparer)
			feature_name_number := 0
		end

feature -- Access

	context_editor: EB_CONTEXT_EDITOR
			-- Container of `Current'.
			-- Used to access surface on which `Current' is displayed.

	class_from_interface (class_i: CLASS_I): ES_CLASS is
			-- Representation of `class_i', Void if none exists.
		require
			class_i_not_void: class_i /= Void
		local
			l_nodes: like nodes
			es_class: ES_CLASS
		do
			Result := class_name_to_node_lookup.item (class_i.name)
			if Result /= Void and then Result.class_i /= class_i then
				-- should not happen.
				Result := Void
				from
					l_nodes := nodes
					l_nodes.start
				until
					Result /= Void or else l_nodes.after
				loop
					es_class ?= l_nodes.item
					if es_class /= Void then
						if es_class.class_i = class_i then
							Result := es_class
						end
					end
					l_nodes.forth
				end
			end
		end

	cluster_from_interface (cluster_i: CLUSTER_I): ES_CLUSTER is
			-- Representation of `cluster_i', Void if none exists.
		require
			cluster_i_not_void: cluster_i /= Void
		local
			l_clusters: like clusters
			es_cluster: ES_CLUSTER
		do
			from
				l_clusters := clusters
				l_clusters.start
			until
				Result /= Void or else l_clusters.after
			loop
				es_cluster ?= l_clusters.item
				if es_cluster /= Void then
					if es_cluster.cluster_i = cluster_i then
						Result := es_cluster
					end
				end
				l_clusters.forth
			end
		end

	inheritance_link_connecting (a_descendant, an_ancestor: EG_LINKABLE): ES_INHERITANCE_LINK is
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
			end
		end

	client_supplier_link_connecting (a_client, a_supplier: EG_LINKABLE): ES_CLIENT_SUPPLIER_LINK is
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

	add_node (a_node: ES_CLASS) is
			-- Add `a_node' to the model.
		do
			Precursor {EG_GRAPH} (a_node)
			if a_node.class_i.compiled then
				add_ancestor_relations (a_node)
				add_descendant_relations (a_node)
				add_client_relations (a_node)
				add_supplier_relations (a_node)
			end
			class_name_to_node_lookup.put (a_node, a_node.class_i.name)
		end

	remove_node (a_node: ES_CLASS) is
			-- Remove `a_node' from the model.
		do
			Precursor {EG_GRAPH} (a_node)
			class_name_to_node_lookup.remove (a_node.class_i.name)
		end

	add_link (a_link: EG_LINK) is
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

	remove_link (a_link: EG_LINK) is
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

	insert_cluster (a_cluster: ES_CLUSTER) is
			-- Add `a_cluster' to the model and add all childrens in the graph
			-- and put it into its parent (if any in the graph).
		do
			add_cluster (a_cluster)
			add_children_relations (a_cluster)
			add_parent_relations (a_cluster)
		end

feature {EB_CONTEXT_EDITOR} -- Synchronization

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchronization.
		local
			l_progress_bar: EB_PERCENT_PROGRESS_BAR
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			nr_of_items: INTEGER
			is_cancelled: BOOLEAN
		do
			context_editor.development_window.window.set_pointer_style (wait_cursor)
			if not is_cancelled then
				l_status_bar := context_editor.development_window.status_bar

				nr_of_items := 1 + nodes.count + clusters.count + links.count + 1 + 1
				l_status_bar.reset_progress_bar_with_range (0 |..| nr_of_items)
				l_status_bar.display_progress_value (0)
				l_status_bar.display_message ("Synchronizing diagram tool: Removing unneeded items")
				remove_unneeded_items

				l_status_bar.display_progress_value (1)
				l_status_bar.display_message ("Synchronizing diagram tool: Synchronizing clusters")
				synchronize_clusters (l_progress_bar)

				l_status_bar.display_message ("Synchronizing diagram tool: Synchronizing classes")
				synchronize_classes (l_progress_bar)

				l_status_bar.display_message ("Synchronizing diagram tool: Synchronizing links")
				synchronize_links (l_progress_bar)

				l_status_bar.display_progress_value (nr_of_items - 1)
				l_status_bar.display_message ("Synchronizing diagram tool: Synchronizing class relations")
				add_classes_relations

				l_status_bar.display_progress_value (nr_of_items)
				l_status_bar.display_message ("Synchronizing diagram tool: Synchronizing cluster relations")
				add_clusters_relations

				l_status_bar.reset
			end
			context_editor.development_window.window.set_pointer_style (standard_cursor)
		rescue
			context_editor.clear_area
			is_cancelled := True
			error_handler.error_list.wipe_out
			l_status_bar.reset
			retry
		end

feature {EIFFEL_WORLD, EB_CONTEXT_DIAGRAM_COMMAND} -- Insert

	add_classes_relations is
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

	add_clusters_relations is
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
					add_children_relations (es_cluster)
					add_parent_relations (es_cluster)
				end
				i := i + 1
			end
		end

	add_children_relations (a_cluster: ES_CLUSTER) is
			-- Add all childrens of `a_cluster' to `a_cluster' if in the graph.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_clusters: like flat_clusters
			l_child: ES_CLUSTER
		do
			from
				l_clusters := flat_clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				l_child ?= l_clusters.item
				if l_child /= Void and then l_child.is_needed_on_diagram and then l_child.cluster_i.parent_cluster = a_cluster.cluster_i then
					if not a_cluster.has (l_child) then
						a_cluster.extend (l_child)
					end
				end
				l_clusters.forth
			end
		end

	add_parent_relations (a_cluster: ES_CLUSTER) is
			-- Add `a_cluster' to the parent of `a_cluster' if any and if in graph.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			parent: CLUSTER_I
			parent_cluster: ES_CLUSTER
		do
			parent := a_cluster.cluster_i.parent_cluster
			if parent /= Void then
				parent_cluster := cluster_from_interface (parent)
				if parent_cluster /= Void and then parent_cluster.is_needed_on_diagram then
					if not parent_cluster.has (a_cluster) then
						parent_cluster.extend (a_cluster)
					end
				end
			end
		end

	add_ancestor_relations (a_class: ES_CLASS) is
			-- Add links to ancestors classes of `a_class' in the graph.
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.class_i.compiled
		local
			l: FIXED_LIST [CL_TYPE_A]
			cl: CLASS_I
			es_class: ES_CLASS
			l_link: ES_INHERITANCE_LINK
		do
			l := a_class.class_i.compiled_class.parents
			if l /= Void then
				from l.start until l.after loop
					cl := l.item.associated_class.lace_class
					if cl /= Void then
						es_class := class_from_interface (cl)
						if es_class /= Void and then es_class.is_needed_on_diagram then
							l_link := inheritance_link_connecting (a_class, es_class)
							if l_link = Void then
								create {ES_INHERITANCE_LINK} l_link.make_with_classes (a_class, es_class)
								add_link (l_link)
							elseif not l_link.is_needed_on_diagram then
								l_link.enable_needed_on_diagram
							end
						end
					end
					l.forth
				end
			end
		end

	add_descendant_relations (a_class: ES_CLASS) is
			-- Add links to descendants of `a_class' in the graph.
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.class_i.compiled
		local
			l: LINEAR [CLASS_C]
			cl: CLASS_I
			es_class: ES_CLASS
			l_link: ES_INHERITANCE_LINK
		do
			l := a_class.class_i.compiled_class.descendants
			if l /= Void then
				from l.start until l.after loop
					cl := l.item.lace_class
					if cl /= Void then
						es_class := class_from_interface (cl)
						if es_class /= Void and then es_class.is_needed_on_diagram then
							l_link := inheritance_link_connecting (es_class, a_class)
							if l_link = Void then
								create {ES_INHERITANCE_LINK} l_link.make_with_classes (es_class, a_class)
								add_link (l_link)
							elseif not l_link.is_needed_on_diagram then
								l_link.enable_needed_on_diagram
							end
						end
					end
					l.forth
				end
			end
		end

	add_client_relations (a_class: ES_CLASS) is
			-- Add links to classes in the graph that are clients of `a_class'
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.class_i.compiled
		local
			cf: ES_CLASS
			l_nodes: like nodes
			cs_link: ES_CLIENT_SUPPLIER_LINK
		do
			from
				l_nodes := nodes
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

	add_supplier_relations (a_class: ES_CLASS) is
			-- Add links to classes in the graph that are suppliers of `a_class'.
		local
			cf: ES_CLASS
			l_nodes: like nodes
			cs_link: ES_CLIENT_SUPPLIER_LINK
		do
			from
				l_nodes := nodes
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

	next_feature_name_number: INTEGER is
			-- Number to append to next created feature.
		do
			Result := feature_name_number
			feature_name_number := feature_name_number + 1
		ensure
			feature_name_number_incremented:
				feature_name_number = old feature_name_number + 1
		end

feature {NONE} -- Implementation

	remove_unneeded_items is
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

	synchronize_clusters (a_progress_bar: EB_PERCENT_PROGRESS_BAR) is
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

	synchronize_classes (a_progress_bar: EB_PERCENT_PROGRESS_BAR) is
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

	synchronize_links (a_progress_bar: EB_PERCENT_PROGRESS_BAR) is
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

	explore_relations is
			-- Explore relations.
		deferred
		end

	feature_name_number: INTEGER
			-- Number to append to next created feature.

	class_name_to_node_lookup: HASH_TABLE [ES_CLASS, STRING]
			-- Lookup tables to speed up `class_from_interface'.

	inheritance_links_lookup: DS_HASH_TABLE [ES_INHERITANCE_LINK, like link_type]
			-- Lookup tables to speed up `inheritance_link_connecting'.

	client_supplier_links_lookup: DS_HASH_TABLE [ES_CLIENT_SUPPLIER_LINK, like link_type]
			-- Lookup tables to speed up `client_supplier_link_connecting'.

	link_comparer (u, v: like link_type): BOOLEAN is
			-- Comparison agent used in `client_supplier_links_lookup' and in
			-- `inheritance_links_lookup'.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := (u.item (1) = v.item (1)) and (u.item (2) = v.item (2))
		end

	link_type: TUPLE [EG_LINKABLE, EG_LINKABLE] is
			-- For typing purposes only
		do
		end

	node_type: ES_CLASS is
			-- Type of nodes in `nodes'.
		do

		end

invariant
	context_editor_not_void: context_editor /= Void
	class_name_to_node_lookup_not_void: class_name_to_node_lookup /= Void
	inheritance_links_lookup_not_void: inheritance_links_lookup /= Void
	client_supplier_links_lookup_not_void: client_supplier_links_lookup /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ES_GRAPH
