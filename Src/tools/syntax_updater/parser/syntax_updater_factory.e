note
	description: "Fast parser that only recognizes the old constructs"
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_UPDATER_FACTORY

inherit
	AST_NULL_FACTORY
		redefine
			new_creation_keyword_as,
			new_keyword_as,
			new_keyword_id_as,
			new_old_syntax_object_test_as,
			new_static_access_as,
			new_class_type_as,
			new_filled_id_as
		end

feature -- Access

	has_obsolete_constructs: BOOLEAN
			-- Does current class has some obsolete constructs?

	is_updating_agents: BOOLEAN
			-- Are we updating agents to drop the first actual generic parameter
			-- and replacing TUPLE with nothing, i.e. PROCEDURE [ANY, TUPLE [STRING]]
			-- becoming PROCEDURE [STRING].

feature -- Status setting

	reset
		do
			has_obsolete_constructs := False
		ensure
			no_obsolete_constructs: not has_obsolete_constructs
		end

	set_is_updating_agents (v: like is_updating_agents)
			-- Set `is_updating_agents' with `v'.
		do
			is_updating_agents := v
		ensure
			is_updating_agents_set: is_updating_agents = v
		end

feature -- Processing

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER): detachable KEYWORD_AS
		do
			has_obsolete_constructs := True
		end

	new_keyword_as (a_code: INTEGER_32; a_scn: EIFFEL_SCANNER): detachable KEYWORD_AS
			-- New KEYWORD_AS only for `feature' and `creation'.
		do
			inspect a_code
			when {EIFFEL_TOKENS}.te_feature  then
				create Result.make (a_code, a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count, a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
			when {EIFFEL_TOKENS}.te_is, {EIFFEL_TOKENS}.te_indexing then
				has_obsolete_constructs := True
			else
			end
		end

	new_keyword_id_as (a_code: INTEGER_32; a_scn: EIFFEL_SCANNER_SKELETON): detachable like keyword_id_type
			-- New KEYWORD AST node
		do
			inspect a_code
			when {EIFFEL_TOKENS}.te_is, {EIFFEL_TOKENS}.te_indexing then
				has_obsolete_constructs := True
			else
			end
		end

	new_old_syntax_object_test_as (start: detachable SYMBOL_AS; name: detachable ID_AS; type: detachable TYPE_AS; expression: detachable EXPR_AS): detachable OBJECT_TEST_AS
		do
			has_obsolete_constructs := True
		end

--	new_old_routine_creation_as (l: AST_EIFFEL; t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: SYMBOL_AS): PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
--		do
--			has_obsolete_constructs := True
--		end

	new_static_access_as (c: detachable TYPE_AS; f: detachable ID_AS; p: detachable PARAMETER_LIST_AS; f_as: detachable KEYWORD_AS; d_as: detachable SYMBOL_AS): detachable STATIC_ACCESS_AS
		do
			has_obsolete_constructs := has_obsolete_constructs or else f_as /= Void
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable ID_AS
		local
			l_cnt: INTEGER_32
			l_str: STRING_8
		do
				-- Filter all identifiers based on the agent types. Only in `new_class_type_as'
				-- do we check that they are not just identifier, but class types.
			if
				not has_obsolete_constructs and then is_updating_agents and then
				(a_scn.utf8_text.is_case_insensitive_equal (routine_class_name) or
				a_scn.utf8_text.is_case_insensitive_equal (procedure_class_name) or
				a_scn.utf8_text.is_case_insensitive_equal (function_class_name) or
				a_scn.utf8_text.is_case_insensitive_equal (predicate_class_name))
			then
				l_cnt := a_scn.text_count
				l_str := Reusable_string_buffer
				l_str.wipe_out
				a_scn.append_text_to_string (l_str)
				create Result.initialize (l_str)
				Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt, a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
			end
		end

	new_class_type_as (n: detachable ID_AS; g: detachable TYPE_LIST_AS): detachable CLASS_TYPE_AS
			-- <Precursor>
		do
			if attached n then
				check
					is_not_empty: not n.name_32.is_empty
					is_agent_name:
						n.name_32.same_caseless_characters (routine_class_name, 1, routine_class_name.count, 1) or
						n.name_32.same_caseless_characters (procedure_class_name, 1, procedure_class_name.count, 1) or
						n.name_32.same_caseless_characters (function_class_name, 1, function_class_name.count, 1) or
						n.name_32.same_caseless_characters (predicate_class_name, 1, predicate_class_name.count, 1)
				end
				has_obsolete_constructs := True
			end
		end

feature {NONE} -- Implementation

	routine_class_name: STRING_8 = "ROUTINE"
	procedure_class_name: STRING_8 = "PROCEDURE"
	function_class_name: STRING_8 = "FUNCTION"
	predicate_class_name: STRING_8 = "PREDICATE"
			-- Name of agent types being in use.

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
