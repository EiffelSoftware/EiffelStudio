note
	description: "[
			RULE #47: Void-check using 'is_equal'
	
			Checking a local variable or argument to be void should
			not be done by calling 'is_equal' but by the '=' or '/=' operators.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_VOID_CHECK_USING_IS_EQUAL_RULE

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

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_nested_expr_pre_action (agent process_nested)
		end

feature -- Properties

	name: STRING = "equal_in_void_test"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.void_check_using_is_equal_title
		end

	id: STRING_32 = "CA047"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.void_check_using_is_equal_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.void_check_using_is_equal_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_target_name then
				a_formatter.add (l_target_name)
			end
			a_formatter.add (ca_messages.void_check_using_is_equal_violation_2)
		end

feature {NONE} -- Rule Checking

	process_nested (a_nested: NESTED_EXPR_AS)
			-- Checks if `a_nested' contains a Void check using 'is_equal'
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_VOID_CHECK_USING_IS_EQUAL_FIX
		do
			if
				attached {ACCESS_FEAT_AS} a_nested.message as l_message and then
				(l_message.feature_name.name_id = {PREDEFINED_NAMES}.is_equal_name_id or else
				l_message.feature_name.name_id = {PREDEFINED_NAMES}.standard_is_equal_name_id or else
				l_message.feature_name.name_id = {PREDEFINED_NAMES}.is_deep_equal_name_id) and then
				attached {VOID_AS} l_message.internal_parameters.parameters.first
			then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_nested.start_location)
				l_violation.long_description_info.extend
					(if
						attached match_list_server.item (current_context.checking_class.class_id) as m and then
						a_nested.target.is_text_available (m)
					then
						a_nested.target.text_32 (m)
					else
						{STRING_32} "%"target of is_equal%""
					end)

				create l_fix.make_with_nested (current_context.checking_class, a_nested)
				l_violation.fixes.extend (l_fix)

				violations.extend (l_violation)
			end
		end
end

