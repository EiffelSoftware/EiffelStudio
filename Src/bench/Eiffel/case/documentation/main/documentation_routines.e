indexing
	description: "Routines intended for use by DOCUMENTATION."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_ROUTINES

inherit
	OUTPUT_ROUTINES

	SHARED_EIFFEL_PROJECT

feature -- Status setting

	set_excluded_indexing_items (l: LINEAR [STRING]) is
			-- Assign `l' to `excluded_indexing_items'.
		do
			excluded_indexing_items := l
		end

feature -- Access

	current_class: CLASS_C
			-- Class currently being processed.

	excluded_indexing_items: LINEAR [STRING]
			-- Indexing items not to include in HTML meta clause.

	index_text: STRUCTURED_TEXT is
			-- Generate documentation index as structured text.
		local
			subs: LINEAR [CLUSTER_I]
		do
			create Result.make
			Result.add (ti_Before_class_declaration)
			append_system_info (Result)
			subs := Eiffel_system.sub_clusters
			if subs /= Void and then not subs.is_empty then
				Result.add (create {KEYWORD_TEXT}.make ("Top-level clusters"))
				Result.add_new_line
				append_cluster_list (Result, subs)
				Result.add_new_line
			end
			Result.add (ti_After_class_declaration)
		ensure
			not_void: Result /= Void
		end

	class_list_text (du: DOCUMENTATION_UNIVERSE): STRUCTURED_TEXT is
			-- Generate documentation class list from `du.classes' as structured text.
		require
			du_not_void: du /= Void
		do
			create Result.make
			Result.add (ti_Before_class_declaration)
			Result.add (create {KEYWORD_TEXT}.make ("Classes"))
			Result.add_new_line
			append_class_list (Result, du.classes, True)
			Result.add (ti_After_class_declaration)
		ensure
			not_void: Result /= Void
		end

	cluster_list_text (du: DOCUMENTATION_UNIVERSE): STRUCTURED_TEXT is
			-- Generate documentation cluster list from `du.clusters' as structured text.
		require
			du_not_void: du /= Void
		do
			create Result.make
			Result.add (ti_Before_class_declaration)
			Result.add (create {KEYWORD_TEXT}.make ("Clusters"))
			Result.add_new_line
			append_cluster_list (Result, du.clusters)
			Result.add (ti_After_class_declaration)
		ensure
			not_void: Result /= Void
		end

	cluster_hierarchy_text (du: DOCUMENTATION_UNIVERSE): STRUCTURED_TEXT is
			-- Generate documentation cluster hierarchy as structured text.
			-- Do not generate leafs of clusters that are not generated as described by `du'.
			-- Add links to diagrams if `diagrams' is True.
		require
			du_not_void: du /= Void
		local
			cluster_list: LIST [CLUSTER_I]
		do
			create Result.make
			Result.add (ti_Before_class_declaration)
			Result.add (create {KEYWORD_TEXT}.make ("Clusters"))
			Result.add_new_line
			cluster_list := Eiffel_system.sub_clusters
			from cluster_list.start until cluster_list.after loop
				append_cluster_hierarchy_leaf (Result, du, cluster_list.item, 1)
				cluster_list.forth
			end
			Result.add (ti_After_class_declaration)
		ensure
			not_void: Result /= Void
		end

	cluster_index_text (
		cluster: CLUSTER_I;
		class_list: LINKED_LIST [CLASS_I];
		diagrams: BOOLEAN): STRUCTURED_TEXT is
			-- Generate documentation cluster index for `cluster' as structured text.
			-- Add links to diagrams if `diagrams' is True.
		require
			cluster_not_void: cluster /= Void
		local
			parent: CLUSTER_I
			subs: ARRAYED_LIST [CLUSTER_I]
			ust: URL_STRING_TEXT
		do
			create Result.make
			Result.add (ti_Before_class_declaration)
			Result.add (create {KEYWORD_TEXT}.make ("Cluster"))
			Result.add_new_line
			Result.add_indent
			Result.add (create {CLUSTER_NAME_TEXT}.make (cluster.cluster_name, cluster))
			if diagrams then
				Result.add_indent
				create ust.make ("(diagram)")
				ust.set_link ("./diagram.html")
				Result.add (ust)
			end
			Result.add_new_line
			Result.add_new_line;

			(create {CLASS_AS}).format_indexes (
				create {FORMAT_CONTEXT}.make_for_appending (Result),
				cluster.indexes
			)

			parent := cluster.parent_cluster
			if parent /= Void then
				Result.add (create {KEYWORD_TEXT}.make ("Supercluster"))
				Result.add_new_line
				Result.add_indent
				Result.add (create {CLUSTER_NAME_TEXT}.make (parent.cluster_name, parent))		
				Result.add_new_line
				Result.add_new_line
			end
			subs := cluster.sub_clusters
			if subs /= Void and then not subs.is_empty then
				Result.add (create {KEYWORD_TEXT}.make ("Subclusters"))
				Result.add_new_line
				append_cluster_list (Result, subs)
				Result.add_new_line
			end
			if not class_list.is_empty then
				Result.add (create {KEYWORD_TEXT}.make ("Classes"))
				Result.add_new_line
				append_class_list (Result, class_list, False)
			end
			Result.add (ti_After_class_declaration)
		ensure
			not_void: Result /= Void
		end

	class_chart_text (class_c: CLASS_C): STRUCTURED_TEXT is
			-- Generate documentation class chart for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
		local
			as_c: CLASS_C
			features: LINEAR [E_FEATURE]
			queries, commands, actions: SORTED_TWO_WAY_LIST [E_FEATURE]
			f: E_FEATURE
		do
			current_class := class_c
			create Result.make
			Result.add (ti_Before_class_declaration)
			class_c.append_header (Result)
			Result.add_new_line
			append_general_info (Result, class_c.lace_class)
			append_class_ancestors (Result, class_c)
			create queries.make
			create commands.make
			create actions.make
			as_c := Action_sequence_class
			features := class_c.api_feature_table.linear_representation
			if features /= Void then
				from features.start until features.after loop
					f := features.item
					if display_feature (f, class_c) then
						if f.is_procedure then
							commands.extend (f)
						elseif safe_conforms_to (f, as_c) then
							actions.extend (f)
						else
							queries.extend (f)
						end
					end
					features.forth
				end
			end
			append_feature_chart_item (Result, actions, "Action sequences")
			append_feature_chart_item (Result, queries, "Queries")
			append_feature_chart_item (Result, commands, "Commands")
			append_class_constraints (Result, class_c)
			Result.add (ti_After_class_declaration)
			current_class := Void
		ensure
			not_void: Result /= Void
		end

	class_relations_text (class_c: CLASS_C): STRUCTURED_TEXT is
			-- Generate documentation class relations for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
		do
			create Result.make
			Result.add (ti_Before_class_declaration)
			class_c.append_header (Result)
			Result.add_new_line
			append_class_ancestors (Result, class_c)
			append_class_descendants (Result, class_c)
			append_class_clients (Result, class_c)
			append_class_suppliers (Result, class_c)
			Result.add (ti_After_class_declaration)
		ensure
			not_void: Result /= Void
		end

	class_text (class_C: CLASS_C; flat, short: BOOLEAN): STRUCTURED_TEXT is
			-- Generate documentation class text for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
		local
			formatter: CLASS_TEXT_FORMATTER
		do
			create formatter
			formatter.set_clickable
			if flat then
				formatter.set_feature_clause_order ((create {EB_FLAT_SHORT_DATA}).feature_clause_order)
			else
				formatter.set_one_class_only
				formatter.set_order_same_as_text
			end
			if short then
				formatter.set_is_short
			end
			formatter.format (class_c)
			Result := formatter.text
		ensure
			not_void: Result /= Void
		end

feature -- Routines

	append_general_info (text: STRUCTURED_TEXT; class_i: CLASS_I) is
			-- Append "General" item for class charts.
		local
			creators: HASH_TABLE [EXPORT_I, STRING]
			s: STRING
			class_c: CLASS_C
		do
			class_c := class_i.compiled_class
			text.add (create {KEYWORD_TEXT}.make ("General"))
			text.add_new_line
			if class_c.is_obsolete then
				append_info_item (text, "obsolete")
				add_string_multilined (text, "%"" + class_c.obsolete_message + "%"")
				text.add_new_line
			end
			append_info_item (text, "cluster")
			text.add (create {CLUSTER_NAME_TEXT}.make (class_i.cluster.cluster_name, class_i.cluster))
			text.add_new_line
				
			s := indexing_item_as_string (class_i, "description")
			if s /= Void then
				append_info_item (text, "description")
				add_string_multilined (text, s)
				text.add_new_line
			end
			s := indexing_item_as_string (class_i, "keywords")
			if s /= Void then
				append_info_item (text, "keywords")
				add_string_multilined (text, s)
				text.add_new_line
			end
			creators := class_c.creators
			if creators /= Void and then not creators.is_empty then
				append_info_item (text, "create")
				append_creators (text, class_c)
				text.add_new_line
			end
			text.add_new_line
		end

	append_class_constraints (text: STRUCTURED_TEXT; class_c: CLASS_C) is
			-- Append to `text', all invariant tags.
		local
			ast: INVARIANT_AS
			invariants: EIFFEL_LIST [TAGGED_AS]
			s: STRING
		do
			ast := class_c.invariant_ast
			if ast /= Void then
				invariants := ast.assertion_list
				if ast.assertion_list /= Void and then not ast.assertion_list.is_empty then
					text.add (create {KEYWORD_TEXT}.make ("Constraints"))
					text.add_new_line
					from
						invariants.start
					until
						invariants.after
					loop
						s := invariants.item.tag
						if s /= Void and then not s.is_empty then
							s := clone (s)
							s.replace_substring_all ("_", " ")
							text.add_indent
							text.add (create {ASSERTION_TAG_TEXT}.make (s))
							text.add_new_line
						end
						invariants.forth
					end
					text.add_new_line
				end
			end
		end

	append_creators (text: STRUCTURED_TEXT; class_c: CLASS_C) is
			-- Append creators list.
		local
			cr: HASH_TABLE [EXPORT_I, STRING]
			f_name: STRING
		do
			cr := class_c.creators
			from
				cr.start
			until
				cr.after
			loop
				f_name := cr.key_for_iteration
				text.add_feature (class_c.feature_with_name (f_name), f_name)
				cr.forth
				if not cr.after then
					text.add (ti_Comma)
					text.add_space
				end
			end
		end

	append_cluster_list (text: STRUCTURED_TEXT; cluster_list: LINEAR [CLUSTER_I]) is
		do
			from
				cluster_list.start
			until
				cluster_list.after
			loop
				text.add_indent
				text.add (create {CLUSTER_NAME_TEXT}.make (
					cluster_list.item.cluster_name, cluster_list.item))
				text.add_new_line
				cluster_list.forth
			end
		end
 
	append_feature_list (text: STRUCTURED_TEXT; f_list: LINEAR [E_FEATURE]) is
			-- Append list of feature with signatures to `ctxt'.
		local
			f: E_FEATURE
			t: STRING
			ti: TOOLTIP_ITEM
			fi: FILTER_ITEM
		do
			from
				f_list.start
			until
				f_list.after
			loop
				f := f_list.item
				t := feature_tooltip (f)
				text.add_indent
				create ti.make (t)
				ti.set_before
				text.add (ti)
				f.append_signature (text)
				create ti.make (t)
				ti.set_after
				text.add (ti)

				if current_class /= f.written_class then
					create fi.make (f_Origin_comment)
					fi.set_before
					text.add (fi)
					text.add_comment_text (" -- (from " + f.written_class.name_in_upper + ")")
					create fi.make (f_Origin_comment)
					fi.set_after
					text.add (fi)
				end

				text.add_new_line

				f_list.forth
			end
		end

	feature_tooltip (f: E_FEATURE): STRING is
			-- Get a descriptive comment on the origin of `f'.
		local
			wc: CLASS_C
			anc: E_FEATURE
			real_name: STRING
		do
			create Result.make (20)
			Result.append ("`")
			Result.append (f.name)
			Result.append ("' ")
			wc := f.written_class
			if wc.has_feature_table then
				anc := wc.feature_with_body_index (f.body_index)
			end
			if anc /= Void then
				real_name := anc.name
			else
				real_name := f.name
			end
			if wc = current_class then
				Result.append ("is declared in `Current'")
			else
				Result.append ("was declared in ")
				Result.append (wc.name_in_upper)
				if not real_name.is_equal (f.name) then
					Result.append (" as `")
					Result.append (real_name)
					Result.append ("'")
				end
			end
		end

feature {NONE} -- Implementation

	append_class_list (text: STRUCTURED_TEXT; class_list: LINKED_LIST [CLASS_I]; desc: BOOLEAN) is
			-- Append to `ctxt.text', formatted `class_list'.
			-- Depending on `desc', include descriptions.
		local
			s: STRING
			ci: CLASS_I
		do
			from
				class_list.start
			until
				class_list.after
			loop
				ci := class_list.item
				text.add_indent
				ci.compiled_class.append_signature (text)
				text.add_new_line
				if desc then
					s := clone (indexing_item_as_string (class_list.item, "description"))
					if s /= Void then
						s.remove (1)
						s.remove (s.count)
						s.replace_substring_all ("%%T", "")
						s.replace_substring_all ("%%R", "")
						s.replace_substring_all ("%%%'", "%'")
						s.replace_substring_all ("%%%"", "%"")
						append_comment (text, s)
					end
					text.add_new_line
				end
				class_list.forth
			end
		end

	append_cluster_hierarchy_leaf (
		text: STRUCTURED_TEXT;
		doc_universe: DOCUMENTATION_UNIVERSE;
		parent_cluster: CLUSTER_I;
		indent: INTEGER) is
		local
			n: INTEGER
			subs: ARRAYED_LIST [CLUSTER_I]
		do
			if doc_universe.is_cluster_leaf_generated (parent_cluster) then
				from n := 1 until n > indent loop
					text.add_indent
					n := n + 1
				end
				text.add (create {CLUSTER_NAME_TEXT}.make (
					parent_cluster.cluster_name, parent_cluster))
				text.add_new_line
				subs := parent_cluster.sub_clusters
				if subs /= Void then
					from subs.start until subs.after loop
						append_cluster_hierarchy_leaf (text, doc_universe, subs.item, indent + 1)
						subs.forth
					end
				end
			end
		end

	add_string_multilined (text: STRUCTURED_TEXT; s: STRING) is
			-- Append `s' to `text' using the multilined formatting.
		local
			s_as: STRING_AS
		do
			create s_as
			if s.substring_index ("%%N", 1) > 0 then
				s_as.append_nice_multilined (s, text, 2)
			else
				text.add_indexing_string (s)
			end
		end

	append_info_item (text: STRUCTURED_TEXT; tag: STRING) is
			-- Append `tag': `content' to `text'.
		do
			text.add_indent
			text.add (create {INDEXING_TAG_TEXT}.make (tag))
			text.add (ti_Colon)			
			text.add_space			
		end

	append_feature_chart_item (text: STRUCTURED_TEXT; fl: LIST [E_FEATURE]; a_title: STRING) is
			-- Append class ancestors for `class_c' to `text'.
		do
			if not fl.is_empty then
				text.add (create {KEYWORD_TEXT}.make (a_title))
				text.add_new_line
				append_feature_list (text, fl)
				text.add_new_line
			end
		end

	append_comment (text: STRUCTURED_TEXT; comment: STRING) is
			-- Append `comment' to `text'.
		local
			n, prev: INTEGER
		do
			from
				n := 1
				prev := n
			until
				n = 0
			loop
				n := comment.substring_index ("%%N", prev)
				text.add_indent
				text.add_indent
				text.add_indent
				text.add (ti_Dashdash)
				if n > 0 then
					text.add_comment_text (" " + comment.substring (prev, n - 1))
					prev := n + 2
				else
					text.add_comment_text (" " + comment.substring (prev, comment.count))
				end
				text.add_new_line
			end
		end

feature {NONE} -- Indexing clauses

	html_meta_for_class (class_i: CLASS_I): STRING is
			-- Generate string with list of HTML META tags
			-- describing the indexing clause of `class_i'.
		require
			class_i_not_void: class_i /= Void
		do
			Result := indexes_to_html_meta (class_i.compiled_class.ast.top_indexes, "Eiffel class")
			Result.append (indexes_to_html_meta (class_i.compiled_class.ast.bottom_indexes, "Eiffel class"))
		end

	html_meta_for_cluster (cluster_i: CLUSTER_I): STRING is
			-- Generate strings of HTML meta data.
		require
			cluster_i_not_void: cluster_i /= Void
		do
			Result := indexes_to_html_meta (cluster_i.indexes, "Eiffel cluster")
		end

	html_meta_for_system: STRING is
			-- Generate strings of HTML meta data.
		do
			Result := indexing_tuple_to_string ("keywords", "Eiffel system")
		end

	indexes_to_html_meta (indexes: EIFFEL_LIST [INDEX_AS]; added_keywords: STRING): STRING is
			-- Convert `indexes' to a big string of HTML meta data.
		local
			content, t: STRING
			ic: HASH_TABLE [STRING, STRING]
			exc: like excluded_indexing_items
		do
			create Result.make (20)
			ic := indexes_to_table (indexes)
			exc := excluded_indexing_items
			from
				ic.start
			until
				ic.after
			loop
				t := ic.key_for_iteration
				if not exc.has (t) then
					content := clone (ic.item_for_iteration)
					content.replace_substring_all ("%%N", " ")
					content.prune_all ('%%')
					content.prune_all ('"')
					if t.is_equal ("keywords") and added_keywords /= Void then
						content.prepend (", ")
						content.prepend (added_keywords)
					end
					Result.append (indexing_tuple_to_string (t, content))
				end
				ic.forth
			end
			if not ic.has ("keywords") and not exc.has ("keywords") and added_keywords /= Void then
				Result.append (indexing_tuple_to_string ("keywords", added_keywords))
			end
		end

	indexing_tuple_to_string (tag, content: STRING): STRING is
			-- Create HTML meta string.
		do
			create Result.make (20)
			Result.append ("<META NAME=%"")
			Result.append (tag)
			Result.append ("%" CONTENT=%"")
			Result.append (content)
			Result.append ("%">%N")
		end

	indexes_to_table (indexes: EIFFEL_LIST [INDEX_AS]): HASH_TABLE [STRING, STRING] is
			-- Table of [content, tag].
		local
			t: STRING
			ii: INDEX_AS
		do
			create Result.make (5)
			if indexes /= Void then
				from
					indexes.start
				until
					indexes.after
				loop
					ii := indexes.item
					t := ii.tag
					if t = Void then
						t := "description"
							-- It is legal Eiffel syntax to omit first tag
							-- of the indexing clause.
							-- We will assume this is the description clause.
					end
					Result.put (ii.content_as_string, t)
					indexes.forth
				end
			end
		end

	indexing_item_as_string (c: CLASS_I; s: STRING): STRING is
		local
			ic: HASH_TABLE [STRING, STRING]
		do
			ic := indexes_to_table (c.compiled_class.ast.top_indexes)
			if ic.has (s) then
				Result := ic.found_item
			end
			if Result = Void then				
				ic := indexes_to_table (c.compiled_class.ast.bottom_indexes)
				if ic.has (s) then
					Result := ic.found_item
				end
			end
		end

feature {NONE} -- Implementation

	safe_conforms_to (f: E_FEATURE; conf: CLASS_C): BOOLEAN is
			-- Is the return type of `f' a descendant of `conf'?
			-- `f' may be any feature. Returns `False' if not a function.
		require
			f_not_void: f /= Void
		local
			t: TYPE_A
			return_class: CLASS_C
		do
			t := f.type
			if t /= Void then
				return_class := t.associated_class
				if return_class /= Void then
					if conf /= Void then	
						Result := return_class.conform_to (conf)
					end
				end
			end
		end

	Action_sequence_class: CLASS_C is
			-- Compiled class ACTION_SEQUENCE.
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_system.Universe.compiled_classes_with_name ("action_sequence")
			if cl /= Void and then not cl.is_empty then
				Result := cl.i_th (1).compiled_class
			end
		end

	Any_class: CLASS_C is
			-- Compiled class ANY.
		once
			Result := Eiffel_system.any_class.compiled_class
		end

	display_feature (f: E_FEATURE; class_c: CLASS_C): BOOLEAN is
			-- Should feature be included in feature list for `class_c'?
		do
			Result :=
				f.is_exported_to (Any_class)
				and then (class_c = Any_class or else f.written_class /= Any_class)
				and then not f.is_obsolete
		end

end -- class DOCUMENTATION_ROUTINES
