note
	description: "[
			RULE #22: Unreachable code
	
			Code that will never be executed should be removed. It may be there for debug
			purposes or due to a programmer's mistake. One example is a series of instructions
			(in the same block) which follows an assertion that always evaluates to false.
		]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNREACHABLE_CODE_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent check_feature)
			a_checker.add_if_pre_action (agent check_if)
		end

feature -- Properties

	name: STRING = "unreachable_code"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.unreachable_code_title
		end

	id: STRING_32 = "CA022"
		-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.unreachable_code_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.unreachable_code_violation_1)
			a_formatter.add (a_violation.affected_class.name_in_upper)
			a_formatter.add (ca_messages.unreachable_code_violation_2)
		end

feature {NONE} -- Rule Checking

	check_feature (a_feature: FEATURE_AS)
		local
			l_found_violation: BOOLEAN
			l_index: INTEGER
		do
			if attached a_feature.body as l_body and then
			   attached {ROUTINE_AS} l_body.content as l_routine and then
			   attached {INTERNAL_AS} l_routine.routine_body as l_internal and then
			   attached l_internal.compound as l_compound then
				-- Getting the instruction list of the feature.
				from
					l_found_violation := False
					l_index := 1
					l_compound.start
				until
					l_compound.after or l_found_violation
				loop
					if attached {CHECK_AS} l_compound.item as l_check then
						across l_check.check_list as l_tagged loop
							if
								not l_found_violation and then
								is_expr_false (l_tagged.item.expr) and then
									-- We found at least one assertion which is False.
									-- There are still more instructions after the check fails.
								not l_compound.islast
							then
								l_found_violation := True
								create_violation (l_compound, l_index + 1)
							end
						end
					elseif attached {INSTR_CALL_AS} l_compound.item as l_call and then
						   attached {NESTED_AS} l_call.call as l_nested and then
						   attached {ACCESS_FEAT_AS} l_nested.message as l_feat_access and then
						   l_feat_access.feature_name.name_32.is_equal ("raise") then
						if not l_compound.islast then
							-- There are still more instructions after the exception is raised.
							l_found_violation := True
							create_violation (l_compound, l_index + 1)
						end
					end
					l_compound.forth
					l_index := l_index + 1
				end
			end
		end

	check_if (a_if: IF_AS)
		do
			if attached a_if.compound and then is_expr_false (a_if.condition) then
				create_violation (a_if.compound, 1)
			end
			if attached a_if.else_part and then is_expr_true (a_if.condition) then
				create_violation (a_if.else_part, 1)
			end
		end

	is_expr_true (a_expr: EXPR_AS): BOOLEAN
		do
			Result := attached {BOOL_AS} a_expr as l_bool and then l_bool.value
		end

	is_expr_false (a_expr: EXPR_AS): BOOLEAN
		do
			Result := attached {BOOL_AS} a_expr as l_bool and then not l_bool.value
		end

	create_violation (a_list: EIFFEL_LIST[INSTRUCTION_AS] a_index: INTEGER)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_UNREACHABLE_CODE_FIX
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (a_list.at (a_index).start_location)

			create l_fix.make_with_list_and_index (current_context.checking_class, a_list, a_index)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

end
