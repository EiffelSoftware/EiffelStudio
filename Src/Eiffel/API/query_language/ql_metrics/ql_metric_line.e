indexing
	description: "Metric to calculate line"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_METRIC_LINE

inherit
	QL_METRIC_BASIC
		rename
			make as old_make,
			internal_generator_table as normal_generator_table
		redefine
			set_criterion,
			basic_scope_table
		end

	QL_SHARED_UNIT

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize current.
		do
			unit := line_unit
			setup_generator_table
		ensure
			unit_set: unit = line_unit
		end

feature -- Setting

	set_criterion (a_criterion: QL_CRITERION) is
			-- Set criterion used when calculate metric
			-- A metric can have several basic scopes, and `a_criterion' is only set into
			-- that scope which has the same scope as `a_criterion'.
		do
			criterion := a_criterion
			Precursor (a_criterion)
		ensure then
			criterion_set: criterion = a_criterion
		end

feature -- Access

	criterion: QL_CRITERION
			-- Criterion used to calculate metric

feature{NONE} -- Implementation

	basic_scope_table: HASH_TABLE [QL_METRIC_BASIC_SCOPE_INFO, QL_SCOPE] is
			-- Table of domain generators per scope
		do
			if criterion = Void then
					-- We use a faster algorithm to count line if no `criterion' is specified.
				Result := fast_generator_table
			else
					-- With a criterion specified, calculate metric in normal way.
				Result := normal_generator_table
			end
		ensure then
			good_result: (criterion = Void implies Result = fast_generator_table) and
						 (criterion /= Void implies Result = normal_generator_table)
		end

	fast_generator_table: like basic_scope_table
			-- Generator table used in fast calculation mode

	setup_generator_table is
			-- Setup both `normal_generator_table' and `fast_generator_table'.
		local
			l_scopes: like scopes
			l_class_basic_scope: QL_METRIC_CLASS_BASIC_SCOPE_INFO
			l_generic_basic_scope: QL_METRIC_GENERIC_BASIC_SCOPE_INFO
			l_feature_basic_scope: QL_METRIC_FEATURE_BASIC_SCOPE_INFO
			l_local_basic_scope: QL_METRIC_LOCAL_BASIC_SCOPE_INFO
			l_argument_basic_scope: QL_METRIC_ARGUMENT_BASIC_SCOPE_INFO
			l_assertion_basic_scope: QL_METRIC_ASSERTION_BASIC_SCOPE_INFO
			l_line_basic_scope: QL_METRIC_LINE_BASIC_SCOPE_INFO
			l_quantity_basic_scope: QL_METRIC_QUANTITY_BASIC_SCOPE_INFO
		do
			l_scopes := scopes
				-- Setup `fast_generator_table'.
			create fast_generator_table.make (l_scopes.count)
			create l_line_basic_scope.make (Void)
			l_scopes.do_all (agent normal_generator_table.put (l_line_basic_scope, ?))

				-- Setup `normal_generator_table'.
			create normal_generator_table.make (l_scopes.count)
			create l_class_basic_scope.make (agent number_of_lines_in_code_structure ({QL_CLASS}?))
			create l_generic_basic_scope.make (agent number_of_lines_in_code_structure ({QL_GENERIC}?))
			create l_feature_basic_scope.make (agent number_of_lines_in_code_structure ({QL_FEATURE}?))
			create l_local_basic_scope.make (agent number_of_lines_in_code_structure ({QL_LOCAL}?))
			create l_argument_basic_scope.make (agent number_of_lines_in_code_structure ({QL_ARGUMENT}?))
			create l_assertion_basic_scope.make (agent number_of_lines_in_code_structure ({QL_ASSERTION}?))
			create l_line_basic_scope.make (Void)
			create l_quantity_basic_scope.make (Void)
			normal_generator_table.put (l_class_basic_scope, target_scope)
			normal_generator_table.put (l_class_basic_scope, group_scope)
			normal_generator_table.put (l_class_basic_scope, class_scope)
			normal_generator_table.put (l_generic_basic_scope, generic_scope)
			normal_generator_table.put (l_feature_basic_scope, feature_scope)
			normal_generator_table.put (l_local_basic_scope, local_scope)
			normal_generator_table.put (l_argument_basic_scope, argument_scope)
			normal_generator_table.put (l_assertion_basic_scope, assertion_scope)
			normal_generator_table.put (l_line_basic_scope, line_scope)
			normal_generator_table.put (l_quantity_basic_scope, quantity_scope)
		ensure
			fast_generator_table_attached: fast_generator_table /= Void
			normal_generator_table_attached: normal_generator_table /= Void
		end

	number_of_lines_in_code_structure (a_item: QL_CODE_STRUCTURE_ITEM): DOUBLE is
			-- Number of lines in `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_text: STRING
			l_count: INTEGER
			l_last_new_line_position: INTEGER
		do
			l_text := a_item.text
			check l_text /= Void end
			Result := l_text.occurrences ('%N')
			l_count := l_text.count
			l_last_new_line_position := l_text.last_index_of ('%N', l_count)
			if l_last_new_line_position /= l_count then
				Result := Result + 1.0
			end
		end

invariant
	fast_generator_table_attached: fast_generator_table /= Void
	normal_generator_table_attached: normal_generator_table /= Void

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


end
