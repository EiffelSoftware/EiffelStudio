note
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

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Status setting

	set_excluded_indexing_items (l: like excluded_indexing_items)
			-- Assign `l' to `excluded_indexing_items'.
		do
			excluded_indexing_items := l
		end

feature -- Access

	current_class: CLASS_C
			-- Class currently being processed.

	excluded_indexing_items: LINEAR [STRING_32]
			-- Indexing items not to include in HTML meta clause.

	index_text (a_text_formatter: TEXT_FORMATTER)
			-- Generate documentation index as structured text.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			subs: ARRAYED_LIST [CONF_GROUP]
		do
			a_text_formatter.process_filter_item (f_class_declaration, True)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, True, True)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			append_system_info (a_text_formatter)
			subs := top_level_clusters
			if subs /= Void and then not subs.is_empty then
				a_text_formatter.process_keyword_text ("Top-level clusters", Void)
				a_text_formatter.add_new_line
				append_cluster_list (a_text_formatter, subs)
				a_text_formatter.add_new_line
			end

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, True, True)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_filter_item (f_class_declaration, False)
		end

	class_list_text (du: DOCUMENTATION_UNIVERSE; a_text_formatter: TEXT_FORMATTER)
			-- Generate documentation class list from `du.classes' as structured text.
		require
			du_not_void: du /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			a_text_formatter.process_filter_item (f_class_declaration, True)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, False, True, True)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_keyword_text ("Classes", Void)
			a_text_formatter.add_new_line
			append_class_list (a_text_formatter, du.classes, True)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, False, True, True)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_filter_item (f_class_declaration, False)
		end

	cluster_list_text (du: DOCUMENTATION_UNIVERSE; a_text_formatter:TEXT_FORMATTER)
			-- Generate documentation cluster list from `du.clusters' as structured text.
		require
			du_not_void: du /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			a_text_formatter.process_filter_item (f_class_declaration, True)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, False, True)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_keyword_text ("Clusters", Void)
			a_text_formatter.add_new_line
			append_cluster_list (a_text_formatter, du.groups)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, False, True)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_filter_item (f_class_declaration, False)
		end

	cluster_hierarchy_text (du: DOCUMENTATION_UNIVERSE; a_text_formatter: TEXT_FORMATTER)
			-- Generate documentation cluster hierarchy as structured text.
			-- Do not generate leafs of clusters that are not generated as described by `du'.
			-- Add links to diagrams if `diagrams' is True.
		require
			du_not_void: du /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			group: CONF_GROUP
		do
			a_text_formatter.process_filter_item (f_class_declaration, True)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_keyword_text ("Clusters", Void)
			a_text_formatter.add_new_line
			across
				eiffel_universe.target.groups as gs
			loop
				group := gs.item
				if attached {CONF_CLUSTER} group as l_cluster implies not attached l_cluster.parent then
					append_cluster_hierarchy_leaf (a_text_formatter, du, group, 1)
				end
			end

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_filter_item (f_class_declaration, False)
		end

	group_index_text (
				group: CONF_GROUP;
				class_list: ARRAYED_LIST [CLASS_I];
				diagrams: BOOLEAN; a_text_formatter: TEXT_FORMATTER
			)
			-- Generate documentation group index for `group'.
			-- Add links to diagrams if `diagrams' is True.
		require
			group_not_void: group /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			l_name: STRING_32
			l_group_type: STRING_32
			l_desc: detachable READABLE_STRING_32
		do
			l_group_type := type_of_group (group)
			l_name := group_name_presentation ({STRING_32}".", {STRING_32}"", group)
			a_text_formatter.process_filter_item (f_class_declaration, True)

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_keyword_text (l_group_type, Void)
			a_text_formatter.add_new_line
			a_text_formatter.add_indent
			a_text_formatter.process_cluster_name_text (l_name, group, False)
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
			l_desc := Void
			if
				group.is_library and then
				attached {CONF_LIBRARY} group as l_library and then
				l_library.classes_set
			then
				l_desc := l_library.library_target.description
			else
				l_desc := group.description
			end
			if l_desc /= Void then
				a_text_formatter.add_indexing_string (l_desc)
			end
			a_text_formatter.process_string_text (ti_double_quote, Void)
			a_text_formatter.process_new_line
			if attached group.target.version as l_version and then attached l_version.copyright as l_version_copyright then
				a_text_formatter.add_indent
				a_text_formatter.process_basic_text ("copyright")
				a_text_formatter.process_symbol_text (ti_colon)
				a_text_formatter.process_basic_text (ti_space)
				a_text_formatter.process_string_text (ti_double_quote, Void)
				a_text_formatter.add_indexing_string (l_version_copyright)
				a_text_formatter.process_string_text (ti_double_quote, Void)
				a_text_formatter.process_new_line
			end

			a_text_formatter.process_new_line

			if
				group.is_cluster and then attached {CONF_CLUSTER} group as l_cluster and then
				attached l_cluster.parent as l_cluster_parent
			then
				a_text_formatter.process_keyword_text ("Supercluster", Void)
				a_text_formatter.add_new_line
				a_text_formatter.add_indent
				a_text_formatter.process_cluster_name_text (group_name_presentation ({STRING_32}".", {STRING_32}"", l_cluster_parent), l_cluster_parent, False)
				a_text_formatter.add_new_line
				a_text_formatter.add_new_line
			end

			if
				attached subclusters_of_group (group) as subs and then
				not subs.is_empty
			then
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

			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_global_menu_bar (a_text_formatter, True, True, False)
			a_text_formatter.process_filter_item (f_menu_bar, False)

			a_text_formatter.process_filter_item (f_class_declaration, False)
		end

	class_chart_text (class_c: CLASS_C; a_text_formatter: TEXT_FORMATTER)
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
			a_text_formatter.process_filter_item (f_class_declaration, True)
			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_class_menu_bar (a_text_formatter, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (class_c.name).as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, False)
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
			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_class_menu_bar (a_text_formatter, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (class_c.name).as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, False)
			a_text_formatter.process_filter_item (f_class_declaration, False)
			current_class := Void
		end

	class_relations_text (class_c: CLASS_C; a_text_formatter: TEXT_FORMATTER)
			-- Generate documentation class relations for `class_c' as structured text.
		require
			class_c_not_void: class_c /= Void
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			a_text_formatter.process_filter_item (f_class_declaration, True)
			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_class_menu_bar (a_text_formatter, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (class_c.name).as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, False)
			class_c.append_header (a_text_formatter)
			a_text_formatter.add_new_line
			append_class_ancestors (a_text_formatter, class_c)
			append_class_descendants (a_text_formatter, class_c)
			append_class_clients (a_text_formatter, class_c)
			append_class_suppliers (a_text_formatter, class_c)
			a_text_formatter.process_filter_item (f_menu_bar, True)
			insert_class_menu_bar (a_text_formatter, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (class_c.name).as_lower)
			a_text_formatter.process_filter_item (f_menu_bar, False)
			a_text_formatter.process_filter_item (f_class_declaration, False)
		end

	class_text (class_c: CLASS_C; flat, short: BOOLEAN; a_text_formatter: TEXT_FORMATTER)
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

	append_general_info (text: TEXT_FORMATTER; class_i: CLASS_I)
			-- Append "General" item for class charts.
		local
			s: STRING_32
			class_c: CLASS_C
			l_group: CONF_GROUP
		do
			class_c := class_i.compiled_class
			text.process_keyword_text ("General", Void)
			text.add_new_line
			if class_c.is_obsolete then
				append_info_item (text, "obsolete")
				add_string_multilined (text, "%"" + class_c.obsolete_message + "%"")
				text.add_new_line
			end
			if attached {EXTERNAL_CLASS_I} class_i as l_external_class then
				append_info_item (text, "dotnet name")
				text.process_string_text (l_external_class.dotnet_name, Void)
				text.add_new_line
			end
			l_group := class_i.group
			s := type_of_group (l_group)
			append_info_item (text, s.as_lower)
			text.process_cluster_name_text (l_group.name, l_group, False)
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
			if attached class_c.creators as cs and then not cs.is_empty then
				append_info_item (text, "create")
				append_creators (text, class_c)
				text.add_new_line
			end
			text.add_new_line
		end

	append_class_constraints (text: TEXT_FORMATTER; class_c: CLASS_C)
			-- Append to `text', all invariant tags.
		local
			ast: INVARIANT_AS
			invariants: EIFFEL_LIST [TAGGED_AS]
			s: STRING_32
		do
			ast := class_c.invariant_ast
			if ast /= Void then
				invariants := ast.assertion_list
				if attached ast.assertion_list as l_assertion_list and then not l_assertion_list.is_empty then
					text.process_keyword_text ("Constraints", Void)
					text.add_new_line
					from
						invariants.start
					until
						invariants.after
					loop
						if attached invariants.item.tag as l_tag then
							s := l_tag.name_32
						end
						if s /= Void and then not s.is_empty then
							create s.make_from_string (s)
							s.replace_substring_all ({STRING_32} "_", {STRING_32} " ")
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

	append_creators (text: TEXT_FORMATTER; class_c: CLASS_C)
			-- Append creators list.
		local
			f: E_FEATURE
		do
			if attached class_c.creators as cs then
				across
					cs as c
				loop
					f := class_c.feature_with_name_id (c.key)
					text.add_feature (f, f.name_32)
					if not c.is_last then
						text.process_symbol_text (ti_Comma)
						text.add_space
					end
				end
			end
		end

	append_cluster_list (text: TEXT_FORMATTER; cluster_list: ARRAYED_LIST [CONF_GROUP])
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
				text.process_cluster_name_text (group_name_presentation (".", "", l_cluster), l_cluster, False)
				text.add_new_line
				cluster_list.forth
			end
		end

	append_feature_list (text: TEXT_FORMATTER; f_list: LINEAR [E_FEATURE])
			-- Append list of feature with signatures to `ctxt'.
		local
			f: E_FEATURE
			t: STRING_32
			wc: CLASS_C
		do
			from
				f_list.start
			until
				f_list.after
			loop
				f := f_list.item
				t := feature_tooltip (f)
				text.add_indent
				text.process_tooltip_item (t, True)
				f.append_signature (text)
				text.process_tooltip_item (t, False)
				wc := f.written_class

				if current_class /= wc then
					text.process_filter_item (f_Origin_comment, True)
					text.add_comment_text (" -- (from " + wc.name_in_upper + ")")
					text.process_filter_item (f_Origin_comment, False)
				end

				text.add_new_line

				f_list.forth
			end
		end

	feature_tooltip (f: E_FEATURE): STRING_32
			-- Get a descriptive comment on the origin of `f'.
		local
			wc: CLASS_C
			real_name: STRING_32
		do
			create Result.make (20)
			Result.append_character ({CHARACTER_32}'`')
			Result.append (f.name_32)
			Result.append_character ({CHARACTER_32}'%'')
			Result.append_character ({CHARACTER_32}' ')
			if attached f.written_feature as anc then
				real_name := anc.name_32
			else
				real_name := f.name_32
			end
			wc := f.written_class
			if wc = current_class then
				Result.append_string_general ("is declared in `Current'")
			else
				Result.append ({STRING_32}"was declared in ")
				Result.append_string_general (wc.name_in_upper)
				if not real_name.same_string (f.name_32) then
					Result.append_string_general (" as `")
					Result.append (real_name)
					Result.append_character ({CHARACTER_32}'%'')
				end
			end
		end

feature {NONE} -- Implementation

	append_class_list (text: TEXT_FORMATTER; class_list: ARRAYED_LIST [CLASS_I]; desc: BOOLEAN)
			-- Append to `ctxt.text', formatted `class_list'.
			-- Depending on `desc', include descriptions.
		local
			s: detachable STRING_32
			ci: CLASS_I
		do
			across
				class_list as c
			loop
				ci := c.item
				text.add_indent
				ci.compiled_class.append_signature (text, True)
				text.add_new_line
				if desc then
					s := indexing_item_as_string (ci, "description")
					if s /= Void then
						create s.make_from_string (s)
						s.remove (1)
						s.remove (s.count)
						s.replace_substring_all ({STRING_32} "%%T", {STRING_32} "")
						s.replace_substring_all ({STRING_32} "%%R", {STRING_32} "")
						s.replace_substring_all ({STRING_32} "%%%'", {STRING_32} "%'")
						s.replace_substring_all ({STRING_32} "%%%"", {STRING_32} "%"")
						append_comment (text, s)
					end
					text.add_new_line
				end
			end
		end

	append_cluster_hierarchy_leaf (text: TEXT_FORMATTER; du: DOCUMENTATION_UNIVERSE; a_group: CONF_GROUP; indent: INTEGER)
		local
			n: INTEGER
		do
			from n := 1 until n > indent loop
				text.add_indent
				n := n + 1
			end
			if du.is_group_generated (a_group) then
			 	text.process_cluster_name_text (a_group.name, a_group, False)
			else
				text.process_basic_text (a_group.name)
			end
			text.add_new_line
			if attached subclusters_of_group (a_group) as subs then
				from subs.start until subs.after loop
					append_cluster_hierarchy_leaf (text, du, subs.item_for_iteration, indent + 1)
					subs.forth
				end
			end
		end

	add_string_multilined (text: TEXT_FORMATTER; s: STRING_32)
			-- Append `s' to `text' using the multilined formatting.
		local
			sb: STRING_32
			n, ind: INTEGER
		do
			if s.substring_index ("%%N", 1) > 0 then
					-- Format on a new line, breaking at every newline.
					-- Indent `ind' times.
					-- Prune all '%' and special characters.
				ind := 2
				text.add_new_line
				text.add_indents (ind)
				s.replace_substring_all ({STRING_32} "%%T", {STRING_32} "")
				s.replace_substring_all ({STRING_32} "%%R", {STRING_32} "")
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

	append_info_item (text: TEXT_FORMATTER; tag: STRING_32)
			-- Append `tag': `content' to `text'.
		do
			text.add_indent
			text.process_indexing_tag_text (tag)
			text.process_symbol_text (ti_Colon)
			text.add_space
		end

	append_feature_chart_item (text: TEXT_FORMATTER; fl: LIST [E_FEATURE]; a_title: STRING_32)
			-- Append class ancestors for `class_c' to `text'.
		do
			if not fl.is_empty then
				text.process_keyword_text (a_title, Void)
				text.add_new_line
				append_feature_list (text, fl)
				text.add_new_line
			end
		end

	append_comment (text: TEXT_FORMATTER; comment: STRING_32)
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
					text.add_comment_text ({STRING_32} " " + comment.substring (prev, n - 1))
					prev := n + 2
				else
					text.add_comment_text ({STRING_32} " " + comment.substring (prev, comment.count))
				end
				text.add_new_line
			end
		end

feature {NONE} -- Indexing clauses

	html_meta_for_class (a_class: CLASS_I): STRING_32
			-- Generate string with list of HTML META tags
			-- describing the indexing clause of `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_class_is_compiled: a_class.is_compiled
		local
			cl: CLASS_C
		do
			cl := a_class.compiled_class
			Result := indexes_to_html_meta (cl.ast.top_indexes, "Eiffel class")
			Result.append (indexes_to_html_meta (cl.ast.bottom_indexes, "Eiffel class"))
		end

	html_meta_for_cluster (cluster_i: CONF_GROUP): STRING_32
			-- Generate strings of HTML meta data.
		require
			cluster_i_not_void: cluster_i /= Void
		do
			Result := indexes_to_html_meta_group (cluster_i, "Eiffel cluster")
		end

	html_meta_for_system: STRING_32
			-- Generate strings of HTML meta data.
		do
			Result := indexing_tuple_to_string ("keywords", "Eiffel system")
		end

	indexes_to_html_meta_group (a_group: CONF_GROUP; added_keywords: STRING_32): STRING_32
			-- Convert `a_group' to a big string of HTML meta data.
		local
			content, t: STRING_32
			exc: like excluded_indexing_items
			l_description: detachable READABLE_STRING_32
		do
			create Result.make (20)
			exc := excluded_indexing_items

			if
				a_group.is_library and then
				attached {CONF_LIBRARY} a_group as l_library and then
				l_library.classes_set
			then
				l_description := l_library.library_target.description
			end
			if l_description = Void then
				l_description := a_group.description
			end
			if l_description /= Void then
				t := "description"
				content := l_description
				content.replace_substring_all ({STRING_32} "%%N", {STRING_32} " ")
				content.prune_all ('%%')
				content.prune_all ('"')
				Result.append (indexing_tuple_to_string (t, content))
			end

			if attached a_group.target.version as l_version and then attached l_version.copyright as l_version_copyright then
				t := "copyright"
				create content.make_from_string_general (l_version_copyright)
				content.replace_substring_all ({STRING_32} "%%N", {STRING_32} " ")
				content.prune_all ('%%')
				content.prune_all ('"')
				Result.append (indexing_tuple_to_string (t, content))
			end

			if not exc.has ({STRING_32} "keywords") and added_keywords /= Void then
				Result.append (indexing_tuple_to_string ("keywords", added_keywords))
			end
		end

	indexes_to_html_meta (indexes: EIFFEL_LIST [INDEX_AS]; added_keywords: STRING_32): STRING_32
			-- Convert `indexes' to a big string of HTML meta data.
		local
			content, t: STRING_32
			ic: HASH_TABLE [STRING_32, STRING_32]
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
				content.replace_substring_all ({STRING_32} "%%N", {STRING_32} " ")
				content.prune_all ('%%')
				content.prune_all ('"')
				if t.same_string_general ("keywords") and added_keywords /= Void then
					content.prepend_string_general (", ")
					content.prepend (added_keywords)
				end
				Result.append (indexing_tuple_to_string (t, content))
				ic.forth
			end
			if not ic.has ({STRING_32} "keywords") and not exc.has ({STRING_32} "keywords") and added_keywords /= Void then
				Result.append (indexing_tuple_to_string ("keywords", added_keywords))
			end
		end

	indexing_tuple_to_string (tag, content: STRING_32): STRING_32
			-- Create HTML meta string.
		do
			create Result.make (20)
			Result.append_string_general ("<meta name=%"")
			Result.append (tag)
			Result.append_string_general ("%" content=%"")
			Result.append (content)
			Result.append_string_general ("%"/>%N")
		end

	indexes_to_table (indexes: detachable EIFFEL_LIST [INDEX_AS]): HASH_TABLE [STRING_32, STRING_32]
			-- Table of [content, tag].
		local
			t: STRING_32
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
					if attached ii.tag as l_tag then
						t := l_tag.name_32
					end
					if t = Void then
						t := {STRING_32} "description"
							-- It is legal Eiffel syntax to omit first tag
							-- of the indexing clause.
							-- We will assume this is the description clause.
					end
					Result.put (ii.content_as_string_32, t)
					indexes.forth
				end
			end
		end

	indexing_item_as_string (c: CLASS_I; s: STRING_32): STRING_32
		local
			ic: HASH_TABLE [STRING_32, STRING_32]
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

	safe_conforms_to (f: E_FEATURE; conf: CLASS_C): BOOLEAN
			-- Is the return type of `f' a descendant of `conf'?
			-- `f' may be any feature. Returns `False' if not a function.
		require
			f_not_void: f /= Void
		do
			Result :=
				attached f.type as t and then
				t.has_associated_class and then
				attached t.base_class as return_class and then
				attached conf and then
				return_class.conform_to (conf)
		end

	Action_sequence_class: CLASS_C
			-- Compiled class ACTION_SEQUENCE.
		do
			if attached Eiffel_system.Universe.compiled_classes_with_name ("ACTION_SEQUENCE") as cl and then not cl.is_empty then
				Result := cl.first.compiled_class
			end
		end

	Any_class: CLASS_C
			-- Compiled class ANY.
		once
			Result := Eiffel_system.any_class.compiled_class
		end

	display_feature (f: E_FEATURE; class_c: CLASS_C): BOOLEAN
			-- Should feature be included in feature list for `class_c'?
		do
			Result :=
				f.is_exported_to (Any_class)
				and then (class_c = Any_class or else f.written_class /= Any_class)
				and then not f.is_obsolete
		end

feature  -- Menu bars

	insert_global_menu_bar (text: TEXT_FORMATTER; d, l, h: BOOLEAN)
			-- Append a menu bar to `text'.
		deferred
		end

	insert_class_menu_bar (text: TEXT_FORMATTER; class_name: STRING_32)
			-- Append a menu bar to `text'.
		deferred
		end

feature {NONE} -- Implementation

	type_of_group (a_group: CONF_GROUP): STRING_32
			-- String representation of type of `a_group'
		require
			a_group_not_void: a_group /= Void
		do
			if a_group.is_library then
				Result := {STRING_32} "Library"
			elseif a_group.is_assembly or a_group.is_physical_assembly then
				Result := {STRING_32} "Assembly"
			else
				Result := {STRING_32} "Cluster"
			end
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
