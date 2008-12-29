note
	description: "Factory to produce criteria"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CRITERION_FACTORY

inherit
	QL_SHARED_NAMES

feature{NONE} -- Initialization

	make
			-- Initialize.
		deferred
		ensure
			agent_table_attached: agent_table /= Void
			name_table_attached: name_table /= Void
		end

feature -- Criterion creation

	simple_criterion_with_index (a_index: INTEGER): like criterion_type
			-- Simple criterion with index `a_index'
			-- A simple criterion is a criterion that needs no argument to initialize,
			-- such as is_compiled for all kinds of items, and is_deferred for class and feature item.
			-- In contrast, a criterion that is not simple needs some argument to initialize,
			-- for example, name_is criterion needs a name, a case-sensitive flag, and a regular
			-- expression usage flag as arguments.
		require
			criterion_exists: has_criterion_with_index (a_index)
		do
			Result := criterion_with_index (a_index, [])
		end

	simple_criterion_with_name (a_name: STRING): like criterion_type
			-- Simple criterion with name `a_name'
			-- `a_name' should be in lower case and without heading and trailing spaces.			
			-- A simple criterion is a criterion that needs no argument to initialize.
			-- See `simple_criterion_with_index' for more information.
		require
			a_name_attached: a_name /= Void
			criterion_exists: has_criterion_with_name (a_name)
		do
			Result := simple_criterion_with_index (name_table.item (a_name))
		end

	criterion_with_index (a_index: INTEGER; a_argu: TUPLE): like criterion_type
			-- Criterion with `index' and `a_argu' as its initialization arguments
			-- Void if no criterion with `a_name' is applicable with respect to current scope
		require
			criterion_exists: has_criterion_with_index (a_index)
		local
			l_creation_function: like creation_function
		do
			l_creation_function := agent_table.item (a_index)
			if l_creation_function.valid_operands (a_argu) then
				Result := l_creation_function.item (a_argu)
			end
		end

	criterion_with_name (a_name: STRING; a_argu: TUPLE): like criterion_type
			-- Criterion with `a_name' as `a_argu' as its initialization arguments
			-- Void if no criterion with `a_name' is applicable with respect to current scope
		require
			a_name_attached: a_name /= Void
			criterion_exists: has_criterion_with_name (a_name)
		do
			Result := criterion_with_index (name_table.item (a_name), a_argu)
		end

	avaliable_indexes: LIST [INTEGER]
			-- List of indexes for all supported criteria
		local
			l_index_table: like agent_table
		do
			l_index_table := agent_table
			create {ARRAYED_LIST [INTEGER]} Result.make (l_index_table.count)
			from
				l_index_table.start
			until
				l_index_table.after
			loop
				Result.extend (l_index_table.key_for_iteration)
				l_index_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

	available_names: LIST [STRING]
			-- List of names for all supported criteria
		local
			l_index_table: like name_table
		do
			l_index_table := name_table
			create {ARRAYED_LIST [STRING]} Result.make (l_index_table.count)
			from
				l_index_table.start
			until
				l_index_table.after
			loop
				Result.extend (l_index_table.key_for_iteration)
				l_index_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	has_criterion_with_index (a_index: INTEGER): BOOLEAN
			-- Does Current contain criterion with index `a_index'?
		do
			Result := agent_table.has (a_index)
		end

	has_criterion_with_name (a_name: STRING): BOOLEAN
			-- Does Current contain criterion named `a_name'?
			-- `a_name' should be in lower case and without heading and trailing spaces.
		require
			a_name_attached: a_name /= Void
		do
			Result := name_table.has (a_name)
		end

feature{NONE} -- Implementation

	creation_function: FUNCTION [ANY, TUPLE, like criterion_type]
			-- Creation function type anchor

	criterion_type: QL_CRITERION
			-- Criterion anchor type

	item_type: QL_ITEM
			-- Item anchor type

	simple_criterion_type: QL_SIMPLE_CRITERION
			-- Simple criterion type

	agent_table: HASH_TABLE [like creation_function, INTEGER]
			-- Agent table for create a criterion.
			-- Key is agent index, value is that agent.

	name_table: HASH_TABLE [INTEGER, STRING]
			-- Name-index table
			-- Key is agent index, value is name of the criterion that the agent creates

	ast_index_list_from_string (a_text: STRING): LIST [INTEGER]
			-- A list of AST node indexes parsed from `a_text'
			-- `a_text' is of the form: "ast_type1, ast_type2, ..., ast_typen".
			-- For example, "if, inspect, loop, integer".
		require
			a_text_attached: a_text /= Void
		local
			l_str_list: LIST [STRING]
			l_str: STRING
			l_indexes: ARRAY [INTEGER]
			l_ast_index_table: HASH_TABLE [ARRAY [INTEGER], STRING]
		do
			create {LINKED_LIST [INTEGER]} Result.make
			l_str_list := a_text.split (',')
			l_ast_index_table := query_language_names.ast_index_table
			from
				l_str_list.start
			until
				l_str_list.after
			loop
				l_str := l_str_list.item
				l_str.left_adjust
				l_str.right_adjust
				if not l_str.is_empty then
					l_indexes := l_ast_index_table.item (l_str)
					if l_indexes /= Void then
						l_indexes.do_all (agent Result.extend)
					end
				end
				l_str_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	value_criterion_evalaute_agent (a_item: QL_ITEM; a_evaluate_value_func: FUNCTION [ANY, TUPLE [QL_ITEM], BOOLEAN]): BOOLEAN
			-- Value agent for value criterion.
		require
			a_item_attached: a_item /= Void
			a_evaluate_value_func_attached: a_evaluate_value_func /= Void
		do
			Result := a_evaluate_value_func.item ([a_item])
		end

invariant
	agent_index_table_attached: agent_table /= Void
	index_name_table_attached: name_table /= Void

note
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

end
