indexing
	description: "Representation of metrics composing a composite metric%N%
				%to ease metric calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_MEASURE

inherit
	EB_METRIC_VALUE

	EB_CONSTANTS

create
	make

feature -- Initialization

	make (name: STRING; tl: EB_METRIC_TOOL) is
			-- Create en EB_METRIC_VALUE object that can evaluate metric of name `name'.
		require
			name_not_empty: name /= Void and then not name.is_empty
			existing_tool: tl /= Void
		do
			metric_name := name
			requested_metric ?= tl.metric (metric_name)
		ensure
			existing_metric: requested_metric /= Void
		end

feature -- Access

	metric_name: STRING
		-- Name of the metric `Current' must evaluate.

	requested_metric: EB_METRIC
		-- Metric `Current' must evaluate.

feature -- Value

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Result of evaluating `requested_metric' over scope `s'
		require else
			scope_not_void: s /= Void
			metric_not_void: requested_metric /= Void
		do
			Result := requested_metric.value (s)
		end

end -- class EB_METRIC_MEASURE
