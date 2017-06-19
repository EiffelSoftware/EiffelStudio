note
	description: "[
			RULE #41: Boolean result can be returned directly
	
			For a boolean result there is no need for
			an If/Else clause with Result := True and and Result := False,
			respectively. One can directly assign the If condition (or its
			negation) to the result.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_BOOLEAN_RESULT_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
			default_severity_score := 30
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_if_pre_action (agent process_if)
		end

feature -- Properties

	name: STRING = "conditional_computes_only_boolean"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.boolean_result_title
		end

	id: STRING_32 = "CA041"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.boolean_result_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.boolean_result_violation)
		end

feature {NONE} -- Rule Checking

	process_if (a_if: IF_AS)
			-- Checks whether `a_if' has the structure that will trigger a violation.
		local
			l_violation: CA_RULE_VIOLATION
		do
				-- If-else instructions without any 'elseif':
			if
				attached a_if.compound as l_if_branch
				and then attached a_if.else_part as l_else_branch
				and then a_if.elsif_list = Void
				and then l_if_branch.count = 1
				and then l_else_branch.count = 1
				and then is_result_assign (l_if_branch.first)
				and then is_result_assign (l_else_branch.first)
			then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_if.start_location)
				violations.extend (l_violation)
			end
		end

	is_result_assign (a_instruction: attached INSTRUCTION_AS): BOOLEAN
			-- Does instruction `a_instruction' assign a boolean constant
			-- to "Result"?
		do
			if attached {ASSIGN_AS} a_instruction as l_assign then
				Result := (attached {RESULT_AS} l_assign.target) and (attached {BOOL_AS} l_assign.source)
			end
		end

end
