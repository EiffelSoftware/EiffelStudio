indexing
	description: "Fast parser that only recognizes the old constructs"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_UPDATER_FACTORY

inherit
	AST_NULL_FACTORY
		redefine
			new_bang_creation_as,
			new_bang_creation_expr_as,
			new_old_routine_creation_as,
			new_static_access_as,
			new_keyword_as,
			new_creation_keyword_as
		end

feature -- Access

	has_obsolete_constructs: BOOLEAN
			-- Does current class has some obsolete constructs?

feature -- Status setting

	reset is
		do
			has_obsolete_constructs := False
		ensure
			no_obsolete_constructs: not has_obsolete_constructs
		end

feature -- Processing

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
		do
			has_obsolete_constructs := True
		end

	new_keyword_as (a_code: INTEGER_32; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD_AS only for `feature' and `creation'.
		do
			inspect a_code
			when {EIFFEL_TOKENS}.te_feature  then
				create Result.make (a_code, a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)

			when {EIFFEL_TOKENS}.te_is, {EIFFEL_TOKENS}.te_indexing then
				has_obsolete_constructs := True
			else

			end
		end

	new_static_access_as (c: TYPE_AS; f: ID_AS; p: PARAMETER_LIST_AS; f_as: KEYWORD_AS; d_as: SYMBOL_AS): STATIC_ACCESS_AS is
		do
			has_obsolete_constructs := has_obsolete_constructs or else f_as /= Void
		end

	new_bang_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_AS is
		do
			has_obsolete_constructs := True
		end

	new_bang_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_EXPR_AS is
		do
			has_obsolete_constructs := True
		end

	new_old_routine_creation_as (l: AST_EIFFEL; t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: SYMBOL_AS): PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
			has_obsolete_constructs := True
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
