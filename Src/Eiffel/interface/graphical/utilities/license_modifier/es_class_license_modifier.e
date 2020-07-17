note
	description: "A modifier used to inject a license text into a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS_LICENSE_MODIFIER

inherit
	ES_CLASS_TEXT_AST_MODIFIER

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature -- Access

	license_name: detachable STRING_32
			-- Name of the license previously assigned to the class.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_ast: detachable like ast_license_name
			l_list: EIFFEL_LIST [ATOMIC_AS]
			l_result: detachable STRING_32
		do
			l_ast := ast_license_name
			if l_ast /= Void then
				l_list := l_ast.index_list
				if l_list /= Void and then not l_list.is_empty then
						-- Take the first index value, ignore all others, in case of a typo on the user's part.
					if attached {STRING_AS} l_list.first as l_string then
						l_result := l_string.value_32
						if not l_result.is_empty then
							Result := l_result
						end
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	license: attached STRING_32
			-- The current license text of the current class
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_ast: detachable like ast_license
		do
			if attached internal_license as l_result then
				Result := l_result
			else
				l_ast := ast_license
				if l_ast /= Void then
					create Result.make_from_string (l_ast.text (ast_match_list))
				else
					create Result.make_empty
				end
				internal_license := Result
			end
		ensure
			result_consistent: Result = license
		end

feature {NONE} -- Access

	ast_license_name: detachable INDEX_AS
			-- License name AST node.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_indexing: detachable INDEXING_CLAUSE_AS
		do
			l_indexing := ast.top_indexes
			if l_indexing /= Void then
				Result := ast_license_name_from_indexing (l_indexing)
			end
			if Result = Void then
				l_indexing := ast.bottom_indexes
				if l_indexing /= Void then
					Result := ast_license_name_from_indexing (l_indexing)
				end
			end
		ensure
			result_is_license_id_term: Result /= Void implies
				(Result.tag /= Void and then Result.tag.name.is_case_insensitive_equal (license_name_term))
		end

	ast_license: detachable INDEXING_CLAUSE_AS
			-- License section AST node.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		do
			Result := ast.internal_bottom_indexes
		end

feature -- Element change

	set_license_name (a_name: detachable STRING_GENERAL)
			-- Sets the license name for the current class.
			--
			-- `a_name': The name of the license, as found in a license file, or Void to remove.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			not_a_name_is_empty: a_name /= Void implies not a_name.is_empty
		local
			l_ast: detachable AST_EIFFEL
		do
			if a_name = Void then
					-- Remove the license id
				l_ast := ast_license_name
				if l_ast /= Void then
					remove_ast_code (l_ast, remove_white_space_trailing)
					if ast_license_name /= Void then
							-- There are multiple license ids, keep removing.
						set_license_name (Void)
					end
				end
			else
					-- This is to be implemented. It's not implemented now because it is quite complex and there is no
					-- established need for it yet.
				check False end
			end
		ensure
			is_dirty: ((a_name = Void and old ast_license_name /= Void) implies is_dirty)
		end

	set_license (a_license: detachable READABLE_STRING_GENERAL)
			-- Sets the licenses text for the current class.
			--
			-- `a_license': The license indexing text to set, or Void to remove.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			not_a_license_is_empty: a_license /= Void implies not a_license.is_empty
			a_license_is_valid_license: is_valid_license (a_license)
		local
			l_ast: detachable AST_EIFFEL
			l_pos: attached like ast_position
			l_data: like modified_data
			l_parser: like indexing_parser
			l_wrapper: like eiffel_parser_wrapper
			l_options: CONF_OPTION
			l_match_list: like ast_match_list
			l_start_position: INTEGER
			l_new_license, l_current_license: STRING_32
			l_win_eol_style: BOOLEAN
		do
			if a_license = Void then
					-- Remove the license
				l_ast := ast_license
				if l_ast /= Void then
					remove_ast_code (l_ast, remove_white_space_trailing)
				end
			else
				create l_new_license.make_from_string_general (a_license)
				l_current_license := license
					-- We keep the new license the same style of new line.
				l_win_eol_style := original_text_eol_style = windows_eol_style
				l_new_license.prune_all ('%R')
				if l_win_eol_style then
					l_new_license.replace_substring_all ("%N", "%R%N")
				end

				if not l_new_license.same_string (l_current_license) then
						-- The license is different from the class license, so change it.
					l_match_list := ast_match_list
					if attached {INDEXING_CLAUSE_AS} ast_license as l_indexing_ast and then l_match_list /= Void then
						merge_license_code (l_indexing_ast, l_match_list, l_new_license)
					else
							-- There is no indexing AST clause, so insert just above the class end keyword.
						l_ast := ast.end_keyword
						if l_ast /= Void then
							if l_win_eol_style then
								l_new_license.append ("%R%N")
							else
								l_new_license.append_character ('%N')
							end
							l_pos := ast_position (l_ast)
							l_start_position := l_pos.start_position
							insert_code (l_start_position, l_new_license)

							l_wrapper := eiffel_parser_wrapper
							l_parser := validating_parser
							l_options := context_class.options
							check l_options_attached: l_options /= Void end

							l_wrapper.parse_with_option_32 (l_parser, text, l_options, True, Void)
							if l_wrapper.has_error then
									-- It is quite possible for the license to introduce a syntax error because the last
									-- feature may be an attribute, in which case we need to inject a ;.

									-- Undo changes.
								rollback
								l_data := modified_data
								if not l_data.is_prepared then
										-- Need to reprepare the text again
									l_data.prepare
								end

									-- Add ; to license and reapply.
								l_new_license.prepend_character (';')
								insert_code (l_start_position, l_new_license)
							end
						end
					end
				end
			end
		ensure
			is_dirty: (a_license /= Void and then not a_license.as_string_32.is_equal (license) implies is_dirty) or else
				((a_license = Void and then not old license.is_empty) implies is_dirty)
		end

feature {NONE} -- Query

	ast_license_name_from_indexing (a_clause: attached INDEXING_CLAUSE_AS): detachable INDEX_AS
			-- Attempts to retrieve an {INDEX_AS} representing a specified license name.
			--
			-- `a_clause': An indexing clause to extract a license name from.
			-- `Result': An indexing term presenting the license name or Void if none was found.
		require
			is_interface_usable: is_interface_usable
		local
			l_index: INDEX_AS
			l_tag: ID_AS
		do
			from a_clause.start until a_clause.after or Result /= Void loop
				l_index := a_clause.item
				if l_index /= Void then
					l_tag := l_index.tag
					if l_tag /= Void then
						if l_tag.name.is_case_insensitive_equal (license_name_term) then
							Result := l_index
						end
					end
				end
				a_clause.forth
			end
		ensure
			result_is_license_id_term: Result /= Void implies
				(Result.tag /= Void and then Result.tag.name.is_case_insensitive_equal (license_name_term))
		end

feature -- Status report

	is_valid_license (a_license: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Detemines if a license text is valid for the current modifier.
			--
			-- `a_license': The license to validate.
			-- `Result': True if the license if valid; False otherwise.
		require
			a_license_attached: a_license /= Void
		do
			Result := a_license.is_empty or else is_parse_valid_license (a_license)
		ensure
			is_valid: Result implies (a_license.is_empty or else is_parse_valid_license (a_license))
		end

feature {NONE} -- Status report

	is_parse_valid_license (a_license: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Detemines if a license text is Eiffel parser valid.
			--
			-- `a_license': The license to validate.
			-- `Result': True if the license if valid; False otherwise.
		require
			a_license_attached: a_license /= Void
			not_a_license_is_empty: not a_license.is_empty
		local
			l_parser: attached like indexing_parser
			l_wrapper: attached like eiffel_parser_wrapper
			l_options: CONF_OPTION
		do
			l_wrapper := eiffel_parser_wrapper
			l_parser := indexing_parser

			l_options := context_class.options
			check l_options_attached: l_options /= Void end

			l_wrapper.parse_with_option_32 (l_parser, a_license, l_options, True, Void)
			if not l_wrapper.has_error then
				Result := l_wrapper.ast_node /= Void
			end
		end

feature {NONE} -- Basic operations: Modifications

	merge_license_code (a_ast: attached INDEXING_CLAUSE_AS; a_match_list: attached LEAF_AS_LIST; a_license: attached READABLE_STRING_GENERAL)
			-- Merges a license with an indexing/note clause.
			--
			-- `a_ast': An AST indexing node.
			-- `a_match_list': A match list for the AST indexing node.
			-- `a_license': The license to merge with the supplied AST indexing node.
		require
			not_a_license_is_empty: not a_license.is_empty
			a_license_is_valid_license: is_valid_license (a_license)
		local
			l_wrapper: like eiffel_parser_wrapper
			l_index: INDEX_AS
			l_old_index: detachable INDEX_AS
			l_tag_name: STRING_GENERAL
			l_atoms: EIFFEL_LIST [ATOMIC_AS]
		do
			l_wrapper := eiffel_parser_wrapper
			l_wrapper.parse_with_option_32 (round_trip_indexing_parser, a_license, context_class.options, True, Void)
			if not l_wrapper.has_error then
				if
					attached {INDEXING_CLAUSE_AS} l_wrapper.ast_node as l_indexing and then
					not l_indexing.is_empty
				then
					check attached {LEAF_AS_LIST} l_wrapper.ast_match_list as l_match_list then
						from l_indexing.start until l_indexing.after loop
							l_index := l_indexing.item_for_iteration
							l_tag_name := l_index.tag.name
							l_old_index := a_ast.index_as_of_tag_name (l_tag_name)
							if l_old_index /= Void then
								l_atoms := l_old_index.index_list
								replace_code (l_atoms.complete_character_start_position (a_match_list),
											l_atoms.complete_character_end_position (a_match_list),
											l_index.index_list.text_32 (l_match_list))
							else
								insert_code (a_ast.complete_character_end_position (a_match_list) + 1, {STRING_32} "%N%T" + l_index.text_32 (l_match_list))
							end
							l_indexing.forth
						end
					end
				end
			end
		end

feature {NONE} -- Helpers

	indexing_parser: attached EIFFEL_PARSER
			-- A parser used to parse indexing clauses
		once
			create Result.make
			Result.set_indexing_parser
		ensure
			result_is_indexing_parser: Result.indexing_parser
		end

	round_trip_indexing_parser: attached EIFFEL_PARSER
			-- A parser used to parse indexing clauses, with round-trip facilities.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_FACTORY})
			Result.set_indexing_parser
		ensure
			result_is_indexing_parser: Result.indexing_parser
		end

feature -- Constants

	license_name_term: STRING = "license_name"
			-- Note term for specifying a license ID.

	default_license_name: STRING = "default"
			-- Default license name.

feature {NONE} -- Implementation: Internal cache

	internal_license: detachable like license
			-- Cached version of `license'.
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
