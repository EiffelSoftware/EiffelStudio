indexing
	description: "Representation of metric objects which are combination%N%
				%of previously recorded metrics (either basic or composite)"
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMPOSITE
	
inherit
	EB_METRIC

	SHARED_WORKBENCH

	EB_METRIC_SCOPE_INFO

create
	make

feature -- Initialization

	make (a_name, a_unit: STRING; an_operator: EB_METRIC_VALUE; tl:EB_METRIC_TOOL; minimal: INTEGER) is
			-- Assign an operator to `Current'
		require
			correct_name: a_name /= Void and then not a_name.is_empty
			correct_unit: a_unit /= Void and then not a_unit.is_empty
			correct_scope: minimal >= Feature_scope and minimal <= Archive_scope
			tool_not_void: tl /= Void
			correct_operator: an_operator /= Void
		do
			name := a_name
			unit := a_unit
			operator := an_operator
			tool := tl
			min_scope := minimal
		end

feature -- Access

	operator: EB_METRIC_VALUE
		-- Mathematical combination of avilable metrics (either basics or composite).

feature -- Nature

	is_linear: BOOLEAN
		-- Is `Current' a linear combination of available metrics?

	set_linear (bool: BOOLEAN) is
			-- Assign `bool' to `is_linear'.
		do
			is_linear := bool
		end

	is_metric_ratio: BOOLEAN
		-- Is `Current' a ratio of two available metrics?

	set_metric_ratio (bool: BOOLEAN) is
			-- Assign `bool' to `is_metric_ratio'.
		do
			is_metric_ratio := bool
		end

	is_scope_ratio: BOOLEAN
			-- Is `Current' a ratio of an available metrics over two different scopes?

	set_scope_ratio (bool: BOOLEAN) is
			-- Assign `bool' to `is_scope_ratio'.
		do
			is_scope_ratio := bool
		end

feature -- When metric needs several scopes

	scope_num: EB_METRIC_SCOPE
		-- Numerator scope for scope ratio metrics.

	set_scope_num (s: EB_METRIC_SCOPE) is
			-- Assign `s' to `scope_num'.
		require
			scope_not_void: s /= Void
		do
			scope_num := s
		end

	scope_den: EB_METRIC_SCOPE
		-- Denominator scope for scope ratio metrics.

	set_scope_den (s: EB_METRIC_SCOPE) is
			-- Assign `s' to `scope_den'.
		require
			scope_not_void: s /= Void
		do
			scope_den := s
		end

feature -- Application to scope.

	value (s:EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate current metric using its `operator'.
		do
			Result := operator.value (s)
		end

end -- class EB_METRIC_COMPOSITE
