indexing
	description: "Objects that represents a value criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALUE_CRITERION

inherit
	EB_METRIC_DOMAIN_CRITERION
		redefine
			make,
			is_parameter_valid,
			is_value_criterion,
			process,
			new_criterion
		end

	EB_METRIC_SHARED

	EB_METRIC_EVALUATION_CONTEXT

create
	make

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING) is
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		do
			metric_name := ""
			create value_tester.make
			Precursor (a_scope, a_name)
		ensure then
			domain_attached: domain /= Void
		end

feature -- Access

	metric_name: STRING
			-- Metric name whose value is tested

	value_tester: EB_METRIC_VALUE_TESTER
			-- Value tester

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION is
			-- QL_CRITERION representing current criterion
		do
			Result := criterion_factory_table.item (a_scope).criterion_with_name (name, [agent evaluate_function])
		end

feature -- status report

	is_parameter_valid: BOOLEAN is
			-- Is parameters of current criterion valid?
			-- Parameter for current is `domain'.
		do
			Result := domain.is_valid and then
					  not value_tester.criteria.is_empty and then
					  (metric_manager.is_metric_calculatable (metric_name))
		end

	is_value_criterion: BOOLEAN is True
			-- Is crrent a value criterion?

feature -- Setting

	set_metric_name (a_metric_name: like metric_name) is
			-- Set `metric_name' with `a_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create metric_name.make_from_string (a_metric_name)
		ensure
			metric_name_set: metric_name /= Void
		end

	set_value_tester (a_tester: like value_tester) is
			-- Set `value_tester' with `a_tester'.
		require
			a_tester_attached: a_tester /= Void
		do
			value_tester := a_tester
		ensure
			value_tester_set: value_tester = a_tester
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_value_criterion (Current)
		end

feature{NONE} -- Implementation

	evaluate_function (a_item: QL_ITEM): BOOLEAN is
			-- Function to evaluate if Current criterion is satisfied by `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_metric: EB_METRIC
			l_domain: like domain
		do
			l_domain := domain
			l_metric := metric_manager.metric_with_name (metric_name)
			set_delayed_domain (a_item.wrapped_domain)
			Result := value_tester.is_satisfied_by (l_metric.value (l_domain).first.value)
			set_delayed_domain (Void)
		end

invariant
	metric_name_attached: metric_name /= Void
	value_tester_attached: value_tester /= Void

end
