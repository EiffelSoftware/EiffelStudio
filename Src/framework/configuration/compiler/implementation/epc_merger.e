note
	description: "Merge partial classes into one"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EPC_MERGER

inherit
	SHARED_ERROR_HANDLER
		redefine
			default_create
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create.
		do
			create class_text.make_empty
			line_return := Default_line_return
			error_message := Void
		end

feature -- Access

	class_text: STRING
			-- Resulting class text

	error_message: detachable STRING_32
			-- Error message if any

feature -- Status Report

	successful: BOOLEAN
			-- Was last call to `merge' successful?

	ast_from_file (a_file: READABLE_STRING_GENERAL): detachable CLASS_AS
			-- AST from text in file `a_file' if syntactically correct
			-- Otherwise set `successful' to False and initialize `error_message'
		require
			attached_file: a_file /= Void
		local
			l_errors: detachable LIST [ERROR]
			l_new_pragma: STRING
			l_index: INTEGER
			l_match_list: detachable LEAF_AS_LIST
			l_retried: BOOLEAN
			l_file: KL_BINARY_INPUT_FILE
			gobo: GOBO_FILE_UTILITIES
			e: like error_message
		do
			if not l_retried then
				l_file := gobo.make_binary_input_file (a_file)
				l_file.open_read
				roundtrip_eiffel_parser.parse (l_file)
				l_file.close
				Result := roundtrip_eiffel_parser.root_node
				if Result = Void then
					successful := False
					l_errors := Error_handler.error_list
					if l_errors /= Void and then not l_errors.is_empty then
						if attached {SYNTAX_ERROR} l_errors.first as l_syntax_error then
							create e.make (256)
							error_message := e
							e.append ({STRING_32} "Syntax error at line ")
							e.append_string_general (l_syntax_error.line.out)
							if not l_syntax_error.error_message.is_empty then
								e.append ({STRING_32} ": ")
								e.append_string_general (l_syntax_error.error_message)
							end
						else
							error_message := {STRING_32} "Syntax error"
						end
					else
						error_message := {STRING_32} "Syntax error"
					end
				else
					analyze_file (a_file)
					if attached first_line_pragma as l_first_line_pragma and attached Result.features as l_features then
						l_index := l_first_line_pragma.index_of ('"', 1)
						if l_index > 0 then
							l_match_list := roundtrip_eiffel_parser.match_list
							if l_match_list /= Void then
								create l_new_pragma.make (300)
								l_new_pragma.append ("--#line ")
								if attached l_features.first_token (l_match_list) as first_token then
									l_new_pragma.append ((first_token.line - 1).out)
								end
								l_new_pragma.append (l_first_line_pragma.substring (l_index - 1, l_first_line_pragma.count))
								l_new_pragma.append (line_return)
								l_features.prepend_text (l_new_pragma, l_match_list)
							else
								check has_match_list: False end
							end
						end
					end
					successful := True
					error_message := Void
				end
			else
				successful := False
				error_message := {STRING_32} "Could not open file " + a_file.to_string_32
			end
		rescue
			l_retried := True
			retry
		end

	merge (a_file_names: ARRAYED_LIST [READABLE_STRING_GENERAL])
			-- Merge content of files in `a_file_names' into one class.
			-- `a_file_names': Files to be merged.
		require
			attached_file_names: a_file_names /= Void
			valid_file_names: not a_file_names.is_empty
			-- Contain source for same class
		local
			l_ast, l_new_ast: detachable CLASS_AS
			l_match_list, l_new_match_list: detachable LEAF_AS_LIST
			l_is_deferred, l_is_expanded, l_is_once: BOOLEAN
		do
			successful := False
			error_message := Void
			create class_text.make_empty
			a_file_names.start
			l_ast := ast_from_file (a_file_names.item)
			if successful and then l_ast /= Void then
				l_match_list := roundtrip_eiffel_parser.match_list
				if
					l_match_list /= Void and then
					l_ast.is_partial and then
					attached l_ast.class_keyword (l_match_list) as class_keyword
				then
					class_keyword.replace_text ("class", l_match_list)
				end
				l_is_deferred := l_ast.is_deferred
				l_is_expanded := l_ast.is_expanded
				l_is_once := l_ast.is_once

				from
					a_file_names.forth
				until
					a_file_names.after or not successful
				loop
					l_new_ast := ast_from_file (a_file_names.item)
					if successful and then l_new_ast /= Void then
						l_new_match_list := roundtrip_eiffel_parser.match_list
						l_is_deferred := l_is_deferred or l_new_ast.is_deferred
						l_is_expanded := l_is_expanded or l_new_ast.is_expanded
						l_is_once := l_is_once or l_new_ast.is_once
						if l_match_list /= Void and l_new_match_list /= Void then
							append_features (l_match_list, l_new_match_list, l_ast, l_new_ast)
							append_invariants (l_match_list, l_new_match_list, l_ast, l_new_ast)
							merge_inheritance_clauses (l_match_list, l_new_match_list, l_ast, l_new_ast)
							append_indexing_clauses (l_match_list, l_new_match_list, l_ast, l_new_ast)
							merge_creation_routines (l_match_list, l_new_match_list, l_ast, l_new_ast)
						else
							check successful_implies_match_list_attached: False end
						end
					else
						check successful implies l_new_ast /= Void end
					end
					a_file_names.forth
				end
				if successful and l_match_list /= Void then
					if
						not l_ast.is_deferred and
						l_is_deferred and then
						attached l_ast.class_keyword (l_match_list) as class_keyword
					then
						class_keyword.prepend_text ("deferred ", l_match_list)
					end
					if
						not l_ast.is_expanded and
						l_is_expanded and then
						attached l_ast.class_keyword (l_match_list) as class_keyword
					then
						class_keyword.prepend_text ("expanded ", l_match_list)
					end
					if
						not l_ast.is_once and
						l_is_once and then
						attached l_ast.class_keyword (l_match_list) as class_keyword
					then
						class_keyword.prepend_text ("once ", l_match_list)
					end
					class_text := l_ast.text (l_match_list)
				else
					check successful implies l_match_list /= Void end
				end
			end
		ensure
			successful_if_attached_class_text_and_name: successful = (not class_text.is_empty)
			error_message_void_iff_successful: successful = (error_message = Void)
		end

feature {NONE} -- Implementation

	append_features (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS)
			-- Append features in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		do
			if attached a_new_ast.features as l_new_features then
				if attached a_ast.features as l_features then
					l_features.append_text (l_new_features.text (a_new_match_list), a_match_list)
				elseif attached a_new_ast.features as features then
					post_features_ast (a_ast).prepend_text (features.text (a_new_match_list), a_match_list)
				end
			end
		end

	post_features_ast (a_ast: CLASS_AS): AST_EIFFEL
			-- First node after 'feature' keyword
		require
			attached_ast: a_ast /= Void
		do
			if attached a_ast.invariant_part as l_invariant_part then
				Result := l_invariant_part
			elseif attached a_ast.bottom_indexes as l_bottom_indexes then
				Result := l_bottom_indexes
			else
				Result := a_ast.end_keyword
			end
		ensure
			attached_ast: Result /= Void
		end

	append_invariants (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS)
			-- Append invariants in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		do
			if attached a_new_ast.invariant_part as l_new_invariant then
				if attached a_ast.internal_invariant as l_invariant then
					if
						attached l_invariant.full_assertion_list as l_list and then
						not l_list.is_empty and then
						l_list.i_th (l_list.count).expr = Void
					then
						l_list.i_th (l_list.count).replace_text ("", a_match_list)
					end
					l_invariant.append_text (line_return, a_match_list)
					l_invariant.append_text ("%T", a_match_list)
					if attached l_new_invariant.assertion_list as l then
						l_invariant.append_text (l.text (a_new_match_list), a_match_list)
					end
				elseif attached a_ast.features as features then
					features.append_text (l_new_invariant.text (a_new_match_list) + line_return, a_match_list)
				end
			end
		end

	merge_inheritance_clauses (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS)
			-- Merge inheritance clauses in `l_match_list' and `l_ast' into `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		do
			(create {ERT_PARENT_LIST_MODIFIER}.make (a_ast, a_match_list, a_new_ast, a_new_match_list)).apply
		end

	append_indexing_clauses (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS)
			-- Append indexing clauses in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_mod: ERT_EIFFEL_LIST_MODIFIER
			l_count: INTEGER
		do
			if attached a_new_ast.top_indexes as l_new_indexes then
				if attached a_ast.internal_top_indexes as l_indexes then
					l_count := l_indexes.count
					create l_mod.make (l_indexes, a_match_list)
					l_mod.set_separator_32 (line_return + "%T")
					from
						l_new_indexes.start
					until
						l_new_indexes.after
					loop
						l_mod.append (l_new_indexes.item.text (a_new_match_list))
						l_new_indexes.forth
					end
					l_mod.apply
				elseif attached a_ast.first_token (a_match_list) as first_token then
					first_token.prepend_text (l_new_indexes.text (a_new_match_list) + line_return + line_return, a_match_list)
				end
			end
		end

	merge_creation_routines (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS)
			-- Append creation routines in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_mod: ERT_EIFFEL_LIST_MODIFIER
			l_new_creator: CREATE_AS
			l_index: INTEGER
		do
			if attached a_new_ast.creators as l_new_creators then
				if attached a_ast.creators as l_creators then
					from
						l_new_creators.start
					until
						l_new_creators.after
					loop
						l_new_creator := l_new_creators.item
						l_index := equiv_client_index (l_new_creator, l_creators)
						if l_index <= 0 then
							create l_mod.make (l_creators, a_match_list)
							l_mod.set_separator_32 (line_return)
							l_mod.append (l_new_creator.text (a_new_match_list))
							l_mod.apply
						elseif attached l_creators.i_th (l_index).feature_list as l_list then
							create l_mod.make (l_list, a_match_list)
							l_mod.set_separator_32 (", ")
							if attached l_new_creator.feature_list as l_new_list then
								across
									l_new_list as n
								loop
									l_mod.append (n.item.text (a_new_match_list))
								end
							end
							l_mod.apply
						end
						l_new_creators.forth
					end
				elseif attached a_ast.features as features then
					features.prepend_text (l_new_creators.text (a_new_match_list) + line_return + line_return, a_match_list)
				end
			end
		end

	equiv_client_index (a_creator: CREATE_AS; a_creators: EIFFEL_LIST [CREATE_AS]): INTEGER
			-- Index in `l_creators' of create_as with equivalient client export,
			-- 0 if none.
		require
			attached_creator: a_creator /= Void
			attached_creators: a_creators /= Void
		local
			l_clients, l_other_clients: detachable CLIENT_AS
		do
			from
				l_clients := a_creator.clients
				a_creators.start
			until
				a_creators.after or (Result > 0)
			loop
				l_other_clients := a_creators.item.clients
				if
					(l_other_clients = Void) and (l_clients = Void)
					or ((l_other_clients /= Void) and then
						(l_clients /= Void) and then
						l_other_clients.is_equiv (l_clients))
				then
					Result := a_creators.index
				end
				a_creators.forth
			end
		ensure
			Definition: (Result > 0) implies (
						(a_creators.i_th (Result).clients = Void and a_creator.clients = Void)
						or (attached a_creators.i_th (Result).clients as el_i_th_client and then
							attached a_creator.clients as el_clients
							and then el_i_th_client.is_equiv (el_clients)
							)
						)
		end

	analyze_file (a_file_path: READABLE_STRING_GENERAL)
			-- Analyze file located at `a_file_path'.
			-- Set `line_return' accordingly.
			-- Set `first_line_pragma' accodingly.
		require
			attached_path: a_file_path /= Void
		local
			l_retried, l_done: BOOLEAN
			l_file: RAW_FILE
			l_read: STRING
			c: INTEGER_8
		do
			line_return := Default_line_return
			first_line_pragma := Void
			if not l_retried then
				create l_file.make_with_name (a_file_path)
				if l_file.exists then
					l_file.open_read
					if l_file.count > 8 then
						from
							create l_read.make (1024)
						until
							l_done
						loop
							l_file.read_integer_8
							c := l_file.last_integer_8
							if c = 13 then
								l_file.read_integer_8
								if l_file.last_integer_8 = 10 then
									line_return := "%R%N"
									l_done := True
								else
									l_read.append_character (c.to_character_8)
									l_read.append_character (l_file.last_integer_8.to_character_8)
								end
							elseif c = 10 then
								line_return := "%N"
								l_done := True
							elseif c = -1 then
								l_done := True
							else
								l_read.append_character (c.to_character_8)
							end
						end
						if l_read.substring_index ("--#line ", 1) = 1 then
							first_line_pragma := l_read
						end
					end
					l_file.close
				end
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Onces

	roundtrip_eiffel_parser: EIFFEL_PARSER
			-- Shared instance of roundtrip parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser -- This is to accept class alias syntax
		ensure
			attached_eiffel_parser: Result /= Void
		end

feature {NONE} -- Private Access

	line_return: STRING
			-- String to use for line returns (i.e. "%N" or "%R%N")

	first_line_pragma: detachable STRING
			-- First line pragma of last partial class analyzed with `ast_from_file' if any

	Default_line_return: STRING = "%R%N"
			-- Default line return in case `analyze' fails.
			-- Use Windows convention as partial classes have more chances to be used on that platform.

invariant
	successful_iff_attached_class_text_and_name: successful = (class_text /= Void)
	error_message_void_iff_successful: successful = (error_message = Void)
	valid_line_return: line_return.same_string ("%N") or line_return.same_string ("%R%N")
	valid_first_line_pragma: attached first_line_pragma as p implies p.substring (1, 8).is_equal ("--#line ")

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
