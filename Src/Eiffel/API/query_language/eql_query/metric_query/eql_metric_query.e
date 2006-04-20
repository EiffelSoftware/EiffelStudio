indexing
	description: "Object that represents a query for a metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_METRIC_QUERY

inherit
	EQL_QUERY
		redefine
			last_result,
			executable
		end

feature -- Access

	metric: EB_METRIC
			-- Metric to execute

feature -- Setting

	set_metric (a_metric: like metric) is
			-- Set `metric' with `a_metric'.
		require
			a_metric_not_void: a_metric /= Void
		do
			metric := a_metric
		ensure
			metric_set: metric = a_metric
		end

feature -- Result

	last_result: EQL_RESULT [EQL_METRIC_ITEM]
			-- Last result

feature -- Status reporting

	executable (a_single_scope: EQL_SINGLE_SCOPE): BOOLEAN is
			-- Is current query exectuable over `a_single_scope'?
		local
			l_metric_scope: EQL_METRIC_SINGLE_SCOPE
		do
			if a_single_scope.is_metric_scope then
				l_metric_scope ?= a_single_scope
				Result := l_metric_scope.valid_scope
			end
		end

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_metric_scope: EQL_METRIC_SINGLE_SCOPE
		do
			if a_single_scope.is_metric_scope then
				l_metric_scope ?= a_single_scope
				last_result.extend (
					create {EQL_TREE_NODE [EQL_METRIC_ITEM]}.make_with_data (last_result,
						create{EQL_METRIC_ITEM}.make_with_data (metric.value (l_metric_scope))))
			end
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
