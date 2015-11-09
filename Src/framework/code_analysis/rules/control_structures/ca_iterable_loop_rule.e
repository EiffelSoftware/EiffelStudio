note
	description: "[
			RULE #24: From-until loop on ITERABLE can be reduced to across loop
	
			A from-until loop iterating through an
			{ITERABLE} data structure from beginning to end can be transformed into
			a (more recommendable) across loop.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ITERABLE_LOOP_RULE

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
			default_severity_score := 30
			create {CA_SUGGESTION} severity
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_loop_pre_action (agent process_loop)
		end

feature {NONE} -- Rule checking

	iterable: CLASS_C
			-- The {ITERABLE} class.
		once
			Result := Eiffel_universe.compiled_classes_with_name ("ITERABLE").first.compiled_class
		end

	current_feature_i: FEATURE_I
			-- Currently checked feature.

	process_feature (a_feature: FEATURE_AS)
			-- Sets currently checked feature.
		do
			current_feature_i := current_context.checking_class.feature_named_32 (a_feature.feature_name.name_32)
		end

	process_loop (a_loop: LOOP_AS)
			-- Checks `a_loop' for a rule violation.
		local
			l_viol: CA_RULE_VIOLATION
		do
			check_until_part (a_loop.stop)
			if
				matching_until_part
				and then matching_from_part (a_loop.from_part)
				and then matching_last_instruction (a_loop.compound)
			then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_loop.start_location)
				l_viol.long_description_info.extend (expected_var)
				violations.extend (l_viol)
			end
		end

	matching_until_part: BOOLEAN
			-- Is the until part analyzed in `check_until_part' as expected?

	check_until_part (a_stop_condition: detachable EXPR_AS)
			-- Checks if `a_stop_condition' is of the form 'list.after', where list is
			-- a variable of a type that conforms to {ITERABLE}.
		local
			l_type: TYPE_A
			l_target: ACCESS_AS
		do
			matching_until_part := False

			if
				a_stop_condition /= Void
				and then attached {EXPR_CALL_AS} a_stop_condition as l_call
				and then attached {NESTED_AS} l_call.call as l_nested_call
				and then attached {ACCESS_AS} l_nested_call.message as l_msg
				and then l_msg.access_name_8.is_equal ("after")
			then
				l_target := l_nested_call.target
				l_type := current_context.node_type (l_target, current_feature_i)
				if l_type /= Void and then l_type.base_class.conform_to (iterable) then
					matching_until_part := True
					expected_var := l_target.access_name_32
				end
			end
		ensure
			expected_variable_set: matching_until_part implies (expected_var /= Void)
		end

	expected_var: detachable STRING_32
			-- The expected iteration variable.

	matching_from_part (a_from: detachable EIFFEL_LIST [INSTRUCTION_AS]): BOOLEAN
			-- Does `a_from' contain an instruction of the form `expected_var'.start?			
		require
			expected_variable_set: expected_var /= Void
		do
			if a_from /= Void then
				across a_from as l_instr loop
					if
						attached {INSTR_CALL_AS} l_instr.item as l_call
						and then attached {NESTED_AS} l_call.call as l_nested_call
						and then l_nested_call.target.access_name_32.is_equal (expected_var)
						and then attached {ACCESS_AS} l_nested_call.message as l_msg
						and then l_msg.access_name_8.is_equal ("start")
					then
							-- We do not have to check the type of `l_target' since we know it is the expected variable
							-- that has already been checked for conformance to {ITERABLE}.
						Result := True
					end
				end
			end
		end

	matching_last_instruction (a_loop_body: detachable EIFFEL_LIST [INSTRUCTION_AS]): BOOLEAN
			-- Is the last instruction of `a_loop_body' of the form `expected_var'.start?
		do
			if
				a_loop_body /= Void
				and then attached {INSTR_CALL_AS} a_loop_body.last as l_call
				and then attached {NESTED_AS} l_call.call as l_nested_call
				and then l_nested_call.target.access_name_32.is_equal (expected_var)
				and then attached {ACCESS_AS} l_nested_call.message as l_msg
				and then l_msg.access_name_8.is_equal ("forth")
			then
					-- We do not have to check the type of `l_target' since we know it is the expected variable
					-- that has already been checked for conformance to {ITERABLE}.
				Result := True
			end
		end

feature -- Properties

	name: STRING = "general_loop_on_iterable"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.iterable_loop_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.iterable_loop_description
		end

	id: STRING_32 = "CA024"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.iterable_loop_violation_1)
			if attached {STRING_32} a_violation.long_description_info.first as l_name then
				a_formatter.add_local (l_name)
			end
			a_formatter.add (ca_messages.iterable_loop_violation_2)
		end

end
