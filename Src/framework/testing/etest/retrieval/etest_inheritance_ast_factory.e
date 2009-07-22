note
	description: "[
		Objects that represent a simplified ast factory which records the names of ancestors when parsing
		a class. Once it has traversed the inheritance section parsing is aborted.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_INHERITANCE_AST_FACTORY

inherit
	AST_NULL_FACTORY
		redefine
			new_keyword_as,
			new_filled_id_as,
			new_parent_as
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create internal_ancestors.make_default
			reset
		ensure
			ancestors_empty: ancestors.is_empty
			not_parsing_ancestors: not is_parsing_ancestors
			not_parsing_parent_clause: not is_parsing_parent_clause
		end

feature -- Access

	ancestors: DS_LINEAR [STRING]
			-- Name of ancestors which were found during last parse
		do
			Result := internal_ancestors
		end

feature {NONE} -- Access

	internal_ancestors: DS_ARRAYED_LIST [STRING]
			-- Internal storage for `ancestors'

feature -- Status report

	is_reset: BOOLEAN
			-- Is `Current' in default state
		do
			Result := internal_ancestors.is_empty and then
				not (is_parsing_ancestors or is_parsing_parent_clause)
		end

feature {NONE} -- Status report

	is_parsing_ancestors: BOOLEAN
			-- Are we currently parsing the ancestors?

	is_parsing_parent_clause: BOOLEAN
			-- Are we currently parsing an inheritance clause?

feature -- Status setting

	reset
			-- Remove items in `ancestors'
		do
			ancestors.wipe_out
			is_parsing_ancestors := False
			is_parsing_parent_clause := False
		end

feature -- Query

	new_keyword_as (a_code: INTEGER_32; a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- <Precursor>
		do
			if a_code = {EIFFEL_TOKENS}.te_inherit then
				is_parsing_ancestors := True
			elseif is_parsing_ancestors then
				if a_code = {EIFFEL_TOKENS}.te_export or a_code = {EIFFEL_TOKENS}.te_undefine or
				   a_code = {EIFFEL_TOKENS}.te_redefine or a_code = {EIFFEL_TOKENS}.te_rename or
				   a_code = {EIFFEL_TOKENS}.te_select then
					is_parsing_parent_clause := True
				end
			end
			if a_code = {EIFFEL_TOKENS}.te_create or a_code = {EIFFEL_TOKENS}.te_creation or
			   a_code = {EIFFEL_TOKENS}.te_convert or a_code = {EIFFEL_TOKENS}.te_feature or
			   a_code = {EIFFEL_TOKENS}.te_invariant or (is_parsing_ancestors and
			   a_code = {EIFFEL_TOKENS}.te_indexing) then
				is_parsing_ancestors := False
				if attached {EIFFEL_PARSER} a_scn as l_parser then
					l_parser.abort
				end
			end
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS
			-- <Precursor>
		local
			l_type: STRING
		do
			if is_parsing_ancestors then
				if not is_parsing_parent_clause  then
					create l_type.make (a_scn.text_count)
					a_scn.append_text_to_string (l_type)
					if not l_type.is_case_insensitive_equal ("NONE") then
						internal_ancestors.force_last (l_type.as_upper)
					end
				end
			end
		end

	new_parent_as (t: CLASS_TYPE_AS; rn: RENAME_CLAUSE_AS; e: EXPORT_CLAUSE_AS; u: UNDEFINE_CLAUSE_AS; rd: REDEFINE_CLAUSE_AS; s: SELECT_CLAUSE_AS; ed: KEYWORD_AS): PARENT_AS
			-- <Precursor>
		do
			is_parsing_parent_clause := False
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
