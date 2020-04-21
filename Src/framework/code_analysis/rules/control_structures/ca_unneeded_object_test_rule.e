note
	description: "[
			RULE #6: Object test typing not needed
	
			An object test is redundant if the static
			type of the tested variable is the same as the type (in curly braces)
			that the variable is tested for.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNEEDED_OBJECT_TEST_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 40
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_object_test_pre_action (agent process_object_test)
		end

feature -- Properties

	name: STRING = "redundant_object_test"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.unneeded_object_test_title
		end

	id: STRING_32 = "CA006"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.unneeded_object_test_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		local
			l_info: LINKED_LIST [ANY]
		do
			l_info := a_violation.long_description_info

			a_formatter.add (ca_messages.unneeded_object_test_violation_1)
			if attached {READABLE_STRING_GENERAL} l_info.first as l_var then
				a_formatter.add_local (l_var)
			end
			a_formatter.add (ca_messages.unneeded_object_test_violation_2)
			if attached {CLASS_C} l_info.at (2) as l_type then
				a_formatter.add_class (l_type.original_class)
			end
			a_formatter.add ("'.")
		end

feature {NONE} -- AST Visits

	current_feature_i: FEATURE_I
			-- Currently checked feature.

	process_feature (a_feature: FEATURE_AS)
			-- Sets currently checked feature.
		do
			current_feature_i := current_context.checking_class.feature_named_32 (a_feature.feature_name.name_32)
		end

	process_object_test (a_ot: OBJECT_TEST_AS)
			-- Checks `a_ot' for rule violations.
		local
			l_violation: CA_RULE_VIOLATION
			l_static_variable_type: TYPE_A
			l_access: ACCESS_FEAT_AS
		do
			if attached {EXPR_CALL_AS} a_ot.expression as l_call then

				if attached {ACCESS_FEAT_AS} l_call.call as l_af then
					l_access := l_af
				elseif attached {NESTED_EXPR_AS} l_call.call as l_nested then
						-- Extract the rightmost feature in the nested call.
					l_access := l_nested.message
				end
				if l_access /= Void and then attached {CLASS_TYPE_AS} a_ot.type as l_type then
					l_static_variable_type := current_context.node_type (l_access, current_feature_i)
					if
						l_static_variable_type /= Void and then
						l_type.class_name.name_8.is_equal (l_static_variable_type.name)
					then
						create l_violation.make_with_rule (Current)
						l_violation.set_location (a_ot.start_location)
						l_violation.long_description_info.extend (l_access.access_name_32)
						l_violation.long_description_info.extend (l_static_variable_type.base_class)
						violations.extend (l_violation)
					end
				end
			end
		end

end
