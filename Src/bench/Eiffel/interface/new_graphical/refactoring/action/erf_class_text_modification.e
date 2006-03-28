indexing
	description: "This allows undoable modification of a class text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CLASS_TEXT_MODIFICATION

inherit
	ERF_TEXT_MODIFICATION
		redefine
			load_text,
			save_text,
			discard_text
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	EB_SAVE_FILE
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_SERVER
		export
			{NONE} all
		end

	ERF_SHARED_LOGGER

	CONF_REFACTORING

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I) is
			-- Create modification associated with `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_class_writable: not a_class.is_read_only
		do
			class_i := a_class
		end

feature -- Status

	is_parsing: BOOLEAN
			-- Will the class be parsed if it isn't compiled?

	is_parse_error: BOOLEAN
			-- Was there a parse error?

	is_parsed: BOOLEAN is
			-- Is the AST available?
		do
			Result := ast /= Void and match_list /= Void
		end

feature -- Status change

	enable_parsing is
			-- Enable parsing of non compiled classes.
		do
			is_parsing := True
		end

	disable_parsing is
			-- Disable parsing of non compiled classes.
		do
			is_parsing := False
		end

feature -- Access

	last_code: STRING
			-- The last computed code.

	last_export: STRING
			-- The last computed export string.

	last_comment: STRING
			-- The last computed feature clause comment.

feature -- Highlevel element change

	execute_visitor (a_visitor: AST_REFACTORING_VISITOR; process_leading: BOOLEAN) is
			-- Execute `a_visitor' on this class, if we `process_leading' we process all nodes and process the `BREAK_AS' directly,
			-- otherwise we process the `BREAK_AS' at the end.
		require
			text_managed: text_managed
			a_visitor_not_void: a_visitor /= Void
		do
			compute_ast
			if not is_parse_error then
				a_visitor.setup (ast, match_list, process_leading, true)
				a_visitor.process_ast_node (ast)
				if not process_leading then
					a_visitor.process_all_break_as
				end
			end

			if a_visitor.has_modified then
				rebuild_text
				logger.refactoring_class (class_i)
			end
		end

	get_feature_named (a_name: STRING) is
			-- Get the code of the feature with `a_name'.
			-- The clients will be in `last_export', the feature clause comment in `last_comment' and the code in `last_code'.
		require
			text_managed: text_managed
			a_name_ok: a_name /= Void and not a_name.is_empty
		local
			l_feature: FEATURE_AS
			l_f_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_clause: FEATURE_CLAUSE_AS
			l_comment: EIFFEL_COMMENTS
		do
			compute_ast
			if not is_parse_error then
				create last_export.make_empty
				create last_code.make_empty
				create last_comment.make_empty
				l_feature := ast.feature_with_name (a_name)
				if l_feature /= Void then
					last_code := l_feature.text (match_list)
					from
						l_f_clauses := ast.features
						l_f_clauses.start
					until
						l_f_clauses.after
					loop
						l_clause := l_f_clauses.item
						if l_clause.has_feature (l_feature) and then l_clause.clients /= Void then
							last_export := l_clause.clients.text (match_list)
							l_comment := l_clause.comment (match_list)
							if l_comment /= Void and then not l_comment.is_empty then
								last_comment := "--"+l_comment.first
							end

						end
						l_f_clauses.forth
					end
				end
			end
		ensure
			no_error_implies_result: not is_parse_error implies (last_code /= Void and last_export /= Void and last_comment /= Void)
		end

	remove_feature_named (a_name: STRING) is
			-- Remove the feature with the name `a_name'.
		require
			text_managed: text_managed
			a_name_ok: a_name /= Void and not a_name.is_empty
		local
			l_feature: FEATURE_AS
			l_elist_modifier: ERT_EIFFEL_LIST_MODIFIER
			l_names: EIFFEL_LIST [FEATURE_NAME]
		do
			compute_ast
			if not is_parse_error then
				l_feature := ast.feature_with_name (a_name)
				if l_feature /= Void then
					l_names := l_feature.feature_names
					if l_names.count = 1 then
						l_feature.remove_text (match_list)
					else
						from
							l_names.start
							create l_elist_modifier.make (l_names, match_list)
						until
							l_names.after
						loop
							if a_name.is_case_insensitive_equal (l_names.item.visual_name) then
								l_elist_modifier.remove (l_names.index)
								l_elist_modifier.apply
							end
							l_names.forth
						end
					end
					rebuild_text
				end
			end
		end

	add_feature_code (a_feature_code, a_export_clause, a_comment: STRING) is
			-- Add `a_feature_code' to the class.
		require
			text_managed: text_managed
			a_feature_code_ok: a_feature_code /= Void and not a_feature_code.is_empty
			a_export_clause_not_void: a_export_clause /= Void
			a_comment_not_void: a_comment /= Void
		local
			l_pos: INTEGER
			l_ast: AST_EIFFEL
		do
			compute_ast
			if not is_parse_error then
				l_pos := ast.feature_clause_insert_position
				l_ast := match_list.item_by_start_position (l_pos)
				if ast.internal_bottom_indexes /= Void then
					l_ast.prepend_text ("feature "+a_export_clause+" "+a_comment+"%N%T"+a_feature_code+";%N%N", match_list)
				else
					l_ast.prepend_text ("feature "+a_export_clause+" "+a_comment+"%N%T"+a_feature_code+"%N%N",  match_list)
				end

				rebuild_text
			end
		end

	add_redefine (a_class_name, a_feature_name: STRING) is
			-- Add a redefine clause for `a_feature_name'. May use a renamed name.
			-- Doesn't add it if it's already there or if it is undefined.
		require
			text_managed: text_managed
			a_class_name_ok: a_class_name /= Void and not a_class_name.is_empty
			a_feature_name_ok: a_feature_name /= Void and not a_feature_name.is_empty
		local
			l_parents: EIFFEL_LIST [PARENT_AS]
			l_inherit: PARENT_AS
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_renames: EIFFEL_LIST [RENAME_AS]
			l_renaming: RENAME_AS
			l_done: BOOLEAN
			l_name: STRING
			l_parent_modifier: ERT_PARENT_AS_MODIFIER
		do
			compute_ast
			if not is_parse_error then
				l_parents := ast.parents
				if l_parents /= Void then
					from
						l_parents.start
					until
						l_parents.after
					loop
						l_inherit := l_parents.item
						if a_class_name.is_case_insensitive_equal (l_inherit.type.class_name) then
							l_name := a_feature_name

								-- if we rename it, we have to use the new name
							l_renames := l_inherit.renaming
							if l_renames /= Void then
								from
									l_renames.start
								until
									l_renames.after
								loop
									l_renaming := l_renames.item
									if l_renaming.old_name.visual_name.is_case_insensitive_equal (a_feature_name) then
										l_name := l_renaming.new_name.visual_name
									end
									l_renames.forth
								end
							end

								-- we only have to do anything if we don't undefine or redefine it
							l_features := l_inherit.undefining
							if l_features /= Void then
								from
									l_features.start
								until
									l_done or l_features.after
								loop
									if l_name.is_case_insensitive_equal (l_features.item.visual_name) then
										l_done := True
									end
									l_features.forth
								end
							end
							l_features := l_inherit.redefining
							if l_features /= Void then
								from
									l_features.start
								until
									l_done or l_features.after
								loop
									if l_name.is_case_insensitive_equal (l_features.item.visual_name) then
										l_done := True
									end
									l_features.forth
								end
							end

							if not l_done then
								create l_parent_modifier.make (l_inherit, match_list)
								l_parent_modifier.extend ({ERT_PARENT_AS_MODIFIER}.redefine_clause, l_name)
								l_parent_modifier.apply
							end
						end
						l_parents.forth
					end
				end
			end
		end

	redefine_into_undefine (a_feature_name, a_implements: STRING) is
			-- Change redefines of `a_feature_name' into undefines, except for the parent `a_implements'.
		require
			text_managed: text_managed
			a_feature_name_ok: a_feature_name /= Void and not a_feature_name.is_empty
		local
			l_parents: EIFFEL_LIST [PARENT_AS]
			l_inherit: PARENT_AS
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_found: BOOLEAN
			l_parent_modifier: ERT_PARENT_AS_MODIFIER
		do
			compute_ast
			if not is_parse_error then
				l_parents := ast.parents
				if l_parents /= Void then
					from
						l_parents.start
					until
						l_parents.after
					loop
						l_inherit := l_parents.item
						l_found := False

							-- remove redefines
						l_features := l_inherit.redefining
						if l_features /= Void then
							from
								l_features.start
							until
								l_found or l_features.after
							loop
								if a_feature_name.is_case_insensitive_equal (l_features.item.visual_name) then
									create l_parent_modifier.make (l_inherit, match_list)
									l_parent_modifier.remove ({ERT_PARENT_AS_MODIFIER}.redefine_clause, l_features.index)
									l_parent_modifier.apply
									l_found := True
								end
								l_features.forth
							end
						end

							-- if we redefine it and we aren't the implementer
							-- => add undefine
						if l_found and not a_implements.is_case_insensitive_equal (l_inherit.type.class_name) then
							create l_parent_modifier.make (l_inherit, match_list)
							l_parent_modifier.extend ({ERT_PARENT_AS_MODIFIER}.undefine_clause, a_feature_name)
							l_parent_modifier.apply
						end
						l_parents.forth
					end
				end
			end
		end

feature -- Load/Save file

	load_text is
			-- Load the text.
		do
			text := class_i.text
		end

	save_text is
			-- Save the text.
		do
			save (class_i.file_name, text)
		end

	discard_text is
			-- Discard the text.
		do
			Precursor
			ast := Void
			match_list := Void
		end


feature {NONE} -- Implementation

	compute_ast is
			-- Compute or retrieve the ast. The result will be available in ast and match_list.
		require
			text_managed: text_managed
			class_compiled_or_parsing: not class_i.is_compiled implies is_parsing
		do
				-- only when necessary
			if ast = Void then
				if is_parsing and then not class_i.compiled then
					recompute_ast
				else
					ast := class_i.compiled_class.ast
					match_list := match_list_server.item (class_i.compiled_class.class_id)
				end
			end
		ensure
			no_error_implies_set: not is_parse_error implies is_parsed
		end

	recompute_ast is
			-- Compute the ast even if we have a compiled version.
		require
			text_managed: text_managed
		local
			l_parser: EIFFEL_PARSER
		do
			l_parser := heavy_eiffel_parser
			l_parser.parse_from_string (text)
			if l_parser.error_count = 0 then
				ast := l_parser.root_node
				match_list := l_parser.match_list
			else
				is_parse_error := True
			end
		ensure
			no_error_implies_set: not is_parse_error implies is_parsed
		end

	rebuild_text is
			-- Rebuild the text from the ast.
		require
			text_managed: text_managed
			is_parsed: is_parsed
		do
			set_changed_text (ast.text (match_list))
		end

	ast: CLASS_AS
			-- The ast of the class.

	match_list: LEAF_AS_LIST
			-- The match list of the class.

	class_i: CLASS_I
			-- The associated class.

invariant
	associated_to_class: class_i /= void

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

end
