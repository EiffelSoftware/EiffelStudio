indexing
	description: "[
		A help context scavenger used to probe the Eiffel editor {EB_SMART_EDITOR} for help context information.
		For more information on help context scavengers see {ES_HELP_CONTEXT_SCAVENGER}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_EDITOR_HELP_CONTEXT_SCAVENGER

inherit
	ES_HELP_CONTEXT_SCAVENGER [!EB_SMART_EDITOR]
		redefine
			reset
		end

feature {NONE} -- Access

	context_class: ?CLASS_I
			-- A help context class

	context_class_name: ?STRING_8
			-- A help context class name.
			-- Note: This is the "live" class name from the editor which may differ
			--       from the actual compiled class name

	context_feature_name: ?STRING_8
			-- A help context feature name.
			-- Note: This is the "live" feature name from the editor which may differ
			--       from the actual compiled class' feature name

	context_variables: !DS_HASH_TABLE [!STRING_8, !STRING_8]
			-- A table of context variables, indexed by a variable name
		do
			create Result.make_default

			if {l_class: !CLASS_I} context_class then
					-- Add class, target and project related variables.

				if {l_target_name: !STRING_8} l_class.target.name then
					Result.force (l_target_name, target_name_var_name)
				end
					-- TODO, when implemented scan through target and library to locate help tags
					-- and keywords to create target.keyword
			end

			if {l_class_name: !STRING_8} context_class_name then
				Result.force (l_class_name, class_name_var_name)
			end
			if {l_feature_name: !STRING_8} context_feature_name then
				Result.force (l_feature_name, feature_name_var_name)
			end
		end

	help_uri_parser: !ES_HELP_URI_PARSER
			-- Help URI parser for converting a editor help URI into a {HELP_CONTEXT_I}
		once
			create Result
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := True
		end

feature {NONE} -- Query

	uris_for_indexing_clause (a_clause: !INDEXING_CLAUSE_AS): !DS_ARRAYED_LIST [!STRING_8] is
			-- Attempts to retrieve help URIs from an indexing clause.
			--
			-- `a_clause': The indexing clauses to look for help URIs in.
			-- `Result': A list of help URIs located in the indexing clause, or empty if none were located.
		require
			is_interface_usable: is_interface_usable
		local
			l_cursor, l_sub_cursor: INTEGER
			l_index: INDEX_AS
			l_list: EIFFEL_LIST [ATOMIC_AS]
		do
			create Result.make_default

			l_cursor := a_clause.index
			from a_clause.start until a_clause.after loop
				l_index := a_clause.item
				if l_index.tag.name.is_case_insensitive_equal (help_indexing_tag) then
					l_list := l_index.index_list
					if l_list /= Void then
							-- Add all documents
						l_sub_cursor := l_list.index
						from l_list.start until l_list.after loop
							if {l_value: !STRING_8} l_list.item.string_value then
									-- Strip quotation marks from URI
								l_value.prune_all_leading ('"')
								l_value.prune_all_trailing ('"')
								Result.force_last (l_value)
							end
							l_list.forth
						end
						l_list.go_i_th (l_cursor)
					end
				end
				a_clause.forth
			end
			a_clause.go_i_th (l_cursor)
		ensure
			result_contains_valid_items: Result.for_all (agent (a_ia_item: !STRING_8): BOOLEAN do Result := not a_ia_item.is_empty end)
			a_clause_unmovde: a_clause.index = old a_clause.index
		end

feature {NONE} -- Basic operations

	reset
			-- Sets Current to clear any previously probed cached data.
		do
			Precursor {ES_HELP_CONTEXT_SCAVENGER}
			context_class := Void
			context_class_name := Void
			context_feature_name := Void
		ensure then
			context_class_detached: context_class = Void
			context_class_name_detached: context_class_name = Void
			context_feature_name_detached: context_feature_name = Void
		end

	probe_object (a_object: !EB_SMART_EDITOR): !DS_ARRAYED_LIST [!HELP_CONTEXT_I] is
			-- Probes an object to locate and scavenge any help context information to be used with a help provider.
			--
			-- `a_object': Object to probe to scavenge help contexts
			-- `Result': The list of scavanged help contexts.
		local
			l_try_class: BOOLEAN
			l_text: STRING_8
			l_parser: like create_eiffel_parser
		do
			create Result.make_default
			if {l_stone: !CLASSI_STONE} a_object.stone then

					-- Set context class
				context_class := l_stone.class_i

				l_parser := create_eiffel_parser

					-- Only classes
				l_try_class := True
				if a_object.text_is_fully_loaded then
					l_text := a_object.text
					if l_text /= Void and then not l_text.is_empty then
							-- Parse editor text
						l_parser.parse_from_string (l_text)
						if not l_parser.syntax_error and then {l_class_as: !CLASS_AS} l_parser.root_node then
							probe_ast (l_class_as, a_object.cursor_y_position.max (1), Result)
								-- No need to resort to using a class stone
							l_try_class := False
						end
					end
				end

				if l_try_class then
						-- Unable to parse editor class text, try the text from a (un)compiled class.
					if {l_class_i: !CLASS_I} l_stone.class_i then
						if (create {RAW_FILE}.make (l_stone.file_name)).exists then
								-- If the file exist parse the stored file
							l_parser.parse_from_string (l_stone.origin_text)
							if not l_parser.syntax_error and then {l_class_as2: !CLASS_AS} l_parser.root_node then
								probe_ast (l_class_as2, a_object.cursor_y_position.max (1), Result)
							end
						end
					end
				end
			end
		end

	probe_ast (a_ast: !CLASS_AS; a_line: INTEGER; a_results: !DS_ARRAYED_LIST [!HELP_CONTEXT_I]) is
			-- Probes an AST root node to locate and scavenge any help context information to be used with a help provider.
			--
			-- `a_ast': An abstract syntax root node to probe for help contexts.
			-- `a_line': A contextual line number to use to order help contexts based on applicability.
			-- `a_results': The list of scavanged help contexts.
		require
			a_line_positive: a_line > 0
		local
			l_indexing: ?INDEXING_CLAUSE_AS
			l_indexing_first: ?INDEXING_CLAUSE_AS
			l_indexing_second: ?INDEXING_CLAUSE_AS
			l_indexing_clauses: !DS_ARRAYED_LIST [INDEXING_CLAUSE_AS]
			l_feature_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_features: EIFFEL_LIST [FEATURE_AS]
			l_feature: FEATURE_AS
			l_feature_name: ?STRING_8
			l_all_uris: !DS_ARRAYED_LIST [!STRING_8]
			l_uri_parser: like help_uri_parser
		do
			create l_indexing_clauses.make_default

				-- Set context class name (we used parsed class name as it may have changed in source text)
			context_class_name := a_ast.class_name.name

				-- Iterate through all feature clauses and all features to find the feature where the caret is placed.
			l_feature_clauses := a_ast.features
			if l_feature_clauses /= Void and then not l_feature_clauses.is_empty then
				from l_feature_clauses.start until l_feature_clauses.after or l_feature_name /= Void loop
					l_features := l_feature_clauses.item.features
					if l_features /= Void and then not l_features.is_empty then
						from l_features.start until l_features.after or l_feature_name /= Void loop
							l_feature := l_features.item
							if a_line >= l_feature.start_location.line  and then a_line <= l_feature.end_location.line then
									-- Set feature name, for URI replacement
								l_feature_name := l_feature.feature_name.name
								l_indexing := l_feature.indexes
								if l_indexing /= Void then
									l_indexing_clauses.force_last (l_indexing)
								end
							end
							l_features.forth
						end
					end
					l_feature_clauses.forth
				end
			end

				-- Set context feature name
			context_feature_name := l_feature_name

				-- Add top and bottom class indexing clauses in order of most applicable.
			l_indexing_first := a_ast.bottom_indexes
			if l_indexing_first /= Void and then a_line >= l_indexing_first.start_location.line then
				l_indexing_clauses.force_last (l_indexing_first)
				l_indexing_second := a_ast.top_indexes
			else
				l_indexing_second := a_ast.top_indexes
				if l_indexing_second /= Void then
					l_indexing_clauses.force_last (l_indexing_second)
				end
				if l_indexing_first /= Void then
					l_indexing_clauses.force_last (l_indexing_first)
				end
			end

				-- Iterate indexing clauses an build help contexts
			if not l_indexing_clauses.is_empty then
				create l_all_uris.make_default
				from l_indexing_clauses.start until l_indexing_clauses.after loop
					if {l_clause: !INDEXING_CLAUSE_AS} l_indexing_clauses.item_for_iteration then
						l_all_uris.append_last (uris_for_indexing_clause (l_clause))
					end
					l_indexing_clauses.forth
				end

				if not l_all_uris.is_empty then
						-- Format all URIs swapping variables for values
					if {l_uris: !DS_BILINEAR [!STRING_8]} l_all_uris then
						format_uris (l_uris)
						from l_all_uris.start until l_all_uris.after loop
							if l_all_uris.item_for_iteration.is_empty then
									-- Remove empty URIs as nothing can be done with them.
								l_all_uris.remove_at
							else
								l_all_uris.forth
							end
						end
					end

					l_uri_parser := help_uri_parser
					from l_all_uris.start until l_all_uris.after loop
						if {l_context: !HELP_CONTEXT_I} l_uri_parser.parse_help_uri (l_all_uris.item_for_iteration) then
								-- Add help context
							a_results.force_last (l_context)
						end
						l_all_uris.forth
					end
				end
			end
		end

feature {NONE} -- Formatting

	format_uris (a_uris: !DS_BILINEAR [!STRING_8])
			-- Formates a list of URIs and expands any variables
			--
			-- `a_uris': List of URIs to format.
		require
			a_uris_contains_valid_items: a_uris.for_all (agent (a_ia_item: !STRING_8): BOOLEAN do Result := not a_ia_item.is_empty end)
		local
			l_context_vars: like context_variables
			l_uri: !STRING_8
			l_new_uri: !STRING_8
			l_vars: like uri_variables
			l_var: TUPLE [var: !STRING_8; start_i, end_i: INTEGER]
			l_start_i, l_end_i: INTEGER
			l_scanner_regex: like variable_scanner_regex
			l_extractor_regex: like variable_extractor_regex
		do
			if {l_cursor: !DS_BILINEAR_CURSOR [!STRING_8]} a_uris.new_cursor then
				l_scanner_regex := variable_scanner_regex
				l_extractor_regex := variable_extractor_regex

					-- Retrieve variables for class Current state.
				l_context_vars := context_variables
				from l_cursor.start until l_cursor.after loop
					l_uri := l_cursor.item

					l_vars := uri_variables (l_uri, l_scanner_regex, l_extractor_regex)
					if l_vars /= Void and then not l_vars.is_empty then
							-- Maek variable replacements.
						create l_new_uri.make (l_uri.count)

						l_start_i := 1
						l_end_i := l_vars.first.start_i - 1
						from
							l_vars.start
							l_var := l_vars.item_for_iteration
						until
							l_vars.after or
							l_start_i > l_uri.count
						loop
							if l_start_i <= l_end_i then
									-- Append leading text
								l_new_uri.append (l_uri.substring (l_start_i, l_end_i))
							end

							if l_context_vars.has (l_var.var) then
									-- Append variable value
								l_new_uri.append (l_context_vars.item (l_var.var))
							end

								-- Make position text adjustments
							l_start_i := l_var.end_i + 1
							l_vars.forth
							if not l_vars.after then
								l_var := l_vars.item_for_iteration
								l_end_i := l_var.start_i - 1
							else
								l_end_i := l_uri.count
							end
						end

						if l_start_i <= l_uri.count then
								-- Append trailing text
							l_new_uri.append (l_uri.substring (l_start_i, l_end_i))
						end

							-- Change original URI
						l_uri.wipe_out
						l_uri.append (l_new_uri)
					end

					l_cursor.forth
				end
			end
		end

	uri_variables (a_uri: !STRING_8; a_scanner: !RX_PCRE_MATCHER; a_var_extractor: !RX_PCRE_MATCHER): ?DS_ARRAYED_LIST [TUPLE [var: !STRING_8; start_i, end_i: INTEGER]] is
			-- Extracts variables from a URI and returns a list of variables with the start and end location
			-- in characters.
			--
			-- `a_uri': A URI string containing variable
			-- `a_scanner': An expression to extract tokenized variables.
			-- `a_var_extractor': An expression used to extract the variable name from its tokenized representation
		require
			not_a_uri_is_empty: not a_uri.is_empty
			a_scanner_is_compiled: a_scanner.is_compiled
			a_var_extractor_is_compiled: a_var_extractor.is_compiled
		do
			a_scanner.match (a_uri)
			if a_scanner.has_matched then
				create Result.make_default
				from a_scanner.first_match until not a_scanner.has_matched loop
					if {l_token_var: !STRING_8} a_scanner.captured_substring (1) then
							-- Token variable located
						if not l_token_var.is_empty then
							a_var_extractor.match (l_token_var)
							if a_var_extractor.has_matched then
									-- Variable name extracted
								if {l_var: !STRING_8} a_var_extractor.captured_substring (1) then
									Result.force_last ([l_var, a_scanner.captured_start_position (1), a_scanner.captured_end_position (1)])
								end
							end
						end
					end
					a_scanner.next_match
				end
			end
		ensure
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
			result_contains_valid_items: Result /= Void implies Result.for_all (agent (a_ia_item: TUPLE [var: !STRING_8; start_i, end_i: INTEGER]): BOOLEAN
				do
					Result := not a_ia_item.var.is_empty and a_ia_item.start_i > 0 and a_ia_item.start_i < a_ia_item.end_i
				end)
		end

feature {NONE} -- Factory

	create_eiffel_parser: !EIFFEL_PARSER
			-- Creates a new Eiffel parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_LIGHT_FACTORY})
		end

feature {NONE} -- Regular expression

	variable_scanner_regex: !RX_PCRE_MATCHER
			-- Regular expression to extract tokenized variables from a URI string
		once
			create Result.make
			Result.compile ("(\$[a-zA-Z0-9_-]+|\$\([a-zA-Z0-9_-]+\))")
		ensure
			result_is_compiled: Result.is_compiled
		end

	variable_extractor_regex: !RX_PCRE_MATCHER
			-- Regular expression to extract tokenized variables from a URI string
		once
			create Result.make
			Result.compile ("^\$(.+)$")
		ensure
			result_is_compiled: Result.is_compiled
		end

feature {NONE} -- Constants

	help_indexing_tag: STRING_8 = "doc"
			-- Indexing clause term tag name

	target_var_name: !STRING_8 = "target"
	group_var_name: !STRING_8 = "group"
			-- Variable prefixes for ECF custom variables

	target_name_var_name: !STRING_8 = "target_name"
	group_name_var_name: !STRING_8 = "group_name"
	class_name_var_name: !STRING_8 = "class_name"
	feature_name_var_name: !STRING_8 = "feature_name"
			-- Variable names

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
