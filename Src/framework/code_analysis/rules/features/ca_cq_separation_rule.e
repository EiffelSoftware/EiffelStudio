note
	description: "[
			RULE #4: No command-query separation (possible function side effect)
			
			To the client of a class it is not
			important whether a query is implemented as an attribute or as a
			function. When a class evolves an attribute may be changed into a
			function, for example. A function should never change the state of
			an object. A function containing a procedure call, assigning to an
			attribute, or creating an attribute is a strong indication that this
			principle is violated. This rule applies exactly in these three
			last-mentioned cases. There are rather exceptional but sometimes useful
			class designs in which the externally visible state of an object (i. e.
			the values of exported queries) does not change even though the function
			contains a rule-violating instruction.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CQ_SEPARATION_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 60
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent post_process_feature)

			a_checker.add_assign_pre_action (agent process_assign)
			a_checker.add_creation_pre_action (agent process_creation)
			a_checker.add_instruction_call_pre_action (agent process_instruction_call)
		end

feature {NONE} -- AST Visits

	pre_process_feature (a_feature: FEATURE_AS)
			-- Stores if `a_feature' is a function.
		do
			is_function := a_feature.is_function
			rule_violated := False
		end

	post_process_feature (a_feature: FEATURE_AS)
			-- Creates a rule violation regarding `a_feature', if
			-- necessary.
		local
			l_violation: CA_RULE_VIOLATION
		do
			if rule_violated then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_feature.start_location)
				l_violation.long_description_info.extend (a_feature.feature_name.name_32)
				violations.extend (l_violation)
			end
		end

	is_function, rule_violated: BOOLEAN
			-- Properties of current feature.

	process_assign (a_assign: ASSIGN_AS)
			-- Is something assigned to an attributein `a_assign'?
		do
				-- Skip the checks if we are not within a function.
			if
				is_function
				and then attached {ACCESS_ID_AS} a_assign.target as l_access_id
				and then current_context.checking_class.feature_with_id (l_access_id.feature_name) /= Void
			then
					-- We have an assignment to an attribute.
				rule_violated := True
			end
		end

	process_creation (a_creation: CREATION_AS)
			-- Is an attribute created in `a_creation'?
		do
			-- Skip the checks if we are not within a function.
			if
				is_function
				and then attached {ACCESS_ID_AS} a_creation.target as l_access_id
				and then current_context.checking_class.feature_with_id (l_access_id.feature_name) /= Void
			then
					-- We have a creation of an attribute.
				rule_violated := True
			end
		end

	process_instruction_call (a_call: INSTR_CALL_AS)
			-- Checks whether `a_call' is a procedure call relevant to this rule.
		do
				-- Skip the checks if we are not within a function.
			if
				is_function
				and then attached {ACCESS_ID_AS} a_call.call as l_access_id
				and then attached current_context.checking_class.feature_with_id (l_access_id.feature_name) as l_feat
				and then l_feat.is_procedure
			then
					-- There is a procedure call within this function.
				rule_violated := True
			end
		end

feature -- Properties

	name: STRING = "possible_side_effect"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.cq_separation_title
		end

	id: STRING_32 = "CA004"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.cq_separation_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.cq_separation_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.cq_separation_violation_2)
		end

end
