indexing
	description: "Objects is a model for a class in Eiffel Studio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS

inherit
	EM_CLASS
		redefine
			graph,
			cluster
		end

	ES_ITEM
		undefine
			default_create
		end

	SHARED_WORKBENCH
		undefine
			default_create
		end

	SHARED_STATELESS_VISITOR
		undefine
			default_create
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I) is
			-- Create an ES_CLASS with `a_class'
		require
			a_class_not_void: a_class /= Void
		do
			default_create
			name := a_class.name.twin
			class_i := a_class

			is_needed_on_diagram := True
			create {ARRAYED_LIST [FEATURE_AS]} queries.make (5)
			queries.compare_objects

			create suppliers.make (10)

			create queries_changed_actions

			create feature_clause_list.make (0)
			create feature_clause_list_changed_actions

			synchronize
		end

feature -- Status report

	has_supplier (a_class: ES_CLASS): BOOLEAN is
			-- Does `Current' have `a_class' as supplier?
			-- | independend of if there is a link to it or not.
		do
			Result := suppliers.has (a_class.class_i.name)
		end

	is_queries_changed: BOOLEAN
			-- Has `queries' changed at last synchronization?

	has_only_suppliers: BOOLEAN is
			-- Has `Current' only links to suppliers?
		local
			l_links: like internal_links
			i, nb: INTEGER
			cs_link: ES_CLIENT_SUPPLIER_LINK
			i_link: ES_INHERITANCE_LINK
		do
			from
				l_links := internal_links
				i := 1
				nb := l_links.count
			until
				i > nb or else not Result
			loop
				cs_link ?= l_links.i_th (i)
				i_link ?= l_links.i_th (i)
				if i_link /= Void and then i_link.is_needed_on_diagram then
					Result := False
				elseif cs_link /= Void and then cs_link.is_needed_on_diagram then
					if cs_link.client /= Current then
						Result := False
					end
				end
				i := i + 1
			end
		end

	has_only_clients: BOOLEAN is
			-- Has `Current' only links to clients?
		local
			l_links: like internal_links
			i, nb: INTEGER
			cs_link: ES_CLIENT_SUPPLIER_LINK
			i_link: ES_INHERITANCE_LINK
		do
			from
				l_links := internal_links
				i := 1
				nb := l_links.count
			until
				i > nb or else not Result
			loop
				cs_link ?= l_links.i_th (i)
				i_link ?= l_links.i_th (i)
				if i_link /= Void and then i_link.is_needed_on_diagram then
					Result := False
				elseif cs_link /= Void and then cs_link.is_needed_on_diagram then
					if cs_link.supplier /= Current then
						Result := False
					end
				end
				i := i + 1
			end
		end

	has_only_ancestors: BOOLEAN is
			-- Has `Current' only links to ancestors?
		local
			l_links: like internal_links
			i, nb: INTEGER
			cs_link: ES_CLIENT_SUPPLIER_LINK
			i_link: ES_INHERITANCE_LINK
		do
			from
				l_links := internal_links
				i := 1
				nb := l_links.count
			until
				i > nb or else not Result
			loop
				cs_link ?= l_links.i_th (i)
				i_link ?= l_links.i_th (i)
				if i_link /= Void and then i_link.is_needed_on_diagram then
					if i_link.descendant /= Current then
						Result := False
					end
				elseif cs_link /= Void and then cs_link.is_needed_on_diagram then
					Result := False
				end
				i := i + 1
			end
		end

	has_only_descendants: BOOLEAN is
			-- Has `Current' only links to ancestors?
		local
			l_links: like internal_links
			i, nb: INTEGER
			cs_link: ES_CLIENT_SUPPLIER_LINK
			i_link: ES_INHERITANCE_LINK
		do
			from
				l_links := internal_links
				i := 1
				nb := l_links.count
			until
				i > nb or else not Result
			loop
				cs_link ?= l_links.i_th (i)
				i_link ?= l_links.i_th (i)
				if i_link /= Void and then i_link.is_needed_on_diagram then
					if i_link.ancestor /= Current then
						Result := False
					end
				elseif cs_link /= Void and then cs_link.is_needed_on_diagram then
					Result := False
				end
				i := i + 1
			end
		end

feature -- Access

	code_generator: CLASS_TEXT_MODIFIER is
			-- Code generator for `Current'.
		do
			if internal_code_generator = Void then
				create internal_code_generator.make_with_tool (class_i, graph.context_editor)
			end
			Result := internal_code_generator
		ensure
			Result_not_void: Result /= Void
		end

	graph: ES_GRAPH
			-- Graph `Current' is part of.

	cluster: ES_CLUSTER
			-- Cluster `Current' is part of if any.

	class_i: CLASS_I
			-- Class `Current' is a model for.

	class_c: CLASS_C is
			-- Compiled class.
		do
			Result := class_i.compiled_class
		ensure
			compiled_implies_Result_not_void: class_i.is_compiled implies Result /= Void
		end

	queries: LIST [FEATURE_AS]
			-- All written queries in `Current'.

	suppliers_with_class (a_class: ES_CLASS): LIST [FEATURE_AS] is
			-- Sublist of `queries' that have type `a_class'.
		local
			l_feature: FEATURE_AS
		do
			create {ARRAYED_LIST [FEATURE_AS]} Result.make (1)
			from
				queries.start
			until
				queries.after
			loop
				l_feature := queries.item
				if has_feature_supplier (l_feature, a_class.class_i) then
					Result.extend (l_feature)
				end
				queries.forth
			end
		end

	needed_links: LIST [ES_ITEM] is
			-- `links' that are EIFFEL_ITEMS and are needed_on_diagram.
		local
			l_links: like internal_links
			l_item: ES_ITEM
		do
			l_links := internal_links
			create {ARRAYED_LIST [ES_ITEM]} Result.make (l_links.count)
			from
				l_links.start
			until
				l_links.after
			loop
				l_item ?= l_links.item
				if l_item /= Void and then l_item.is_needed_on_diagram then
					Result.extend (l_item)
				end
				l_links.forth
			end
		end

	queries_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `queries' has changed.

	feature_clause_list: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- List of features in `Current'.

	feature_clause_list_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `feature_clause_list' changed.

feature -- Element change

	remove_queries (a_queries: LIST [FEATURE_AS]) is
			-- Remove `a_queries' in `queries' do not change class text.
		local
			ef: FEATURE_AS
			l_body: BODY_AS
		do
			from
				a_queries.start
			until
				a_queries.after
			loop
				queries.prune_all (a_queries.item)
				a_queries.forth
			end
			from
				suppliers.wipe_out
				queries.start
			until
				queries.after
			loop
				ef := queries.item
				l_body := ef.body
				if l_body /= Void then
					add_suppliers (l_body.type)
				end
				queries.forth
			end
			is_queries_changed := True
		end

	add_queries (a_queries: LIST [FEATURE_AS]) is
			-- Add `a_queries' to `queries' do not change class text.
		require
			a_queries_not_void: a_queries /= Void
		do
			from
				a_queries.start
			until
				a_queries.after
			loop
				add_query (a_queries.item)
				a_queries.forth
			end
			is_queries_changed := True
		end

	add_query (a_query: FEATURE_AS) is
			-- Add `a_query' to `queries'.
		require
			a_query_not_void: a_query /= Void
		local
			l_body: BODY_AS
		do
			queries.extend (a_query)
			l_body := a_query.body
			if l_body /= Void then
				add_suppliers (l_body.type)
			end
			is_queries_changed := True
		ensure
			add: queries.has (a_query)
		end

	remove_query (a_query: FEATURE_AS) is
			-- Remove `a_query' from `queries'.
		require
			a_query_not_void: a_query /= Void
		local
			l_queries: ARRAYED_LIST [FEATURE_AS]
		do
			create l_queries.make (1)
			l_queries.extend (a_query)
			remove_queries (l_queries)
			is_queries_changed := True
		end

	synchronize is
			-- Synchronize with `class_i' and `class_c' properties, build_queries, put into right cluster.
		local
			c, st: like class_c
			l_class: CLASS_I
			i: EIFFEL_LIST [INDEX_AS]
			s: STRING
			f: LIST [E_FEATURE]
			l: EIFFEL_LIST [PARENT_AS]
			l_cluster: ES_CLUSTER
			is_properties_changed: BOOLEAN
			b: BOOLEAN
			cwn: LIST [CLASS_I]
			l_persistent_str: STRING
			l_feature_clause_list: like feature_clause_list
		do
			l_persistent_str := "persistent"
			cwn := universe.classes_with_name (name)
			if cwn.count = 1 and then cwn.first /= class_i then
				class_i := cwn.first
			end
			if not universe.classes_with_name (class_i.name).has (class_i) then
				if graph /= Void then
						-- class was renamed, eather outside Eiffel Studio
						-- or without the renaming tool. The result is a new
						-- class_i object. Since we have no idea what the new
						-- class name is we can't find the new class_i.
					graph.remove_links (links)
					graph.remove_node (Current)
				end
			elseif cluster /= Void and then cluster.cluster_i /= class_i.cluster then
				if graph /= Void then
						-- This class was moved to another cluster without
						-- using Eiffel Studio.
					graph.remove_links (links)
					graph.remove_node (Current)
				end
			else
				if not class_i.name_in_upper.is_equal (name) then
					-- should never happen (see above)
					set_name (class_i.name_in_upper)
				end
				set_is_root_class (class_i.name.is_equal (class_i.System.root_class_name))
				c := class_c
				if c /= Void then
					if c.ast /= Void then
						if c.ast.generics_as_string = Void or else c.ast.generics_as_string.is_empty then
							set_generics (Void)
						else
							set_generics (c.ast.generics_as_string)
						end
					end
					b := c.is_deferred
					if b /= is_deferred then
						is_deferred := b
						is_properties_changed := True
					end
					b := c.is_used_as_expanded
					if b /= is_expanded then
						is_expanded := b
						is_properties_changed := True
					end
					b := c.is_precompiled or else c.cluster.is_library
					if b /= is_reused then
						is_reused := b
						is_properties_changed := True
					end
					-- is_interfaced
					if c.has_feature_table then
						f := c.written_in_features
						from
							f.start
							b := False
						until
							b or f.after
						loop
							b := f.item.is_external
							f.forth
						end
						if b /= is_interfaced then
							is_interfaced := b
							is_properties_changed := True
						end
					end
					-- is_persistent
					st := Storable_class
					b := False
					if st /= Void then
						b := c.conform_to (storable_class)
					end
					if not b then
						i := c.ast.top_indexes
						if i /= Void then
							from
								i.start
							until
								b or i.after
							loop
								s := i.item.tag
								b := s /= Void and then s.is_equal (l_persistent_str)
								i.forth
							end
						end
						i := c.ast.bottom_indexes
						if i /= Void then
							from
								i.start
							until
								b or i.after
							loop
								s := i.item.tag
								b := s /= Void and then s.is_equal (l_persistent_str)
								i.forth
							end
						end
					end
					if b /= is_persistent then
						is_persistent := b
						is_properties_changed := True
					end
					-- is_effective
					if not c.is_deferred then
						b := False
						if c.ast /= Void then
							l := c.ast.parents
							if l /= Void then
								from
									l.start
								until
									b or l.after
								loop
									l_class := clickable_info.associated_eiffel_class (c.lace_class, l.item.type)
									b := (l_class /= Void and then l_class.is_compiled and then
										l_class.compiled_class.is_deferred) or else l.item.is_effecting
									l.forth
								end
							end
						end
					end
					if b /= is_effective then
						is_effective := b
						is_properties_changed := True
					end
					-- features
					l_feature_clause_list := class_c.ast.features
					if l_feature_clause_list = Void then
						create l_feature_clause_list.make (0)
					end
					l_feature_clause_list.compare_objects
					if not l_feature_clause_list.is_equal (feature_clause_list) then
						feature_clause_list := l_feature_clause_list
						feature_clause_list_changed_actions.call (Void)
					end
				end
				b := class_i.compiled
				if b /= is_compiled then
					is_compiled := b
					is_properties_changed := True
				end
				build_queries
				if cluster /= Void then
					if cluster.cluster_i /= class_i.cluster then
						cluster.prune_all (Current)
					end
				end
				if graph /= Void then
					l_cluster := graph.cluster_from_interface (class_i.cluster)
					if l_cluster /= Void and then not l_cluster.has (Current) then
						l_cluster.extend (Current)
					end
				end
				if is_properties_changed then
					properties_changed_actions.call (Void)
				end
				if internal_code_generator /= Void then
					internal_code_generator.reset_date
				end
			end
		end

feature {NONE} -- Implementation

	storable_class: CLASS_C is
			-- Compiled class STORABLE.
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_system.Universe.compiled_classes_with_name ("STORABLE")
			if cl /= Void and then not cl.is_empty then
				Result := cl.i_th (1).compiled_class
			end
		end

	build_queries is
			-- Fill `queries' with all written features of the class
			-- that have a return type.
		local
			f: LIST [E_FEATURE]
			ef: E_FEATURE
			old_suppliers: like suppliers
			old_queries: like queries
			l_body: BODY_AS
		do
			old_queries := queries.twin
			if not queries.is_empty then
				queries.wipe_out
			end
			old_suppliers := suppliers.twin
			if not suppliers.is_empty then
				suppliers.wipe_out
			end
			if class_i.compiled and class_i.compiled_class.has_feature_table then
				f := class_i.compiled_class.written_in_features
				from
					f.start
				until
					f.after
				loop
					ef := f.item
					if ef.type /= Void and then ef.type.has_associated_class then
						if ef.ast /= Void then
							queries.extend (ef.ast)
							l_body := ef.ast.body
							if l_body /= Void then
								add_suppliers (l_body.type)
							end
						end
					end
					f.forth
				end
			end
			is_queries_changed := not old_suppliers.is_equal (suppliers) or else not old_queries.is_equal (queries)
			if is_queries_changed then
				queries_changed_actions.call (Void)
			end
		end

	suppliers: HASH_TABLE [CLASS_I, STRING]
			-- All suppliers of `Current'.

	add_suppliers (a_type: TYPE_AS) is
			-- Add suppliers of `a_type' to `suppliers'.
		local
			ct: CLASS_TYPE_AS
			g: TYPE_LIST_AS
			l_class_i: CLASS_I
		do
			ct ?= a_type
			if ct /= Void then
				l_class_i := class_i_by_name (ct.class_name)
				if not suppliers.has (l_class_i.name) then
					suppliers.put (l_class_i, l_class_i.name)
				end
				g := ct.generics
				if g /= Void then
					from
						g.start
					until
						g.after
					loop
						add_suppliers (g.item)
						g.forth
					end
				end
			end
		end

	has_feature_supplier (a_feature: FEATURE_AS; a_class: CLASS_I): BOOLEAN is
			-- Does `a_feature' have supplier `a_class'?
		local
			l_body: BODY_AS
		do
			if a_feature /= Void then
				l_body := a_feature.body
				if l_body /= Void then
					Result := has_suppliers (l_body.type, a_class)
				end
			end
		end

	has_suppliers (a_type: TYPE_AS; a_class: CLASS_I): BOOLEAN is
			-- Does `a_type' have `a_class' as supplier?
		local
			ct: CLASS_TYPE_AS
			g: TYPE_LIST_AS
		do
			ct ?= a_type
			if ct /= Void then
				Result := class_i_by_name (ct.class_name) = a_class
				if not Result then
					g := ct.generics
					if g /= Void then
						from
							g.start
						until
							Result or else g.after
						loop
							Result := has_suppliers (g.item, a_class)
							g.forth
						end
					end
				end
			end
		end

	internal_code_generator: CLASS_TEXT_MODIFIER
			-- Code generator returned by `code_generator'.

	class_i_by_name (a_name: STRING): CLASS_I is
			-- Return class with `a_name'.
			-- `Void' if not in system.
		local
			cl: LIST [CLASS_I]
			l_nodes: ARRAYED_LIST [EG_NODE]
			l_item: ES_CLASS
		do
			cl := eiffel_universe.classes_with_name (a_name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
			if Result = Void then
				from
					l_nodes := graph.flat_nodes
					l_nodes.start
				until
					l_nodes.after or else Result /= Void
				loop
					l_item ?= l_nodes.item
					if l_item.name.is_equal (a_name) then
						Result := l_item.class_i
					end
					l_nodes.forth
				end
			end
		end

invariant
	queries_not_void: queries /= Void
	suppliers_not_void: suppliers /= Void
	queries_changed_actions_not_void: queries_changed_actions /= Void
	feature_clause_list_not_Void: feature_clause_list /= Void
	feature_clause_list_changed_actions_not_Void: feature_clause_list_changed_actions /= Void

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

end -- class ES_CLASS
