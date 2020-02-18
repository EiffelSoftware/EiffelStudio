note
	description: "[
		RULE #29: Object test or non-Void test always succeeds
		
		For an attached variable object tests and non-Void tests
		always succeed. Also, objects tests that check if an entity
		is attached to a supertype always suceed. The tests should
		be removed.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_OBJECT_TEST_ALWAYS_SUCCEEDS_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
		end

feature {NONE} -- Implementation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent  (f: FEATURE_AS) do current_feature := Void end)
			a_checker.add_bin_ne_pre_action (agent pre_process_bin_ne)
			a_checker.add_object_test_pre_action (agent pre_process_object_test)
		end

	pre_process_bin_ne (a_bin_ne: BIN_NE_AS)
		do
			if
				is_project_setting_void_safety_complete
				and then attached {VOID_AS} a_bin_ne.right
				and then attached current_context.node_type (a_bin_ne.left, current_feature) as l_type
				and then l_type.has_attached_mark
			then
				create_violation (a_bin_ne, extract_feature_name (a_bin_ne.left))
			elseif
				is_project_setting_void_safety_complete
				and then attached {VOID_AS} a_bin_ne.left
				and then attached current_context.node_type (a_bin_ne.right, current_feature) as l_type
				and then l_type.has_attached_mark
			then
				create_violation (a_bin_ne, extract_feature_name (a_bin_ne.right))
			end
		end

	pre_process_object_test (a_object_test: OBJECT_TEST_AS)
		local
			l_type_var, l_type_test: TYPE_A
		do
			if attached a_object_test.type then
				l_type_var := current_context.node_type (a_object_test.expression, current_feature)
				l_type_test := current_context.node_type (a_object_test.type, current_feature)

				if
					l_type_var /= Void and l_type_test /= Void
					and then l_type_var.conform_to (current_context.checking_class, l_type_test)
				then
					create_violation (a_object_test, extract_feature_name (a_object_test.expression))
				end
			elseif
				is_project_setting_void_safety_complete
				and then attached current_context.node_type (a_object_test.expression, current_feature) as l_type
				and then l_type.has_attached_mark
			then
				create_violation (a_object_test, extract_feature_name (a_object_test.expression))
			end
		end

	pre_process_feature (a_feature: FEATURE_AS)
		do
			current_feature := current_context.checking_class.feature_named_32 (a_feature.feature_names.first.visual_name_32)
		end

	extract_feature_name (a_expr: EXPR_AS): READABLE_STRING_32
		do
			if
				attached {EXPR_CALL_AS} a_expr as l_expr_call
				and then attached {ACCESS_ASSERT_AS} l_expr_call.call as l_access_assert
				and then attached l_access_assert.feature_name as l_id
			then
				Result := l_id.name_32
			end
		end

	create_violation (a_expr: EXPR_AS; a_variable_name: READABLE_STRING_32)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_OBJECT_TEST_ALWAYS_SUCCEEDS_FIX
		do
			create l_violation.make_with_rule (Current)

			l_violation.set_location (a_expr.start_location)

				-- Put a boolean into long_description whether the violating structure is a bin_neq_as or a object_test_as.
			l_violation.long_description_info.extend (attached {BIN_NE_AS} a_expr)
			l_violation.long_description_info.extend (a_variable_name)

			create l_fix.make_with_bin_eq_or_object_test (current_context.checking_class, a_expr)

			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			if
				attached {BOOLEAN} a_violation.long_description_info.at (2) as l_is_bin_ne
				and then l_is_bin_ne
			then
				a_formatter.add (ca_messages.object_test_succeeds_violation_1)
			else
				a_formatter.add (ca_messages.object_test_succeeds_violation_2)
			end

			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_variable_name then
				a_formatter.add (l_variable_name)
			end

			a_formatter.add (ca_messages.object_test_succeeds_violation_3)
		end

	is_project_setting_void_safety_complete: BOOLEAN
			-- Is the project's setting for void safety set to "Complete"?
		local
			l_conf: CONF_OPTION
		do
			l_conf := current_context.universe.target.options
			Result := l_conf.void_safety.index = l_conf.void_safety_index_all
		end

	current_feature: FEATURE_I
			-- The feature we are currently in.

feature -- Properties

	name: STRING = "unnecessary_voidness_test"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.object_test_succeeds_title
		end

	id: STRING_32 = "CA029"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.object_test_succeeds_description
		end

end
