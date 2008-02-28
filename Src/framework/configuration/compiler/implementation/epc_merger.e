indexing
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

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			error_message := "No error."
		end

feature -- Access

	class_text: STRING
			-- Resulting class text

	error_message: STRING
			-- Error message if any

feature -- Status Report

	successful: BOOLEAN
			-- Was last call to `merge' successful?

	ast_from_file (a_file: STRING): CLASS_AS is
			-- AST from text in file `a_file' if syntactically correct
			-- Otherwise set `successful' to False and initialize `error_message'
		require
			attached_file: a_file /= Void
		local
			l_errors: LIST [ERROR]
			l_syntax_error: SYNTAX_ERROR
			l_new_pragma: STRING
			l_index: INTEGER
			l_match_list: LEAF_AS_LIST
			l_retried: BOOLEAN
			l_file: KL_BINARY_INPUT_FILE
		do
			if not l_retried then
				create l_file.make (a_file)
				l_file.open_read
				roundtrip_eiffel_parser.parse (l_file)
				l_file.close
				Result := roundtrip_eiffel_parser.root_node
				if Result = Void then
					successful := False
					l_errors := Error_handler.error_list
					if l_errors /= Void and then not l_errors.is_empty then
						l_syntax_error ?= l_errors.first
						if l_syntax_error /= Void then
							create error_message.make (256)
							error_message.append ("Syntax error at line ")
							error_message.append (l_syntax_error.line.out)
							if not l_syntax_error.error_message.is_empty then
								error_message.append (": ")
								error_message.append (l_syntax_error.error_message)
							end
						else
							error_message := "Syntax error"
						end
					else
						error_message := "Syntax error"
					end
				else
					analyze_file (a_file)
					if first_line_pragma /= Void and Result.features /= Void then
						l_index := first_line_pragma.index_of ('"', 1)
						if l_index > 0 then
							l_match_list := roundtrip_eiffel_parser.match_list
							create l_new_pragma.make (300)
							l_new_pragma.append ("--#line ")
							l_new_pragma.append ((Result.features.first_token (l_match_list).line - 1).out)
							l_new_pragma.append (first_line_pragma.substring (l_index - 1, first_line_pragma.count))
							l_new_pragma.append (line_return)
							Result.features.prepend_text (l_new_pragma, l_match_list)
						end
					end
					successful := True
					error_message := Void
				end
			else
				successful := False
				error_message := "Could not open file " + a_file
			end
		rescue
			l_retried := True
			retry
		end

	merge (a_file_names: LIST [STRING]) is
			-- Merge content of files in `a_file_names' into one class.
			-- `a_file_names': Files to be merged.
		require
			attached_file_names: a_file_names /= Void
			valid_file_names: not a_file_names.is_empty
			-- Contain source for same class
		local
			l_ast, l_new_ast: CLASS_AS
			l_match_list, l_new_match_list: LEAF_AS_LIST
			l_is_deferred, l_is_expanded: BOOLEAN
		do
			successful := False
			error_message := Void
			class_text := Void
			a_file_names.start
			l_ast := ast_from_file (a_file_names.item)
			if successful then
				l_match_list := roundtrip_eiffel_parser.match_list
				if l_ast.is_partial then
					l_ast.class_keyword (l_match_list).replace_text ("class", l_match_list)
				end
				l_is_deferred := l_ast.is_deferred
				l_is_expanded := l_ast.is_expanded

				from
					a_file_names.forth
				until
					a_file_names.after or not successful
				loop
					l_new_ast := ast_from_file (a_file_names.item)
					if successful then
						l_new_match_list := roundtrip_eiffel_parser.match_list
						l_is_deferred := l_is_deferred or l_new_ast.is_deferred
						l_is_expanded := l_is_expanded or l_new_ast.is_expanded
						append_features (l_match_list, l_new_match_list, l_ast, l_new_ast)
						append_invariants (l_match_list, l_new_match_list, l_ast, l_new_ast)
						merge_inheritance_clauses (l_match_list, l_new_match_list, l_ast, l_new_ast)
						append_indexing_clauses (l_match_list, l_new_match_list, l_ast, l_new_ast)
						merge_creation_routines (l_match_list, l_new_match_list, l_ast, l_new_ast)
					end
					a_file_names.forth
				end
				if successful then
					if not l_ast.is_deferred and l_is_deferred then
						l_ast.class_keyword (l_match_list).prepend_text ("deferred ", l_match_list)
					end
					if not l_ast.is_expanded and l_is_expanded then
						l_ast.class_keyword (l_match_list).prepend_text ("expanded ", l_match_list)
					end
					class_text := l_ast.text (l_match_list)
				end
			end
		ensure
			successful_iff_attached_class_text_and_name: successful = (class_text /= Void)
			error_message_void_iff_successful: successful = (error_message = Void)
		end

feature {NONE} -- Implementation

	append_features (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS) is
			-- Append features in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_ast: AST_EIFFEL
		do
			if a_ast.features /= Void then
				if a_new_ast.features /= Void then
					a_ast.features.append_text (a_new_ast.features.text (a_new_match_list), a_match_list)
				end
			elseif a_new_ast.features /= Void then
				if a_ast.invariant_part /= Void then
					l_ast := a_ast.invariant_part
				elseif a_ast.bottom_indexes /= Void then
					l_ast := a_ast.bottom_indexes
				else
					l_ast := a_ast.end_keyword
				end
				l_ast.prepend_text (a_new_ast.features.text (a_new_match_list), a_match_list)
			end
		end

	post_features_ast (a_ast: CLASS_AS): AST_EIFFEL is
			-- First node after 'feature' keyword
		require
			attached_ast: a_ast /= Void
		do
			if a_ast.invariant_part /= Void then
				Result := a_ast.invariant_part
			elseif a_ast.bottom_indexes /= Void then
				Result := a_ast.bottom_indexes
			else
				Result := a_ast.end_keyword
			end
		ensure
			attached_ast: Result /= Void
		end

	append_invariants (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS) is
			-- Append invariants in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_list: EIFFEL_LIST [TAGGED_AS]
			l_invariant, l_new_invariant: INVARIANT_AS
		do
			l_new_invariant := a_new_ast.invariant_part
			if l_new_invariant /= Void then
				l_invariant := a_ast.internal_invariant
				if l_invariant /= Void then
					l_list := l_invariant.full_assertion_list
					if l_list /= Void and then not l_list.is_empty and then l_list.i_th (l_list.count).expr = Void then
						l_list.i_th (l_list.count).replace_text ("", a_match_list)
					end
					l_invariant.append_text (line_return, a_match_list)
					l_invariant.append_text ("%T", a_match_list)
					l_invariant.append_text (l_new_invariant.assertion_list.text (a_new_match_list), a_match_list)
				else
					a_ast.features.append_text (a_new_ast.invariant_part.text (a_new_match_list) + line_return, a_match_list)
				end
			end
		end

	merge_inheritance_clauses (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS) is
			-- Merge inheritance clauses in `l_match_list' and `l_ast' into `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_mod: ERT_PARENT_LIST_MODIFIER
		do
			create l_mod.make (a_ast, a_match_list, a_new_ast, a_new_match_list)
			l_mod.apply
		end

	append_indexing_clauses (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS) is
			-- Append indexing clauses in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_mod: ERT_EIFFEL_LIST_MODIFIER
			l_indexes, l_new_indexes: INDEXING_CLAUSE_AS
			l_count: INTEGER
		do
			l_new_indexes := a_new_ast.top_indexes
			l_indexes := a_ast.internal_top_indexes
			if l_new_indexes /= Void then
				if l_indexes /= Void then
					l_count := l_indexes.count
					create l_mod.make (l_indexes, a_match_list)
					l_mod.set_separator (line_return + "%T")
					from
						l_new_indexes.start
					until
						l_new_indexes.after
					loop
						l_mod.append (l_new_indexes.item.text (a_new_match_list))
						l_new_indexes.forth
					end
					l_mod.apply
				else
					a_ast.first_token (a_match_list).prepend_text (a_new_ast.internal_top_indexes.text (a_new_match_list) + line_return + line_return, a_match_list)
				end
			end
		end

	merge_creation_routines (a_match_list, a_new_match_list: LEAF_AS_LIST; a_ast, a_new_ast: CLASS_AS) is
			-- Append creation routines in `l_match_list' and `l_ast' to `l_new_ast'.
		require
			attached_match_list: a_match_list /= Void
			attached_new_match_list: a_new_match_list /= Void
			attached_ast: a_ast /= Void
			attached_new_ast: a_new_ast /= Void
		local
			l_mod: ERT_EIFFEL_LIST_MODIFIER
			l_creators, l_new_creators: EIFFEL_LIST [CREATE_AS]
			l_new_creator: CREATE_AS
			l_index: INTEGER
			l_list, l_new_list: EIFFEL_LIST [FEATURE_NAME]
		do
			if a_new_ast.creators /= Void then
				if a_ast.creators /= Void then
					l_new_creators := a_new_ast.creators
					l_creators := a_ast.creators
					from
						l_new_creators.start
					until
						l_new_creators.after
					loop
						l_new_creator := l_new_creators.item
						l_index := equiv_client_index (l_new_creator, l_creators)
						if l_index > 0 then
							l_list := l_creators.i_th (l_index).feature_list
							if l_list /= Void then
								create l_mod.make (l_list, a_match_list)
								l_mod.set_separator (", ")
								l_new_list := l_new_creator.feature_list
								from
									l_new_list.start
								until
									l_new_list.after
								loop
									l_mod.append (l_new_list.item.text (a_new_match_list))
									l_new_list.forth
								end
								l_mod.apply
							end
						else
							create l_mod.make (l_creators, a_match_list)
							l_mod.set_separator (line_return)
							l_mod.append (l_new_creator.text (a_new_match_list))
							l_mod.apply
						end
						l_new_creators.forth
					end
				else
					a_ast.features.prepend_text (a_new_ast.creators.text (a_new_match_list) + line_return + line_return, a_match_list)
				end
			end
		end

	equiv_client_index (a_creator: CREATE_AS; a_creators: EIFFEL_LIST [CREATE_AS]): INTEGER is
			-- Index in `l_creators' of create_as with equivalient client export,
			-- 0 if none.
		require
			attached_creator: a_creator /= Void
			attached_creators: a_creators /= Void
		local
			l_clients, l_other_clients: CLIENT_AS
		do
			from
				l_clients := a_creator.clients
				a_creators.start
			until
				a_creators.after or (Result > 0)
			loop
				l_other_clients := a_creators.item.clients
				if (l_other_clients = Void) and (l_clients = Void) or
					((l_other_clients /= Void) and (l_clients /= Void) and l_other_clients.is_equiv (l_clients)) then
					Result := a_creators.index
				end
				a_creators.forth
			end
		ensure
			Definition: (Result > 0) implies ((a_creators.i_th (Result).clients = Void and a_creator.clients = Void) or a_creators.i_th (Result).clients.is_equiv (a_creator.clients))
		end

	analyze_file (a_file_path: STRING) is
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
				create l_file.make (a_file_path)
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
					end
					l_file.close
					if l_read.substring (1, 8).is_equal ("--#line ") then
						first_line_pragma := l_read
					end
				end
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Onces

	roundtrip_eiffel_parser: EIFFEL_PARSER is
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

	first_line_pragma: STRING
			-- First line pragma of last partial class analyzed with `ast_from_file' if any

	Default_line_return: STRING is "%R%N"
			-- Default line return in case `analyze' fails.
			-- Use Windows convention as partial classes have more chances to be used on that platform.

invariant
	successful_iff_attached_class_text_and_name: successful = (class_text /= Void)
	error_message_void_iff_successful: successful = (error_message = Void)
	valid_line_return: line_return /= Void implies (line_return.is_equal ("%N") or line_return.is_equal ("%R%N"))
	valid_first_line_pragma: first_line_pragma /= Void implies first_line_pragma.substring (1, 8).is_equal ("--#line ")

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

end -- class EPC_MERGER
