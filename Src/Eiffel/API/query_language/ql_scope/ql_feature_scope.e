indexing
	description: "Object that represents a feature scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_SCOPE

inherit
	QL_SCOPE
		redefine
			basic_scope,
			domain_generator,
			path_domain_generator,
			empty_domain
		end

create
	make

feature{QL_SHARED_SCOPES} -- Initialization

	make is
			-- Initialize.
		do
			index := feature_scope_index
		ensure
			scope_index_set: index = feature_scope_index
		end

feature -- Metric support

	basic_scope (a_calculate_function: FUNCTION [ANY, TUPLE [QL_FEATURE], DOUBLE];
	                  a_criterion: QL_FEATURE_CRITERION): QL_METRIC_FEATURE_BASIC_SCOPE_INFO is
			-- Metric basic scope information that uses `a_calculate_function' and `a_criterion' to calculate metric.
			-- If `a_calculate_function' or `a_criterion' is Void, default value will be used.
			-- Default value for `a_calculate_function' is to do counting simply, and for `a_criterion' is a tautology criterion.
		do
			create Result.make (a_calculate_function)
		end

feature -- Access

	domain_generator: QL_FEATURE_DOMAIN_GENERATOR is
			-- Domain generator for current scope
		do
			create Result
		end

	path_domain_generator (a_item: QL_FEATURE; a_path: STRING): QL_DOMAIN_GENERATOR is
			-- Domain generator for current scope
		local
			l_assert_name: STRING
		do
			if assertion_path_marker.is_equipped_with_marker (a_path) then
				create {QL_ASSERTION_DOMAIN_GENERATOR}Result
				l_assert_name := assertion_path_marker.base_name (a_path)
				if not l_assert_name.is_equal (empty_assertion_name) then
					Result.set_criterion (create{QL_ASSERTION_NAME_IS_CRI}.make_with_setting (l_assert_name, False, True))
				else
					Result.set_criterion (create{QL_ASSERTION_NAME_IS_CRI}.make_with_setting ("", False, True))
				end
			elseif argument_path_marker.is_equipped_with_marker (a_path) then
				create {QL_ARGUMENT_DOMAIN_GENERATOR}Result
				Result.set_criterion (create {QL_ARGUMENT_NAME_IS_CRI}.make_with_setting (argument_path_marker.base_name (a_path), False, True))
			elseif local_path_marker.is_equipped_with_marker (a_path) then
				create {QL_LOCAL_DOMAIN_GENERATOR}Result
				Result.set_criterion (create {QL_LOCAL_NAME_IS_CRI}.make_with_setting (local_path_marker.base_name (a_path), False, True))
			elseif line_path_marker.is_equipped_with_marker (a_path) then
				create {QL_LINE_DOMAIN_GENERATOR}Result
				Result.set_criterion (create {QL_LINE_NAME_IS_CRI}.make_with_setting (line_path_marker.base_name (a_path), False, True))
			end
		end

	empty_domain: QL_FEATURE_DOMAIN is
			-- An empty domain whose scope is feature
		do
			create Result.make
		end

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
