note
	description: "[
			RULE #46: Avoid 'not equal' in If-Else instructions
	
			Having an If-Else instruction with a
			condition that checks for inequality is not optimal for readability.
			Instead an equality comparison should be made. Refactoring by negating
			the condition and by switching the instructions solves this issue.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_IF_ELSE_NOT_EQUAL_RULE

inherit
	CA_STANDARD_RULE

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
			a_checker.add_if_pre_action (agent process_if)
		end

feature {NONE} -- Rule checking	

	process_if (a_if: IF_AS)
			-- Checks whether `a_if' follows the pattern that leads to a rule violation.
		local
			l_viol: CA_RULE_VIOLATION
		do
				-- Only look at if-else instructions. (Whether there exists an 'elseif' is
				-- not relevant to this rule.)
			if
				a_if.else_part /= Void
				and then attached {BIN_NE_AS} a_if.condition as l_c
				and then (not attached {VOID_AS} l_c.right)
			then
					-- The if condition is of the form 'a /= b' or 'a /~ b'. Comparing to Void, however, is ignored
					-- for the sake of intuition: "if c /= Void then" is preferrable (note: the 'attached' syntax
					-- will not be discussed here and is not part of this rule).
				create l_viol.make_with_rule (Current)
				l_viol.set_location (l_c.start_location)
				violations.extend (l_viol)
			end
		end

feature -- Properties

	name: STRING = "inequality_in_conditional"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.if_else_not_equal_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.if_else_not_equal_description
		end

	id: STRING_32 = "CA046"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.if_else_not_equal_violation)
		end

end
