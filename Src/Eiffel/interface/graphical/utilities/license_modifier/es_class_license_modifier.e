indexing
	description: "[
		A modifier used to inject a license text into a class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_LICENSE_MODIFIER

inherit
	ES_CLASS_TEXT_AST_MODIFIER

create
	make

feature -- Access

	license_name: ?STRING_32
			-- Name of the license previously assigned to the class.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_ast: ?like ast_license_name
			l_list: EIFFEL_LIST [ATOMIC_AS]
			l_result: ?STRING_32
		do
			l_ast := ast_license_name
			if l_ast /= Void then
				l_list := l_ast.index_list
				if l_list /= Void and then not l_list.is_empty then
						-- Take the first index value, ignore all others, in case of a typo on the user's part.
					if {l_string: STRING_AS} l_list.first then
						l_result := l_string.value.as_string_32
						if not l_result.is_empty then
							Result := l_result
						end
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	license: !STRING_32
			-- The current license text of the current class
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_ast: ?like ast_license
		do
			if {l_result: like internal_license} internal_license then
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

	ast_license_name: ?INDEX_AS
			-- License name AST node.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_indexing: ?INDEXING_CLAUSE_AS
		do
			l_indexing := ast.top_indexes
			if l_indexing /= Void then
				Result := ast_license_name_from_indexing (l_indexing)
			else
				l_indexing := ast.bottom_indexes
				if l_indexing /= Void then
					Result := ast_license_name_from_indexing (l_indexing)
				end
			end
		ensure
			result_is_license_id_term: Result /= Void implies
				(Result.tag /= Void and then Result.tag.name.is_case_insensitive_equal (license_name_term))
		end

	ast_license: ?INDEXING_CLAUSE_AS
			-- License section AST node.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		local
			l_ast: ?like ast
		do
			l_ast := ast
			Result := l_ast.internal_bottom_indexes
		end

feature -- Element change

	set_license_name (a_name: ?STRING_GENERAL)
			-- Sets the license name for the current class.
			--
			-- `a_name': The name of the license, as found in a license file, or Void to remove.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			not_a_name_is_empty: a_name /= Void implies not a_name.is_empty
		local
			l_ast: ?AST_EIFFEL
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

	set_license (a_license: ?STRING_GENERAL)
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
			l_ast: ?AST_EIFFEL
			l_pos: !like ast_position
			l_license: !STRING_32
			l_data: like modified_data
			l_parser: !like indexing_parser
			l_wrapper: !like eiffel_parser_wrapper
			l_options: CONF_OPTION
		do
			if a_license = Void then
					-- Remove the license
				l_ast := ast_license
				if l_ast /= Void then
					remove_ast_code (l_ast, remove_white_space_trailing)
				end
			else
				if not a_license.as_string_32.is_equal (license) then
						-- The license is different from the class license, so change it.
					l_ast := ast_license
					if l_ast /= Void then
						l_pos := ast_position (l_ast)
						replace_code (l_pos.start_position, l_pos.end_position, a_license)
					else
							-- There is not indexing AST clause, so insert just above the class end keyword.
						l_ast := ast.end_keyword
						if l_ast /= Void then
							create l_license.make_from_string (a_license)
							l_license.append_character ('%N')
							l_pos := ast_position (l_ast)
							insert_code (l_pos.start_position, l_license)

							l_wrapper := eiffel_parser_wrapper
							l_parser := validating_parser
							l_options := context_class.options
							check l_options_attached: l_options /= Void end

							l_wrapper.parse_with_option (l_parser, text, l_options, True)
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
								l_license.prepend_character (';')
								insert_code (l_pos.start_position, l_license)
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

	ast_license_name_from_indexing (a_clause: !INDEXING_CLAUSE_AS): ?INDEX_AS
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

	is_valid_license (a_license: ?STRING_GENERAL): BOOLEAN
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

	is_parse_valid_license (a_license: ?STRING_GENERAL): BOOLEAN
			-- Detemines if a license text is Eiffel parser valid.
			--
			-- `a_license': The license to validate.
			-- `Result': True if the license if valid; False otherwise.
		require
			a_license_attached: a_license /= Void
			not_a_license_is_empty: not a_license.is_empty
		local
			l_parser: !like indexing_parser
			l_wrapper: !like eiffel_parser_wrapper
			l_options: CONF_OPTION
		do
			l_wrapper := eiffel_parser_wrapper
			l_parser := indexing_parser

			l_options := context_class.options
			check l_options_attached: l_options /= Void end

			l_wrapper.parse_with_option (l_parser, a_license, l_options, True)
			if not l_wrapper.has_error then
				Result := l_wrapper.ast_node /= Void
			end
		end

feature {NONE} -- Helpers

	indexing_parser: !EIFFEL_PARSER
			-- A parser used to parse indexing clauses
		once
			create Result.make
			Result.set_indexing_parser
		ensure
			result_is_indexing_parser: Result.indexing_parser
		end

feature -- Constants

	license_name_term: !STRING = "license_name"
			-- Note term for specifying a license ID.

	default_license_name: !STRING = "default"
			-- Default license name.

feature {NONE} -- Implementation: Internal cache

	internal_license: ?like license
			-- Cached version of `license'.
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
