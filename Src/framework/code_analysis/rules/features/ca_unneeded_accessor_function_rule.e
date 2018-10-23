note
	description: "[
		RULE #79: Unneeded accessor function
		
		In Eiffel, it is not necessary to use a secret attribute together with an exported accessor ('getter') function.
		Since it is not allowed to write to an attribute from outside a class, an exported attribute can be used instead
		and the accessor may be removed.
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNEEDED_ACCESSOR_FUNCTION_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_do_pre_action (agent process_do)
		end

feature {NONE} -- Rule checking

	current_feature: detachable FEATURE_AS
			-- The feature currently being analyzed.

	process_do (a_as: DO_AS)
			-- <Precursor>
		local
			l_viol: CA_RULE_VIOLATION
		do
				-- Sample violation
				--
				--	feature -- Publicly accessible
				--
				--		tell_me_the_secret_attribute: INTEGER
				--			do
				--				Result := secret_attribute
				--			end
				--
				--	feature {NONE} -- Secret
				--
				--		secret_attribute: INTEGER
				--

			if
					-- Check that the current feature is a function containing exactly one instruction.
				attached current_feature as l_current_feature and then
				l_current_feature.is_function and then
				attached a_as.compound as l_compound and then
				l_compound.count = 1 and then
					-- Check that the said instruction is an assignment to 'Result'
				attached {ASSIGN_AS} a_as.compound.first as l_assignment and then
				attached {RESULT_AS} l_assignment.target and then
					-- Check that the right hand of the assignment is a feature accessed directly.
				attached {EXPR_CALL_AS} l_assignment.source as l_expr_call and then
				attached {ACCESS_ID_AS} l_expr_call.call as l_access_id and then
					-- Check that said feature is an attribute.
				attached {ATTRIBUTE_I} current_context.checking_class.feature_named_32 (l_access_id.access_name_32) as l_called_attribute
			then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (current_feature.start_location)
				l_viol.long_description_info.extend (current_feature.feature_name.name_32)
				l_viol.long_description_info.extend (l_called_attribute.feature_name_32)
				violations.extend (l_viol)
			end
		end

	process_feature (a_feature_as: FEATURE_AS)
			-- <Precursor>
		do
			current_feature := a_feature_as
		end

feature -- Properties

	name: STRING = "unnecessary_accessor"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.unneeded_accessor_function_title
		end

	id: STRING_32 = "CA079"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.unneeded_accessor_function_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.unneeded_accessor_function_violation_1)
			a_violation.long_description_info.start
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.item
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.item as l_feature_name then
				a_formatter.add (l_feature_name)
				a_violation.long_description_info.forth
			end
			a_formatter.add (ca_messages.unneeded_accessor_function_violation_2)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.item
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.item as l_attribute_name then
				a_formatter.add (l_attribute_name)
			end
			a_formatter.add (ca_messages.unneeded_accessor_function_violation_3)
		end

end
