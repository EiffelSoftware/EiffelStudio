indexing
	description: "Object that represents a query for a metric"
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

end
