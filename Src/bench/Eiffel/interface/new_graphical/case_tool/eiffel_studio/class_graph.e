indexing
	description: "Objects that is a graph of classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS_GRAPH

inherit
	ES_GRAPH
		redefine
			synchronize
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like context_editor) is
			-- Create a CLASS_GRAPH in `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			default_create
			context_editor := a_tool
			ancestor_depth := 1
			descendant_depth := 1
			client_depth := 0
			supplier_depth := 0

			include_all_classes_of_cluster := False
			include_only_classes_of_cluster := False
		ensure
			set: context_editor = a_tool
		end

feature -- Access

	center_class: ES_CLASS
			-- Center class of this graph.

	ancestor_depth: INTEGER
			-- Depth of ancestor links.

	descendant_depth: INTEGER
			-- Depth of descendant links.

	client_depth: INTEGER
			-- Depth of client links.

	supplier_depth: INTEGER
			-- Depth of supplier links.

feature -- Status report.

	include_all_classes_of_cluster: BOOLEAN
			-- Do all the classes in same cluster as `center_class' have to be in `Current?

	include_only_classes_of_cluster: BOOLEAN
			-- Do all the classes in `Current' have to be in same cluster as `center_class'?

feature -- Status settings.

	set_include_all_classes_of_cluster (b: BOOLEAN) is
			-- Set `include_all_classes_of_cluster' to `b'.
		do
			include_all_classes_of_cluster := b
		ensure
			set: include_all_classes_of_cluster = b
		end

	set_include_only_classes_of_cluster (b: BOOLEAN) is
			-- Set `include_only_classes_in_cluster' to `b'.
		do
			include_only_classes_of_cluster := b
		ensure
			set: include_only_classes_of_cluster = b
		end

feature -- Element change

	set_ancestor_depth (i: INTEGER) is
			-- Set `ancestor_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			ancestor_depth := i
		ensure
			assigned: ancestor_depth = i
		end

	set_descendant_depth (i: INTEGER) is
			-- Set `descendant_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			descendant_depth := i
		ensure
			assigned: descendant_depth = i
		end

	set_client_depth (i: INTEGER) is
			-- Set `client_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			client_depth := i
		ensure
			assigned: client_depth = i
		end

	set_supplier_depth (i: INTEGER) is
			-- Set `supplier_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			supplier_depth := i
		ensure
			assigned: supplier_depth = i
		end

	set_center_class (a_center_class: like center_class) is
			-- Set `center_class' to `a_center_class'.
		require
			a_center_class_not_void: a_center_class /= Void
		do
			center_class := a_center_class
		ensure
			center_class_set: center_class = a_center_class
		end

	explore_center_class is
			-- Explore relations according to `center_class'.
		require
			center_class_not_void: center_class /= Void
		do
			wipe_out
			add_node (center_class)
			if include_all_classes_of_cluster then
				include_all_classes (center_class.class_i.cluster)
			end
			explore_relations
			remove_unneeded_items
		end

	set_new_center_class (a_center_class: like center_class) is
			-- Set `center_class' to `a_center_class' add not
			-- relations not yet there, remove relations too
			-- far away.
		require
			a_center_class_not_void: a_center_class /= Void
			center_class_not_void: center_class /= Void
		do
			create last_created_classes.make (10)
			if not has_node (a_center_class) then
				add_node (a_center_class)
			end
			disable_reachable_classes (center_class)
			center_class.disable_needed_on_diagram
			disable_all_links (center_class.internal_links)
			center_class := a_center_class
			center_class.enable_needed_on_diagram
			if center_class.is_compiled then
				add_ancestor_relations (center_class)
				add_descendant_relations (center_class)
				add_client_relations (center_class)
				add_supplier_relations (center_class)
			end

			explore_ancestors (center_class.class_i, ancestor_depth, False)
			explore_descendants (center_class.class_i, descendant_depth, False)
			explore_clients (center_class, client_depth, False)
			explore_suppliers (center_class, supplier_depth, False)
		end

feature {EB_CONTEXT_EDITOR} -- Synchronization

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchronization.
		do
			Precursor {ES_GRAPH}
			if center_class /= Void and then not has_node (center_class) then
				if not center_class.is_needed_on_diagram then
					-- Fake the class is still there but don't show it
					add_node (center_class)
					disable_all_links (center_class.links)
--				else
					-- The class must have been deleted/or renamed and can't be found anymore
					-- The stone will be set to Void and the diagram is erased.
				end
			end
		end

feature {NONE} -- Implementation

	explore_relations is
			-- Explore relations of `center_class'.
		local
			nb_of_items: INTEGER
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			nb_of_items := number_of_ancestors (center_class.class_i, ancestor_depth) +
						   number_of_descendants (center_class.class_i, descendant_depth) +
						   number_of_clients (center_class.class_i, client_depth) +
						   number_of_suppliers (center_class.class_i, supplier_depth)

			l_status_bar := context_editor.development_window.status_bar
			l_status_bar.reset_progress_bar_with_range (0 |..| nb_of_items)

			l_status_bar.display_message ("Exploring ancestors of " + center_class.name)
			explore_ancestors (center_class.class_i, ancestor_depth, True)

			l_status_bar.display_message ("Exploring descendants of " + center_class.name)
			explore_descendants (center_class.class_i, descendant_depth, True)

			l_status_bar.display_message ("Exploring clients of " + center_class.name)
			explore_clients (center_class, client_depth, True)

			l_status_bar.display_message ("Exploring suppliers of " + center_class.name)
			explore_suppliers (center_class, supplier_depth, True)
		end

	number_of_ancestors (a_class: CLASS_I; depth: INTEGER): INTEGER is
			-- Calculate number of ancestors of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: FIXED_LIST [CL_TYPE_A]
			ci: CLASS_I
		do
			if depth > 0 and then a_class.compiled then
				l := a_class.compiled_class.parents
				if l /= Void then
					from
						l.start
					until
						l.after
					loop
						ci := l.item.associated_class.lace_class
						Result := Result + number_of_ancestors (ci, depth - 1) + 1
						l.forth
					end
				end
			end
		end

	explore_ancestors (a_class: CLASS_I; depth: INTEGER; progress_bar: BOOLEAN) is
			-- Add ancestors of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: FIXED_LIST [CL_TYPE_A]
			ci: CLASS_I
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			if depth > 0 and then a_class.compiled then
				l := a_class.compiled_class.parents
				if l /= Void then
					from
						if progress_bar then
							l_status_bar := context_editor.development_window.status_bar
						end
						l.start
					until
						l.after
					loop
						ci := l.item.associated_class.lace_class
						add_class (ci)
						explore_ancestors (ci, depth - 1, progress_bar)
						if progress_bar then
							l_status_bar.display_progress_value (
								l_status_bar.current_progress_value + 1
							)
						end
						l.forth
					end
				end
			end
		end

	number_of_descendants (a_class: CLASS_I; depth: INTEGER): INTEGER is
			-- Add descendants of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: LINEAR [CLASS_C]
			ci: CLASS_I
		do
			if depth > 0 and then a_class.compiled then
				l := a_class.compiled_class.descendants
				from
					l.start
				until
					l.after
				loop
					ci := l.item.lace_class
					Result := Result + number_of_descendants (ci, depth - 1) + 1
					l.forth
				end
			end
		end

	explore_descendants (a_class: CLASS_I; depth: INTEGER; progress_bar: BOOLEAN) is
			-- Add descendants of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: ARRAYED_LIST [CLASS_C]
			ci: CLASS_I
			i, nb: INTEGER
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			if depth > 0 and then a_class.compiled then
				l := a_class.compiled_class.descendants
				from
					i := 1
					nb := l.count
					if progress_bar then
						l_status_bar := context_editor.development_window.status_bar
					end
				until
					i > nb
				loop
					ci := l.i_th (i).lace_class
					add_class (ci)
					explore_descendants (ci, depth - 1, progress_bar)
						if progress_bar then
							l_status_bar.display_progress_value (
								l_status_bar.current_progress_value + 1
							)
						end
					i := i + 1
				end
			end
		end

	number_of_clients (a_class: CLASS_I; depth: INTEGER): INTEGER is
			-- Add clients of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: ARRAYED_LIST [CLASS_C]
			ci: CLASS_I
			i, nb: INTEGER
		do
			if depth > 0 and then a_class.is_compiled then
				l := a_class.compiled_class.syntactical_clients
				from
					i := 1
					nb := l.count
				until
					i > nb
				loop
					ci := l.i_th (i).lace_class
					Result := Result + number_of_clients (ci, depth - 1) + 1
					i := i + 1
				end
			end
		end

	explore_clients (a_class: ES_CLASS; depth: INTEGER; progress_bar: BOOLEAN) is
			-- Add clients of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: ARRAYED_LIST [CLASS_C]
			ci: CLASS_I
			i, nb, c: INTEGER
			added_class: ES_CLASS
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			if depth > 0 and then a_class.class_i.is_compiled then
				l := a_class.class_i.compiled_class.syntactical_clients
				from
					i := 1
					nb := l.count
					if progress_bar then
						l_status_bar := context_editor.development_window.status_bar
					end
				until
					i > nb
				loop
					ci := l.i_th (i).lace_class
					if ci = a_class.class_i then
						added_class := a_class
					else
						add_class (ci)
						added_class := class_from_interface (ci)
					end
					if added_class /= Void then
						if not added_class.has_supplier (a_class) then
							if last_added_class /= Void then
								disable_class (added_class)
							end
							if progress_bar then
								c := number_of_clients (ci, depth - 1) + 1
							end
						else
							explore_clients (added_class, depth - 1, progress_bar)
							c := 1
						end
					else
						if progress_bar then
							c := number_of_clients (ci, depth - 1) + 1
						end
					end
					if progress_bar then
						l_status_bar.display_progress_value (
							l_status_bar.current_progress_value + c
						)
					end
					i := i + 1
				end
			end
		end


	number_of_suppliers (a_class: CLASS_I; depth: INTEGER): INTEGER is
			-- Add suppliers of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: ARRAYED_LIST [CLASS_C]
			ci: CLASS_I
			i, nb: INTEGER
		do
			if depth > 0 and then a_class.compiled then
				l := a_class.compiled_class.syntactical_suppliers
				from
					i := 1
					nb := l.count
				until
					i > nb
				loop
					ci := l.i_th (i).lace_class
					Result := Result + number_of_suppliers (ci, depth - 1) + 1
					i := i + 1
				end
			end
		end

	explore_suppliers (a_class: ES_CLASS; depth: INTEGER; progress_bar: BOOLEAN) is
			-- Add suppliers of `a_class' until `depth' is reached.
		require
			a_class_not_void: a_class /= Void
		local
			l: ARRAYED_LIST [CLASS_C]
			ci: CLASS_I
			i, nb, c: INTEGER
			added_class: ES_CLASS
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			if depth > 0 and then a_class.class_i.compiled then
				l := a_class.class_i.compiled_class.syntactical_suppliers
				from
					i := 1
					nb := l.count
					if progress_bar then
						l_status_bar := context_editor.development_window.status_bar
					end
				until
					i > nb
				loop
					ci := l.i_th (i).lace_class
					if ci = a_class.class_i then
						added_class := a_class
					else
						add_class (ci)
						added_class := class_from_interface (ci)
					end
					if added_class /= Void then
						if not a_class.has_supplier (added_class) then
							-- added_class was not a syntactical_supplier in a query
							if last_added_class /= Void then
								-- added_class was not added before
								disable_class (added_class)
							end
							if progress_bar then
								c := number_of_suppliers (ci, depth - 1) + 1
							end
						else
							explore_suppliers (added_class, depth - 1, progress_bar)
							c := 1
						end
					else
						-- Was an excluded class
						if progress_bar then
							c := number_of_suppliers (ci, depth - 1) + 1
						end
					end
					if progress_bar then
						l_status_bar.display_progress_value (
							l_status_bar.current_progress_value + c
						)
					end
					i := i + 1
				end
			end
		end

	include_all_classes (cluster_i: CLUSTER_I) is
			-- Include all classes in `cluster_i'.
		require
			cluster_i_not_void: cluster_i /= Void
		local
			l_classes: LIST [CLASS_I]
		do
			l_classes := cluster_i.classes.linear_representation
			from
				l_classes.start
			until
				l_classes.after
			loop
				add_class (l_classes.item)
				l_classes.forth
			end
		end

feature {NONE} -- Disable relations

	disable_reachable_classes (a_center: ES_CLASS) is
			-- Disable needed on diagram for all classes reachable from `a_center'.
		require
			a_center_not_void: a_center /= Void
		do
			disable_reachable_clients (a_center, client_depth)
			disable_reachable_suppliers (a_center, supplier_depth)
			disable_reachable_ancestors (a_center, ancestor_depth)
			disable_reachable_descendants (a_center, descendant_depth)
		end

	disable_reachable_clients (a_class: ES_CLASS; a_depth: INTEGER) is
			-- Disable needed on diagram for all reachable clients from `a_class'.
		require
			a_class_not_Void: a_class /= Void
			a_depth_not_negative: a_depth >= 0
		local
			l_links: LIST [EG_LINK]
			cs_link: ES_CLIENT_SUPPLIER_LINK
		do
			if a_depth > 0 then
				from
					l_links := a_class.links
					l_links.start
				until
					l_links.after
				loop
					check
						is_a_class_link: l_links.item.source = a_class or else l_links.item.target = a_class
					end
					cs_link ?= l_links.item
					if cs_link /= Void and then cs_link.supplier = a_class then
						disable_reachable_clients (cs_link.client, a_depth - 1)

						if cs_link.client.is_needed_on_diagram then
							cs_link.client.disable_needed_on_diagram
							disable_all_links (cs_link.client.internal_links)
						end
					end
					l_links.forth
				end
			end
		end

	disable_reachable_suppliers (a_class: ES_CLASS; a_depth: INTEGER) is
			-- Disable needed on diagram for all reachable suppliers from `a_class'.
		require
			a_class_not_Void: a_class /= Void
			a_depth_not_negative: a_depth >= 0
		local
			l_links: LIST [EG_LINK]
			cs_link: ES_CLIENT_SUPPLIER_LINK
		do
			if a_depth > 0 then
				from
					l_links := a_class.links
					l_links.start
				until
					l_links.after
				loop
					cs_link ?= l_links.item
					if cs_link /= Void and then cs_link.client = a_class then
						disable_reachable_suppliers (cs_link.supplier, a_depth - 1)
						if cs_link.supplier.is_needed_on_diagram then
							cs_link.supplier.disable_needed_on_diagram
							disable_all_links (cs_link.supplier.internal_links)
						end
					end
					l_links.forth
				end
			end

		end

	disable_reachable_ancestors (a_class: ES_CLASS; a_depth: INTEGER) is
			-- Disable needed on diagram for all reachable ancestors from `a_class'.
		require
			a_class_not_Void: a_class /= Void
			a_depth_not_negative: a_depth >= 0
		local
			l_links: LIST [EG_LINK]
			i_link: ES_INHERITANCE_LINK
		do
			if a_depth > 0 then
				from
					l_links := a_class.links
					l_links.start
				until
					l_links.after
				loop
					i_link ?= l_links.item
					if i_link /= Void and then i_link.descendant = a_class then
						disable_reachable_suppliers (i_link.ancestor, a_depth - 1)
						if i_link.ancestor.is_needed_on_diagram then
							i_link.ancestor.disable_needed_on_diagram
							disable_all_links (i_link.ancestor.internal_links)
						end
					end
					l_links.forth
				end
			end
		end

	disable_reachable_descendants (a_class: ES_CLASS; a_depth: INTEGER) is
			-- Disable needed on diagram for all reachable descendants from `a_class'.
		require
			a_class_not_Void: a_class /= Void
			a_depth_not_negative: a_depth >= 0
		local
			l_links: LIST [EG_LINK]
			i_link: ES_INHERITANCE_LINK
		do
			if a_depth > 0 then
				from
					l_links := a_class.links
					l_links.start
				until
					l_links.after
				loop
					i_link ?= l_links.item
					if i_link /= Void and then i_link.ancestor = a_class then
						disable_reachable_descendants (i_link.descendant, a_depth - 1)
						if i_link.descendant.is_needed_on_diagram then
							i_link.descendant.disable_needed_on_diagram
							disable_all_links (i_link.descendant.internal_links)
						end
					end
					l_links.forth
				end
			end
		end

	disable_class (a_class: ES_CLASS) is
			-- Remove `a_class' and its links
		do
			a_class.disable_needed_on_diagram
			disable_all_links (a_class.internal_links)
		end

	disable_all_links (a_links: LIST [EG_LINK]) is
			-- Disable `is_needed_on_diagram' for all links in `a_links'
		require
			a_links_not_void: a_links /= Void
		local
			l_item: ES_ITEM
		do
			from
				a_links.start
			until
				a_links.after
			loop
				l_item ?= a_links.item
				if l_item /= Void then
					l_item.disable_needed_on_diagram
				end
				a_links.forth
			end
		end

	add_class (a_class: CLASS_I) is
			-- Include `a_class' in the diagram.
			-- Add any relations `a_class' may have with
			-- all items in `class_figures'.
		require
			a_class_not_void: a_class /= Void
		local
			es_class: ES_CLASS
		do
			last_added_class := Void
			if not context_editor.is_excluded_in_preferences (a_class.name_in_upper) then

				if not include_only_classes_of_cluster or else a_class.cluster = center_class.class_i.cluster then
					es_class := class_from_interface (a_class)
					if es_class = Void then
						create es_class.make (a_class)
						add_node (es_class)
						last_added_class := es_class
						if last_created_classes /= Void then
							last_created_classes.extend (es_class)
						end
					elseif not es_class.is_needed_on_diagram then
						es_class.enable_needed_on_diagram
						if es_class.is_compiled then
							add_ancestor_relations (es_class)
							add_descendant_relations (es_class)
							add_client_relations (es_class)
							add_supplier_relations (es_class)
						end
						last_added_class := es_class
						if last_created_classes /= Void then
							last_created_classes.extend (es_class)
						end
					end
				end
			end
		end

	last_added_class: ES_CLASS

feature {EIFFEL_CLASS_FIGURE}

	last_created_classes: ARRAYED_LIST [ES_CLASS]
			-- Last created classes by `add_class' if not Void.

	reset_last_created_classes is
			-- Set `last_created_classes' to Void.
		do
			last_created_classes := Void
		end

invariant
	ancestor_depth_positive: ancestor_depth >= 0
	descendant_depth_positive: descendant_depth >= 0
	client_depth_positive: client_depth >= 0
	supplier_depth_positive: supplier_depth >= 0
	center_class_Void_implies_empty: center_class = Void implies is_empty

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

end -- class ES_CLASS_GRAPH
