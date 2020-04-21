note
	description: "[
			RULE #52: Number of elements of a structure is compared to zero
	
			In a data structure, comparing the number
			of elements to zero can be transformed into the boolean query 'is_empty'.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_COUNT_EQUALS_ZERO_RULE

inherit
	CA_STANDARD_RULE

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			severity := severity_hint
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_bin_eq_pre_action (agent process_equality)
		end

feature {NONE} -- Rule checking

	current_feature_i: FEATURE_I
			-- The current feature the AST visitor is processing.

	process_feature (a_feature: FEATURE_AS)
			-- Stores `a_feature'.
		do
			current_feature_i := current_context.checking_class.feature_named_32 (a_feature.feature_name.name_32)
		end

	process_equality (a_bin_eq: BIN_EQ_AS)
			-- Checks whether `a_bin_eq' follows the pattern for a rule violation.
		local
			l_viol: CA_RULE_VIOLATION
		do
			if
				(is_zero (a_bin_eq.right) and then is_finite_count (a_bin_eq.left))
				or else (is_zero (a_bin_eq.left) and then is_finite_count (a_bin_eq.right))
			then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_bin_eq.start_location)
				violations.extend (l_viol)
			end
		end

	is_zero (a_expr: attached EXPR_AS): BOOLEAN
			-- Is `a_expr' the integer constant 0?
		do
			if attached {INTEGER_AS} a_expr as l_int then
				Result := l_int.has_integer (32) and then l_int.integer_32_value = 0
			end
		end

	finite: CLASS_C
			-- The compiled class {FINITE}.
		once
			Result := Eiffel_universe.compiled_classes_with_name ("FINITE").first.compiled_class
		end

	is_finite_count (a_expr: attached EXPR_AS): BOOLEAN
			-- Does `a_expr' call `finite' on a {FINITE} (or conforming) instance?
		do
			if
				attached {EXPR_CALL_AS} a_expr as l_ec and then
				attached {NESTED_EXPR_AS} l_ec.call as l_nested_call and then
				l_nested_call.message.feature_name.name_id = {PREDEFINED_NAMES}.count_name_id and then
				attached current_context.node_type (l_nested_call.target, current_feature_i) as l_type
			then
				Result := l_type.base_class.conform_to (finite)
			end
		end

feature -- Properties

	name: STRING = "zero_count_test"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.count_equals_zero_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.count_equals_zero_description
		end

	id: STRING_32 = "CA052"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.count_equals_zero_violation)
			a_formatter.add_feature_name ("is_empty", finite)
			a_formatter.add ("'.")
		end

end
