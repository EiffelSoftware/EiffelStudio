indexing
	description: "Object that represents a feature local variable scope"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LOCAL_SCOPE

inherit
	QL_SCOPE
		redefine
			domain_generator,
			path_domain_generator,
			basic_scope,
			empty_domain,
			delayed_domain
		end

create
	make

feature{QL_SHARED_SCOPES} -- Initialization

	make is
			-- Initialize.
		do
			index := local_scope_index
		ensure
			scope_index_set: index = local_scope_index
		end

feature -- Access

	criterion (a_name: STRING; a_argu: TUPLE): QL_CRITERION is
			-- Criterion with `a_name' as `a_argu' as its initialization arguments
			-- Void if no criterion with `a_name' is applicable with respect to current scope
		do
			to_implement ("Implement criterion for line scope")
		end

	domain_generator: QL_LOCAL_DOMAIN_GENERATOR is
			-- Domain generator for current scope
		do
			create Result
		end

	path_domain_generator (a_item: QL_LOCAL; a_path: STRING): QL_DOMAIN_GENERATOR is
			-- Domain generator for current scope
		do
			if line_path_marker.is_equipped_with_marker (a_path) then
				create {QL_LINE_DOMAIN_GENERATOR}Result
				Result.set_criterion (create {QL_LINE_NAME_IS_CRI}.make_with_setting (line_path_marker.base_name (a_path), False, True))
			end
		ensure then
			good_result: line_path_marker.is_equipped_with_marker (a_path) implies Result /= Void
		end

	empty_domain: QL_LOCAL_DOMAIN is
			-- An empty domain whose scope is local
		do
			create Result.make
		end

	delayed_domain: QL_DELAYED_LOCAL_DOMAIN is
			-- An empty delayed domain whose scope is same as current scope
		do
			create Result
		end

feature -- Metric support

	basic_scope (a_calculate_function: FUNCTION [ANY, TUPLE [QL_LOCAL], DOUBLE]; a_criterion: QL_LOCAL_CRITERION): QL_METRIC_LOCAL_BASIC_SCOPE_INFO is
			-- Metric basic scope information that uses `a_calculate_function' and `a_criterion' to calculate metric.
			-- If `a_calculate_function' or `a_criterion' is Void, default value will be used.
			-- Default value for `a_calculate_function' is to do counting simply, and for `a_criterion' is a tautology criterion.
		do
			create Result.make (a_calculate_function)
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
