indexing
	description: "Routines intended for use by DOCUMENTATION."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOCUMENTATION_ROUTINES

inherit
	DOCUMENTATION_EXPORT

	OUTPUT_ROUTINES

	EIFFEL_PROJECT_FACILITIES

	EC_SHARED_PREFERENCES

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

	index_text (a_text_formatter: TEXT_FORMATTER) is
			-- Generate documentation index as structured text.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			subs: DS_ARRAYED_LIST [CONF_GROUP]
		do
			a_text_formatter.process_filter_item (f_class_declaration, true)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, true, true, true)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			append_system_info (a_text_formatter)
			subs := top_level_clusters
			if subs /= Void and then not subs.is_empty then
				a_text_formatter.process_keyword_text ("Top-level clusters", Void)
				a_text_formatter.add_new_line
				append_cluster_list (a_text_formatter, subs)
				a_text_formatter.add_new_line
			end

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, true, true, true)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_filter_item (f_class_declaration, false)
		end

	class_list_text (du: DOCUMENTATION_UNIVERSE; a_text_formatter: TEXT_FORMATTER) is
			-- Generate documentation class list from `du.classes' as structured text.
		require
			du_not_void: du /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			a_text_formatter.process_filter_item (f_class_declaration, true)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, false, true, true)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_keyword_text ("Classes", Void)
			a_text_formatter.add_new_line
			append_class_list (a_text_formatter, du.classes, True)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, false, true, true)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_filter_item (f_class_declaration, false)
		end

	cluster_list_text (du: DOCUMENTATION_UNIVERSE; a_text_formatter:TEXT_FORMATTER)  is
			-- Generate documentation cluster list from `du.clusters' as structured text.
		require
			du_not_void: du /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			a_text_formatter.process_filter_item (f_class_declaration, true)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, True, False, True)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_keyword_text ("Clusters", Void)
			a_text_formatter.add_new_line
			append_cluster_list (a_text_formatter, du.groups)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, True, False, True)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_filter_item (f_class_declaration, false)
		end

	cluster_hierarchy_text (du: DOCUMENTATION_UNIVERSE; a_text_formatter: TEXT_FORMATTER)  is
			-- Generate documentation cluster hierarchy as structured text.
			-- Do not generate leafs of clusters that are not generated as described by `du'.
			-- Add links to diagrams if `diagrams' is True.
		require
			du_not_void: du /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
			l_grp: CONF_GROUP
			l_cluster: CONF_CLUSTER
		do
			a_text_formatter.process_filter_item (f_class_declaration, true)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_keyword_text ("Clusters", Void)
			a_text_formatter.add_new_line
			l_groups := eiffel_universe.target.groups
			from
				l_groups.start
			until
				l_groups.after
			loop
				l_grp := l_groups.item_for_iteration
				if l_grp.is_cluster then
					l_cluster ?= l_grp
					check cluster: l_cluster /= Void end
					if l_cluster.parent = Void then
						append_cluster_hierarchy_leaf (a_text_formatter, du, l_grp, 1)
					end
				else
					append_cluster_hierarchy_leaf (a_text_formatter, du, l_grp, 1)
				end
				l_groups.forth
			end

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_filter_item (f_class_declaration, false)
		end

	group_index_text (
		group: CONF_GROUP;
		class_list: DS_ARRAYED_LIST [CONF_CLASS];
		diagrams: BOOLEAN; a_text_formatter: TEXT_FORMATTER) is
			-- Generate documentation group index for `group'.
			-- Add links to diagrams if `diagrams' is True.
		require
			group_not_void: group /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			subs: DS_ARRAYED_LIST [CONF_CLUSTER]
			l_name: STRING
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_group_type: STRING
		do
			l_group_type := type_of_group (group)
			l_name := group_name_presentation (".", "", group)
			a_text_formatter.process_filter_item (f_class_declaration, true)

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_keyword_text (l_group_type, Void)
			a_text_formatter.add_new_line
			a_text_formatter.add_indent
			a_text_formatter.process_cluster_name_text (l_name, group, false)
			if diagrams then
				a_text_formatter.add_indent
				a_text_formatter.process_string_text ("(diagram)", "./diagram.html")
			end
			a_text_formatter.add_new_line
			a_text_formatter.add_new_line;

					-- Generate indexes for a group.
					-- We may need more structured information for indexing of a group.
			a_text_formatter.process_keyword_text (ti_indexing_keyword, Void)
			a_text_formatter.process_new_line
			a_text_formatter.add_indent
			a_text_formatter.process_basic_text ("description")
			a_text_formatter.process_symbol_text (ti_colon)
			a_text_formatter.process_basic_text (ti_space)
			a_text_formatter.process_string_text (ti_double_quote, Void)
			if group.is_library then
				l_library ?= group
				check l_library /= Void end
				if l_library.classes_set and then l_library.library_target.description /= Void then
					a_text_formatter.add_indexing_string (l_library.library_target.description)
				elseif group.description /= Void then
					a_text_formatter.add_indexing_string (group.description)
				end
			elseif group.description /= Void then
				a_text_formatter.add_indexing_string (group.description)
			end
			a_text_formatter.process_string_text (ti_double_quote, Void)
			a_text_formatter.process_new_line
			if group.target.version /= Void and then group.target.version.copyright /= Void then
				a_text_formatter.add_indent
				a_text_formatter.process_basic_text ("copyright")
				a_text_formatter.process_symbol_text (ti_colon)
				a_text_formatter.process_basic_text (ti_space)
				a_text_formatter.process_string_text (ti_double_quote, Void)
				a_text_formatter.add_indexing_string (group.target.version.copyright)
				a_text_formatter.process_string_text (ti_double_quote, Void)
				a_text_formatter.process_new_line
			end

			a_text_formatter.process_new_line

			if group.is_cluster then
				l_cluster ?= group
				if l_cluster.parent /= Void then
					a_text_formatter.process_keyword_text ("Supercluster", Void)
					a_text_formatter.add_new_line
					a_text_formatter.add_indent
					a_text_formatter.process_cluster_name_text (group_name_presentation (".", "", l_cluster.parent), l_cluster.parent, false)
					a_text_formatter.add_new_line
					a_text_formatter.add_new_line
				end
			end

			subs := subclusters_of_group (group)
			if subs /= Void and then not subs.is_empty then
				a_text_formatter.process_keyword_text ("Subclusters", Void)
				a_text_formatter.add_new_line
				append_cluster_list (a_text_formatter, subs)
				a_text_formatter.add_new_line
			end
			if not class_list.is_empty then
				a_text_formatter.process_keyword_text ("Classes", Void)
				a_text_formatter.add_new_line
				append_class_list (a_text_formatter, class_list, False)
			end

			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, false)

			a_text_formatter.process_filter_item (f_class_declaration, false)
		end

	class_chart_text (class_c: CLASS_C; a_text_formatter: TEXT_FORMATTER) is
			-- Generate documentation class chart for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			as_c: CLASS_C
			features: LINEAR [E_FEATURE]
			queries, commands, actions: SORTED_TWO_WAY_LIST [E_FEATURE]
			f: E_FEATURE
		do
			current_class := class_c
			a_text_formatter.process_filter_item (f_class_declaration, true)
			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_class_menu_bar (a_text_formatter, class_c.name.as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, false)
			class_c.append_header (a_text_formatter)
			a_text_formatter.add_new_line
			append_general_info (a_text_formatter, class_c.original_class)
			append_class_ancestors (a_text_formatter, class_c)
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
			append_feature_chart_item (a_text_formatter, actions, "Action sequences")
			append_feature_chart_item (a_text_formatter, queries, "Queries")
			append_feature_chart_item (a_text_formatter, commands, "Commands")
			append_class_constraints (a_text_formatter, class_c)
			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_class_menu_bar (a_text_formatter, class_c.name.as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, false)
			a_text_formatter.process_filter_item (f_class_declaration, false)
			current_class := Void
		end

	class_relations_text (class_c: CLASS_C; a_text_formatter: TEXT_FORMATTER) is
			-- Generate documentation class relations for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			a_text_formatter.process_filter_item (f_class_declaration, true)
			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_class_menu_bar (a_text_formatter, class_c.name.as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, false)
			class_c.append_header (a_text_formatter)
			a_text_formatter.add_new_line
			append_class_ancestors (a_text_formatter, class_c)
			append_class_descendants (a_text_formatter, class_c)
			append_class_clients (a_text_formatter, class_c)
			append_class_suppliers (a_text_formatter, class_c)
			a_text_formatter.process_filter_item (f_menu_bar, true)
			insert_class_menu_bar (a_text_formatter, class_c.name.as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, false)
			a_text_formatter.process_filter_item (f_class_declaration, false)
		end

	class_text (class_C: CLASS_C; flat, short: BOOLEAN; a_text_formatter: TEXT_FORMATTER) is
			-- Generate documentation class text for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
		local
			formatter: CLASS_TEXT_FORMATTER
		do
			create formatter
			formatter.set_documentation (Current)
			formatter.set_clickable
			if flat then
				formatter.set_feature_clause_order (preferences.flat_short_data.feature_clause_order)
			else
				formatter.set_one_class_only
				formatter.set_order_same_as_text
			end
			if short then
				formatter.set_is_short
			end
			formatter.format (class_c, a_text_formatter)
		end

feature -- Routines

	append_general_info (text: TEXT_FORMATTER; class_i: CLASS_I) is
			-- Append "General" item for class charts.
		local
			creators: HASH_TABLE [EXPORT_I, STRING]
			s: STRING
			class_c: CLASS_C
			l_external_class: EXTERNAL_CLASS_I
		do
			class_c := class_i.compiled_class
			text.process_keyword_text ("General", Void)
			text.add_new_line
			if class_c.is_obsolete then
				append_info_item (text, "obsolete")
				add_string_multilined (text, "%"" + class_c.obsolete_message + "%"")
				text.add_new_line
			end
			if class_i.is_external_class then
				l_external_class ?= class_i
				append_info_item (text, "dotnet name")
				text.process_string_text (l_external_class.dotnet_name, Void)
				text.add_new_line
			end
			s := type_of_group (class_i.group)
			append_info_item (text, s.as_lower)
			text.process_cluster_name_text (class_i.group.name, class_i.group, false)
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

	append_class_constraints (text: TEXT_FORMATTER; class_c: CLASS_C) is
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
					text.process_keyword_text ("Constraints", Void)
					text.add_new_line
					from
						invariants.start
					until
						invariants.after
					loop
						if invariants.item.tag /= Void then
							s := invariants.item.tag.name
						end
						if s /= Void and then not s.is_empty then
							s := s.twin
							s.replace_substring_all ("_", " ")
							text.add_indent
							text.process_assertion_tag_text (s)
							text.add_new_line
						end
						invariants.forth
					end
					text.add_new_line
				end
			end
		end

	append_creators (text: TEXT_FORMATTER; class_c: CLASS_C) is
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
					text.process_symbol_text (ti_Comma)
					text.add_space
				end
			end
		end

	append_cluster_list (text: TEXT_FORMATTER; cluster_list: DS_ARRAYED_LIST [CONF_GROUP]) is
		local
			l_cluster: CONF_GROUP
		do
			from
				cluster_list.start
			until
				cluster_list.after
			loop
				text.add_indent
				l_cluster := cluster_list.item_for_iteration
				text.process_cluster_name_text (group_name_presentation (".", "", l_cluster), l_cluster, false)
				text.add_new_line
				cluster_list.forth
			end
		end

	append_feature_list (text: TEXT_FORMATTER; f_list: LINEAR [E_FEATURE]) is
			-- Append list of feature with signatures to `ctxt'.
		local
			f: E_FEATURE
			t: STRING
		do
			from
				f_list.start
			until
				f_list.after
			loop
				f := f_list.item
				t := feature_tooltip (f)
				text.add_indent
				text.process_tooltip_item (t, true)
				f.append_signature (text)
				text.process_tooltip_item (t, false)

				if current_class /= f.written_class then
					text.process_filter_item (f_Origin_comment, true)
					text.add_comment_text (" -- (from " + f.written_class.name_in_upper + ")")
					text.process_filter_item (f_Origin_comment, false)
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
			anc := f.written_feature
			if anc /= Void then
				real_name := anc.name
			else
				real_name := f.name
			end
			wc := f.written_class
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

	append_class_list (text: TEXT_FORMATTER; class_list: DS_ARRAYED_LIST [CONF_CLASS]; desc: BOOLEAN) is
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
				ci ?= class_list.item_for_iteration
				check
					ci_not_void: ci /= Void
				end
				text.add_indent
				ci.compiled_class.append_signature (text, True)
				text.add_new_line
				if desc then
					s := indexing_item_as_string (ci, "description")
					if s /= Void then
						s := s.twin
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

	append_cluster_hierarchy_leaf (text: TEXT_FORMATTER; du: DOCUMENTATION_UNIVERSE; a_group: CONF_GROUP; indent: INTEGER) is
		local
			n: INTEGER
			subs: DS_ARRAYED_LIST [CONF_CLUSTER]
		do
			from n := 1 until n > indent loop
				text.add_indent
				n := n + 1
			end
			if du.is_group_generated (a_group) then
			 	text.process_cluster_name_text (a_group.name, a_group, false)
			else
				text.process_basic_text (a_group.name)
			end
			text.add_new_line
			subs := subclusters_of_group (a_group)
			if subs /= Void then
				from subs.start until subs.after loop
					append_cluster_hierarchy_leaf (text, du, subs.item_for_iteration, indent + 1)
					subs.forth
				end
			end
		end

	add_string_multilined (text: TEXT_FORMATTER; s: STRING) is
			-- Append `s' to `text' using the multilined formatting.
		local
			sb: STRING
			n, ind: INTEGER
		do
			if s.substring_index ("%%N", 1) > 0 then
					-- Format on a new line, breaking at every newline.
					-- Indent `ind' times.
					-- Prune all '%' and special characters.
				ind := 2
				text.add_new_line
				text.add_indents (ind)
				s.replace_substring_all ("%%T", "")
				s.replace_substring_all ("%%R", "")
				n := s.substring_index ("%%N", 1)
				text.add_indexing_string (s.substring (1, n - 1))
				text.add_new_line
				text.add_indents (ind)
				s.remove_head (n + 1)
				from
					n := s.substring_index ("%%N", 1)
				until
					n = 0
				loop
					if n = 0 then
						n := s.count
					else
						n := n + 1
					end
					sb := s.substring (1, n - 2)
					s.remove_head (n)
					text.add_indexing_string (sb)
					text.add_new_line
					text.add_indents (ind)
					n := s.substring_index ("%%N", 1)
				end
				text.add_indexing_string (s)
			else
				text.add_indexing_string (s)
			end
		end

	append_info_item (text: TEXT_FORMATTER; tag: STRING) is
			-- Append `tag': `content' to `text'.
		do
			text.add_indent
			text.process_indexing_tag_text (tag)
			text.process_symbol_text (ti_Colon)
			text.add_space
		end

	append_feature_chart_item (text: TEXT_FORMATTER; fl: LIST [E_FEATURE]; a_title: STRING) is
			-- Append class ancestors for `class_c' to `text'.
		do
			if not fl.is_empty then
				text.process_keyword_text (a_title, Void)
				text.add_new_line
				append_feature_list (text, fl)
				text.add_new_line
			end
		end

	append_comment (text: TEXT_FORMATTER; comment: STRING) is
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
				text.add_comment_text (ti_Dashdash)
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

	html_meta_for_class (a_class: CONF_CLASS): STRING is
			-- Generate string with list of HTML META tags
			-- describing the indexing clause of `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_class_i: CLASS_I
		do
			l_class_i ?= a_class
			check
				l_class_i /= Void and then l_class_i.is_compiled
			end
			Result := indexes_to_html_meta (l_class_i.compiled_class.ast.top_indexes, "Eiffel class")
			Result.append (indexes_to_html_meta (l_class_i.compiled_class.ast.bottom_indexes, "Eiffel class"))
		end

	html_meta_for_cluster (cluster_i: CONF_GROUP): STRING is
			-- Generate strings of HTML meta data.
		require
			cluster_i_not_void: cluster_i /= Void
		do
			Result := indexes_to_html_meta_group (cluster_i, "Eiffel cluster")
		end

	html_meta_for_system: STRING is
			-- Generate strings of HTML meta data.
		do
			Result := indexing_tuple_to_string ("keywords", "Eiffel system")
		end

	indexes_to_html_meta_group (a_group: CONF_GROUP; added_keywords: STRING): STRING is
			-- Convert `a_group' to a big string of HTML meta data.
		local
			content, t: STRING
			exc: like excluded_indexing_items
			l_library: CONF_LIBRARY
			l_description: STRING
		do
			create Result.make (20)
			exc := excluded_indexing_items

			if a_group.is_library then
				l_library ?= a_group
				check l_library /= Void end
				if l_library.classes_set then
					l_description := l_library.library_target.description
				end
			end
			if l_description = Void then
				l_description := a_group.description
			end
			if l_description /= Void then
				t := "description"
				content := l_description
				content.replace_substring_all ("%%N", " ")
				content.prune_all ('%%')
				content.prune_all ('"')
				Result.append (indexing_tuple_to_string (t, content))
			end

			if a_group.target.version /= Void and then a_group.target.version.copyright /= Void then
				t := "copyright"
				content := a_group.target.version.copyright
				content.replace_substring_all ("%%N", " ")
				content.prune_all ('%%')
				content.prune_all ('"')
				Result.append (indexing_tuple_to_string (t, content))
			end

			if not exc.has ("keywords") and added_keywords /= Void then
				Result.append (indexing_tuple_to_string ("keywords", added_keywords))
			end
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
				exc.start
			until
				exc.after
			loop
				ic.remove (exc.item)
				exc.forth
			end
			from
				ic.start
			until
				ic.after
			loop
				t := ic.key_for_iteration
				content := ic.item_for_iteration.twin
				content.replace_substring_all ("%%N", " ")
				content.prune_all ('%%')
				content.prune_all ('"')
				if t.is_equal ("keywords") and added_keywords /= Void then
					content.prepend (", ")
					content.prepend (added_keywords)
				end
				Result.append (indexing_tuple_to_string (t, content))
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
					if ii.tag /= Void then
						t := ii.tag.name
					end
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
			if ic.has_key (s) then
				Result := ic.found_item
			end
			if Result = Void then
				ic := indexes_to_table (c.compiled_class.ast.bottom_indexes)
				if ic.has_key (s) then
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
				if t.has_associated_class then
					return_class := t.associated_class
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
			cl := Eiffel_system.Universe.compiled_classes_with_name ("ACTION_SEQUENCE")
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

feature  -- Menu bars

	insert_global_menu_bar (text: TEXT_FORMATTER; d, l, h: BOOLEAN) is
			-- Append a menu bar to `text'.
		deferred
		end

	insert_class_menu_bar (text: TEXT_FORMATTER; class_name: STRING) is
			-- Append a menu bar to `text'.
		deferred
		end

feature {NONE} -- Implementation

	type_of_group (a_group: CONF_GROUP): STRING is
			-- String representation of type of `a_group'
		require
			a_group_not_void: a_group /= Void
		do
			if a_group.is_library then
				Result := "Library"
			elseif a_group.is_assembly or a_group.is_physical_assembly then
				Result := "Assembly"
			else
				Result := "Cluster"
			end
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class DOCUMENTATION_ROUTINES
