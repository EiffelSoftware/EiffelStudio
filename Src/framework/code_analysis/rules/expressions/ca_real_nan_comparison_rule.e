note
	description: "[
			RULE #45: Comparison of {REAL}.nan
	
			To check whether a REAL object is "NaN" (not a number) a comparison
			using the '=' symbol does not yield the intended result. Instead one
			must use the query {REAL}.is_nan.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_REAL_NAN_COMPARISON_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
		end

feature {NONE} -- Implementation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_bin_eq_pre_action (agent process_bin_eq)
		end

	process_feature (a_feature: attached FEATURE_AS)
			-- Sets the current feature.
		do
			current_feature := current_context.checking_class.feature_named_32 (a_feature.feature_names.first.visual_name_32)
		end

	process_bin_eq (a_bin: attached BIN_EQ_AS)
		do
			if is_nan_comparison (get_expression(a_bin.left), get_expression(a_bin.right)) then
				create_violation (a_bin, True)
			elseif is_nan_comparison (get_expression(a_bin.right), get_expression(a_bin.left)) then
				create_violation (a_bin, False)
			end
		end

	get_expression (a_expr: EXPR_AS): EXPR_AS
		do
			if attached {CONVERTED_EXPR_AS} a_expr as l_converted then
				Result := l_converted.expr
			else
				Result := a_expr
			end
		end

	is_nan_comparison (a_one, a_other: attached EXPR_AS): BOOLEAN
		do
			Result := attached {EXPR_CALL_AS} a_one as l_one_expr_call
				and then attached {ACCESS_ID_AS} l_one_expr_call.call as l_access
				and then attached {STRING_8} current_context.node_type (l_access, current_feature).name as l_type
				and then (l_type.is_equal ("REAL_32")
						 or else l_type.is_equal ("REAL_64")
						 or else l_type.is_equal ("REAL_32_REF")
						 or else l_type.is_equal ("REAL_64_REF"))
				and then attached {EXPR_CALL_AS} a_other as l_other_expr_call
				and then attached {STATIC_ACCESS_AS} l_other_expr_call.call as l_static_access
				and then l_static_access.feature_name.name_32.is_equal ("nan")
		end

	current_feature: FEATURE_I

	create_violation (a_bin: attached BIN_EQ_AS; a_is_right: BOOLEAN)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_REAL_NAN_COMPARISON_FIX
		do
			create l_violation.make_with_rule (Current)

			l_violation.set_location (a_bin.start_location)

			create l_fix.make_with_bin_eq (current_context.checking_class, a_bin, a_is_right)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.real_nan_comparison_violation_1)
		end

feature -- Properties

	name: STRING = "nan_comparison"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.real_nan_comparison_title
		end

	id: STRING_32 = "CA045"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.real_nan_comparison_description
		end
end
