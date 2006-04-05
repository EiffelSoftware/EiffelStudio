indexing
	description: "Merge partial classes into one"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EPC_MERGER

inherit
	ANY
		redefine
			default_create
		end

	EPC_SHARED_ROUNDTRIP_PARSER
		export
			{NONE} all
		undefine
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

	merge (a_file_names: LIST [STRING]) is
			-- Merge content of files in `a_file_names' into one class.
			-- `a_file_names': Files to be merged.
		require
			attached_file_names: a_file_names /= Void
			-- Contain source for same class
		local
			l_ast, l_new_ast: CLASS_AS
			l_match_list, l_new_match_list: LEAF_AS_LIST
			l_is_deferred, l_is_expanded: BOOLEAN
			l_content, l_new_pragma: STRING
			l_index, l_index2: INTEGER
		do
			from
				a_file_names.start
			until
				a_file_names.after or l_ast /= Void
			loop
				l_content := file_content (a_file_names.item)
				if l_content /= Void then
					roundtrip_eiffel_parser.parse_from_string (l_content)
					l_ast := roundtrip_eiffel_parser.root_node
					l_match_list := roundtrip_eiffel_parser.match_list
					if l_content.substring (1, 8).is_equal ("--#line ") then
						l_index := l_content.index_of ('"', 1)
						if l_index > 0 then
							l_index2 := l_content.index_of ('%N', l_index + 1)
							if l_index2 > 0 then
								create l_new_pragma.make (300)
								l_new_pragma.append ("--#line ")
								l_new_pragma.append ((l_ast.features.first_token (l_match_list).line - 1).out)
								l_new_pragma.append (l_content.substring (l_index - 1, l_index2))
								l_ast.features.prepend_text (l_new_pragma, l_match_list)
							end
						end
					end
					if l_ast.is_partial then
						l_ast.class_keyword.replace_text ("class", l_match_list)
					end
				end
				a_file_names.forth
			end

			from
				l_is_deferred := l_ast.is_deferred
				l_is_expanded := l_ast.is_expanded
			until
				a_file_names.after
			loop
				l_content := file_content (a_file_names.item)
				if l_content /= Void then
					roundtrip_eiffel_parser.parse_from_string (l_content)
					l_new_ast := roundtrip_eiffel_parser.root_node
					l_new_match_list := roundtrip_eiffel_parser.match_list
					if l_new_ast /= Void then
						l_is_deferred := l_is_deferred or l_new_ast.is_deferred
						l_is_expanded := l_is_expanded or l_new_ast.is_expanded
						if l_content.substring (1, 8).is_equal ("--#line ") then
							l_index := l_content.index_of ('"', 1)
							if l_index > 0 then
								l_index2 := l_content.index_of ('%N', l_index + 1)
								if l_index2 > 0 then
									create l_new_pragma.make (300)
									l_new_pragma.append ("--#line ")
									l_new_pragma.append ((l_new_ast.features.first_token (l_new_match_list).line - 1).out)
									l_new_pragma.append (l_content.substring (l_index - 1, l_index2))
									l_ast.features.append_text (l_new_pragma, l_match_list)
								end
							end
						end
						append_features (l_match_list, l_new_match_list, l_ast, l_new_ast)
						append_invariants (l_match_list, l_new_match_list, l_ast, l_new_ast)
						merge_inheritance_clauses (l_match_list, l_new_match_list, l_ast, l_new_ast)
						append_indexing_clauses (l_match_list, l_new_match_list, l_ast, l_new_ast)
						merge_creation_routines (l_match_list, l_new_match_list, l_ast, l_new_ast)
					end
				end
				a_file_names.forth
			end

			if l_ast /= Void then
				if not l_ast.is_deferred and l_is_deferred then
					l_ast.class_keyword.prepend_text ("deferred ", l_match_list)
				end
				if not l_ast.is_expanded and l_is_expanded then
					l_ast.class_keyword.prepend_text ("expanded ", l_match_list)
				end
				class_text := l_ast.text (l_match_list)
				successful := True
				error_message := Void
			else
				successful := False
				error_message := "Could not merge files."
				class_text := Void
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
		do
			a_ast.features.append_text (a_new_ast.features.text (a_new_match_list), a_match_list)
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
			if a_new_ast.invariant_part /= Void then
				l_new_invariant := a_new_ast.invariant_part
				l_invariant := a_ast.internal_invariant
				if l_invariant /= Void then
					l_list := l_invariant.full_assertion_list
					if l_list /= Void and then not l_list.is_empty and then l_list.i_th (l_list.count).expr = Void then
						l_list.i_th (l_list.count).replace_text ("", a_match_list)
					end
					l_invariant.append_text ("%N%T", a_match_list)
					l_invariant.append_text (l_new_invariant.assertion_list.text (a_new_match_list), a_match_list)
				else
					a_ast.features.append_text (a_new_ast.invariant_part.text (a_new_match_list) + "%N", a_match_list)
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
					l_mod.set_separator ("%N%T")
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
					a_ast.first_token (a_match_list).prepend_text (a_new_ast.internal_top_indexes.text (a_new_match_list) + "%N%N", a_match_list)
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
						else
							create l_mod.make (l_creators, a_match_list)
							l_mod.set_separator ("%N")
							l_mod.append (l_new_creator.text (a_new_match_list))
							l_mod.apply
						end
						l_new_creators.forth
					end
				else
					a_ast.features.prepend_text (a_new_ast.creators.text (a_new_match_list) + "%N%N", a_match_list)
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
			Definition: (Result > 0) implies (a_creators.i_th (Result).clients.is_equiv (a_creator.clients))
		end

	file_content (a_file_name: STRING): STRING is
			-- File content of `a_file_name'
			-- `Void' if file doesn't exist or cannot be opened
		require
			attached_file_name: a_file_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_file_name)
				if l_file.exists then
					l_file.open_read
					l_file.read_stream (l_file.count)
					l_file.close
					Result := l_file.last_string
				end
			end
		rescue
			l_retried := True
			retry
		end

invariant
	successful_iff_attached_class_text_and_name: successful = (class_text /= Void)
	error_message_void_iff_successful: successful = (error_message = Void)

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
