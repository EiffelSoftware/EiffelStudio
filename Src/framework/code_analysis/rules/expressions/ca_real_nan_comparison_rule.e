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
			-- Initialize the rule.
		do
			make_with_defaults
			create {ARRAYED_STACK [FEATURE_I]} current_feature.make (1)
		end

feature {NONE} -- Implementation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_bin_eq_pre_action (agent process_bin_eq)
			a_checker.add_inline_agent_creation_pre_action (agent process_inline_agent_start)
			a_checker.add_inline_agent_creation_post_action (agent process_inline_agent_stop)
		end

	process_feature (a_feature: attached FEATURE_AS)
			-- Sets the current feature.
		do
			current_feature.wipe_out
			current_feature.put (current_context.checking_class.feature_named_32 (a_feature.feature_names.first.visual_name_32))
		end

	process_bin_eq (a_bin: attached BIN_EQ_AS)
			-- Check if the equality compares a value to NaN.
		do
			if is_nan_comparison (get_expression(a_bin.left), get_expression(a_bin.right)) then
				create_violation (a_bin, True)
			elseif is_nan_comparison (get_expression(a_bin.right), get_expression(a_bin.left)) then
				create_violation (a_bin, False)
			end
		end

	process_inline_agent_start (a: INLINE_AGENT_CREATION_AS)
			-- Switch to a new routine identified by `a`.
		do
			current_feature.put (current_context.checking_class.feature_of_rout_id (a.routine_ids.first))
		end

	process_inline_agent_stop (a: INLINE_AGENT_CREATION_AS)
			-- Restore previous feature context.
		do
			current_feature.remove
		end

	get_expression (e: EXPR_AS): EXPR_AS
			-- Retrieve an expression from `e` taking possible conversion into account.
		do
			if attached {CONVERTED_EXPR_AS} e as l_converted then
				Result := l_converted.expr
			else
				Result := e
			end
		end

	is_nan_comparison (a_one, a_other: attached EXPR_AS): BOOLEAN
			-- Is one of the operands NaN and the other one has a real type?
		do
			Result :=
				attached {EXPR_CALL_AS} a_other as l_other_expr_call
				and then attached {STATIC_ACCESS_AS} l_other_expr_call.call as l_static_access
				and then l_static_access.feature_name.name_id = {PREDEFINED_NAMES}.nan_name_id
				and then attached {EXPR_CALL_AS} a_one as l_one_expr_call
				and then attached {ACCESS_ID_AS} l_one_expr_call.call as l_access
				and then attached current_context.node_type (l_access, current_feature.item).name as l_type
				and then (l_type.same_string ("REAL_32")
						 or else l_type.same_string ("REAL_64")
						 or else l_type.same_string ("REAL_32_REF")
						 or else l_type.same_string ("REAL_64_REF"))
		end

	current_feature: STACK [FEATURE_I]
			-- A stack of nested features.

	create_violation (a_bin: attached BIN_EQ_AS; a_is_right: BOOLEAN)
			-- Add a rule violation.
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
			-- <Precursor>
		do
			a_formatter.add (ca_messages.real_nan_comparison_violation_1)
		end

feature -- Properties

	name: STRING = "nan_comparison"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.real_nan_comparison_title
		end

	id: STRING_32 = "CA045"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.real_nan_comparison_description
		end

end
