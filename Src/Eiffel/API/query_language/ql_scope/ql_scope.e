indexing
	description: "Scope used int Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_SCOPE

inherit
	QL_CONSTANT
		undefine
			is_equal
		end

	COMPARABLE

	QL_SHARED_SCOPE_CONSTANTS
		export
			{NONE}all
		undefine
			is_equal
		end

	QL_SHARED_PATH_MARKER
		undefine
			is_equal
		end

	QL_SHARED
		undefine
			is_equal
		end

	REFACTORING_HELPER
		undefine
			is_equal
		end

feature -- Access

	name: STRING is
			-- Name of current scope
		do
			Result := scope_names.item (index)
		ensure then
			result_correct: Result.is_equal (scope_names.item (index))
		end

	index: INTEGER
			-- Index of current scope

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator for current scope
		deferred
		ensure
			result_attached: Result /= Void
		end

	path_domain_generator (a_item: QL_ITEM; a_path: STRING): QL_DOMAIN_GENERATOR is
			-- Domain generator for current scope
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		deferred
		ensure
			result_attached: Result /= Void
		end

	empty_domain: QL_DOMAIN is
			-- An empty domain whose scope is same as current scope
		deferred
		ensure
			result_attached: Result /= Void
			result_is_empty: Result.is_empty
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := index < other.index
		end

feature -- Metric support

	basic_scope (a_calculate_function: FUNCTION [ANY, TUPLE [QL_ITEM], DOUBLE]; a_criterion: QL_CRITERION): QL_METRIC_BASIC_SCOPE_INFO is
			-- Metric basic scope information that uses `a_calculate_function' and `a_criterion' to calculate metric.
			-- If `a_calculate_function' or `a_criterion' is Void, default value will be used.
			-- Default value for `a_calculate_function' is to do counting simply, and for `a_criterion' is a tautology criterion.
		deferred
		ensure
			result_attached: Result /= Void
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
